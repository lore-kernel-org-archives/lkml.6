Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CDFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB87B21A53
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB87B21A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbeHHWbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:31:37 -0400
Received: from sauhun.de ([88.99.104.3]:37918 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbeHHWbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:31:36 -0400
Received: from localhost (p54B334CC.dip0.t-ipconnect.de [84.179.52.204])
        by pokefinder.org (Postfix) with ESMTPSA id D6EF16DC22C;
        Wed,  8 Aug 2018 22:10:19 +0200 (CEST)
Date:   Wed, 8 Aug 2018 22:10:19 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c-amd8111: Mark expected switch fall-through
Message-ID: <20180808201019.v6wbbixglpqvzsou@ninjato>
References: <20180703190751.GA29770@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fn3nrerbdujaohn2"
Content-Disposition: inline
In-Reply-To: <20180703190751.GA29770@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fn3nrerbdujaohn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 02:07:51PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to for-next, thanks!


--fn3nrerbdujaohn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrTicACgkQFA3kzBSg
KbacCw//Vgx6WVx2Tt0R+jFSW2lba92Z1cptBvAItIaDKLevwAMfyOpgV+a7vaqh
YkTNKGCbUjy14bCiJkXVng93NiUU6IV6OvWBlx9omrhqVynTZFTOtl3Gc97mCXK6
U8zab/fSEXj6KDoVr+LppMKbZNtCrEqDzy5jxdZapTt/iqECNWL+9HhIiDapaWat
mvHOdtudhFCthW/hYf/MKBsaE1fCjIwnoqk4rEqmPBuu/EaEv4MJpOMfgbdKq2Pd
pDNUTb1t+j5Oa26dX6H88DQ4fsE5/D7qgKDmY2gmOIbkT1rLFISXHuhEAtMaWCFc
bGqbbFmDmd55Org//sdoKFqheoXxUqlV/inqVKvtIH+pY8fuYkIp3JLmbVQWTGdL
TOhhY7AuKCgZc018u79/lgoUqwWdFG+uJwQ4F9wPx+bWMiPslOo2tSIQJraNmH9g
8xZDYLpOeD0Se8OGctg5JuPxIMUuZR7eofhCvmFhwZajYztALXJBVzqpK/S+b5AS
ejL4GqQJeH7bXxFR1uHF4J/P6+XJmbxx8phGHMiVp9BWrfeWXRcCm9qeuD3BPI4K
hnhKgQOvg3763aZZ3kMGLJQzjUEXhjE0RnZJOPkl12AEtzzdgYX1t9WI6ttjm5XL
pQkO6LJvsamI8W8NPenfSlcnnGv2uA2fxsme55vP1oJbJVFszJs=
=fy5D
-----END PGP SIGNATURE-----

--fn3nrerbdujaohn2--
