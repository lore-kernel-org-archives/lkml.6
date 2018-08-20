Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB81C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4849D2172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4849D2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeHTSDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:03:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44105 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeHTSDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:03:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4EAFB208C2; Mon, 20 Aug 2018 16:47:07 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id 17CDB20828;
        Mon, 20 Aug 2018 16:46:57 +0200 (CEST)
Date:   Mon, 20 Aug 2018 16:46:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: allwinner: dts: h6: fix Pine H64 MMC bus width
Message-ID: <20180820144657.pexeoupw5h5xwcc5@flea>
References: <20180726044805.55888-1-icenowy@aosc.io>
 <20180730082712.koiaej6dxjnnk6lb@flea>
 <6e2df3d919b85f48c22c653124b7c2b594cb2d28.camel@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="twmsbk4y6bcyavqt"
Content-Disposition: inline
In-Reply-To: <6e2df3d919b85f48c22c653124b7c2b594cb2d28.camel@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--twmsbk4y6bcyavqt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 10:24:20PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2018-07-30=E4=B8=80=E7=9A=84 10:27 +0200=EF=BC=8CMaxime Ripard=
=E5=86=99=E9=81=93=EF=BC=9A
> > On Thu, Jul 26, 2018 at 12:48:05PM +0800, Icenowy Zheng wrote:
> > > Currently the enabled MMC controllers on Pine H64 do not have bus-
> > > width
> > > set, which make them fall back to 1-bit mode and become quite slow.
> > >=20
> > > Fix this by add the corresponding bus-width properties.
> > >=20
> > > Fixes: ecbd611882a1 ("arm64: allwinner: h6: enable MMC0/2 on Pine
> > > H64")
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >=20
> > Applied, thanks!
>=20
> BTW why didn't I see it in next-20180820?
>=20
> It's 3 weeks later, and you didn't say that the patch is queued for
> another version.

This has been merged to a fix branch we'll send for 4.19 once rc1 is
out.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--twmsbk4y6bcyavqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt61GAACgkQ0rTAlCFN
r3S92A/9ESkWSTDWOv3o8zqiDdTI8CCI1Y4i9iECngE+xDJsuQ49j/raF/JSp8bV
udPM0mRikDkVoKnzae7UQGhhU4YjFcePopC4KTsSMXac/KszIIitsd3QDLnYhqKo
3gXNN2yt3g2pUBFcisjARVUTuKVnLbn0xWOVIeOkUA9LplCwCfF79kCmGWZOvTds
C7u1J3gxQlXGEJoZwrvg+gFy7P3uc/BKn6J+uJYau/1MuoTgsjO4wK+9W7hHa54R
gFYx5iWAPlg0zU7/1AFlF2XUEYOppYWl6y3kcblsvKEH92XqoidCGp1FUjrD71L6
YPRvj0WVr/LNetnP3AZT/KDDYZPammT7+V6kNsAAthfXXiUNQggU8XNTQ1zDk0Pp
BAWlMXjlt6ldeCVleAdcz4ObSf5+OQaYM56x9HwmgVKBlkHMx6jB0p93uBB9i/Mr
OZcbPnNP7MJM5yUMa9tiFvGnzT+w1hz/FbzIaSZQCw+wMwlzxg/hKVjpD2ndrYPc
IMrqwviW0Qdr7NEYdkCR+FQfq/sniVBziFBR+HR6kCKXAWghyQQPRWdKHjueTlFa
iSAhyr30UJWVaIwLyxhXf6ZoQxbhREM6YQ+QLB+DMCjUzSIA6R5fz6/NRarhHyWF
if6jZViGdz7yDQGGqS7Oe27sEpjTn//39Br3ojkAZRmsFC3tCAY=
=QYFG
-----END PGP SIGNATURE-----

--twmsbk4y6bcyavqt--
