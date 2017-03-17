fit = lm(Difference ~ Death_Ratio + Injured_ratio + Disaster_Mag + Total_Damage_Ratio, data = Final)
summary(fit)
plot(fit)
