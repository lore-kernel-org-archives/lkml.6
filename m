Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBB4C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4575B217D1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4575B217D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeHDX3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:29:35 -0400
Received: from sauhun.de ([88.99.104.3]:59140 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbeHDX3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:29:35 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id 50097684EB6;
        Sat,  4 Aug 2018 23:27:33 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:27:33 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] i2c: xlr: use core to detect 'no zero length' quirk
Message-ID: <20180804212732.mpnplmon5x4vrwul@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-12-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tl2hkdq2cknu3aqc"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-12-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tl2hkdq2cknu3aqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:15PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--tl2hkdq2cknu3aqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmGkQACgkQFA3kzBSg
KbZ7yg/9FwRRAAvhqlUjIccoPxACKuZrAmn+BehdJPlgzLKdj0Z5V58QsS2ZUGlt
tqOpjnOx+hNWl+nmj5tG7ZSg42yBp2bP4z505BIzwaLNCAUd4isfHifikIfDjb32
nxWjaXxSq9J+5Exn7yOd7gT6j7qOevQzoqasSdfacp+Sqy9wxIIcFd45u4IVX2jN
GJo4it60+Cnp5OjqtkJzDiXr32ZLCCMJnIaZblLLC7zZoqm4iYN/pgpOowtWII78
3Vs3IKyNb5m+XJaSTMXJ/o7Lsz7/M9in0cH6LGQTULZT2UVDQtszL09Rd96qzJHK
9D8yWIvogcVPH0vg8mFF7Fbnn4wnQzAr06WMakkzjfp+rwCOn12QaWdE7K2W+i4I
sjAAfcNXB1ke9j4pSVIT61Sq2GdnPkgXamHPy9QMO7YECqio+gTGqaWDpA9RBXuj
C97ovUPyR0USRogX+pZqbTy1dBgAppl7Fv9BTBCa0EsIk0WLfJ1shP5z2R8oq4hs
98hamO8YGrfY4Kr/jX+DDsHr8CO56fMsmCj19nBHN/BUrEhv0rx8+y7DHGcKcfYq
+xCxiZCPOcATEvDY7GDXJ6KWLddTjxrvICS82GhlTYl8fcoztrV7AEO/RJNzh2ML
37XbDH7jAMZLyRcHYrM1dtmhvKvfi9gEKH0sbhtPPhLXsfosUJE=
=cYN7
-----END PGP SIGNATURE-----

--tl2hkdq2cknu3aqc--
