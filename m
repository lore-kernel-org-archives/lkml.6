Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DB02BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB4E20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB4E20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935546AbeFMMDQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:03:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935106AbeFMMDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:03:13 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fT4UR-00053x-DK; Wed, 13 Jun 2018 14:03:03 +0200
Subject: Re: [PATCH v7 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
To:     Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-6-o.rempel@pengutronix.de>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <503b7af3-6a6a-1ed9-e2b6-609da537c855@pengutronix.de>
Date:   Wed, 13 Jun 2018 14:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180517055014.6607-6-o.rempel@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PAdCPQPW3BM1XfBSmjcmXXJJqHNDNxnVP"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PAdCPQPW3BM1XfBSmjcmXXJJqHNDNxnVP
Content-Type: multipart/mixed; boundary="ebaSKat60fCA9TqMPHx77ey6XsIur2bCf";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>
Message-ID: <503b7af3-6a6a-1ed9-e2b6-609da537c855@pengutronix.de>
Subject: Re: [PATCH v7 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-6-o.rempel@pengutronix.de>
In-Reply-To: <20180517055014.6607-6-o.rempel@pengutronix.de>

--ebaSKat60fCA9TqMPHx77ey6XsIur2bCf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Rob ACKed DT bindings, Rafael ACKed export of pm_power_off_prepare. I
need your OK for regulator patch.

On 17.05.2018 07:50, Oleksij Rempel wrote:
> On some boards the SoC can use one pin "PMIC_STBY_REQ" to notify th PMI=
C
> about state changes. In this case internal state of PMIC must be
> preconfigured for upcomming state change.
> It works fine with the current regulator framework, except with the
> power-off case.
>=20
> This patch is providing an optional pm_power_off_prepare handler
> which will configure standby state of the PMIC to disable all power lin=
es.
>=20
> In my power consumption test on RIoTBoard, I got the following results:=

> power off without this patch:	320 mA
> power off with this patch:	2   mA
> suspend to ram:			40  mA
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/regulator/pfuze100-regulator.c | 92 ++++++++++++++++++++++++++=

>  1 file changed, 92 insertions(+)
>=20
> diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator=
/pfuze100-regulator.c
> index 63922a2167e5..f6c276ed91d8 100644
> --- a/drivers/regulator/pfuze100-regulator.c
> +++ b/drivers/regulator/pfuze100-regulator.c
> @@ -28,6 +28,7 @@
>  #include <linux/regulator/pfuze100.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> +#include <linux/kallsyms.h>
>  #include <linux/regmap.h>
> =20
>  #define PFUZE_NUMREGS		128
> @@ -42,11 +43,17 @@
> =20
>  #define PFUZE100_COINVOL	0x1a
>  #define PFUZE100_SW1ABVOL	0x20
> +#define PFUZE100_SW1ABMODE	0x23
>  #define PFUZE100_SW1CVOL	0x2e
> +#define PFUZE100_SW1CMODE	0x31
>  #define PFUZE100_SW2VOL		0x35
> +#define PFUZE100_SW2MODE	0x38
>  #define PFUZE100_SW3AVOL	0x3c
> +#define PFUZE100_SW3AMODE	0x3f
>  #define PFUZE100_SW3BVOL	0x43
> +#define PFUZE100_SW3BMODE	0x46
>  #define PFUZE100_SW4VOL		0x4a
> +#define PFUZE100_SW4MODE	0x4d
>  #define PFUZE100_SWBSTCON1	0x66
>  #define PFUZE100_VREFDDRCON	0x6a
>  #define PFUZE100_VSNVSVOL	0x6b
> @@ -57,6 +64,13 @@
>  #define PFUZE100_VGEN5VOL	0x70
>  #define PFUZE100_VGEN6VOL	0x71
> =20
> +#define PFUZE100_SWxMODE_MASK	0xf
> +#define PFUZE100_SWxMODE_APS_APS	0x8
> +#define PFUZE100_SWxMODE_APS_OFF	0x4
> +
> +#define PFUZE100_VGENxLPWR	BIT(6)
> +#define PFUZE100_VGENxSTBY	BIT(5)
> +
>  enum chips { PFUZE100, PFUZE200, PFUZE3000 =3D 3 };
> =20
>  struct pfuze_regulator {
> @@ -489,6 +503,69 @@ static inline struct device_node *match_of_node(in=
t index)
>  }
>  #endif
> =20
> +static struct pfuze_chip *syspm_pfuze_chip;
> +
> +static void pfuze_power_off_prepare(void)
> +{
> +	dev_info(syspm_pfuze_chip->dev, "Configure standy mode for power off"=
);
> +
> +	/* Switch from default mode: APS/APS to APS/Off */
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW1ABMODE,
> +			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW1CMODE,
> +			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW2MODE,
> +			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW3AMODE,
> +			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW3BMODE,
> +			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW4MODE,
> +			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
> +
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN1VOL,
> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
> +			   PFUZE100_VGENxSTBY);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN2VOL,
> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
> +			   PFUZE100_VGENxSTBY);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN3VOL,
> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
> +			   PFUZE100_VGENxSTBY);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN4VOL,
> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
> +			   PFUZE100_VGENxSTBY);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN5VOL,
> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
> +			   PFUZE100_VGENxSTBY);
> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN6VOL,
> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
> +			   PFUZE100_VGENxSTBY);
> +}
> +
> +static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip)=

