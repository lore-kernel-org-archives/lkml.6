Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC0DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDCE20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDCE20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeG3JZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:25:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34615 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeG3JZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:25:04 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fk2xR-0007Rj-Mz; Mon, 30 Jul 2018 09:51:09 +0200
Subject: Re: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
To:     Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
Date:   Mon, 30 Jul 2018 09:50:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LwQFIlLOjXGOTd1dIcOYesL3Vuu40VYjj"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LwQFIlLOjXGOTd1dIcOYesL3Vuu40VYjj
Content-Type: multipart/mixed; boundary="pFAUOKSuRxFMze1y29w5DqVceqozD4x5Y";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>, dl-linux-imx <linux-imx@nxp.com>,
 "A.s. Dong" <aisheng.dong@nxp.com>
Message-ID: <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
Subject: Re: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>

--pFAUOKSuRxFMze1y29w5DqVceqozD4x5Y
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 27.07.2018 11:32, Robin Gong wrote:
>=20
>=20
>> -----Original Message-----
>> From: Oleksij Rempel [mailto:o.rempel@pengutronix.de]
>> Sent: 2018=C4=EA7=D4=C226=C8=D5 17:22
>> To: Shawn Guo <shawnguo@kernel.org>; Mark Brown <broonie@kernel.org>;
>> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel@pengutronix.de;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Andrew Morton=

>> <akpm@linux-foundation.org>; Liam Girdwood <lgirdwood@gmail.com>;
>> Leonard Crestez <leonard.crestez@nxp.com>; Rob Herring
>> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Michael
>> Turquette <mturquette@baylibre.com>; Stephen Boyd
>> <sboyd@codeaurora.org>; Fabio Estevam <fabio.estevam@nxp.com>; Russell=

>> King <linux@armlinux.org.uk>; dl-linux-imx <linux-imx@nxp.com>; Robin =
Gong
>> <yibin.gong@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
>> Subject: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
>> pm_power_off_prepare handler
>>
>> On some boards the SoC can use one pin "PMIC_STBY_REQ" to notify th PM=
IC
>> about state changes. In this case internal state of PMIC must be preco=
nfigured
>> for upcomming state change.
>> It works fine with the current regulator framework, except with the po=
wer-off
>> case.
>>
>> This patch is providing an optional pm_power_off_prepare handler which=
 will
>> configure standby state of the PMIC to disable all power lines.
>>
>> In my power consumption test on RIoTBoard, I got the following results=
:
>> power off without this patch:	320 mA
>> power off with this patch:	2   mA
>> suspend to ram:			40  mA
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  drivers/regulator/pfuze100-regulator.c | 92 +++++++++++++++++++++++++=
+
>>  1 file changed, 92 insertions(+)
>>
>> diff --git a/drivers/regulator/pfuze100-regulator.c
>> b/drivers/regulator/pfuze100-regulator.c
>> index 8d9dbcc775ea..e386e9acb3f7 100644
>> --- a/drivers/regulator/pfuze100-regulator.c
>> +++ b/drivers/regulator/pfuze100-regulator.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/regulator/pfuze100.h>
>>  #include <linux/i2c.h>
>>  #include <linux/slab.h>
>> +#include <linux/kallsyms.h>
> Is it necessary?

yes, for pm_power_off_prepare

