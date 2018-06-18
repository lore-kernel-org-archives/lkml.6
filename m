Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7A0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737D20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C737D20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934891AbeFRQEh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:04:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46516 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933773AbeFRQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:04:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D9C8120DE1; Mon, 18 Jun 2018 18:04:32 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id E53CF208B3;
        Mon, 18 Jun 2018 18:04:00 +0200 (CEST)
Date:   Mon, 18 Jun 2018 18:04:01 +0200
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
Subject: Re: [PATCH v4 04/19] dt-bindings: sram: sunxi: Add A20 binding for
 the C1 SRAM region
Message-ID: <20180618160401.c6aqkeh6suime7xb@flea>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4nxzqk2qbkg4dawg"
Content-Disposition: inline
In-Reply-To: <20180618145843.14631-5-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4nxzqk2qbkg4dawg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1;5202;0c
On Mon, Jun 18, 2018 at 04:58:28PM +0200, Paul Kocialkowski wrote:
> This introduces a dedicated binding for the C1 SRAM region for the A20
> sunxi platform.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Docu=
mentation/devicetree/bindings/sram/sunxi-sram.txt
> index ddc82cbd7f4d..221fa7b42c18 100644
> --- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> @@ -35,6 +35,9 @@ The valid sections compatible for A10 are:
>  The valid sections compatible for A13 are:
>      - allwinner,sun5i-a13-sram-c1
> =20
> +The valid sections compatible for A20 are:
> +    - allwinner,sun7i-a20-sram-c1

Same thing here, there's more supported SRAM than that. And maybe we
should just merge everything into the first patch? This looks like the
same commit over and over again.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4nxzqk2qbkg4dawg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsn1/AACgkQ0rTAlCFN
r3SiCRAAiZ0bv1Jj9SWLG1S5rEcQ0h1+du3g1PpMBPhx4WGG04MZJNLBjG9gdRkk
uRZz/H3nV4WbajFBQrP7N1XghxE7pDLKcuH+dSRoentVEJk1COaJ6WHBsfp85Fyy
4hR5KJ5I+195piJcCG6crdkOqYzbtCBmZloJzxna44m7nE+mewhcxHtmuPdzQCny
dsi3YUdadL/Q3X3U0IuiY8MYlvCLBeYnN4XZYkgSJkIigu7Cu5DpeatTL9B5zJEp
wbLpF0JyiQ3cqxUqAtnBwXeZfsi1xhU7yLPFJphcJN1jpqFbjiiTpjaC8RaqdkNX
LdygQ5IPg6Uzbzhs/qwWa6e+Wsi8UNEIyk6RepsmthBFA9I59sz54ebIheimc7Q7
5fdQjyJsDCbQJENp28/Y56sTnkXUTVKNvxg3b/EtZ4VPvfSp4Ooydr3o74iKtFyp
17VRmxKXKEr6bFfrD8NjnZbUyqN/qh5VXoBIKKQa/be6oNJPVg1+e/5Nd2JBS+MI
NXrfPvN2jR1ohKDJ6PdDiIgC4izFZEuXUIzhFyTcPkJSbVKjLCbZV0DV67ru+SxN
Rh6xySetDQZfasehYAU2KzkLBic5IIKHhZkfOCnqEeX++4meh8FSy/yPJoU3jOVy
Kp18L4zsKA/kbdyf+0J2CdaZ6VFEkQ0eO9d/VvnHaYmBjCeooyQ=
=kEQ3
-----END PGP SIGNATURE-----

--4nxzqk2qbkg4dawg--
