Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C80C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BFD24388
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BFD24388
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933551AbeFVOUj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:20:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55427 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbeFVOUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:20:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 919E720DBE; Fri, 22 Jun 2018 16:20:35 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id B0A8B207EB;
        Fri, 22 Jun 2018 16:20:20 +0200 (CEST)
Date:   Fri, 22 Jun 2018 16:20:21 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marco Franchi <marco.franchi@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>
Subject: Re: [PATCH v4 12/19] ARM: sun8i-a33: Add SRAM controller node and C1
 SRAM region
Message-ID: <20180622142021.fatrwqqsdjxv2cbq@flea>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-13-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hvpbg5zut62467ge"
Content-Disposition: inline
In-Reply-To: <20180618145843.14631-13-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hvpbg5zut62467ge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 04:58:36PM +0200, Paul Kocialkowski wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> This adds a SRAM controller node for the A33, with support for the C1
> SRAM region that is shared between the Video Engine and the CPU.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a=
33.dtsi
> index a21f2ed07a52..97a976b3b1ef 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi

This should be in the common DTSI between the A23 and A33.

Thnaks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--hvpbg5zut62467ge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlstBaQACgkQ0rTAlCFN
r3SkNg/6AjoCGvevDMLwR0ine7kH62EPr0FYXhrmcsK+kz6+0nWO3Ikwkptpv5Or
pzL83S4oJczV7K8Wl8T8vjC6npmBlAR7ePaL6IXNQXgH7Na98rbkLeFw1bI/mywH
DrdQ5tGX6B3WF7gvF5KL3W+SSCvYl0DUfToLd3d1nNNy/iIh1dxpJn4dh4U/0f7z
XsRkPZ+Fbxz5jgHOjyb6Jm70DLHjMOA+OYxN+IDSu6hMIEZJ37G3fB+JxfONWaRK
SslBgndqecqRCp/whYTG6bSXI1GEVb500aW0NyMFPxylSWCctfBN82mpmqcqxo06
3oBXD6s2ObRvjAyW+/nIjagSdA/8eCX2GqnX8pTjHR3a3yo6rsdlmABDQt0UuuCS
ZEXcWQpVI1rYkJ5LhuiAm/MuUWd8bKr37O7i1IMLRwwcdQqpLtR+7vL7Gp7PgNjA
rhQrA0Dquq8frH36c0BrgKw2o03a1OXtV+Xpgrpyw1NqAkKnm01lScDG1ky/cKoE
lznl2fGhEsxzexPvd7PS9vSBXXcza48buULqSENSI8kc2McFkQ06W8V+MUwoFnHI
TbzpL/I1YMM5k5WhlincIYfHW8pswoVBZfGqSQqq/0sOh5I+BEDnJYgyQbYC3xfo
J8C2QbxigV3cVAKXhF3zYpBL1csp+pEh5Ih1kLua383XYTFFGxc=
=MH2g
-----END PGP SIGNATURE-----

--hvpbg5zut62467ge--
