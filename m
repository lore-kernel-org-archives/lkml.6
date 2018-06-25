Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D8EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B2125E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B2125E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933846AbeFYQnF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:43:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34233 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933140AbeFYQnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:43:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3F29206D8; Mon, 25 Jun 2018 18:43:00 +0200 (CEST)
Received: from localhost (unknown [88.128.82.118])
        by mail.bootlin.com (Postfix) with ESMTPSA id B7DC320012;
        Mon, 25 Jun 2018 18:43:00 +0200 (CEST)
Date:   Mon, 25 Jun 2018 18:43:01 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/24] Add support for R40 HDMI pipeline
Message-ID: <20180625164300.vivzyu3g52d2pjdn@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fedf5x4px5amfvpi"
Content-Disposition: inline
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fedf5x4px5amfvpi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 02:02:40PM +0200, Jernej Skrabec wrote:
> This series adds support for R40 HDMI pipeline. It is a bit special
> than other already supported pipelines because it has additional unit
> called TCON TOP responsible for relationship configuration between
> mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
> and TV TCONs, TV encoder clock settings and pin muxing between LCD
> and TV encoders.
>=20
> However, it seems that TCON TOP will become a norm, since newer
> Allwinner SoCs like H6 also have this unit.
>=20
> I tested different possible configurations:
> - mixer0 <> TCON-TV0 <> HDMI
> - mixer0 <> TCON-TV1 <> HDMI
> - mixer1 <> TCON-TV0 <> HDMI
> - mixer1 <> TCON-TV1 <> HDMI
>=20
> Please review.

This looks all fine by me, thanks!

I'd still like some more review (by Chen-Yu and Rob) before applying
it, but you can add my Acked-by for the next round if needed.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--fedf5x4px5amfvpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsxG5QACgkQ0rTAlCFN
r3QBiA//an1PO/EbZjw00Eqp1RaiAneLJvJrChICpxAUXy2zYmIhpKUmVxdv1jxl
Osyb/mJb14nkegVCLNPjwSeFu0TN2D+s0gS95q7KBE/8MrFrAxNwc6PcN8Y/7vNx
0hg0mosBIoot7+VStEmjSzyCF82B0YE2FHpIO+bYjwdx0oAGJ8XGrIgeXJv38QRx
oqZ3ilF504mRHwRu6eadGaG3rEgU2/eOjSZvC4CQz4trQ2PlyC/pxIRipYogBxkU
SaMQqVkQ1mp4oqpikMqFqUIFtR9gRS4qGHrtahzMqbdRxuzF/4wwmcWLiAgCAOIN
x2ygwkSdrsla9Zc0SHfJV8tlD/kAt7cmyqU0RjwtDeyA9RjOpgD5dnciygxittgm
hZWb1Gb4lPEeOkoiJeq3NHNez3A55dVGPWtWbeU+FyiEFl9UN0K/Qu+m97fyllj1
XmrAdWZ+wS0Yw52pj9/CVaFk8X1G0jyTHvgXDNxBuQNJ8tELtxSHfOhiZd4Dbn5k
CirxbfOz5wHaoLu5mlJM077olYp1ZoKw4D6dTx0Zfgn1FO99Mjgep9vz8KXLHx9k
WKFxUgVcRGtMGWwjVKRIjvz+4FhWr1PXcqVh9kGVQSVD2Q/JZKEqV6sdWQAHBLCe
Vp8WzDVo8GXAmfozQ9ErxdTwUPfhx97cNSFVFFlUcxx8aI9ThIQ=
=aSGT
-----END PGP SIGNATURE-----

--fedf5x4px5amfvpi--
