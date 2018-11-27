Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D877BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDE720989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDE720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeK0UBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:01:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58588 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeK0UBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:01:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0A20420D31; Tue, 27 Nov 2018 10:03:55 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id CE97E20736;
        Tue, 27 Nov 2018 10:03:44 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:03:44 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sean Paul <sean@poorly.run>, nd <nd@arm.com>
Subject: Re: [PATCH v2 31/43] drm/sun4i: Add a dedicated ioctl call for
 allocating tiled buffers
Message-ID: <20181127090344.qlrksisbbmcjm3ac@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-32-paul.kocialkowski@bootlin.com>
 <20181123113019.43vrzvj42l35el7z@DESKTOP-E1NTVVP.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k5r55qbcww2xy4lm"
Content-Disposition: inline
In-Reply-To: <20181123113019.43vrzvj42l35el7z@DESKTOP-E1NTVVP.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k5r55qbcww2xy4lm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 11:30:20AM +0000, Brian Starkey wrote:
> Hi Paul,
>=20
> On Fri, Nov 23, 2018 at 10:25:03AM +0100, Paul Kocialkowski wrote:
> >This introduces a dedicated ioctl for allocating buffers for the VPU
> >tiling mode. It allows setting up buffers that comply to the hardware
> >alignment requirements, by aligning the stride and height to 32 bytes.
> >
> >Only YUV semiplanar and planar formats are allowed by the ioctl, as the
> >hardware does not support the tiling mode for other formats.
>=20
> What's the general feeling about a more generic version of this ioctl?
> There doesn't seem to be anything Allwinner-specific in the ioctl
> arguments.

I'm definitely in favor of having such an ioctl.

maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--k5r55qbcww2xy4lm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0IcAAKCRDj7w1vZxhR
xR4QAQC0RFDFjyHktG8EZmqMcMnpA8PxaL72V+Kpkbe8O8e0hAEAxdq2dde2CIY3
rmmp6SYmvHk2zG7yV30A36FXajupLwU=
=WOAm
-----END PGP SIGNATURE-----

--k5r55qbcww2xy4lm--
