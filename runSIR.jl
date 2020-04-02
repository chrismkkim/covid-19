using CSV
using DataFrames
using PyPlot

include("SICR.jl")

# csvfile = CSV.File("covid_timeseries_United Kingdom.csv")
csvfile = CSV.File("covid_timeseries_Korea, South.csv")
# csvfile = CSV.File("covid_timeseries_China.csv")
dfuk = DataFrame(csvfile)
colsuk = [5, 3, 4]
# N = 6.67e6 #UK
# N = 1.0e5 #China
N = 2.5e6
@time outuk = mcmc(dfuk,colsuk,rand(7),N,Int(3e5),sicrqmitigate!,1000.)
@time outuk = mcmc(dfuk,colsuk,outuk[2][end,:],N,Int(3e5),sicrqmitigate!,10.)
@time outuk = mcmc(dfuk,colsuk,outuk[2][end,:],N,Int(3e5),sicrqmitigate!,10.)
# @time outuk = mcmc(dfuk,colsuk,outuk[2][end,:],N,Int(3e5),sicrq!,10.)
# @time outuk = mcmc(dfuk,colsuk,outuk[2][end,:],N,Int(3e5),sicrq!,10.)
# @time outuk = mcmc(dfuk,colsuk,outuk[2][end,:],N,Int(3e5),sicrq!,10.)
# @time outuk = mcmc(dfuk,colsuk,outuk[2][end,:],N,Int(3e5),sicrq!,10.)
# @time outuk = mcmc(dfuk,colsuk,outuk[2][end,:],N,Int(3e5),sicrq!,10.)

puk = outuk[end]
pred, data, days = modelprediction(dfuk,colsuk,puk,N,sicrqmitigate!);

figure()
plot(outuk[1])

figure()
makehistograms(outuk[2])

figure(figsize=(12,5))
subplot(1,3,1)
plot(days,pred[:,1],color="k",linewidth=5)
plot(days,data[:,1],color="r",linewidth=2)
title("active",fontsize=15)
subplot(1,3,2)
plot(days,pred[:,2],color="k",linewidth=5)
plot(days,data[:,2],color="r",linewidth=2)
title("recovered",fontsize=15)
subplot(1,3,3)
plot(days,pred[:,3],color="k",linewidth=5)
plot(days,data[:,3],color="r",linewidth=2)
title("death",fontsize=15)




# @time out = mcmc(dfuk,[8,3,4],ones(6),6.67e7,10);
# @time out = mcmc(dfuk,[8,3,4],ones(6),6.67e7,100000);

# column 2, 3, 4: cum_cases, cum_deaths, cum_recover

# csvfile = CSV.File("covid_timeseries_Italy.csv")
# dfitaly = DataFrame(csvfile)
# dfitaly[:,:active] = dfitaly[:,:cum_cases] - dfitaly[:,:cum_recover] - dfitaly[:,:cum_deaths]

# @time out = mcmc(dfitaly,[5,6,7],[.2,.1,.1,.1,10.],6.05e7,100000);
# column 5, 6, 7: cum_cases, cum_deaths, cum_recover

# csvfile = CSV.File("covid_timeseries_Hubei.csv")
# dfhubei = DataFrame(csvfile)
# dfhubei[:,:active] = dfhubei[:,:cum_cases] - dfhubei[:,:cum_recover] - dfhubei[:,:cum_deaths]
# out = 0 # reset
# @time out = mcmc(dfhubei,[11,5,6],ones(6),81000,Int(10));
# @time out = mcmc(dfhubei,[11,5,6],ones(6),81000,Int(30e5));
# # @time out = mcmc(dfhubei,[11,5,6],ones(6),1.0e5,Int(30e5));

# csvfile = CSV.File("covid_timeseries_Korea, South.csv")
# dfkorea = DataFrame(csvfile)
# out = 0 # reset
# @time out = mcmc(dfkorea,[5,3,4],ones(6),5e7,Int(10));
# @time out = mcmc(dfkorea,[5,3,4],ones(6),5e7,Int(30e5));

# csvfile = CSV.File("covid_timeseries_New York.csv")
# dfny = DataFrame(csvfile)

# pout = out[2];
# plotPout(pout)