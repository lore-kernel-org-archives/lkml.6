Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB343C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8132120877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8132120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeGKI1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:27:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39853 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbeGKI1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:27:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F10C920739; Wed, 11 Jul 2018 10:24:34 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id BFC9320714;
        Wed, 11 Jul 2018 10:24:34 +0200 (CEST)
Date:   Wed, 11 Jul 2018 10:24:34 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux@armlinux.org.uk, mark.rutland@arm.com, robh+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: sun8i-a83t-bananapi-m3: enhance vcc-pd
 to 3.3v
Message-ID: <20180711082434.euhakdczf56p3fia@flea>
References: <1531165914-29760-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5c33dao3eatkslbo"
Content-Disposition: inline
In-Reply-To: <1531165914-29760-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5c33dao3eatkslbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 07:51:54PM +0000, Corentin Labbe wrote:
> Since commit d7c5f6863550 ("ARM: dts: sun8i: a83t: bananapi-m3: Add AXP81=
3 regulator nodes")
> my BPIM3 no longer works at gigabit speed.
>=20
> With the default setting, dldo3 is regulated at 2.9v which seems
> sufficient for the PHy but d7c5f6863550 drop it to 2.5 which is insuffici=
ent.
> Note that this behaviour is random for all BPIM3 (some works with 2.5, so=
me not)
>=20
> Finnaly, someone from bananapi confirmed that this regulator must be set =
to 3.3
>=20
> Fixes: d7c5f6863550 ("ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regu=
lator nodes")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--5c33dao3eatkslbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltFvsEACgkQ0rTAlCFN
r3QKJg/+K/DlD00KHNse+0AizjSvYrZcvybZixLUpIcYzlQSCJyamy/2xTHgX3/H
WHQpIUynVYRn0Dtocw9K3lAknejdloVahJXE5PK9rdfRrWQDPa+D2WKMVX5bdjJf
RfJQlGG7hvlhXLUTDeH8AJmdIWSICPOqLD3Rj6GbarVmhCdq0rki6FTgpCFGnYpz
Dru90YFGjiM5XAKS4KVVvjFkxqIyMHcy3yr7Da8ue/lhm+xOPbjrrDmVegTv566z
OJrbmj7toiQ/HglsrtdqaKxMCStul4e174DyHd74JH9zqi39VWwhbkSoAG+M03VH
SBEtpjj8kbcH7j+AM5uXSD4rvXaKioCuwjYciYXzuoz5UOFRKBGkb4FwYwRIpMj/
jMkt2O3ucYElGRMxNTTuHzGxdMeJEWjWUVR5+bLCEMnbHvTljQMTae8BZAGvdFmI
CHO99NTI0V4zicCOFOb58sMHYKrf4pfrBZBdbzzAT8pI2lI6L/g+HfOkxVYFE4rl
JjDkzcCRR4CxustpdZy/ZLJQCOST315d6wLt8Fc2my87FlTVZoSar09j31uZpaUz
TkfGY6vx+ihANb9TD9GnTLz+t/3SWJBBqiQXzbk0cInD7eZEXOriyea9nu0bqbtW
WX5aILLdgN4xWyBQO7+X3cmK63XVrxEwdcpBJnzVu/MFGmSS2hQ=
=AmsX
-----END PGP SIGNATURE-----

--5c33dao3eatkslbo--
