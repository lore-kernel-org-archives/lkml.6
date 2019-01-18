Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3AAC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6624520850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfARSrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:47:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34331 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbfARSrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:47:52 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 213A32074A; Fri, 18 Jan 2019 19:47:50 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 22CA920BCD;
        Fri, 18 Jan 2019 19:46:58 +0100 (CET)
Date:   Fri, 18 Jan 2019 19:46:58 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] ARM: dts: sun4i-a10: Add Video Engine and reserved
 memory nodes
Message-ID: <20190118184658.dflpkqvdlg6zox7f@flea>
References: <20190118145730.22227-1-paul.kocialkowski@bootlin.com>
 <20190118145730.22227-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k53ajjhsub4gzoqy"
Content-Disposition: inline
In-Reply-To: <20190118145730.22227-2-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k53ajjhsub4gzoqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 03:57:30PM +0100, Paul Kocialkowski wrote:
> This adds nodes for the Video Engine and the associated reserved memory
> for the A10. Up to 96 MiB of memory are dedicated to the CMA pool.
>=20
> The VPU can only map the first 256 MiB of DRAM, so the reserved memory
> pool has to be located in that area. Following Allwinner's decision in
> downstream software, the last 96 MiB of the first 256 MiB of RAM are
> reserved for this purpose.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied both, thanks

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--k53ajjhsub4gzoqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEIfIQAKCRDj7w1vZxhR
xa2vAP0T8Y8UwFhPOPemgWXrb3EgpiLE0JQdqXwtuwHk3Sx2TAD/b8ziV3+fFRLn
beosSkkvgx9oUr3JfDnOI+dLFVFgugU=
=EC96
-----END PGP SIGNATURE-----

--k53ajjhsub4gzoqy--
