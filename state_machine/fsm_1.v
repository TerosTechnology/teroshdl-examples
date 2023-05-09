module LandingGearController(Clock, Clear,
                               GearIsDown, GearIsUp, PlaneOnGround, TimeUp, Lever,
                               RedLED, GrnLED, Valve, Pump, Timer);

  input Clock, Clear, GearIsDown, GearIsUp, PlaneOnGround, TimeUp, Lever;
  output RedLED, GrnLED, Valve, Pump, Timer;
  reg RedLED, GrnLED, Valve, Pump, Timer;

  parameter YES = 1'b1;
  parameter ON = 1'b1;
  parameter DOWN = 1'b1;
  parameter RESET = 1'b1;

  parameter NO = 1'b0;
  parameter OFF = 1'b0;
  parameter UP = 1'b0;
  parameter COUNT = 1'b0;

  parameter
    TAXI   = 7'b0000001,
    TUP    = 7'b0000010,
    TDN    = 7'b0000100,
    GOUP   = 7'b0001000,
    GODN   = 7'b0010000,
    FLYUP  = 7'b0100000,
    FLYDN  = 7'b1000000;

  reg [6:0] State, NextState;

  //
  // Updates state or reset on every positive clock edge
  //

  always @(posedge Clock)
  begin
    if (Clear)
      State <= TAXI;
    else
      State <= NextState;
  end

  //
  // State Descriptions
  //
  // TAXI  Plane is on the ground -- this is the only state to reset the timer
  // TUP   Plane has taken off and requested the gear up but less than two seconds
  // TDN   Plane has taken off but not requested the gear up with less than two seconds
  // GOUP  Plane is in flight; gear is in motion being retracted
  // GODN  Plane is in flight; gear is in motion being extended
  // FLYUP Plane is in flight with the gear retracted
  // FLYDN Plane is in flight with the gear extended
  //

  always @(State)
  begin
    case (State)
      TAXI:
      begin
        RedLED = OFF;
        GrnLED = ON;
        Valve  = DOWN;
        Pump   = OFF;
        Timer  = RESET;
      end

      TUP:
      begin
        RedLED = OFF;
        GrnLED = ON;
        Valve  = UP;
        Pump   = OFF;
        Timer  = COUNT;
      end

      TDN:
      begin
        RedLED = OFF;
        GrnLED = ON;
        Valve  = DOWN;
        Pump   = OFF;
        Timer  = COUNT;
      end

      GOUP:
      begin
        RedLED = ON;
        GrnLED = OFF;
        Valve  = UP;
        Pump   = ON;
        Timer  = COUNT;
      end

      GODN:
      begin
        RedLED = ON;
        GrnLED = OFF;
        Valve  = DOWN;
        Pump   = ON;
        Timer  = COUNT;
      end

      FLYUP:
      begin
        RedLED = OFF;
        GrnLED = OFF;
        Valve  = UP;
        Pump   = OFF;
        Timer  = COUNT;
      end

      FLYDN:
      begin
        RedLED = OFF;
        GrnLED = ON;
        Valve  = DOWN;
        Pump   = OFF;
        Timer  = COUNT;
      end

    endcase
  end

  always @(State or GearIsDown or GearIsUp or PlaneOnGround or TimeUp or Lever)
  begin
    case (State)
      TAXI:
      begin
        if (PlaneOnGround == NO && Lever == UP)
          NextState = TUP;
        else if (PlaneOnGround == NO && Lever == DOWN)
          NextState = TDN;
        else
          NextState = TAXI;
      end

      TUP:
      begin
        if (PlaneOnGround)
          NextState = TAXI;
        else if (GearIsDown == NO)
          NextState = GOUP;
        else if (TimeUp == YES)
          NextState = FLYDN;
        else if (TimeUp == NO && Lever == DOWN)
          NextState = TDN;
        else
          NextState = TUP;
      end

      TDN:
      begin
        if (PlaneOnGround)
          NextState = TAXI;
        else if (GearIsDown == NO)
          NextState = GOUP;
        else if (TimeUp == YES)
          NextState = FLYDN;
        else if (TimeUp == NO && Lever == UP)
          NextState = TUP;
        else
          NextState = TDN;
      end

      GOUP:
      begin
        if (GearIsUp == YES)
          NextState = FLYUP;
        else
          NextState = GOUP;
      end

      GODN:
      begin
        if (PlaneOnGround == YES && GearIsDown == YES)
          NextState = TAXI;
        else if (GearIsDown == YES)
          NextState = FLYDN;
        else
          NextState = GODN;
      end

      FLYUP:
      begin
        if (Lever == DOWN)
          NextState = GODN;
        else
          NextState = FLYUP;
      end

      FLYDN:
      begin
        if (PlaneOnGround == YES)
          NextState = TAXI;
        else if (Lever == UP)
          NextState = GOUP;
        else
          NextState = FLYDN;
      end
    endcase
  end


endmodule
