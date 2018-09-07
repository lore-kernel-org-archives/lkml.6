Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC86C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E082083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E082083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeIGT5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:57:22 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:60094 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbeIGT5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:57:22 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 7B3BDC025F;
        Fri,  7 Sep 2018 17:15:59 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 8302CC0F43; Fri,  7 Sep 2018 17:15:57 +0200 (CEST)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id E60EEC0F2D;
        Fri,  7 Sep 2018 17:15:31 +0200 (CEST)
Message-ID: <97d47388931bec3740a503b080dd9f8f9a4ec57e.camel@paulk.fr>
Subject: Re: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Fri, 07 Sep 2018 17:15:27 +0200
In-Reply-To: <20180907142528.4daxlsd6jwnkw74h@flea>
References: <20180906222442.14825-1-contact@paulk.fr>
         <20180906222442.14825-6-contact@paulk.fr>
         <4b30c0bf-e525-1868-f625-569d4a104aa0@xs4all.nl>
         <20180907132620.lmsvlwpa3rzioj2h@flea>
         <2c9689b2-c5a6-58b7-b467-fc53208ecd2d@xs4all.nl>
         <20180907142528.4daxlsd6jwnkw74h@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/jMTXi+1tRNXwFBql5tB"
X-Mailer: Evolution 3.28.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/jMTXi+1tRNXwFBql5tB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 07 septembre 2018 =C3=A0 16:25 +0200, Maxime Ripard a =C3=A9cri=
t :
> On Fri, Sep 07, 2018 at 03:52:00PM +0200, Hans Verkuil wrote:
> > On 09/07/2018 03:26 PM, Maxime Ripard wrote:
> > > Hi Hans,
> > >=20
> > > On Fri, Sep 07, 2018 at 03:13:19PM +0200, Hans Verkuil wrote:
> > > > On 09/07/2018 12:24 AM, Paul Kocialkowski wrote:
> > > > > From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > >=20
> > > > > This introduces the Cedrus VPU driver that supports the VPU found=
 in
> > > > > Allwinner SoCs, also known as Video Engine. It is implemented thr=
ough
> > > > > a V4L2 M2M decoder device and a media device (used for media requ=
ests).
> > > > > So far, it only supports MPEG-2 decoding.
> > > > >=20
> > > > > Since this VPU is stateless, synchronization with media requests =
is
> > > > > required in order to ensure consistency between frame headers tha=
t
> > > > > contain metadata about the frame to process and the raw slice dat=
a that
> > > > > is used to generate the frame.
> > > > >=20
> > > > > This driver was made possible thanks to the long-standing effort
> > > > > carried out by the linux-sunxi community in the interest of rever=
se
> > > > > engineering, documenting and implementing support for the Allwinn=
er VPU.
> > > > >=20
> > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > >=20
> > > > One high-level comment:
> > > >=20
> > > > Can you add a TODO file for this staging driver? This can be done i=
n
> > > > a follow-up patch.
> > > >=20
> > > > It should contain what needs to be done to get this out of staging:
> > > >=20
> > > > - Request API needs to stabilize
> > > > - Userspace support for stateless codecs must be created
> > >=20
> > > On that particular note, as part of the effort to develop the driver,
> > > we've also developped two userspace components:
> > >=20
> > >   - v4l2-request-test, that has a bunch of sample frames for various
> > >     codecs and will rely solely on the kernel request api (and DRM fo=
r
> > >     the display part) to test and bringup a particular driver
> > >     https://github.com/bootlin/v4l2-request-test
> > >=20
> > >   - libva-v4l2-request, that is a libva implementation using the
> > >     request API
> > >     https://github.com/bootlin/libva-v4l2-request
> > >=20
> > > Did you have something else in mind?
> >=20
> > Reviewing this will be the next step. I haven't looked at the userspace=
 components
> > at all yet, so I don't know yet whether it is what we expect/want/need.
>=20
> We meant this as a debug tool and a stop-gap measure, respectively, so
> it might not be what you're expecting, and I'm kind of expecting to
> have the libva fade away with media frameworks getting native support.
>=20
> > I think this might be a very good topic for the media summit in October=
 if we
> > can get all the stakeholders together.
>=20
> I'll be there, so we can definitely discuss this.

Note that I won't be able to attend the summit in the end.

I think some work still needs to be done in libva-v4l2-request to make
it really generic and compatible with other drivers (for instance, only
NV12 is in there at this point, and it's hardcoded in quite some
places). There are other things I'm not too happy about (e.g. I figured
very recently that the approach to "deduce" logical planes sizes and
offsets is problematic). Hopefully, I'll find time to rework that soon.

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-/jMTXi+1tRNXwFBql5tB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAluSlg8ACgkQhP3B6o/u
lQxHlQ//UmgqyrGQXagOOFocJ7Q4bGU8JMBztztEuNIkQTnFbFROL+KmfSmA2JRI
lzxqv3RGwaVrARUqIok17JFxQ/eRjgOAtmP3RVUpWeI9ZqNFGMs9IjHGB/8k7I0R
mXQiE3MY/g8+0jz5T9JX/KDMz6WT4VZ9DjhTLV++aQCSVLspH+tTgis13oBVNdue
E8d9wKjcgjsh1gZrxXbRWNW1IJ7BfuFnzIjXasO+1dHSWMGjxLj8Zn7hr/IUx0XX
2ysTBCqlCw8hOhwyLkBjvpIPxkH3mSyX7Ibnd5PKmiQvXJsR4JuF8vRepHE2XzUv
W8ugudBUZnv29J8v0QOfi3fXF8Ih23giq0/I7+sMR8dnW436UyU9/nEPqRl9hAIK
2twPFORECgxOV1fPwENX5xYW//mEW0UMgigVXNR9CunH1ocqzzvhOzqmDuOBzSya
MyheXsdW9UK0EJj7qJ5oLjy6uTaF1qXL+o22TtpWQqGMESJvPy9iaq7MwUXwPCbv
5akzn8i6F7w1+shdrU1gHdstxYX4o8cc/o1Lmcvaw0lLoy4Yne657NrSwftRRTCp
1Kc6aumnYC+HUUllk86xThFE3belybuK6eDTvIr01nb7jIh4nTzNVNWYhjip0UlA
pehHPQ9p9qEbNnZv/iV5m2U90YlqCLPiHwGxkPqUv3FUIpljiKU=
=h471
-----END PGP SIGNATURE-----

--=-/jMTXi+1tRNXwFBql5tB--

