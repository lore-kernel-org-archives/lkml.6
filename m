Return-Path: <john3909@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524333875; cv=none;
        d=google.com; s=arc-20160816;
        b=g+70M+DcsearwQ8QRBzSOD4fC6SHRipF+G/rTv47GaF6NmIDHwvmYceKzVmqoLlM7D
         IGfpz3hZMoh8Mus0r2IG1hdj/pcm9jQOnN67raO+Kp9gFBaJeU9ZBTVx6jVKcvApUm3E
         TzW7rbKZ4X7kzmLTKgb9llQP/M+T7XcPrLqoS9ODX8kr5rmKrJHSoWsVAhC9f+Bd9HRv
         1+4W0mPjLNazKqFAF33HYvBri1Cj0ReFbqnW33s/4dehDGi7irNMZxn1WLkk9jvnSwlC
         uGogs518sKYIBvbQgSFxjDaOGDl+lCt1dhzWF9z2U7qkMYdOTq9wBIknLvd45/ueW3nK
         7hMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:dkim-signature:arc-authentication-results;
        bh=QM4oF3Ls1g8m7r3CMibkDPy1LldhwF6dEQTRqH84msU=;
        b=YMUdvLR8Jc834noqneBFBuDNZ+cgs1cdJB7ziDnCxmjTJqgNyGut7oS5luw76QUa0k
         M6FsPCQ3pHqCNhyOWIlAD9fBMosuN/y9MewZyHSdsoTbyNgM51h0GEUHMyexzpa9I9Jz
         L/VlaOwvMa050KQU5Zv8wGsN9FoXVr1Md9oV2AqMwYBfuD7fzS+tsT5EtYP/pY/U+7Ca
         la7jLJ3LqmNjFizEGMdCtr6j9J0SmLDglRfIdRrQBv5W0ZIOalKqMXPim9JIs0/kXyGz
         Zpx7ZD+gY7rGUIzQ63SAH21Bhq8UW+1Q2z7e/DpZqHkUjVgnAeyGIjXL3jXXXER7T7Qw
         IqNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=slryGsD9;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=slryGsD9;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49iOBRTmgd9B+Wp0iNCJJlPQCmVuZI8aX8hxbvXHVPv8K94nKzDMQS72AKkjI6P14ezNWbBSw==
From: John Syne <john3909@gmail.com>
Message-Id: <7D2111AF-E3C0-479E-9AC2-F91F9BE9316B@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_A431DB94-1476-4891-AAB2-9C29A07C0133"
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 3/3] stagging:iio:meter: Add ade7854_write_raw function
Date: Sat, 21 Apr 2018 11:04:26 -0700
In-Reply-To: <20180421182608.3371a50b@archlinux>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <82a36a0f4ee84d8ff53be2055bad22be4b75634a.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <20180421182608.3371a50b@archlinux>
X-Mailer: Apple Mail (2.3445.6.18)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598356754160899697?=
X-GMAIL-MSGID: =?utf-8?q?1598379917710792752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Apple-Mail=_A431DB94-1476-4891-AAB2-9C29A07C0133
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



Regards,
John





