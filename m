Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0165EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36A2214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfBOPOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:14:01 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39249 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBOPOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:14:01 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B62A0FF80E;
        Fri, 15 Feb 2019 15:13:57 +0000 (UTC)
Date:   Fri, 15 Feb 2019 16:13:57 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATVH v2 0/4] arm64: dts: allwinner: h6: Enable CPU
Message-ID: <20190215151357.noovkx3r6ia4boag@flea>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="om2f4swtpe4optgl"
Content-Disposition: inline
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--om2f4swtpe4optgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 08:49:33AM -0500, Yangtao Li wrote:
> Add the cpufreq support of h6, source of information is as follows.
>=20
> h6 cpu opp info:
> https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm6=
4/boot/dts/sunxi/sun50iw6p1.dtsi
>=20
> axp805 spec:
> http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf

Was that tested on the two H6 boards this time?

Adding a changelog between version is nice as well so that we can see
what you changed.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--om2f4swtpe4optgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGbXNQAKCRDj7w1vZxhR
xYxkAP9kUMkZaTrK23zivcyuBxMBvnEttPQW5ZUNNelMTWvr5wD/Vg6TAuWXUOQ8
6NQLJne5OBfdUYosfymIYyMamN2pMwY=
=Uep5
-----END PGP SIGNATURE-----

--om2f4swtpe4optgl--
