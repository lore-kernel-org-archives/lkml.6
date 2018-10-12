Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820E6213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820E6213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeJLTYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:24:13 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:36772 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbeJLTYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:24:13 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 8F9A2BFE63;
        Fri, 12 Oct 2018 13:52:06 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 7BF9DC1064; Fri, 12 Oct 2018 13:52:05 +0200 (CEST)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 40884C105A;
        Fri, 12 Oct 2018 13:52:00 +0200 (CEST)
Message-ID: <95802e5952d8dd9c4a26809034e221fa56988ffb.camel@paulk.fr>
Subject: Re: [RFC PATCH v2] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     nicolas@ndufresne.ca, Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Date:   Fri, 12 Oct 2018 13:52:34 +0200
In-Reply-To: <CAAFQd5Cr4OxVQtzT1NyPm+-buZJHsmF0BM6wMTxOdonUpCC_NA@mail.gmail.com>
References: <20181004081119.102575-1-acourbot@chromium.org>
         <f1fa989b372b514f0a7534057de80b0c453cc8a3.camel@paulk.fr>
         <5085f73bc44424b20f1bd0dc1332d9baabecb090.camel@ndufresne.ca>
         <dc1045e5806638d58ae5ace796541cb8a3d29481.camel@paulk.fr>
         <CAAFQd5Cr4OxVQtzT1NyPm+-buZJHsmF0BM6wMTxOdonUpCC_NA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pPho24jATGCEvTPHhYaW"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pPho24jATGCEvTPHhYaW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 09 octobre 2018 =C3=A0 16:36 +0900, Tomasz Figa a =C3=A9crit :
> On Sat, Oct 6, 2018 at 2:09 AM Paul Kocialkowski <contact@paulk.fr> wrote=
:
> > Hi,
> >=20
> > Le jeudi 04 octobre 2018 =C3=A0 14:10 -0400, Nicolas Dufresne a =C3=A9c=
rit :
> > > Le jeudi 04 octobre 2018 =C3=A0 14:47 +0200, Paul Kocialkowski a =C3=
=A9crit :
> > > > > +    Instance of struct v4l2_ctrl_h264_scaling_matrix, containing=
 the scaling
> > > > > +    matrix to use when decoding the next queued frame. Applicabl=
e to the H.264
> > > > > +    stateless decoder.
> > > > > +
> > > > > +``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM``
> > > >=20
> > > > Ditto with "H264_SLICE_PARAMS".
> > > >=20
> > > > > +    Array of struct v4l2_ctrl_h264_slice_param, containing at le=
ast as many
> > > > > +    entries as there are slices in the corresponding ``OUTPUT`` =
buffer.
> > > > > +    Applicable to the H.264 stateless decoder.
> > > > > +
> > > > > +``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAM``
> > > > > +    Instance of struct v4l2_ctrl_h264_decode_param, containing t=
he high-level
> > > > > +    decoding parameters for a H.264 frame. Applicable to the H.2=
64 stateless
> > > > > +    decoder.
> > > >=20
> > > > Since we require all the macroblocks to decode one frame to be held=
 in
> > > > the same OUTPUT buffer, it probably doesn't make sense to keep
> > > > DECODE_PARAM and SLICE_PARAM distinct.
> > > >=20
> > > > I would suggest merging both in "SLICE_PARAMS", similarly to what I
> > > > have proposed for H.265: https://patchwork.kernel.org/patch/1057802=
3/
> > > >=20
> > > > What do you think?
> > >=20
> > > I don't understand why we add this arbitrary restriction of "all the
> > > macroblocks to decode one frame". The bitstream may contain multiple
> > > NALs per frame (e.g. slices), and stateless API shall pass each NAL
> > > separately imho. The driver can then decide to combine them if needed=
,
> > > or to keep them seperate. I would expect most decoder to decode each
> > > slice independently from each other, even though they write into the
> > > same frame.
> >=20
> > Well, we sort of always assumed that there is a 1:1 correspondency
> > between request and output frame when implemeting the software for
> > cedrus, which simplified both userspace and the driver. The approach we
> > have taken is to use one of the slice parameters for the whole series
> > of slices and just append the slice data.
> >=20
> > Now that you bring it up, I realize this is an unfortunate decision.
> > This may have been the cause of bugs and limitations with our driver
> > because the slice parameters may very well be distinct for each slice.
>=20
> I might be misunderstanding something, but, at least for the H.264
> API, there is no relation between the number of buffers/requests and
> number of slice parameters. The V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM
> is an array, with each element describing each slice in the OUTPUT
> buffer. So actually, it could be up to the userspace if it want to
> have 1 OUTPUT buffer per slice or all slices in 1 OUTPUT buffer - the
> former would have v4l2_ctrl_h264_decode_param::num_slices =3D 1 and only
> one valid element in V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS.

