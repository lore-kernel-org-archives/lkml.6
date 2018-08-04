Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A024BC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB39217D1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB39217D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeHDX26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:28:58 -0400
Received: from sauhun.de ([88.99.104.3]:59116 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbeHDX26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:28:58 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id 99466684EB1;
        Sat,  4 Aug 2018 23:26:56 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:26:56 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] i2c: designware-master: use core to detect 'no
 zero length' quirk
Message-ID: <20180804212656.vrxwte7rxf4d2gdp@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rgvhazlkifihs3nj"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-3-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rgvhazlkifihs3nj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:06PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--rgvhazlkifihs3nj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmGiAACgkQFA3kzBSg
KbZqAA/+Padvqy7WQk3KaFaK7Q1G4J+N1wyxhjAZP0Zo54sfg8F8dmMx10uv0vo5
Jbr+7wa93x7SuxmZwRAewPl0KayRq5RYbvUjuIfs/YkqVkkQtNbsteneewSGCfzf
qTGMqis4OFQGwla07LBx9/tieNjrRtrweSGBdKcctVFn0qYAFqfUihTr8bfWZALM
q+DaS07Z0MuSundK3cXl2d3NFI+eMjdMuRIzV+CboC+Iv7bh0lpbfiWwq1aUsSpR
KqNiA00vEWSQG6hhaCQoo9ufzKYpv0uDY5jElpWwbfzD1SX2Uv8NKGCXnxaMAFsE
ZFdnjTUhA/H6pXX6cdHELCLmb7E6HsUKtj1wzD6s7+BiWuhD803/kE+6717ddAy8
GKcny26gHMbddWt+ySo4CxzzMfrXl3AHLUcsgLyQj2fcCvUd/KnBCscGUosNznHt
ohC1gTLqdG1EptRB8mnpB82Ls8z8eyAiUX3JPN97wbj0EAFBj01SBftYQEFOQEI1
w6ng0MEX+yDeL6AC8KlqrrjnIaPBtp5XaH2G546xJAzOKhXnaKlx90VpH2NRUGmr
gPXe/ywKvLrOEwDzKdrbdhE+Wyr+SJyOU/h7CzOtSez4EbKyM4uxEATgsREdsv6V
4Ze57I2TYfKIL2UX7dWoTXXswwrt/Dl8B5VLd9v8FxONSAFmpZI=
=Qh4M
-----END PGP SIGNATURE-----

--rgvhazlkifihs3nj--
