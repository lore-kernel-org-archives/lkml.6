Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D667C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEB32087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEB32087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeH1Sg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:36:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49699 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbeH1Sg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:36:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4F18620797; Tue, 28 Aug 2018 16:44:58 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 053E320877;
        Tue, 28 Aug 2018 16:44:28 +0200 (CEST)
Date:   Tue, 28 Aug 2018 16:44:27 +0200
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
Subject: Re: [PATCH v8 3/8] dt-bindings: media: Document bindings for the
 Cedrus VPU driver
Message-ID: <20180828144427.qhfmrmh757cxkptl@flea>
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-4-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wc5vevv7eatap4tl"
Content-Disposition: inline
In-Reply-To: <20180828073424.30247-4-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wc5vevv7eatap4tl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 09:34:19AM +0200, Paul Kocialkowski wrote:
> This adds a device-tree binding document that specifies the properties
> used by the Cedurs VPU driver, as well as examples.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>


Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wc5vevv7eatap4tl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluFX8oACgkQ0rTAlCFN
r3Qafg//XBepdoOQ/rUfQkKs0Kl7dCRa0Id2qK/y3DPF6eIE7j8tg8gLc5mVB9hF
qwLXb15k4hLFnY2bm91j/t3ZLga+e5YOV1kya/ZB8E5gjuR2+duTeVTGQ0WAX1RN
pQ/H3220Q6HJeUTlj2sXOPsk8P4sM3JUPmn1Eaj1ReNz2bWcRb2iRQbi4OiGQehc
AhIdvsDfxcN1dRnAwr3XAAPa5Hr/sKA2zigdXZMqBWu0v3JXf7JkdnpcUY//zF/e
ZXJYl2xQc4yhgpNbGf2fzTvC8t5lAp4V4F5ddA7H1BvIL2daqRjZyBHteKpeNKU9
WHn4Bbm8ybfQZfSK92HY2ilQzTCJuXUJnmiCyp70WZc4sSrfwS8sD9fAXgDVp2KJ
lXBu8qTeJtjKX3+8RYOVMyjCRdWGfUCOFJ/lyxMHbtB0c83sSWZdTHM+IJzR/KJq
6eKFvdanHEgUpkiK4AbUtJxp5Y9zXkd/YFncdX4XBRjcK6KFG9Dy1gAhY9g0kONe
0Hao9C6+D7C45sdwAZK0l9WQIhxAXQ15Nort7/U0r5yMEYRqc1c5iZHFmhQDMlMT
4DXZMiorpTXWu99py6QVRTKe8L6OCD+YYXbQ31WIiUnJMxsFw7U/QMTWsG524sEc
9UXsTCXC52gLxxWuX2hcrF2lGvG01w/KNmC5UTiBDc9nxCPzGCA=
=6uR/
-----END PGP SIGNATURE-----

--wc5vevv7eatap4tl--
