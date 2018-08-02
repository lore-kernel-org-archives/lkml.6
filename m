Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0BEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5749A2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5749A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeHBKCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:02:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53139 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeHBKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:02:10 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fl8i0-0006Sc-W1; Thu, 02 Aug 2018 10:11:45 +0200
Subject: Re: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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
        Robin Gong <yibin.gong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
 <20180730102452.GH5789@sirena.org.uk>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <d76f7acb-b221-8c4f-1dc9-c1244e7b9f49@pengutronix.de>
Date:   Thu, 2 Aug 2018 10:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730102452.GH5789@sirena.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zEkRnkqXSaGdvvXRCInmGVrLExVFxgGVY"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zEkRnkqXSaGdvvXRCInmGVrLExVFxgGVY
Content-Type: multipart/mixed; boundary="mTbZiom1wH9cEZZgNRQSokrSLBJlrtbwB";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Leonard Crestez <leonard.crestez@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "A.s. Dong" <aisheng.dong@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Gong <yibin.gong@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <d76f7acb-b221-8c4f-1dc9-c1244e7b9f49@pengutronix.de>
Subject: Re: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
 <20180730102452.GH5789@sirena.org.uk>
In-Reply-To: <20180730102452.GH5789@sirena.org.uk>

--mTbZiom1wH9cEZZgNRQSokrSLBJlrtbwB
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 30.07.2018 12:24, Mark Brown wrote:
> On Mon, Jul 30, 2018 at 09:50:55AM +0200, Oleksij Rempel wrote:
>> On 27.07.2018 11:32, Robin Gong wrote:
>=20
>>>>  #include <linux/slab.h>
>>>> +#include <linux/kallsyms.h>
>=20
>>> Is it necessary?
>=20
>> yes, for pm_power_off_prepare
>=20
> That's a *weird* header to have to use for that symbol, are you sure
> there isn't something more specific - if there isn't there should be.

Hm... you right. Removed.


--mTbZiom1wH9cEZZgNRQSokrSLBJlrtbwB--

--zEkRnkqXSaGdvvXRCInmGVrLExVFxgGVY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAltivLgACgkQdQOiSHVI
77TnNQf+MM0ChHX/2Q58uX/+l764in4NhvoSOm0l+PlXqs+73JQUtyAShGxvNasZ
iTy8/vZlIf82z9uSyjJ3DKAqNkxK9Qu74w4HE02Yje6+kcknh+PBPf+MI0ICpzq4
UUdJXrLMoE4zKEqi550BNP4ExuRSja5wKIwuQ4ikvQL93Icrm1+oTX9np7UiZpfG
u31TPYE8HdAjGrWg4Q3gtlJ1/u+J+TZpa0wlHLYpY4/Q88DEt82mQhqwsP1jVREN
xm8GK3od4TRC8ytdQakBS5BWhdwtJH7MJVLinAdWLyPOjthAGr2VoYdcTvD9mWjp
zuLVg1Y6+hGIzcPdm+CufuTs/i6Yww==
=s2Qt
-----END PGP SIGNATURE-----

--zEkRnkqXSaGdvvXRCInmGVrLExVFxgGVY--
