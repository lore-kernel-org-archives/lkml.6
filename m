Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2072E20020
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2072E20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbeGKJFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:05:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41871 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeGKJFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:05:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DCD1E20733; Wed, 11 Jul 2018 11:01:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id AF66F206A6;
        Wed, 11 Jul 2018 11:01:57 +0200 (CEST)
Date:   Wed, 11 Jul 2018 11:01:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pawel Osciak <posciak@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>
Subject: Re: [linux-sunxi] [PATCH v5 09/22] ARM: dts: sun5i: Use
 most-qualified system control compatibles
Message-ID: <20180711090157.bs435c4k6knb6bqv@flea>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-10-paul.kocialkowski@bootlin.com>
 <CAGb2v64HbpvJhy5KQOepc61nU7NECaWMPvhZ16dk5hJXiPBHxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4xdjxhmgjufzuifr"
Content-Disposition: inline
In-Reply-To: <CAGb2v64HbpvJhy5KQOepc61nU7NECaWMPvhZ16dk5hJXiPBHxA@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4xdjxhmgjufzuifr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 10:53:44PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > This switches the sun5i dtsi to use the most qualified compatibles for
> > the system-control block (previously named SRAM controller) as well as
> > the SRAM blocks. The sun4i-a10 compatibles are kept since these hardware
> > blocks are backward-compatible.
>=20
> Not quite sure why they are backward-compatible. The A13 has less SRAM
> mapping controls than the A10.

I've applied this patch, and removed that compatible (and its mention
in the commit log).

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4xdjxhmgjufzuifr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltFx4QACgkQ0rTAlCFN
r3T5hw/+LrwtplgQOGWsmip+88WJ28Kyyjgcza8XqQa4MXn75qKAhuqdHSlPLJ8b
stcNMEWB81LhHzEqabOjltriCEz6sYOLoCZB7deZfV0VO2QuNYBir6scl770b+c3
Pv1HqpZe4vZv8tnY7U/jUI3b35H7bXl+zFlAxu8O7TGTwtOjL4Bt01EM5h5Ox9ut
lTRPX5WUphSgUMkMJzo0BrO7FNHZXb6LhIzmOE3bYvJf62jRLkSF7pwhcqPI8ZtA
jSAp0YlbDcUgb4Q1nkDZmpsvtXFMQdIoDtBUhwGBGbLlUNuY7N9WdK0NehTCB5jA
oSL6XBBiOg8/i5VqXUglSLHaaxE3OMzr5A4QGxrxXCWilV2chbvAfaOpFH7GPOsQ
ijibhtej60bZ7Nii0cL9afzWNVbgRjS7ox78i4MEkMd3V5+3tWodZdED3lcg53RJ
m4fb3m1DyMEZWj3EERFD9khsvb76yIA2/jvq8jzRI4yV4nBgE0bD83XEcKL5x1Pz
i+UYbNPo9JO78q2/gSatoJzVyxZ9CR/j/LTZ+XA2APBqeUEegvK4bXpD0nrC4P+C
j+gqFwLa/AltYU2Tsfh/xVaLYVOfOezAjetht3TfJHecDRc+VXus/AJOftAE2Sfc
1GK5Q6PCU4SYUpj7JtHBaUNFr+Yie+c5YtzJDcdIH/w3TzRXt44=
=MV4R
-----END PGP SIGNATURE-----

--4xdjxhmgjufzuifr--
