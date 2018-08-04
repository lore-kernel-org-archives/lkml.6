Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536C1C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153AA217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153AA217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeHDX2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:28:54 -0400
Received: from sauhun.de ([88.99.104.3]:59110 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbeHDX2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:28:54 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id C312A684EB1;
        Sat,  4 Aug 2018 23:26:52 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:26:52 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] i2c: quirks: add zero length checks
Message-ID: <20180804212652.xe6q2brc74pijvi6@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ss5syh2dz7ow7lq7"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-2-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ss5syh2dz7ow7lq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:05PM +0200, Wolfram Sang wrote:
> Some adapters do not support a message length of 0. Add this as a quirk
> so drivers don't have to open code it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--ss5syh2dz7ow7lq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmGhwACgkQFA3kzBSg
KbYCuBAAqO909trDreplqkNEXwXpF+CJDdy0zwZ3jjlIrlCnnZ7xr5aYlOdS9uA2
gyB7pL+rlbNHoQePk9suNfIkSAGiM0hm71ZoyoPVVU/o8jHRlT26UPVPXoB49LaK
kOhgK5GdhaHWULjTczhwZzs97rrQnXXpfS/f4wl6RuwKUVX235zfPhgn/avJcC2M
Y/GrPicQBenoRrmuZPPqmvlDL/T0LN0HhSF/ZvBYOQZnCMiY1DdmLiy9gwiiWBiy
MgiHGiHDHbJ2GfvLfVrELXnId4gIQaPmCQ6ZZZep85xqS5rPxmvNtzzKZMb1NTK2
lX6tBfG5ji9sx2u435Ha6CJh0KKVNLt6d5KAkRiEtQepCKb8WGw8skgx4jwOIhIs
kYLRhRdba63NxM7ke2pi+TtBzq4pw7hmjJWbJO3402f67ulP4qttykTYEY/joB/E
+8IroXAHek2A3c7mcPKGNTv3uYu1Rt9pRUN5i99fDGEGQ2r8/ixZKdSA+7sJicXJ
A2dd5vV+KcNtp9HiKzdGBa8PTU8etUu5hWKeOdstu2RT9PTrmNKm1yz5oKp8dxna
DVe4x+b2fHDr+cxD0xvxLzvtFOQ6D/8halYL+0mCt4r5LRWJD8mMks8WlwPBiq0V
qL25AHd8XNPh2uEcDbGIghh7D5qBRaHTdnI6bJN9qdttz686MMw=
=KS6K
-----END PGP SIGNATURE-----

--ss5syh2dz7ow7lq7--
