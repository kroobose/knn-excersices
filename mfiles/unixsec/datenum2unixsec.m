function secs = datenum2unixsec( dn )

error(nargchk(1, 1, nargin));
[year, month, day, hour, minute, second] = datevec(dn);

secs = 86400 * (date2jd(year,month,day,hour,minute,second) - ...
		date2jd(1970, 1, 1));


