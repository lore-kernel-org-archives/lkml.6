Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA17C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC77C20836
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC77C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeH1Ssg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:48:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50543 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbeH1Ssg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:48:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EED4920797; Tue, 28 Aug 2018 16:56:32 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 783D222A49;
        Tue, 28 Aug 2018 16:56:15 +0200 (CEST)
Date:   Tue, 28 Aug 2018 16:56:14 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v8 4/8] media: platform: Add Cedrus VPU decoder driver
Message-ID: <20180828145614.rovduhq676eag3gz@flea>
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2unr7vok42r5f56p"
Content-Disposition: inline
In-Reply-To: <20180828073424.30247-5-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2unr7vok42r5f56p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 09:34:20AM +0200, Paul Kocialkowski wrote:
> This introduces the Cedrus VPU driver that supports the VPU found in
> Allwinner SoCs, also known as Video Engine. It is implemented through
> a v4l2 m2m decoder device and a media device (used for media requests).
> So far, it only supports MPEG2 decoding.
>=20
> Since this VPU is stateless, synchronization with media requests is
> required in order to ensure consistency between frame headers that
> contain metadata about the frame to process and the raw slice data that
> is used to generate the frame.
>=20
> This driver was made possible thanks to the long-standing effort
> carried out by the linux-sunxi community in the interest of reverse
> engineering, documenting and implementing support for Allwinner VPU.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2unr7vok42r5f56p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluFYo0ACgkQ0rTAlCFN
r3QJOA/9FoAMH1yDyRaBPYbQVjztJN5W1XFxe8VK6XPyGvoWe3SmdwVIwR+zKnwW
dStsy9NNExPxuNHFHKM30YBYHhd3tV4LSW+LhEQcSDfSNBg77WLrrJeFS4oKNFYL
phemhtdiQntVi/+//eQqAPWfjW/RPMt9akrfXvxdjZFFRDXI0Ag/I0ZS75lrJiyz
bW+7Gh8dKDn+E4X9s/N7ljh2RNSsX6ocgHRZbmfvl4uR4WamxzdB3oT0bowkQy3V
PkukrLoK+pI6kEq2dxNDegf7pF+TenOf5mqL5KCp2W//3vO9OQKchU2C6woD2fOl
NjxwyjF3dZIhAYD6tcp06gf77y6UIhSqTxnNN5LN8U0AA8NspZsDnipmUfr7+Bvf
5nofBiRJNmZ705SnuiToQRgSPaeHh141RldASTTILf7glhg2Q/0Ti+TcEH6Cs+mz
IvAQ95UnkANThua7C2PRQlBhnIRibAw5r8ggBrIZz5uaIGclzqFYZN7Ky3QvNSsQ
QdNpIGyOGgBy3B6GTqGCqkFbaBNbLW/Zqb1e/PiE+ALbJys0KgZX2o48FDeNBDPT
cYRKWAKXgjLwLBgFLNF3bSpfXFf/tUpkag7eXQhGZzCVsQ3kPQ/8Aix2ayFjQa6G
ZlhyooHQEadcNJC3GxQi6UsyCwfhAbfZoUYS11uJzTz/bKKViY4=
=08WM
-----END PGP SIGNATURE-----

--2unr7vok42r5f56p--