> +{
> +	if (pfuze_chip->chip_id !=3D PFUZE100) {
> +		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare handler fo=
r not supported chip\n");
> +		return -ENODEV;
> +	}
> +
> +	if (pm_power_off_prepare) {
> +		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already registere=
d.\n");
> +		return -EBUSY;
> +	}
> +
> +	if (syspm_pfuze_chip) {
> +		dev_warn(pfuze_chip->dev, "syspm_pfuze_chip is already set.\n");
> +		return -EBUSY;
> +	}
> +
> +	syspm_pfuze_chip =3D pfuze_chip;
> +	pm_power_off_prepare =3D pfuze_power_off_prepare;
> +
> +	return 0;
> +}
> +
>  static int pfuze_identify(struct pfuze_chip *pfuze_chip)
>  {
>  	unsigned int value;
> @@ -659,6 +736,20 @@ static int pfuze100_regulator_probe(struct i2c_cli=
ent *client,
>  		}
>  	}
> =20
> +	if (of_property_read_bool(client->dev.of_node,
> +				  "fsl,pmic-stby-poweroff"))
> +		return pfuze_power_off_prepare_init(pfuze_chip);
> +
> +	return 0;
> +}
> +
> +static int pfuze100_regulator_remove(struct i2c_client *client)
> +{
> +	if (syspm_pfuze_chip) {
> +		syspm_pfuze_chip =3D NULL;
> +		pm_power_off_prepare =3D NULL;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -669,6 +760,7 @@ static struct i2c_driver pfuze_driver =3D {
>  		.of_match_table =3D pfuze_dt_ids,
>  	},
>  	.probe =3D pfuze100_regulator_probe,
> +	.remove =3D pfuze100_regulator_remove,
>  };
>  module_i2c_driver(pfuze_driver);
> =20
>=20


--ebaSKat60fCA9TqMPHx77ey6XsIur2bCf--

--PAdCPQPW3BM1XfBSmjcmXXJJqHNDNxnVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlshB/UACgkQdQOiSHVI
77TuZAgAtvxSvuq8V8Sv8A3kPzH5oxmZVqSxDGgjskOHCS4rZ6AAcw7zCxBC8xcH
wrtXLKhetE1PmBn3qP78U3gS/VMdVdXuGV7qItRrprlmgO45cJ4EJ2fYVIMijHb2
K4q3GPZZJhgwRd3s/Fs3JVZneWYWnPtqEbQeAxro+iJ1oPSr1foHmqQAJpkaWhN0
CnSyDGHD9JER8p+KFg8BsUb3c5ypw/C0WPD0gjQLlPhID2fkgylpFuuFpWzngl4B
v34Uh9Z51aKoXxLpOcVaSnp7UFX5ME7HVQjFsAkqi2Xq08oq3nFg1zc+e+9Jz8t3
v79GIIzFPLIsasLHTd0vWCT0veApLQ==
=yIkj
-----END PGP SIGNATURE-----

--PAdCPQPW3BM1XfBSmjcmXXJJqHNDNxnVP--
