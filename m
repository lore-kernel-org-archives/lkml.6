Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A38C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76D520857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76D520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeIELt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:49:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34814 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeIELt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:49:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9F1DC207AB; Wed,  5 Sep 2018 09:21:05 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 73760206DE;
        Wed,  5 Sep 2018 09:21:05 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:21:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 04/11] drm/sun4i: Add support for A64 mixers
Message-ID: <20180905072104.n2v54om6lc4hylf4@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gqzvseqdskkuquks"
Content-Disposition: inline
In-Reply-To: <20180904044053.15425-5-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gqzvseqdskkuquks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 12:40:46PM +0800, Icenowy Zheng wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>=20
> Mixers in Allwinner have similar capabilities as others SoCs with DE2.
>=20
> Add support for them.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> [Icenowy: Add mixer1]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gqzvseqdskkuquks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPg98ACgkQ0rTAlCFN
r3TKAQ//ZtxhtHf+V1D9/0wEn+/6lO6xD62DDNIAT0l7KUHEx+Sz7EWFm5kyuGX9
kMmjV1TqKK0a35pMaiH/HZcgxr7vCtK+JkgKKy30rx2NCeszVHm5GVMXBTzHsPqF
saDB2ULWRbcfYKE/arPljmj7cI4Qjk7z/kVwnedvwLi4NcNWd4M27FmhzDFnH+wU
Mq/fvzCMbUb8Acsr7TyY5jgO9c/O4GXV/W5tTKGANo+YuU6NJBZPjJxWl/YLH5qd
e48CdfOIMOpdvGXWXRj4PMUXft0eR/JtzKXp9FqvogdbgGRXuqBFawmv1Vv6QlX6
ZRmqxh7LGcV+dDyt6HG/NE/Aljvo9Bqu1azCWG+RXWKeYnKaQ5kQhG6ALwMSXz32
4na6PyLbN9T3ZYrB6rNMqBK6PpGNcD+hEEqMPHsul9wk6NY8q3m8QW+6p/AuGbqZ
HP1QEQrzNynTWE51C1MGBdhjBGlj920jc687g1T5CgW+H7AfIFeD8FxDHI8BbEn7
OrwQn2q6HXg+NDsI8QA/pqLNZI3QbTCTXLsmRDNX2rFFiOTmfEdg0LiyNeAMMZKJ
7ftw+zkMPIYwUbMiAxD3+cnIBTW7CcluFyX0kG+q6ejfgV1AI1P7P/p00zskTeTH
ShZ2hsblcKo78DLGHRF7Nw6TRnAwMhfHjtobMOcOGfQFz4NO+Mc=
=arh9
-----END PGP SIGNATURE-----

--gqzvseqdskkuquks--