>>  #include <linux/regmap.h>
>>
>>  #define PFUZE_NUMREGS		128
>> @@ -29,11 +30,17 @@
>>
>>  #define PFUZE100_COINVOL	0x1a
>>  #define PFUZE100_SW1ABVOL	0x20
>> +#define PFUZE100_SW1ABMODE	0x23
>>  #define PFUZE100_SW1CVOL	0x2e
>> +#define PFUZE100_SW1CMODE	0x31
>>  #define PFUZE100_SW2VOL		0x35
>> +#define PFUZE100_SW2MODE	0x38
>>  #define PFUZE100_SW3AVOL	0x3c
>> +#define PFUZE100_SW3AMODE	0x3f
>>  #define PFUZE100_SW3BVOL	0x43
>> +#define PFUZE100_SW3BMODE	0x46
>>  #define PFUZE100_SW4VOL		0x4a
>> +#define PFUZE100_SW4MODE	0x4d
>>  #define PFUZE100_SWBSTCON1	0x66
>>  #define PFUZE100_VREFDDRCON	0x6a
>>  #define PFUZE100_VSNVSVOL	0x6b
>> @@ -44,6 +51,13 @@
>>  #define PFUZE100_VGEN5VOL	0x70
>>  #define PFUZE100_VGEN6VOL	0x71
>>
>> +#define PFUZE100_SWxMODE_MASK	0xf
>> +#define PFUZE100_SWxMODE_APS_APS	0x8
>> +#define PFUZE100_SWxMODE_APS_OFF	0x4
>> +
>> +#define PFUZE100_VGENxLPWR	BIT(6)
>> +#define PFUZE100_VGENxSTBY	BIT(5)
>> +
>>  enum chips { PFUZE100, PFUZE200, PFUZE3000 =3D 3 };
>>
>>  struct pfuze_regulator {
>> @@ -492,6 +506,69 @@ static inline struct device_node *match_of_node(i=
nt
>> index)  }  #endif
>>
>> +static struct pfuze_chip *syspm_pfuze_chip;
>> +
>> +static void pfuze_power_off_prepare(void)=20
>> +	dev_info(syspm_pfuze_chip->dev, "Configure standy mode for power
>> +off");
> Add 'if (syspm_pfuze_chip ->chip_id =3D=3D PFUZE100))' here is easy for=
 extend=20
> Support on pfuze200/3000.. in the feature.

ok.

>> +
>> +	/* Switch from default mode: APS/APS to APS/Off */
>> +	regmap_update_bits(syspm_pfuze_chip->regmap,
>> PFUZE100_SW1ABMODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap,
>> PFUZE100_SW1CMODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW2MODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap,
>> PFUZE100_SW3AMODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap,
>> PFUZE100_SW3BMODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW4MODE,
>> +			   PFUZE100_SWxMODE_MASK,
>> PFUZE100_SWxMODE_APS_OFF);
>> +
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN1VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN2VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN3VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN4VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN5VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN6VOL,
>> +			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
>> +			   PFUZE100_VGENxSTBY);
>> +}
>> +
>> +static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip=
)
>> +{
>> +	if (pfuze_chip->chip_id !=3D PFUZE100) {
>> +		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare
>> handler for not supported chip\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (pm_power_off_prepare) {
>> +		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already
>> registered.\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (syspm_pfuze_chip) {
>> +		dev_warn(pfuze_chip->dev, "syspm_pfuze_chip is already set.\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	syspm_pfuze_chip =3D pfuze_chip;
>> +	pm_power_off_prepare =3D pfuze_power_off_prepare;
>> +
>> +	return 0;
>> +}
>> +
>>  static int pfuze_identify(struct pfuze_chip *pfuze_chip)  {
>>  	unsigned int value;
>> @@ -661,6 +738,20 @@ static int pfuze100_regulator_probe(struct i2c_cl=
ient
>> *client,
>>  		}
>>  	}
>>
>> +	if (of_property_read_bool(client->dev.of_node,
>> +				  "fsl,pmic-stby-poweroff"))
>> +		return pfuze_power_off_prepare_init(pfuze_chip);
>> +
>> +	return 0;
>> +}
>> +
>> +static int pfuze100_regulator_remove(struct i2c_client *client) {
>> +	if (syspm_pfuze_chip) {
>> +		syspm_pfuze_chip =3D NULL;
>> +		pm_power_off_prepare =3D NULL;
>> +	}
>> +
>>  	return 0;
>>  }
>>
>> @@ -671,6 +762,7 @@ static struct i2c_driver pfuze_driver =3D {
>>  		.of_match_table =3D pfuze_dt_ids,
>>  	},
>>  	.probe =3D pfuze100_regulator_probe,
>> +	.remove =3D pfuze100_regulator_remove,
>>  };
>>  module_i2c_driver(pfuze_driver);
>>
>> --
>> 2.18.0
>=20


--pFAUOKSuRxFMze1y29w5DqVceqozD4x5Y--

--LwQFIlLOjXGOTd1dIcOYesL3Vuu40VYjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAltew18ACgkQdQOiSHVI
77SvkQf/bz7OrfiRl8LAMXrax99StT38kYGTmGgksJHP2PC83HQjyLzmIxEGq25z
l5fN4f6h/raCXmKT289xTpnE0yWSFcnkerKAYW9hlqvICAgw4VTmtAKFzbej3hqm
5S7gp9dyUPhfaWvUsnndVZCWy1+EOphvfQTNOBgPeyTCIyoGAU8f0iIUVdZNhq1H
aZ/hqwM0tQXjdlCGbpiZatqrSK0WqxA5kiOpt0yMZnsuRjgqugBpRf0f7RKpVQ5M
CRMZ22sQgRVDwnfABiJmOCxNohqKuguwloODn6T7SLt2A8F13Gi40tyuBYCcLp0f
mA5Y5N3UoK17rFzuChlGAmi8Cq3F0Q==
=PyHs
-----END PGP SIGNATURE-----

--LwQFIlLOjXGOTd1dIcOYesL3Vuu40VYjj--
