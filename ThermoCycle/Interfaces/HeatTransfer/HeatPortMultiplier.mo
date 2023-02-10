within ThermoCycle.Interfaces.HeatTransfer;
model HeatPortMultiplier
  "Convert single heatport into one multi-port"
  parameter Integer N = 10;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[N]
                                                  multi
    annotation (Placement(transformation(extent={{-36,28},{36,42}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                                                   single
     annotation (Placement(transformation(extent={{-36,-48},{36,-34}})));
equation
  single.T = sum(multi.T)/N;

  for i in 1:N loop
    //single.T = multi[1].T;
    //single.phi = -multi.phi[i];
    single.Q_flow/N = -multi[i].Q_flow;

  end for;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
          extent={{-34,-20},{34,-34}},
          lineColor={0,0,255},
          textString="Single"), Text(
          extent={{-34,26},{34,12}},
          lineColor={0,0,255},
          textString="Multi")}));
end HeatPortMultiplier;
