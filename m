Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45EAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9973B20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9973B20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934763AbeFRQDo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:03:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46380 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933036AbeFRQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:03:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B009A20DD7; Mon, 18 Jun 2018 18:03:39 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7D9B020DBE;
        Mon, 18 Jun 2018 18:02:50 +0200 (CEST)
Date:   Mon, 18 Jun 2018 18:02:50 +0200
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
Subject: Re: [PATCH v4 01/19] dt-bindings: sram: sunxi: Add A13, A20 and A33
 SRAM controller bindings
Message-ID: <20180618160250.ik44c3gcbdxylmyd@flea>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dhcros4rwsnjx5pm"
Content-Disposition: inline
In-Reply-To: <20180618145843.14631-2-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dhcros4rwsnjx5pm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 04:58:25PM +0200, Paul Kocialkowski wrote:
> This introduces dedicated bindings for the SRAM controllers found on the
> A13, A20 and A33 sunxi platforms.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Explaining why you need to add these new compatibles would be great.

> diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Docu=
mentation/devicetree/bindings/sram/sunxi-sram.txt
> index d087f04a4d7f..19cc0b892672 100644
> --- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> @@ -11,6 +11,9 @@ Controller Node
>  Required properties:
>  - compatible : should be:
>      - "allwinner,sun4i-a10-sram-controller"
> +    - "allwinner,sun5i-a13-sram-controller"
> +    - "allwinner,sun7i-a20-sram-controller"
> +    - "allwinner,sun8i-a33-sram-controller"

And I think Chen-Yu asked you to rename this compatible to
-system-controller for the previous iteration?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--dhcros4rwsnjx5pm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsn16kACgkQ0rTAlCFN
r3TWxg//a3+WkZe+uYoDymoAWFta2KXmEVuk4QL0Rq9r/B9tlwcpApjlC6l+EL0B
v+Raoj7mTvAR6xubG8JAyCWMuhnQtEuFiJXUaOTy7EHb4So7BMag7W7dR5Y14tdi
OidnEnykgxMQFcfReKuXReM5WasXs3mdq780oaMXfV0P6Oo4mW63GyXBRc3QosKO
g1hgruXQF/goR9LfIFGkJe0Z0+X0jZ81z2kpTKby12/X6dG6ZwoHUPe06oSOFIhk
QlcIydIsX27EqrAaU3FBpJGdlgSOo2YsntOVaZGorYnNXHFflDNGDPl3CK97CiYc
gvACa9GJHCxUT3GI3fDE3qmqih5jbD0Ti8Zp9coVcYTHdniAG9KdhpD1XPHcZh/H
yEUOVV2+cJUmagIyGNXe/UXHCIApjl2UCwcukp4aB7llgkaTDv4ubEOyLEtB47zC
+lU4XZFKReoZvH130luDyWpNOZrqwM8yD9isWwkFVTsLahEMrCXXtzZVpO/gc63/
kY3KXB3n+1qSUlcVoa3+/FM7PVLUqjKF4A++bZUcaE4vmBpqVz8d5sa3NnWUxlM3
y/oYdBiPmhOPmynK9iFf7f/f7hU5PwHsNt7IwniW1qGzarSs3EKLrpiVEemUlkC0
EQZYFFJ6hpES5Fm9LzG7xu7lLI96KydYgd/8HQLhjRDsAjVpln4=
=SUBL
-----END PGP SIGNATURE-----

--dhcros4rwsnjx5pm--