> On Apr 21, 2018, at 10:26 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>=20
> On Sat, 21 Apr 2018 08:56:19 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com =
<mailto:rodrigosiqueiramelo@gmail.com>> wrote:
>=20
>> This patch adds the ade7854_write_raw() function which is responsible
>> for handling the write operation for registers: AIGAIN, BIGAIN, =
CIGAIN,
>> NIGAIN, AVGAIN, BVGAIN, and CVGAIN. Finally, this patch completely
>> removes the old ABI used for handling the registers mentioned above.
>>=20
>> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com =
<mailto:rodrigosiqueiramelo@gmail.com>>
> The baby steps approach here is good, but with all 3 patches as one it
> would have been a lot easier to follow.
>=20
> This is almost fine except for the issue I had with how the channels
> were defined in the first place.
>=20
> Also a question about scales inline...
>=20
>> ---
>> drivers/staging/iio/meter/ade7854.c | 60 =
++++++++++++-----------------
>> 1 file changed, 25 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/drivers/staging/iio/meter/ade7854.c =
b/drivers/staging/iio/meter/ade7854.c
>> index 242ecde75900..df19c8b4b5d7 100644
>> --- a/drivers/staging/iio/meter/ade7854.c
>> +++ b/drivers/staging/iio/meter/ade7854.c
>> @@ -228,34 +228,6 @@ static int ade7854_reset(struct device *dev)
>> 	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
>> }
>>=20
>> -static IIO_DEV_ATTR_AIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_AIGAIN);
>> -static IIO_DEV_ATTR_BIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_BIGAIN);
>> -static IIO_DEV_ATTR_CIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_CIGAIN);
>> -static IIO_DEV_ATTR_NIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_NIGAIN);
>> -static IIO_DEV_ATTR_AVGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_AVGAIN);
>> -static IIO_DEV_ATTR_BVGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_BVGAIN);
>> -static IIO_DEV_ATTR_CVGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_CVGAIN);
>> static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
>> 		ade7854_read_24bit,
>> 		ade7854_write_24bit,
>> @@ -497,6 +469,30 @@ static int ade7854_read_raw(struct iio_dev =
*indio_dev,
>> 	return -EINVAL;
>> }
>>=20
>> +static int ade7854_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int val, int val2, long mask)
>> +{
>> +	struct ade7854_state *st =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	if (mask !=3D IIO_CHAN_INFO_SCALE)
>> +		return -EINVAL;
>> +
>> +	switch (chan->type) {
>> +	case IIO_CURRENT:
>> +	case IIO_VOLTAGE:
> Probably need some range checking to make sure we have a sane value.
>=20
> Also, I'm curious about units here.
>=20
> you are using CHAN_INFO_SCALE which would mean this is linked to
> the _RAW value (the actual reading of the channel) by _RAW*_SCALE =3D =
value in
> defined base units for the channel type.  So I'd expect to see some
> code here doing a conversion to the internal format for the device.
These should be IIO_CHAN_INFO_HARDWAREGAIN as they are used to correct=20=

any imperfections of the sensors. A user space application calculates =
the error and
based on a formula determines the correct register value.=20

Meter values such as Voltage, Current, Power, Energy use a value/LSB =
method,=20
which is determined while applying a known voltage and current. After =
that, any
parameter is multiplied by the respective value/LSB to get a real world =
value.=20

Regards,
John
>=20
> I wouldn't expect to see a value from userspace written unconverted
> into the register.
>=20
> (I missed this in the previous patch - sorry).
>=20
> Jonathan
>=20
>> +		ret =3D st->write_reg(&indio_dev->dev, chan->address, =
val, 24);
>> +		if (ret < 0)
>> +			return ret;
>> +		return 0;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> static int ade7854_initial_setup(struct iio_dev *indio_dev)
>> {
>> 	int ret;
>> @@ -521,13 +517,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");
>> static IIO_CONST_ATTR(name, "ade7854");
>>=20
>> static struct attribute *ade7854_attributes[] =3D {
>> -	&iio_dev_attr_aigain.dev_attr.attr,
>> -	&iio_dev_attr_bigain.dev_attr.attr,
>> -	&iio_dev_attr_cigain.dev_attr.attr,
>> -	&iio_dev_attr_nigain.dev_attr.attr,
>> -	&iio_dev_attr_avgain.dev_attr.attr,
>> -	&iio_dev_attr_bvgain.dev_attr.attr,
>> -	&iio_dev_attr_cvgain.dev_attr.attr,
>> 	&iio_dev_attr_linecyc.dev_attr.attr,
>> 	&iio_dev_attr_sagcyc.dev_attr.attr,
>> 	&iio_dev_attr_cfcyc.dev_attr.attr,
>> @@ -599,6 +588,7 @@ static const struct attribute_group =
ade7854_attribute_group =3D {
>> static const struct iio_info ade7854_info =3D {
>> 	.attrs =3D &ade7854_attribute_group,
>> 	.read_raw =3D &ade7854_read_raw,
>> +	.write_raw =3D &ade7854_write_raw,
>> };
>>=20
>> int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)


--Apple-Mail=_A431DB94-1476-4891-AAB2-9C29A07C0133
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div class=3D"">
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""><br class=3D"Apple-interchange-newline">Regards,</div><div =
class=3D"">John</div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div></div><br =
class=3D"Apple-interchange-newline" style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;"><br =
class=3D"Apple-interchange-newline">

</div>
<div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Apr 21, 2018, at 10:26 AM, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org" class=3D"">jic23@kernel.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">On Sat, 21 Apr 2018 08:56:19 =
-0300</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">Rodrigo =
Siqueira &lt;</span><a href=3D"mailto:rodrigosiqueiramelo@gmail.com" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D"">rodrigosiqueiramelo@gmail.com</a><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">&gt; wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">This patch adds the =
ade7854_write_raw() function which is responsible<br class=3D"">for =
handling the write operation for registers: AIGAIN, BIGAIN, CIGAIN,<br =
class=3D"">NIGAIN, AVGAIN, BVGAIN, and CVGAIN. Finally, this patch =
completely<br class=3D"">removes the old ABI used for handling the =
registers mentioned above.<br class=3D""><br class=3D"">Signed-off-by: =
Rodrigo Siqueira &lt;<a href=3D"mailto:rodrigosiqueiramelo@gmail.com" =
class=3D"">rodrigosiqueiramelo@gmail.com</a>&gt;<br =
class=3D""></blockquote><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">The baby steps approach here is good, but with all 3 patches =
as one it</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">would have =
been a lot easier to follow.</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">This is almost fine except for the issue I had with how the =
channels</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">were defined =
in the first place.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Also a question about scales inline...</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">---<br =
class=3D"">drivers/staging/iio/meter/ade7854.c | 60 =
++++++++++++-----------------<br class=3D"">1 file changed, 25 =
insertions(+), 35 deletions(-)<br class=3D""><br class=3D"">diff --git =
a/drivers/staging/iio/meter/ade7854.c =
b/drivers/staging/iio/meter/ade7854.c<br class=3D"">index =
242ecde75900..df19c8b4b5d7 100644<br class=3D"">--- =
a/drivers/staging/iio/meter/ade7854.c<br class=3D"">+++ =
b/drivers/staging/iio/meter/ade7854.c<br class=3D"">@@ -228,34 +228,6 @@ =
static int ade7854_reset(struct device *dev)<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
st-&gt;write_reg(dev, ADE7854_CONFIG, val, 16);<br class=3D"">}<br =
class=3D""><br class=3D"">-static IIO_DEV_ATTR_AIGAIN(0644,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>NULL,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7854_write_24bit,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7854_AIGAIN);<br class=3D"">-static =
IIO_DEV_ATTR_BIGAIN(0644,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>NULL,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7854_write_24bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7854_BIGAIN);<br =
class=3D"">-static IIO_DEV_ATTR_CIGAIN(0644,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>NULL,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7854_write_24bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7854_CIGAIN);<br =
class=3D"">-static IIO_DEV_ATTR_NIGAIN(0644,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>NULL,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7854_write_24bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7854_NIGAIN);<br =
class=3D"">-static IIO_DEV_ATTR_AVGAIN(0644,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>NULL,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7854_write_24bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7854_AVGAIN);<br =
class=3D"">-static IIO_DEV_ATTR_BVGAIN(0644,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>NULL,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7854_write_24bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7854_BVGAIN);<br =
class=3D"">-static IIO_DEV_ATTR_CVGAIN(0644,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>NULL,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7854_write_24bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7854_CVGAIN);<br =
class=3D"">static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7854_read_24bit,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7854_write_24bit,<br =
class=3D"">@@ -497,6 +469,30 @@ static int ade7854_read_raw(struct =
iio_dev *indio_dev,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -EINVAL;<br class=3D"">}<br =
class=3D""><br class=3D"">+static int ade7854_write_raw(struct iio_dev =
*indio_dev,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;struc=
t iio_chan_spec const *chan,<br class=3D"">+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;int =
val, int val2, long mask)<br class=3D"">+{<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
ade7854_state *st =3D iio_priv(indio_dev);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int =
ret;<br class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (mask !=3D =
IIO_CHAN_INFO_SCALE)<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -EINVAL;<br class=3D"">+<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>switch (chan-&gt;type) {<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>case =
IIO_CURRENT:<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>case IIO_VOLTAGE:<br =
class=3D""></blockquote><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Probably need some range checking to make sure we have a sane =
value.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">Also, I'm =
curious about units here.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">you are using CHAN_INFO_SCALE which would mean this is linked =
to</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">the _RAW =
value (the actual reading of the channel) by _RAW*_SCALE =3D value =
in</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">defined base =
units for the channel type. &nbsp;So I'd expect to see some</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">code here doing a conversion to =
the internal format for the device.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote>These should be =
IIO_CHAN_INFO_HARDWAREGAIN as they are used to =
correct&nbsp;</div><div>any imperfections of the sensors. A user space =
application calculates the error and</div><div>based on a formula =
determines the correct register value.&nbsp;</div><div><br =
class=3D""></div><div>Meter values such as Voltage, Current, Power, =
Energy use a value/LSB method,&nbsp;</div><div>which is determined while =
applying a known voltage and current. After that, =
any</div><div>parameter is multiplied by the respective value/LSB to get =
a real world value.&nbsp;</div><div><br =
class=3D""></div><div>Regards,</div><div>John</div><div><blockquote =
type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">I wouldn't expect to see a value from userspace written =
unconverted</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">into the =
register.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">(I missed =
this in the previous patch - sorry).</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Jonathan</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
st-&gt;write_reg(&amp;indio_dev-&gt;dev, chan-&gt;address, val, 24);<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (ret &lt; 0)<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return ret;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
0;<br class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>default:<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>break;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>}<br =
class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -EINVAL;<br class=3D"">+}<br=
 class=3D"">+<br class=3D"">static int ade7854_initial_setup(struct =
iio_dev *indio_dev)<br class=3D"">{<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int =
ret;<br class=3D"">@@ -521,13 +517,6 @@ static =
IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");<br class=3D"">static =
IIO_CONST_ATTR(name, "ade7854");<br class=3D""><br class=3D"">static =
struct attribute *ade7854_attributes[] =3D {<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_aigain.dev_attr.attr,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_bigain.dev_attr.attr,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_cigain.dev_attr.attr,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_nigain.dev_attr.attr,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_avgain.dev_attr.attr,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_bvgain.dev_attr.attr,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_cvgain.dev_attr.attr,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_linecyc.dev_attr.attr,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_sagcyc.dev_attr.attr,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&amp;iio_dev_attr_cfcyc.dev_attr.attr,<br class=3D"">@@ -599,6 =
+588,7 @@ static const struct attribute_group ade7854_attribute_group =3D =
{<br class=3D"">static const struct iio_info ade7854_info =3D {<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>.attrs =3D &amp;ade7854_attribute_group,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>.read_raw =
=3D &amp;ade7854_read_raw,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.write_raw =3D =
&amp;ade7854_write_raw,<br class=3D"">};<br class=3D""><br class=3D"">int =
ade7854_probe(struct iio_dev *indio_dev, struct device =
*dev)</blockquote></div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_A431DB94-1476-4891-AAB2-9C29A07C0133--
