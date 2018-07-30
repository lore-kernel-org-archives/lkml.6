Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F034DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B36320873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B36320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeG3Jbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:31:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47193 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeG3Jbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:31:46 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fk33w-0008Ex-C7; Mon, 30 Jul 2018 09:57:52 +0200
Subject: Re: [PATCH v8 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
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
 <20180726092220.17250-3-o.rempel@pengutronix.de>
 <DB6PR04MB3223A62E5609BF6431ABEA40892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <86871e56-2d1a-50e0-fe36-f008deb80dad@pengutronix.de>
Date:   Mon, 30 Jul 2018 09:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DB6PR04MB3223A62E5609BF6431ABEA40892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ah7gkOdghVVWTYryjhJmtiBAHDVsyJTdY"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ah7gkOdghVVWTYryjhJmtiBAHDVsyJTdY
Content-Type: multipart/mixed; boundary="3RNX3MfhZolQDFvpi5M9Ol8qHSPY7wqk3";
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
Message-ID: <86871e56-2d1a-50e0-fe36-f008deb80dad@pengutronix.de>
Subject: Re: [PATCH v8 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-3-o.rempel@pengutronix.de>
 <DB6PR04MB3223A62E5609BF6431ABEA40892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR04MB3223A62E5609BF6431ABEA40892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>

--3RNX3MfhZolQDFvpi5M9Ol8qHSPY7wqk3
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 27.07.2018 11:15, Robin Gong wrote:
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
>> Subject: [PATCH v8 2/6] ARM: imx6: register pm_power_off handler if
>> "fsl,pmic-stby-poweroff" is set
>>
>> One of the Freescale recommended sequences for power off with external=

>> PMIC is the following:
>> ...
>> 3.  SoC is programming PMIC for power off when standby is asserted.
>> 4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.
>>
>> See:
>> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww=
w.
>> nxp.com%2Fassets%2Fdocuments%2Fdata%2Fen%2Freference-manuals%2FIM
>> X6DQRM.pdf&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C193fd19e3a
>> 40416ffa4a08d5f2d9583c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1
>> %7C636681937661914076&amp;sdata=3DlICAelYpUh4%2Ft%2Fs7N9mdk2cLQMi
>> cHcOqQ07vTOUoyNY%3D&amp;reserved=3D0
>> page 5083
>>
>> This patch implements step 4. of this sequence.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  arch/arm/mach-imx/pm-imx6.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c=

>> index 017539dd712b..2f5c643f62fb 100644
>> --- a/arch/arm/mach-imx/pm-imx6.c
>> +++ b/arch/arm/mach-imx/pm-imx6.c
>> @@ -601,6 +601,28 @@ static void __init imx6_pm_common_init(const stru=
ct
>> imx6_pm_socdata
>>  				   IMX6Q_GPR1_GINT);
>>  }
>>
>> +static void imx6_pm_stby_poweroff(void) {
>> +	imx6_set_lpm(STOP_POWER_OFF);
>> +	imx6q_suspend_finish(0);
>> +
>> +	mdelay(1000);
>> +
>> +	pr_emerg("Unable to poweroff system\n"); }
>> +
>> +static int imx6_pm_stby_poweroff_probe(void) {
>> +	if (pm_power_off) {
>> +		pr_warn("%s: pm_power_off already claimed  %p %pf!\n",
>> +			__func__, pm_power_off, pm_power_off);

> 'syscon-poweroff' and 'pmic-stby-poweroff ' should be chosen as a singl=
e
> Poweroff way for any i.mx6 board. Why not delete directly 'syscon-power=
off' in dts=20
> to avoid such two power off ways coexist?

pm_power_off can be registred by any part of the kernel. So, we need it
to avoid conflicts or at least to be able see them.

On other hand, you are right. syscon-poweroff should be disabled for
this board.

>> +		return -EBUSY;
>> +	}
>> +
>> +	pm_power_off =3D imx6_pm_stby_poweroff;
>> +	return 0;
>> +}
>> +
>>  void __init imx6_pm_ccm_init(const char *ccm_compat)  {
>>  	struct device_node *np;
>> @@ -617,6 +639,9 @@ void __init imx6_pm_ccm_init(const char
>> *ccm_compat)
>>  	val =3D readl_relaxed(ccm_base + CLPCR);
>>  	val &=3D ~BM_CLPCR_LPM;
>>  	writel_relaxed(val, ccm_base + CLPCR);
>> +
>> +	if (of_property_read_bool(np, "fsl,pmic-stby-poweroff"))
>> +		imx6_pm_stby_poweroff_probe();
>>  }
>>
>>  void __init imx6q_pm_init(void)
>> --
>> 2.18.0
>=20


--3RNX3MfhZolQDFvpi5M9Ol8qHSPY7wqk3--

--Ah7gkOdghVVWTYryjhJmtiBAHDVsyJTdY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAltexP8ACgkQdQOiSHVI
77Rnagf/WsBMA+Gpl5fOpiNL+JN5/7UxDI3oG3GyeGgHDMkR6Qle0LgPnWkuSiuh
tp7HyGB2y8DzsVOf2lTvscWEWBWleQtC7Wo+xyVooctfOCE4LZwJIg1CZIYCR0ID
N7x6axRwHyviazdBTGMkZ2wx4swrhVEXnPcVOK+B0HYlXUgCXdw5Ez4rQWYGkV7X
5k80icazfLx08tIrtXe54l9X70pFiDxkeiJrlXuK/waMUzcyNZlKC6WoAV4VnqCW
OJPbTQpWJ53lpW74NVt/GHRRuEyIKwPNDcJARslWMsJQqDYHF9XUUW5GHWlvFQDK
LsrfjHjRBLw1yVB2AegxMAVkk20f5w==
=pBWp
-----END PGP SIGNATURE-----

--Ah7gkOdghVVWTYryjhJmtiBAHDVsyJTdY--
