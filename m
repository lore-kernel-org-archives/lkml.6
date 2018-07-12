Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BCCC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08F620873
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08F620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeGLHcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:32:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51238 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeGLHcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:32:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6EAC2207E8; Thu, 12 Jul 2018 09:23:48 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3A51420741;
        Thu, 12 Jul 2018 09:23:38 +0200 (CEST)
Date:   Thu, 12 Jul 2018 09:23:38 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/2] ARM: sun8i: h3: add SY8113B regulator on Banana Pi
 M2 Zero board
Message-ID: <20180712072338.zxhzm5rdhmlorjjj@flea>
References: <20180711134450.43148-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y4elnhomycs6zyzv"
Content-Disposition: inline
In-Reply-To: <20180711134450.43148-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y4elnhomycs6zyzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 09:44:50PM +0800, Icenowy Zheng wrote:
> Banana Pi M2 Zero board has a SY8113B regulator, which is controlled via
> GPIO and capable of outputing 1.1V when the PL1 GPIO is set to output 0
> or 1.1V when the PL6 GPIO is set to input or output 1, and the output is
> the power supply of the ARM cores in H3 SoC.
>=20
> Add the device tree node of this regulator and set the cpu's cpu-supply
> property to it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--y4elnhomycs6zyzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltHAfkACgkQ0rTAlCFN
r3Q/fg/+LyKvd6NyfTWI63X7eA0XiTU/rSKDGho9nCsgYbnz8GLbcucWnEy75yNN
yPvpjE9u5jUI/uoxuaqTs/lArDykDpZjM7URA/KDCp9SEKjvC2Lzf/aiOfxRUylP
F0PyXQkVX03cDllEoyJoLwehAQCuKfa6NN/ymuSFtCevN6mToWEy7U5T4GeGuH3T
LiPPSVqi0fUh8LGvzMst9o1B9cEsn7kI8wofKAl1FxEuL7Izod8SZsTgMV9mwrF1
dPQQvdByAXSmW+P3Ag9jOvnGHgdEYILUXIGMNqswQH4CVqPaPsGz/VqyfMDCLs1g
xxwsAhb6ktWVFweKaqTQoENgK63FqiTHv2XDO8AEhl4u9TFx2o/lw3oL7JXuRVGO
uMGbWoY9ElsWvWENHS9JMfthkmfCnRnSU0OKqlWhzDezksi3C/3jc6u6Onmn80vR
Dg5yUlsRvWz26VWNMk5SyQTYO2xC4GOg4gScveuz3Ey+ybxAWWkAbYVsrsI6oSXl
ak2lWKzHuMP3ynDzwiChuU3yxK3jQLlSSx5pmIDwR+ipsfNkExI5fl2z5eYJVoN9
bn6tSMRGSmL5tHXbyyM26MyNN65X/O//uoFF2qmlWol7wegXfP42SLZOF6Gb79lt
hkA066bUAJiwHTgnEbDk7NeQQey97rSiOOtOQqfnJgnHxpS5nGc=
=W4Yr
-----END PGP SIGNATURE-----

--y4elnhomycs6zyzv--
