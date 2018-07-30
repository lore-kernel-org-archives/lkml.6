Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC577C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AFC20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AFC20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeG3Jhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:37:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42163 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbeG3Jhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:37:31 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fk39P-0000SY-5q; Mon, 30 Jul 2018 10:03:31 +0200
Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
To:     Robin Gong <yibin.gong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
 <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <1532680211.32306.36.camel@pengutronix.de>
 <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <02f4b642-14a8-f2db-ea23-c42a4f6f1652@pengutronix.de>
Date:   Mon, 30 Jul 2018 10:03:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0ZXQ3BVq0ww7d6z67tFll8hPf7AVFeQ0a"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0ZXQ3BVq0ww7d6z67tFll8hPf7AVFeQ0a
Content-Type: multipart/mixed; boundary="4qY4n4uWgIxPC5PJDnntgkyLxmMu2YwQx";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin Gong <yibin.gong@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "A.s. Dong" <aisheng.dong@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Leonard Crestez <leonard.crestez@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <02f4b642-14a8-f2db-ea23-c42a4f6f1652@pengutronix.de>
Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
 <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <1532680211.32306.36.camel@pengutronix.de>
 <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>

--4qY4n4uWgIxPC5PJDnntgkyLxmMu2YwQx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 27.07.2018 10:58, Robin Gong wrote:
>=20
>=20
>> -----Original Message-----
>> From: Lucas Stach [mailto:l.stach@pengutronix.de]
>> Sent: 2018=E5=B9=B47=E6=9C=8827=E6=97=A5 16:30
>> To: Robin Gong <yibin.gong@nxp.com>; Oleksij Rempel
>> <o.rempel@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>; Mark
>> Brown <broonie@kernel.org>; Rafael J. Wysocki <rafael.j.wysocki@intel.=
com>
>> Cc: Mark Rutland <mark.rutland@arm.com>; devicetree@vger.kernel.org;
>> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
>> <sboyd@codeaurora.org>; linux-kernel@vger.kernel.org; Liam Girdwood
>> <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>; dl-linux-imx
>> <linux-imx@nxp.com>; kernel@pengutronix.de; A.s. Dong
>> <aisheng.dong@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>; Russell=

>> King <linux@armlinux.org.uk>; Andrew Morton <akpm@linux-foundation.org=
>;
>> Leonard Crestez <leonard.crestez@nxp.com>; linux-clk@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
>> fsl,pmic-stby-poweroff property
>>
>> Hi Robin,
>>
>> Am Freitag, den 27.07.2018, 01:51 +0000 schrieb Robin Gong:
>> [...]
>>>>>> ---
>>>>>> =C2=A0Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8
>>>>>> ++++++++
>>>>>> =C2=A01 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>>>>>> b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>>>>>> index a45ca67a9d5f..e1308346e00d 100644
>>>>>> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>>>>>> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>>>>>> @@ -6,6 +6,14 @@ Required properties:
>>>>>> =C2=A0- interrupts: Should contain CCM interrupt
>>>>>> =C2=A0- #clock-cells: Should be <1>
>>>>>>
>>>>>> +Optional properties:
>>>>>> +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ
>>>>>> +signal
>>>>>> +=C2=A0=C2=A0on power off.
>>>>>> +=C2=A0=C2=A0Use this property if the SoC should be powered off by=

>>>>>> +external power
>>>>>> +=C2=A0=C2=A0management IC (PMIC) triggered via PMIC_STBY_REQ sign=
al.
>>>>>
>>>>> PMIC_ON_REQ didn't connect to any pin of PMIC in your case?
>>>>
>>>> No. First, it was only one customer specific issue. After some
>>>> research I found even publicly available boards (for example
>>>> RioTboard) which has same/similar design. After seeing this in imx6
>>>> documentation as valid power off way, I have no doubts - there shoul=
d be
>> even more devices doin this in the wild.
>>>
>>> Not sure why the customer didn't follow reference design, since
>>> PMIC_ON_REQ can provide power off/on feature by pressing ONOFF key
>>> which connected ONOFF pin of i.mx6(ONOFF will toggle PMIC_ON_REQ to
>>> power off/on PMIC). The official power off/on way (PMIC_ON_REQ) can
>>> also power off all power rails of PFUZE except snvs as your patch did=

>>> on PMIC_STBY_REQ.=C2=A0=C2=A0PMIC_STBY_REQ is used to notify pmic swi=
tch power
>>> mode (PFM/APS) or decrease voltage to save power in kernel suspend, n=
ot
>> power off....I am not sure if we need this patchset to 'workaround' th=
e board
>> issue.
>>>
>> Not all boards follow the reference design, that's a fact of life.
>>
>> Please look at the i.MX6Q reference manual. The sequence implemented i=
n this
>> patchset can be found as a valid way to power off the system in
>> "60.4.3 Power mode transitions" "Normal ON to OFF with external PMIC",=
 so
>> there is hardly any way to argue that this is a board specific quirk. =
This is one of
>> the Freescale/NXP recommended sequences to turn off the system.

> Okay, but could you add one more comment for this solution? RTC alarm a=
nd ONOFF
> Button wakeup feature can't be support in this case.

Enough to add it in to changelog? or should it go to the binding
documentation?


--4qY4n4uWgIxPC5PJDnntgkyLxmMu2YwQx--

--0ZXQ3BVq0ww7d6z67tFll8hPf7AVFeQ0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAltexlEACgkQdQOiSHVI
77TWfAgAjRB1PciUy1OHomvrxni8EkaYEB80z17EC958utpp0mPJwNuFY56/8HFJ
oCrfPZ7bn+/N0K5iCATabDyC4ylmjEGboht6je0eOXtoOqlWU/e+wMRp/yNSlRsw
1/mQAHKWuVIlBopDYuIrNHxR9fYcmJCcOzGEb3u9vFeEJL9G8jda7IgG9ToeKTlm
YW9F5TmlabqPZ57WLDK9AXzpW+3W1jm57VCUZesIkIyoNRYboKhPbvpS1UOr2NHi
rZcwhrIG5CIMWnbxgWAlnNhhG2lF+w1D3wQdqURZns6RmNeDQUQ6OL0bIkLZYy+m
U7/apbmR1x8qalt+rjgpuFFw9CcxoQ==
=LKCD
-----END PGP SIGNATURE-----

--0ZXQ3BVq0ww7d6z67tFll8hPf7AVFeQ0a--
