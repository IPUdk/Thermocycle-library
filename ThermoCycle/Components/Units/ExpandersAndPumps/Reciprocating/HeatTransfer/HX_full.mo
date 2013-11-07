within ThermoCycle.Components.Units.ExpandersAndPumps.Reciprocating.HeatTransfer;
model HX_full "A combination of Cylinder model and a reciprocating machine"
  replaceable package WorkingFluid = ThermoCycle.Media.R134aCP;
  //ThermoCycle.Media.R134aCP;
  //ThermoCycle.Media.AirCP;
  //CoolProp2Modelica.Media.R601_CP;
  //Modelica.Media.Air.DryAirNasa;
  //constrainedby Modelica.Media.Interfaces.PartialMedium;

  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  inner Modelica.Fluid.System system(p_start=2000000, T_start=473.15)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  RecipMachine_Flange recipFlange(redeclare StrokeBoreGeometry geometry)
    annotation (Placement(transformation(extent={{0,-40},{40,0}})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor wall(T(start=system.T_start),
      C=0.5*2500)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));

  Cylinder cylinder(
    redeclare package Medium = WorkingFluid,
    pistonCrossArea=Modelica.Constants.pi*recipFlange.geometry.r_piston^2,
    use_portsData=false,
    p_start=system.p_start,
    T_start=system.T_start)
    annotation (Placement(transformation(extent={{-100,40},{-80,20}})));
  Cylinder annand(
    redeclare package Medium = WorkingFluid,
    use_portsData=false,
    p_start=system.p_start,
    T_start=system.T_start,
    pistonCrossArea=cylinder.pistonCrossArea,
    redeclare model HeatTransfer =
        ThermoCycle.Components.Units.ExpandersAndPumps.Reciprocating.HeatTransfer.Annand1963,
    use_angle_in=true,
    stroke=recipFlange.stroke,
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{-70,40},{-50,20}})));

  Cylinder woschni(
    redeclare package Medium = WorkingFluid,
    use_portsData=false,
    p_start=system.p_start,
    T_start=system.T_start,
    pistonCrossArea=cylinder.pistonCrossArea,
    use_angle_in=true,
    stroke=recipFlange.stroke,
    redeclare model HeatTransfer =
        ThermoCycle.Components.Units.ExpandersAndPumps.Reciprocating.HeatTransfer.Woschni1967,
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{-40,40},{-20,20}})));

  Cylinder adair(
    redeclare package Medium = WorkingFluid,
    use_portsData=false,
    p_start=system.p_start,
    T_start=system.T_start,
    pistonCrossArea=cylinder.pistonCrossArea,
    use_HeatTransfer=true,
    use_angle_in=true,
    stroke=recipFlange.stroke,
    redeclare model HeatTransfer =
        ThermoCycle.Components.Units.ExpandersAndPumps.Reciprocating.HeatTransfer.Adair1972)
    annotation (Placement(transformation(extent={{-10,40},{10,20}})));
  Cylinder destoop(
    redeclare package Medium = WorkingFluid,
    use_portsData=false,
    p_start=system.p_start,
    T_start=system.T_start,
    pistonCrossArea=cylinder.pistonCrossArea,
    use_angle_in=true,
    stroke=recipFlange.stroke,
    redeclare model HeatTransfer =
        ThermoCycle.Components.Units.ExpandersAndPumps.Reciprocating.HeatTransfer.Destoop1986,
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{20,40},{40,20}})));

  Cylinder kornhauser(
    redeclare package Medium = WorkingFluid,
    use_portsData=false,
    p_start=system.p_start,
    T_start=system.T_start,
    pistonCrossArea=cylinder.pistonCrossArea,
    use_HeatTransfer=true,
    use_angle_in=true,
    stroke=recipFlange.stroke,
    redeclare model HeatTransfer =
        ThermoCycle.Components.Units.ExpandersAndPumps.Reciprocating.HeatTransfer.Kornhauser1994)
    annotation (Placement(transformation(extent={{50,40},{70,20}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    phi(fixed=true, start=0),
    w(start=10, fixed=true),
    J=200) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
equation
  connect(recipFlange.crankShaft_a, speed.flange) annotation (Line(
      points={{40,-30},{60,-30}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(recipFlange.crankShaft_a, angleSensor.flange) annotation (Line(
      points={{40,-30},{40,-10},{60,-10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(cylinder.flange, annand.flange) annotation (Line(
      points={{-90,20},{-60,20}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(annand.flange, woschni.flange) annotation (Line(
      points={{-60,20},{-30,20}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(woschni.flange, adair.flange) annotation (Line(
      points={{-30,20},{0,20}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(adair.flange, destoop.flange) annotation (Line(
      points={{0,20},{30,20}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(destoop.flange, kornhauser.flange) annotation (Line(
      points={{30,20},{60,20}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(annand.heatPort, wall.port) annotation (Line(
      points={{-70,30},{-70,60},{0,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(woschni.heatPort, wall.port) annotation (Line(
      points={{-40,30},{-40,60},{5.55112e-16,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(adair.heatPort, wall.port) annotation (Line(
      points={{-10,30},{-10,60},{5.55112e-16,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(destoop.heatPort, wall.port) annotation (Line(
      points={{20,30},{20,60},{0,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(kornhauser.heatPort, wall.port) annotation (Line(
      points={{50,30},{50,60},{5.55112e-16,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(annand.angle_in, angleSensor.phi) annotation (Line(
      points={{-50,30},{-50,50},{90,50},{90,-10},{81,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(woschni.angle_in, angleSensor.phi) annotation (Line(
      points={{-20,30},{-20,50},{90,50},{90,-10},{81,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(adair.angle_in, angleSensor.phi) annotation (Line(
      points={{10,30},{10,50},{90,50},{90,-10},{81,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(destoop.angle_in, angleSensor.phi) annotation (Line(
      points={{40,30},{40,50},{90,50},{90,-10},{81,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(kornhauser.angle_in, angleSensor.phi) annotation (Line(
      points={{70,30},{70,50},{90,50},{90,-10},{81,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(destoop.flange, recipFlange.flange_a) annotation (Line(
      points={{30,20},{20,20},{20,0}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(inertia.flange_b, recipFlange.crankShaft_b) annotation (Line(
      points={{-20,-30},{8.88178e-16,-30}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(extent={{-100,-80},{100,80}},
          preserveAspectRatio=false),
                      graphics), Icon(coordinateSystem(extent={{-100,-80},{100,
            80}})));
end HX_full;
