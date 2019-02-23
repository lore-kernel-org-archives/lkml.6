Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E617C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECE620684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfBWJ3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:29:10 -0500
Received: from sauhun.de ([88.99.104.3]:53524 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBWJ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:29:10 -0500
Received: from localhost (p57BC9845.dip0.t-ipconnect.de [87.188.152.69])
        by pokefinder.org (Postfix) with ESMTPSA id 663462C3312;
        Sat, 23 Feb 2019 10:29:07 +0100 (CET)
Date:   Sat, 23 Feb 2019 10:29:06 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V5 1/2] i2c: tegra: remove master fifo support on tegra186
Message-ID: <20190223092906.GA1018@kunai>
References: <1550597332-21018-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <1550597332-21018-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 09:28:51AM -0800, Sowjanya Komatineni wrote:
> Tegra186 does not have master FIFO  control register and instead
> uses FIFO control register like prior Tegra chipset.
>=20
> This patch fixes this and prevents crashing during boot when
> accessing FIFO control registers.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied to for-next, thanks!


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxxEl4ACgkQFA3kzBSg
Kbb67A//TtevoTcMomvXfKynfNuH+woFBsFGBYhH6Ln8zZecJnJMVi9T+gi2Bzuh
8x23z7IWPiVyEhnByVPxOwXx97IlEMVPMNut2Y0+BTbLNDfBzY+Ii4qUoFGrHaIV
8e6MUAi2gkmJRWTxTZvZwgCkgSczUBbQB7n5WHmKK9Gihc0AvGr+XTLCBzDZRVik
VgnbKJqeRjWfnkOZ3KXhXtTVyitSAxL/Z91xbBrMqPiU4z5NTLRGWckD2RwSbBfm
sEe5jEmqJZgyz3rPLUBZYTzemMXhXmYRNlx7Nbw8fuVEiq6bT852CKTzoMeYASqR
TwHpDOi5PMtV9ZTrWpgd1Kli1HzsJ2RCUYgOnzzoGTUWRo8tpc0VdehdNmQHutPf
lU6AxV4V4Jaul0wxnRtxhxUk0YyDTykikmsJq37wa0DFMHo6u40eU4JVRndQyMgg
nbyhIgJjukvi+OX6nOT0QXAzewkCCrBqptNrKPnFiFyw9TxRhaBBDkopf/F/osjR
zYCaeV8HTyebZ2UD30pSdoieHJGs8FZiDgun3stx/HymzuqjaYghIC28sM5hhjY3
r0nDbTdlDne0qI6ufGHqBvw9wX69X6SNCIoEDnsSpSsVLq/HchMaUdzvIihe+2AT
hA2PFUsoE+mI2dxn9zIUImILBQsrYGsw35NMah63tYfh4rkoYHA=
=JAvd
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
