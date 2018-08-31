Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D068C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0363120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0363120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeHaMlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:41:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59545 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeHaMlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:41:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3B37820719; Fri, 31 Aug 2018 10:34:47 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0B222207B1;
        Fri, 31 Aug 2018 10:34:37 +0200 (CEST)
Date:   Fri, 31 Aug 2018 10:34:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 08/30] iio: adc: remove hwmon structure
Message-ID: <20180831083436.prcidrdli7gdtb45@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-9-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hrgudpzhyfwmlswe"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-9-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hrgudpzhyfwmlswe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:44:56PM +0200, Philipp Rossak wrote:
> We remove the hwmon structure that was requiered for the mfd driver.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

Same thing here, you should merge that in the commit that removes the
probe_mfd call.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hrgudpzhyfwmlswe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI/ZsACgkQ0rTAlCFN
r3S6fA//WRoHHbAOcFw/N4sr4iBf4kynFp2QolCL56V3J03Q+OLkTw0ZPBhkbJDq
7Hk6BtuykSHc+YGcYKO38TuqGYarWj4EuhN1H8sae0LdeUsg7OG8nsKfhy5LCzTA
kDm66DCq0WhZNM9SEd3/FRXmskVjzvZ9M62GNJyYKkOVsggeh8SCps7K34abvnTp
SEnU73uDS0x/nIlqh/JM8RfLftvBHTax2Fo88XPlRzSIk963tMfI8lnIrZZDl4Tw
mQKY8dNHJ6WFVytQ+7FgbUQy3hhkixMMLa/mv8mZpNK86bnJZkF6H2QtcvPx8dhj
Im1obmLnvrWcP0rDYjdTsj1e6JAVQxbj8TEUrZpcxdDF+y1IFdU5rhlv9ZxPwevi
EQrIzZZMilRDrwf3H7OI5jGaJpm2lOZUXjV6+qPn1Ksu5F7ZaNActbfxqB5HM+aN
UL8+0baBPZJT1C/6eezfaBedtpGwNouiiC4KcG23a7TT2/4MbDBSFs09Xjdd6EYB
+V3AadheHMbo8bLRBvxMfsnXp7zAqjA8XAKuFTkMEqTNTJA9pKEcA3c0uZflnMsr
OpOYC2W8IP6ZC4RdRbtiIvLHpYT4qpTbh5W0pZKRiNIkI+gr7Se5EuaZGCs3UoC+
L8MeeV/FLUrh1KgWXVE4wUgn7dsB/KAUYfsEpPmRj/vQa9xD5yA=
=ty7p
-----END PGP SIGNATURE-----

--hrgudpzhyfwmlswe--
