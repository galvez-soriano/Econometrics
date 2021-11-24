*
cd "C:\Users\galve\Documents\UH\Fall 21\Econometrics\PS4\General"

use murder_long.dta, clear
drop if year==87

reg mrdrte exec unem

xtset id year
xtreg mrdrte exec unem, fe

areg mrdrte exec unem, absorb(id)

tab id, gen(dumstate)
reg mrdrte exec unem dumstate*

xi: reg mrdrte exec unem i.id

egen meanm=mean( mrdrte), by(id)
egen meane=mean( exec), by(id)
egen meanu=mean( unem), by(id)

gen dm= mrdrte- meanm
gen de= exec- meane
gen du= unem- meanu

reg dm de du, noc