It seems that we have totally missed that when implementing H.264
support for Cedrus and did not do anything similar for other codecs.

I think grouping slices in the same OUTPUT buffer and providing offsets
for each slice from each element of an array of SLICE_PARAMS controls
makes a lot of sense.

This way we don't have to have one OUTPUT buffer per slice, which
simplifies things a lot. Also, not having one request per slice will
probably speed things up.

However, I'm a bit confused when looking at the chromeos-4.4 code. It
seems that RK3288 only takes the parameters from the first slice (it's
not using DECODE_PARAM's num_slices). Also, RK3399 doesn't seem to use
the slice params at all. I'm really curious to understand how it works
for Rockchip. Perhaps someone has some insight about this?

Also, I'm not sure we have converged on a solution for the Rockchip VPU
requiring the start code before the coded data. Given that each slice
should be handled separately, does it mean the start code has to be
repeated for each?

> > Moreover, I suppose that just appending the slices data implies that
> > they are coded in the same order as the picture, which is probably
> > often the case but certainly not anything guaranteed.
>=20
> Again, at least in the H.264 API being proposed here, the order of
> slices is not specified by the order of slice data in the buffer. Each
> entry of the V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS array points to the
> specific offset within the buffer.

Sounds good to me.

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-pPho24jATGCEvTPHhYaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlvAiwIACgkQhP3B6o/u
lQxw3w//S+TA/HF63g6lQhVlLlxOODD7ufHi1f8ZZP/q07z6TaQ2xxY0VGF0TXss
adUtwVlMhICg4oDvGIjj1WDsFfgpxOlCDOuHMiVtL/ZV12HbVK2wZ6Clgqif1REk
z3QUoKEw0W1DTnFsHIGbZ/pfjE1Cl7OMSRQN6d9MhGaRYzrJSARasXZnlSLAoJsz
0pHewb8vjY+V/Hq2T56j4gHM3Epyj/aPJYwSuM2KEhegrobzu5omkGDyAqyUuH40
kW99f1GVHf0FCJ1q9tLfFzycQtnkICEnmJ3aIy+VsG37d9dpUg8Oxqg7Sv+r88wa
gsUNAeT/4li+KAGl/4DqbyBmjqiyhYrndMW+kW9JmDR25hgkghXAm67a4Anvflig
vFlOIuWYjTVMJh1SNDiKvSjpSr9pgYkxKmQTjViQ01M6Zi/GFqn+tMfGTGu6D9Nq
Xln1ZAF5rhF+MrOLZWyZTd2Qla8CE+GlUFD20MoAKVxM2QuG/WLFZvXB0MdlQ5nw
hHvvOZ4U2ev9t3vdw3I9IFPC3EEL9EJJ7bgKU/T001APvVpvo66Tzt0B40RSmjdX
QbTWShcDtBGRoecCPoER9Rg0HhO+hZa/aULWkxqo9Jlp13Tx08O83SCGxu6KV9T9
I76TA8xxGJC4YwACfHODRRveCPyJILDAl1Yto/90uYezs3lbv4M=
=6Dm/
-----END PGP SIGNATURE-----

--=-pPho24jATGCEvTPHhYaW--

