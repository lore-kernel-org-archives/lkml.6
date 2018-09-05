Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E022075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E022075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIELvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:51:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35051 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbeIELvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:51:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 27680206F6; Wed,  5 Sep 2018 09:22:26 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id C7743203DC;
        Wed,  5 Sep 2018 09:22:25 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:22:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 10/11] drm/sun4i: Add support for HDMI voltage
 regulator
Message-ID: <20180905072224.w5u3djfxxxc2h2pc@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-11-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jh5uyav6levo23sj"
Content-Disposition: inline
In-Reply-To: <20180904044053.15425-11-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jh5uyav6levo23sj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 12:40:52PM +0800, Icenowy Zheng wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> Some boards have HDMI VCC pin connected to voltage regulator which may
> not be turned on by default.
>=20
> Add support for such boards by adding voltage regulator handling code to
> HDMI driver.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> [Icenowy: change supply name to "hvcc"]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jh5uyav6levo23sj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPhDAACgkQ0rTAlCFN
r3SAphAAkQnu9/go2wPG5qcaPI6CaF4TraMiZmed7/ZDF+8JsUiLDlDziZiuLqBe
MIaz29JnuvszsZt4QxubKMMoPfD7g30SpzEPvIakjwtB+AIt9TkNs/rDNJ0NDQ+L
EhefjBTc+JF6M+TwVbAAjTYqUStnBMhT3DXUBdparzvIGGrNxHpju4xYz1hbDQbt
63P7CFsd2ZMJdbTti630FYTR0r1cm8UCpgVSpzN865EkQD2daiTKwFyTPAbUUteA
8X+2DDzy6gnbigpPE9uX3c8V4YZM0se0pouImTyjaveinAfc4tJk7cE6j3c6lIxA
xdiqZKWpjuXG/iG4RsJIg/OVYEMSm3Vru4dKqO6l056HXt9oVzegg0vWKMDsG7Cx
vT3aCSIDbYyxFofUzVr3dUH3fgMnpz4ci/Y0gjtbrV2dzzvWUcZHkDzL9D8TpVbU
XGenjyNx3IyggIeaXG+cYCqJjtZxhAZGJBstEJalrXAVtcqD+tEEiyxiCe20609A
Y7hWWBjG58CPVT157rjQYf6hFEb8tsvoYE5ytNZdMW5MzE/ik7XcEJidDMmOfb+z
q2I45XaolgnRnnbqxR5bZt6RoIeT7J8vIIeafhNq47iAvxlPCWwc8gQ3ZZaZVNNN
mp8rEG0kC/b77gyEP/Q68xpZndqMj+jUGy9oKMgmSx5kWV7phBM=
=HHVn
-----END PGP SIGNATURE-----

--jh5uyav6levo23sj--
