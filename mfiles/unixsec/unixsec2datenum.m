function dn = unixsec2datenum(secs)

error(nargchk(1, 1, nargin));

[year, month, day, hour, minute, second] ...
    = jd2date(secs / 86400 + date2jd(1970, 1, 1));
dn = datenum(year, month, day, hour, minute, second);

