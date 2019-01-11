Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60220C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397E620872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbfAKPxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:53:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59163 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbfAKPxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:53:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE004209BC; Fri, 11 Jan 2019 16:53:27 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id A27172074D;
        Fri, 11 Jan 2019 16:53:27 +0100 (CET)
Date:   Fri, 11 Jan 2019 16:53:27 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Eben Upton <eben@raspberrypi.org>,
        David Airlie <airlied@linux.ie>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm/vc4: Limit SAND tiling support to semiplanar YUV420
 formats
Message-ID: <20190111155327.wbj3xgcfgz3tqmwo@flea>
References: <20181214141218.12671-1-paul.kocialkowski@bootlin.com>
 <87d0q4f5i7.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="44bmoovxofnwahbw"
Content-Disposition: inline
In-Reply-To: <87d0q4f5i7.fsf@anholt.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--44bmoovxofnwahbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 08:16:32AM -0800, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
>=20
> > Despite what the HVS documentation indicates, the VC4 does not actually
> > support SAND tiling modes for any RGB format and only semiplanar YUV420
> > formats (NV12/NV21) can be used in these tiling modes.
> >
> > The driver currently claims to support RGB formats for the associated
> > modifiers, so remove them from the supported list in the
> > format_mod_supported helper for RGB formats.
> >
> > Remove further checks that are no longer necessary along the way, since
> > semi-planar YUV420 formats support every SAND tiling mode.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> Reviewed-by: Eric Anholt <eric@anholt.net>

Applied,

Maxime


--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--44bmoovxofnwahbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDi79wAKCRDj7w1vZxhR
xbxhAQDkUkt4/RU+FZkRKqLB5O8qPuy7jguQF2KxPqAwFN8p9wEAtjTk5xsI68Ns
07Bt4u/y3npiru1Jgw/IhL0z8oFWOAE=
=Yal1
-----END PGP SIGNATURE-----

--44bmoovxofnwahbw--
