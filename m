Return-Path: <monstr@monstr.eu>
ARC-Seal: i=1; a=rsa-sha256; t=1524472642; cv=none;
        d=google.com; s=arc-20160816;
        b=RDNMQif7ugIt8S2+JtGSaYBE9okwQyX2LzHicTB6g3eQQ5X8a8Nm2sDfwh2suWVuOV
         uNQttw5cfbQBgHw/8d5Ne7RCj7Uy6tlejedRyqrKvP2Tr5csb4fdRl5kaotSGVEKsfkZ
         V1co38HNhYZcHseBOUln5qI2dyUGAiBYCaFLXVn+XzZLtpzi3dvifkDgiU7eUhO5HcvA
         FmLSxFNC9uESu4f5u6FzzNumSCJnSzHmMPzvn4jGFJs/Oht/cr2ec5in55D6eRwkp8ZN
         WPKFGaC1dto/L2tJMUHZWOD8vOU2tg4QKIxzE9y1VhnUrasr7T99ONOv1JD03IksrDsk
         uWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:openpgp:from
         :references:cc:to:subject:reply-to:dkim-signature
         :arc-authentication-results;
        bh=9xgUyubzhWXLSFeH+U6XjqG2NinOjaCd7/2nU69thIg=;
        b=Sxv1/SBHDGIfJv5G/XHY2jJfuf9uT0xuNj8yDYj6GhTrYq8ZX5PK67b8gx134evP8G
         /KFssYoeiI0SciFNpPX0RI74o7+lYPSGVS5JDaQdwhgbvYkJXPdxhiErnopL6q0VMJr2
         XoLUIrg47PfzIIaIJwEfx5Os3lHVVfcSN7sCYwAPQ4r+YfAOq0hT+JFSN2dPSVKLfzik
         wnHDcb1VkviH3FEJng33e+/AFdOU/hlNvzuX+BXnFG0Th8Z6hULFAUWuFr45D0zO8k8Q
         dNFaxln/gGcj7UWYTsYyky0kHqMj5abmZKHQXhtd0CG1FkkbX9wWELV41iIO4O7SdNVt
         CynQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=ZhYmtr5o;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=ZhYmtr5o;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
X-Google-Smtp-Source: AB8JxZo3EiLeColKYTt4wGkJpwSvT4BMD+fD3FEUgtK+CnvIAJglscqRG/cp98P7QNuXJWAMW+UuYA==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] tty: serial: xuartps: Setup early console when uartclk is
 also passed
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
 <20180423080641.GA20149@kroah.com>
From: Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Message-ID: <ebc1b162-c5bf-3963-05ab-4b236f89966a@monstr.eu>
Date: Mon, 23 Apr 2018 10:37:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423080641.GA20149@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XGTjHajY7qfXSCDNdLgqD6Vk4aEUur3dO"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597366305687856782?=
X-GMAIL-MSGID: =?utf-8?q?1598525424350497798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XGTjHajY7qfXSCDNdLgqD6Vk4aEUur3dO
Content-Type: multipart/mixed; boundary="KPaznCRZjRlxfSqw507PZC086LxXJF86E";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <ebc1b162-c5bf-3963-05ab-4b236f89966a@monstr.eu>
Subject: Re: [PATCH] tty: serial: xuartps: Setup early console when uartclk is
 also passed
References: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
 <20180423080641.GA20149@kroah.com>
In-Reply-To: <20180423080641.GA20149@kroah.com>

--KPaznCRZjRlxfSqw507PZC086LxXJF86E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.4.2018 10:06, Greg Kroah-Hartman wrote:
> On Tue, Apr 10, 2018 at 03:33:30PM +0200, Michal Simek wrote:
>> Baudrate calculation depends on requested baudrate and uart clock.
>> This patch is checking that uartclk is also passed.
>>
>> The same logic is used 8250_early.c/init_port function.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/x=
ilinx_uartps.c
>> index b9b2bc76bcac..a654cda203c7 100644
>> --- a/drivers/tty/serial/xilinx_uartps.c
>> +++ b/drivers/tty/serial/xilinx_uartps.c
>> @@ -1181,7 +1181,7 @@ static int __init cdns_early_console_setup(struc=
t earlycon_device *device,
>>  	/* only set baud if specified on command line - otherwise
>>  	 * assume it has been initialized by a boot loader.
>>  	 */
>> -	if (device->baud) {
>> +	if (port->uartclk && device->baud) {
>>  		u32 cd =3D 0, bdiv =3D 0;
>>  		u32 mr;
>>  		int div8;
>> --=20
>> 1.9.1
>=20
> This patch conflicts with the previous patch you sent: Subject: [PATCH]=

> serial: xuartps: Fix the early_console junk character issue
>=20
> So, which one should I apply?
>=20
> I've dropped both from my review queue now, please resend the one(s) yo=
u
> want applied, in a patch series if needed.

First of all thanks for dropping. I forget that I have sent it in past.

Both patches are targeting the same problem. The first one is more
destructive.

And this one is what 8250 is doing.

I have also sent
"[PATCH] earlycon: Initialize port->uartclk based on clock-frequency
property" which is filling uartclk based on DT to do proper divider
calculation.

It means when patch above is applied we can keep divider calculation in
the driver because it is using right values. If not we need to remove
that baudrate calculation because it is not correct (uartclk is
hardcoded to BASE_BAUD * 16 in of_setup_earlycon).
And it is really a question if "port->uartclk =3D BASE_BAUD * 16" should
be in of_setup_earlycon.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--KPaznCRZjRlxfSqw507PZC086LxXJF86E--

--XGTjHajY7qfXSCDNdLgqD6Vk4aEUur3dO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlrdmzgACgkQykllyylKDCHrfwCfffPyzm2suay6gS7WHBXfUFBJ
s8QAnA9jh/b+Vh6nP47P4wViogwE6Efg
=6k+y
-----END PGP SIGNATURE-----

--XGTjHajY7qfXSCDNdLgqD6Vk4aEUur3dO--
