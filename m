Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D53CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2C217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA2C217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeHDX3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:29:03 -0400
Received: from sauhun.de ([88.99.104.3]:59122 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbeHDX3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:29:03 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id A06D9684EB3;
        Sat,  4 Aug 2018 23:27:01 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:27:01 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] i2c: mxs: use core to detect 'no zero length' quirk
Message-ID: <20180804212701.s6vkv34uvh4hiafe@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gfkaj2rulnxvlgdl"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-4-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gfkaj2rulnxvlgdl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:07PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--gfkaj2rulnxvlgdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmGiUACgkQFA3kzBSg
KbbSWxAApcOczAWVeR6G9ssh1Fe7ixfVOW/gCgC+MI9+px04XAeYmGP0PTcvFtII
pO2jVcZiRNPNM06D1SG2UJjx55QfzYDvPGjFkZ42/AOVWEd//mP4kwRCFqyJ9jXf
4uUKJdhOFEne5nVBm8P7OZX75ZFfM/rb0UPGrLuTzIrN35BMUHkBzRUmTQPlU/yi
vpiRPGJtyzOG/YhT246dZ7i47JLdg2RJaNrhn3nqBd4LiCr9EYdIRDDtSFFjh+V9
POmcjID6yZgoHCZmUgCFaSXRzEtcrri3QT5rvmHzEpAxvQriupqlz21LvTSq5bCI
eCASls5hlRDfHAcveS+0wjWWx0RdC/IEpFCB5MThF3Q50F3QuogJOyLuvmgZkQHW
c+Y9ElsniSqpqH1LvfDs2K5/M4MOl9oPlybDyjoBYe2vbvqiO9rJiCmm9pnEz2d3
oNTZQ4y9dSzRwQU2CE708xdq/+1mmBPSemgmqb7FFTIbeSQJufZAAJwD7yOluwAP
bT33iV7GMZZ+zmF5r28f+yRTd1cRaRYEhxgOF8CgWpiDWY0m3A6Ba6azA2DcGasI
7Xk+bcFnkhvyEBwoV6sBR7R3rJyvxUtvvxFrKekOVr/iXRHaqxHsKqPOPAiMSwut
oh6N84XwL91IMTpsT5l/1TuTsJUUBIHxIvpdWEFgyNkHBeZ3z3E=
=DXqL
-----END PGP SIGNATURE-----

--gfkaj2rulnxvlgdl--
