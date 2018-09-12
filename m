Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B3CC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEACB206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEACB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeILM1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:27:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41503 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbeILM1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:27:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BC25120795; Wed, 12 Sep 2018 09:23:47 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8AADE20720;
        Wed, 12 Sep 2018 09:23:47 +0200 (CEST)
Date:   Wed, 12 Sep 2018 09:23:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Paul Kocialkowski <contact@paulk.fr>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
Message-ID: <20180912072347.nqw4uu23fykjtz72@flea>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-6-contact@paulk.fr>
 <20180911124625.6759e429@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4iwt5yvaz3vewot5"
Content-Disposition: inline
In-Reply-To: <20180911124625.6759e429@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4iwt5yvaz3vewot5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 12:46:25PM -0300, Mauro Carvalho Chehab wrote:
> Em Fri,  7 Sep 2018 00:24:38 +0200
> Paul Kocialkowski <contact@paulk.fr> escreveu:
>=20
> > From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >=20
> > This introduces the Cedrus VPU driver that supports the VPU found in
> > Allwinner SoCs, also known as Video Engine. It is implemented through
> > a V4L2 M2M decoder device and a media device (used for media requests).
> > So far, it only supports MPEG-2 decoding.
> >=20
> > Since this VPU is stateless, synchronization with media requests is
> > required in order to ensure consistency between frame headers that
> > contain metadata about the frame to process and the raw slice data that
> > is used to generate the frame.
> >=20
> > This driver was made possible thanks to the long-standing effort
> > carried out by the linux-sunxi community in the interest of reverse
> > engineering, documenting and implementing support for the Allwinner VPU.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> There are several checkpatch issues here. Ok, some can be
> ignored, but there are at least some of them that sounda relevant.

Sorry for that. Given that it's intended to be in staging, do you want
us to send subsequent patches or the whole serie?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4iwt5yvaz3vewot5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluYvv0ACgkQ0rTAlCFN
r3S58w/+MvryMqmIRUNmv1H9GXhuDsWOp7VMCpvVstUVg+kffP85rrA02wxoLE3Z
CjnQHNHhBplbOag70aPmK72nY1aPHYYNFlaGzA+p+H/z7pNgSer2TnIBs+FzSjlB
YpXPJFGBFjYAAEuFH/pZdMVrZP6OjXXKQ7vPUouLh1lERFUzbQ14dCnuYjCkIGzy
FFu4f21IYtwc5VLfKKD5TVRREKXKBUEg9QdFcHyGxdIneg6gCMQamCNB0oopY3si
HxOoaImNIQD/nwHRBhh6skWR1lSxCgBrBmL+PWbyx15RUcCFMOl0sWtN4Y7rL8g4
cCGRZn2UUWJXPIRVswe1YL67uvL0Comft0jpyoOLJcuaQ1m7o8ZbrYKd5cmvFvq8
VGPwcqArjKjFZMz4v4GDe7oP1iRr3m7xEr9SVsgBQnYBTFrxcGFJjhv9eTtN9d4G
SKgoY0YcbuuEr48FRwfFJFvbGH3y9tcvWJio4UGgsFuY5W5mCFxPrm1+tRqvE0P2
JxF4mfuVpsThh8Pb5TpynPsU5bmd6Ac0koF3f8NDAytqlwW2N2SRJqy8HuzVuWXB
UByquWYIvuKiEkywek+7I5SngJRA+3+X57Pbe7BmEYUJYpRMPjT61YXG1oKfmrRH
/OAO7wSCwkcMx5YWw4itGrhq2wqkn9GtU+3+nBevW+scBStCxYM=
=8asQ
-----END PGP SIGNATURE-----

--4iwt5yvaz3vewot5--
