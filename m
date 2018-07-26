Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5AFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA582083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA582083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbeGZMyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:54:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44317 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbeGZMyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:54:24 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fieac-0000fm-F0; Thu, 26 Jul 2018 13:37:50 +0200
Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
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
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
Date:   Thu, 26 Jul 2018 13:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CmSIAI6FGWQju5vbxnKfqJmQv2oAuY0pf"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CmSIAI6FGWQju5vbxnKfqJmQv2oAuY0pf
Content-Type: multipart/mixed; boundary="G2Tm66CxLRos6R6xC1wkdggvshNUH6LPO";
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
Message-ID: <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>

--G2Tm66CxLRos6R6xC1wkdggvshNUH6LPO
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 26.07.2018 11:51, Robin Gong wrote:
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
>> Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
>> fsl,pmic-stby-poweroff property
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> index a45ca67a9d5f..e1308346e00d 100644
>> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> @@ -6,6 +6,14 @@ Required properties:
>>  - interrupts: Should contain CCM interrupt
>>  - #clock-cells: Should be <1>
>>
>> +Optional properties:
>> +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ signa=
l
>> +  on power off.
>> +  Use this property if the SoC should be powered off by external powe=
r
>> +  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> PMIC_ON_REQ didn't connect to any pin of PMIC in your case?

No. First, it was only one customer specific issue. After some research
I found even publicly available boards (for example RioTboard) which has
same/similar design. After seeing this in imx6 documentation as valid
power off way, I have no doubts - there should be even more devices doin
this in the wild.

> Don't understand
> why not follow normal board design guide to power off pmic by PMIC_ON_R=
EQ.
> How to power on board again then?

Power cycle. Without this patch, power of is not real power off. So,
power cycle, is expected behavior for user interaction. On usual PC,
reset button will not enable PC as well.


--G2Tm66CxLRos6R6xC1wkdggvshNUH6LPO--

--CmSIAI6FGWQju5vbxnKfqJmQv2oAuY0pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAltZsoUACgkQdQOiSHVI
77TWzQgAhQoMOjx7+S1Qm1rZPtMblz6hK1z0mNYWGfIGeg8cdj3+Aoo5ypnLb7+6
MaMowFsPSn+MLu9KyaKTxhdSP+QBC9kGWqj7Dg13MILlNJJRvk5wLjYxEtbuU31H
K0H8B2gIL9lKA7frgkndteGYeJFYM9ziaWnj1sLRzsud3TJJHx5WBYLCXI0OuLXx
YD4H8fB2xR89Fj2Jqeaugux1Ewu99a/jUbX3PSi0trAi+AmLN83Yg1+c43r5O2Yn
kfWatgPLmK7CMBoTZCKVZZwAG1auPkLnNXp0vSXwkoSnZaPKTzTahzCoKFb49wJ0
PsMc7Rki7cPb+4x3ia0vwxAa/umtYw==
=pEPP
-----END PGP SIGNATURE-----

--CmSIAI6FGWQju5vbxnKfqJmQv2oAuY0pf--
