Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2724C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFD72084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323941;
	bh=xlzni+FhpNXN6y3w7eBIoIm/EbFKwQzum9Lm5Sn/2Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VliA9B3R7uGnNPKK0tWLfYbKEolKO8nXBsD15Ymmd6F3OBdgZZWNmM9KHIYAfUtpM
	 mTowh4UrzbqFW6/3E0Rvg/IcIRV/2M/i4w0rCZU4ERKGEatUq66kMZ8WmLWsQ24k3g
	 xaplNKntDxslqAwVHUYktm0eQKTWfN8oiJ7g0bpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfAXJ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfAXJ6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:58:13 -0500
Received: from earth.universe (dyndsl-037-138-185-084.ewe-ip-backbone.de [37.138.185.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 294C5218AF;
        Thu, 24 Jan 2019 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323892;
        bh=xlzni+FhpNXN6y3w7eBIoIm/EbFKwQzum9Lm5Sn/2Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTGVeCQTvxnqTPDnTyz0Ck6jGSNSNC1KPF78Rjq0iRtglttL5voZNvK7McG8HFQ1O
         MZJDEJBa1dVEIq8pQY95qsl7/z3fiS2C+I3vFBwbckBeyY398vrKtobWIcUcTT5R+V
         79NJBAYBiIS0WqWyOXxf7cN2Qr8i3PygistXVUDg=
Received: by earth.universe (Postfix, from userid 1000)
        id 873823C08E7; Wed, 23 Jan 2019 21:47:57 +0100 (CET)
Date:   Wed, 23 Jan 2019 21:47:57 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 6/7] power: supply: olpc_battery: Avoid using
 platform_info
Message-ID: <20190123204757.itecyl4xtpp67zmq@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-7-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="loz5qj3zvcamwyuf"
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-7-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--loz5qj3zvcamwyuf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:40:04PM +0100, Lubomir Rintel wrote:
> This wouldn't work on the DT-based ARM platform. Let's read the EC version
> directly from the EC driver instead.
>=20
> This removes x86 specific bits that would prevent this driver from being
> used with the EC of ARM-based OLPC XO 1.75.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> ---
> Changes since v2:
> - Move the priv data allocation hunk from this patch to a proper place
>=20
> Changes since v1:
> - Use uint8_t instead of unsigned char [1] for ecver
>=20
>  drivers/power/supply/olpc_battery.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 1fcc459433a8..a6c89d002d5d 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -22,7 +22,6 @@
>  #include <linux/olpc-ec.h>
>  #include <asm/olpc.h>
> =20
> -
>  #define EC_BAT_VOLTAGE	0x10	/* uint16_t,	*9.76/32,    mV   */
>  #define EC_BAT_CURRENT	0x11	/* int16_t,	*15.625/120, mA   */
>  #define EC_BAT_ACR	0x12	/* int16_t,	*6250/15,    =B5Ah  */
> @@ -57,6 +56,7 @@ struct olpc_battery_data {
>  	struct power_supply *olpc_ac;
>  	struct power_supply *olpc_bat;
>  	char bat_serial[17];
> +	int new_proto;

bool?

-- Sebastian

>  };
> =20
>  /*********************************************************************
> @@ -100,7 +100,7 @@ static const struct power_supply_desc olpc_ac_desc =
=3D {
>  static int olpc_bat_get_status(struct olpc_battery_data *data,
>  		union power_supply_propval *val, uint8_t ec_byte)
>  {
> -	if (olpc_platform_info.ecver > 0x44) {
> +	if (data->new_proto) {
>  		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>  		else if (ec_byte & BAT_STAT_DISCHARGING)
> @@ -608,6 +608,7 @@ static int olpc_battery_probe(struct platform_device =
*pdev)
>  	struct power_supply_config psy_cfg =3D {};
>  	struct olpc_battery_data *data;
>  	uint8_t status;
> +	uint8_t ecver;
>  	int ret;
> =20
>  	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> @@ -615,13 +616,21 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, data);
> =20
> -	/*
> -	 * We've seen a number of EC protocol changes; this driver requires
> -	 * the latest EC protocol, supported by 0x44 and above.
> -	 */
> -	if (olpc_platform_info.ecver < 0x44) {
> +	/* See if the EC is already there and get the EC revision */
> +	ret =3D olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (ecver > 0x44) {
> +		/* XO 1 or 1.5 with a new EC firmware. */
> +		data->new_proto =3D 1;
> +	} else if (ecver < 0x44) {
> +		/*
> +		 * We've seen a number of EC protocol changes; this driver
> +		 * requires the latest EC protocol, supported by 0x44 and above.
> +		 */
>  		printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
> -			"battery driver.\n", olpc_platform_info.ecver);
> +			"battery driver.\n", ecver);
>  		return -ENXIO;
>  	}
> =20
> --=20
> 2.20.1
>=20

--loz5qj3zvcamwyuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxI0v0ACgkQ2O7X88g7
+poojA/+Pp8cZN6ftzO0ho/7ChbDh8qp9W4fdFk7ZtJWiAl1eXyHGRbd5OsmWBcO
Vm/CD7VR2/vu+vdqUKyoEYDdmvimwZuZBmbyxAC1XltjoZj8SAcmU2QmlUcEpKtS
0uSSV50f8FUun+gJN510KWLKq2MImMyB8HZecglFSuFze9A7tZDSIaECJx/AB1w0
z2+TMbHaFhchZgM8y9Pi5pdBHOt2W0CHg4pD9qqSB5ioDnDwUwXibbqIbTimPpiG
f4UHx6lYvmfIxoxhlqVRCNMJci10yifaYmhmGiaWbPc7SrPmS7FSdVSe45XJK6iq
wNae2A1hZc8jZa5vxiDyqNEipXFk4erOqXsIXnvcbMnupAivMduxgurKO5NaSYwD
UTm63wmULoe2SHpfpl99pS2Vb42iAgI8o+OKmpWCmLda9n/I9wULUA/ebTi1GA6i
MX/MfKZ2LTDJqqi7Q5O52niuFhbQvVAtm4wP8ogqWU1AKpyKeGHJsk9D0l4zK6lA
N9GaJ+4nO2u83mHpdQ1STyMgCaOB12rNWFnl5klGDrwOF+F3kvIA+rZQ71c9PVZF
7dM+l5+z0yM9YY8HRHNDbNA9A6yiQCFRNaqVJXUmZATXzoxmKtx2+7jFWzFNmPdh
7P/FS+jdJ5hAA0lbZ0BletOuDYcxShJCjz1g1fs1akbpMJuvgD8=
=Vt+p
-----END PGP SIGNATURE-----

--loz5qj3zvcamwyuf--
