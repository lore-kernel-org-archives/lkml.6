Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DB2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446E121473
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446E121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHBK1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:27:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44779 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBK1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:27:32 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fl96i-0000YA-27; Thu, 02 Aug 2018 10:37:16 +0200
Subject: Re: [PATCH v8 6/6] ARM: dts: imx6: RIoTboard provide standby on power
 off option
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
 <20180726092220.17250-7-o.rempel@pengutronix.de>
 <DB6PR04MB3223FA7B91D0D43B2EC1EE2A892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <f28ae35c-9011-7bd8-4c41-182afaf973b8@pengutronix.de>
Date:   Thu, 2 Aug 2018 10:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DB6PR04MB3223FA7B91D0D43B2EC1EE2A892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DVffm75GJylvyNi7R63aJqEHoCumtbYVB"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DVffm75GJylvyNi7R63aJqEHoCumtbYVB
Content-Type: multipart/mixed; boundary="CmV3pN9BFAJd59KG0Z5BYLpTfwEAEUSF8";
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
Message-ID: <f28ae35c-9011-7bd8-4c41-182afaf973b8@pengutronix.de>
Subject: Re: [PATCH v8 6/6] ARM: dts: imx6: RIoTboard provide standby on power
 off option
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-7-o.rempel@pengutronix.de>
 <DB6PR04MB3223FA7B91D0D43B2EC1EE2A892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR04MB3223FA7B91D0D43B2EC1EE2A892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>

--CmV3pN9BFAJd59KG0Z5BYLpTfwEAEUSF8
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 27.07.2018 11:33, Robin Gong wrote:
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
>> Subject: [PATCH v8 6/6] ARM: dts: imx6: RIoTboard provide standby on p=
ower
>> off option
>>
>> This board, as well as some other boards with i.MX6 and a PMIC, uses a=

>> "PMIC_STBY_REQ" line to notify the PMIC about a state change.
>> The PMIC is programmed for a specific state change before triggering t=
he line.
>> In this case, PMIC_STBY_REQ can be used for stand by, sleep and power =
off
>> modes.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/imx6dl-riotboard.dts | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts
>> b/arch/arm/boot/dts/imx6dl-riotboard.dts
>> index 2e98c92adff7..a0e9753ee767 100644
>> --- a/arch/arm/boot/dts/imx6dl-riotboard.dts
>> +++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
>> @@ -90,6 +90,10 @@
>>  	status =3D "okay";
>>  };
>>
>> +&clks {
>> +	fsl,pmic-stby-poweroff;
>> +};
> It's better remove the default "syscon-poweroff" power off node.

"syscon-poweroff" is by default disabled and not enabled in
arch/arm/boot/dts/imx6dl-riotboard.dts


--CmV3pN9BFAJd59KG0Z5BYLpTfwEAEUSF8--

--DVffm75GJylvyNi7R63aJqEHoCumtbYVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAltiwq0ACgkQdQOiSHVI
77RTCQgAlh9T7RVujPYo4Og/Y4LMv1//NfIiXxAYFfzgU1aipD9tZgXOCfTIGMgM
mH9Pcl5WEYGQpdppKFoQg38BPVsCZVdJXtAC1sjVxRTy6seSwDeX21bSCJS7kNba
Y7dYNe98kG2l/tp33HMOgHDC9ZYgv45V19I0EujGLMkifWZojWIeUVTpepTYyTdM
FrxTPeRwxQh3Nu2HuxsD6+g+Es7vKFUMclubmvKWHlffwDs+JsxGQZqhE210pNLo
ET9g3h26rIxkLv4EpWFOMCoikILB7Eug8O/9n5OrX/7GiU5u/vVy/JamXVs2E4LF
CONR3M79m+NVF8etWB8qz1hbUmy/TQ==
=PUQr
-----END PGP SIGNATURE-----

--DVffm75GJylvyNi7R63aJqEHoCumtbYVB--
