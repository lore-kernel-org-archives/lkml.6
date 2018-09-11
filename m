Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74224C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DDA206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DDA206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeIKJe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 05:34:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54781 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeIKJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 05:34:26 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fzaPs-0007YI-Qa; Tue, 11 Sep 2018 06:36:44 +0200
Subject: Re: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
To:     Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        yibin.gong@nxp.com, Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-imx@nxp.com,
        kernel@pengutronix.de, "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk> <20180827014815.GD29208@dragon>
 <20180906101516.GA5360@sirena.org.uk> <20180909020021.GA18838@dragon>
 <20180910151926.GA10889@sirena.org.uk> <20180911015320.GA25790@dragon>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <134a7f76-6e0b-1a9f-26da-f01adaac44e6@pengutronix.de>
Date:   Tue, 11 Sep 2018 06:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911015320.GA25790@dragon>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GH2qLEd1bdYflvrsNcftbP536dqJJG2Gz"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GH2qLEd1bdYflvrsNcftbP536dqJJG2Gz
Content-Type: multipart/mixed; boundary="IQQAtMcNgGktm5ZFih1gXwZeXumOAOaYC";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 yibin.gong@nxp.com, Michael Turquette <mturquette@baylibre.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-imx@nxp.com, kernel@pengutronix.de, "A.s. Dong"
 <aisheng.dong@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Leonard Crestez <leonard.crestez@nxp.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <134a7f76-6e0b-1a9f-26da-f01adaac44e6@pengutronix.de>
Subject: Re: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk> <20180827014815.GD29208@dragon>
 <20180906101516.GA5360@sirena.org.uk> <20180909020021.GA18838@dragon>
 <20180910151926.GA10889@sirena.org.uk> <20180911015320.GA25790@dragon>
In-Reply-To: <20180911015320.GA25790@dragon>

--IQQAtMcNgGktm5ZFih1gXwZeXumOAOaYC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On 11.09.2018 03:53, Shawn Guo wrote:
> On Mon, Sep 10, 2018 at 04:19:26PM +0100, Mark Brown wrote:
>> On Sun, Sep 09, 2018 at 10:00:23AM +0800, Shawn Guo wrote:
>>> On Thu, Sep 06, 2018 at 11:15:17AM +0100, Mark Brown wrote:
>>
>>>> I was expecting to get a pull request with the precursor patches in =
it -
>>>> the regulator driver seems to get a moderate amount of development s=
o
>>>> there's a reasonable risk of conflicts.
>>
>>> What about you create a stable topic branch for regulator patches and=
 I
>>> pull it into IMX tree?
>>
>> Sure, I can send a pull request back but the first two patches in the
>> series are ARM ones - are you OK with me just applying them and sendin=
g
>> them in the pull request or do you want to apply them first?
>=20
> I just took another look at the series.  It seems that there is no
> build-time dependency between regulator and platform patches.  So I
> think we can handle the series like:
>=20
>  - You apply patch #3, #4 and #5 on regulator tree;
>  - I apply the reset on IMX tree.
>=20
> There shouldn't be any build or run time regression on either tree, and=

> the feature that the series adds will be available when both trees get
> merged together on -next or Linus tree.
>=20
> @Oleksij Is my understanding above correct?

Yes.


--IQQAtMcNgGktm5ZFih1gXwZeXumOAOaYC--

--GH2qLEd1bdYflvrsNcftbP536dqJJG2Gz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAluXRlMACgkQdQOiSHVI
77Sxowf8CjP6jDa4tEdi8nba/CtB4vRe2TXeKy4l+9nZNtPn8Bl4PrUC8sOZN0Pa
GlXjWmDPrDBjJ/qV8AMwa0HhK4xvIHIDsM8NMRL7CRIYc9bmBw9AnJty9xgS3UAQ
aYJfQbFx93cz/N3cXCR/ATt50YRPESprtwf8RQBcfNhMX6Fldco3oDfJsmoQBY4l
LZZ5dezGMr1tQGIr/1FfoOUIUUVWrMHU8BfTiJXC+BtENiUITcDwjnUUAb/CcmFU
kiulVUndoahTflqBnO1abaElmbePbKVXd+CHC++3uHDTl8ZY8zSpV6DazAjepmua
57gabHI6prwAB6hDLmRmi0Mr4DMfmQ==
=6PNd
-----END PGP SIGNATURE-----

--GH2qLEd1bdYflvrsNcftbP536dqJJG2Gz--
