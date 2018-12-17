Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADA8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92882133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbeLQWWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:22:51 -0500
Received: from sauhun.de ([88.99.104.3]:41552 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbeLQWWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:22:51 -0500
Received: from localhost (p54B3357B.dip0.t-ipconnect.de [84.179.53.123])
        by pokefinder.org (Postfix) with ESMTPSA id 85C662E4004;
        Mon, 17 Dec 2018 23:22:49 +0100 (CET)
Date:   Mon, 17 Dec 2018 23:22:49 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
Message-ID: <20181217222248.odzccpo2urkk6wnb@ninjato>
References: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="llngqmbapkg2emg6"
Content-Disposition: inline
In-Reply-To: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--llngqmbapkg2emg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 08:22:34PM +0000, Fabrizio Castro wrote:
> Similarly to R-Car E3, RZ/G2E doesn't come with automatic
> transmission registers, as such it is not considered compatible
> with the existing fallback bindings.
>=20
> Add SoC specific binding compatibility to allow for later
> support for automatic transmission.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Applied to for-next, thanks!


--llngqmbapkg2emg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwYIbgACgkQFA3kzBSg
Kbbu2RAAr24frCyoUFovlqSEY8uzc6kXNhKbAqAwDmPbT06Jy7zQ2+o46VqmcQxV
fvUqH09qO/9tF17qRje825rCG/Ss2Qa7Yl6nh8TNFZbSZlGD6JjM54ircLROfXIX
fRcejTZ4uNorbYMkLYGvAmPHm/yottIoEEeJnvvW/p3whHGc7t0GMu7ZMycmWoGl
We2DG1FGbO/hLNPSYJLyKL6DAmtldem5X9cV2pfD9iD/DrGOHhYUpYk2CogEshkD
VTy1XsZ2jaS91QPx82yfrVRNzZpBE4u7n9YLEDy6PvKGFg45qs30HVU1ungMuT9z
lSAhJF0uSZhQGARRHxDSR1ZHrejAWGzclCeeCtA6F1bV6lQgMAv2xu36kiJP+Lb3
+342VSzEIZW2lDSL4X/Beqfdmmy3jcShwh+ppTHa5VAxG4s3yULh93n34p/BDH1T
r4Wu+ED/ujm51PstV6p53QSEpO0zFDOu8ZEOhDQt6bo/89QLQMGJByGVqFCje7s1
aY+l40Gxr7QYna1T8UXMmaEcxmWE9TVkPRuWJeIVqPmfjAQB9qLheeP67SmE4agq
ZFmHck2P2EeOHsfzLiDW3RHE2yREprKP6XCeCIxbL/ijCN2BcX3HS/qi80JK6YCo
ahbBjj8Bj9mQJAc/GNB8CRnkDwfZiGzobzOqyC0o8zRK3/RzZuo=
=64Ct
-----END PGP SIGNATURE-----

--llngqmbapkg2emg6--
