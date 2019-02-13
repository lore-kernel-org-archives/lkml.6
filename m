Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B326C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103C2222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403977AbfBMO4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:56:02 -0500
Received: from sauhun.de ([88.99.104.3]:44976 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbfBMO4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:56:02 -0500
Received: from localhost (p54B33842.dip0.t-ipconnect.de [84.179.56.66])
        by pokefinder.org (Postfix) with ESMTPSA id 7D9F42C0590;
        Wed, 13 Feb 2019 15:56:00 +0100 (CET)
Date:   Wed, 13 Feb 2019 15:55:57 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mkarthik@nvidia.com" <mkarthik@nvidia.com>,
        "smohammed@nvidia.com" <smohammed@nvidia.com>,
        "talho@nvidia.com" <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Message-ID: <20190213145557.vdxahpsacgy4oznl@katana>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
 <de27b8f8-ba8e-fca7-6bdc-cdd580d959e6@axentia.se>
 <cdb66da2-4886-e3ba-e78e-264bd4b5b73c@gmail.com>
 <20190213083519.tynjs3ef6tnvvsms@ninjato>
 <b299217a-454d-6d3a-9c48-3500a95040a7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wmwzoiusobn632pd"
Content-Disposition: inline
In-Reply-To: <b299217a-454d-6d3a-9c48-3500a95040a7@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wmwzoiusobn632pd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Fixing up minor itches while applying patches is the right approach,
> thank you!

It often is. But making a dogma out of it goes nowhere for me.


--wmwzoiusobn632pd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxkL+4ACgkQFA3kzBSg
KbZeaQ/+MXAkJqRV3K8TX6w1Zizs/0btq3fGzYCibmPLTqVKCanOOdoODQdVE/sK
sXvvHcz8W6ei7iBgkhHHjJyaTBgQpbi4WT17n1JqhiKnpeQB+7hrrKlRyjMRtOd0
PnyWw0WxI8hcSgF4Q4mAj3nLAggEmq6aeuc0z0ULquiioFKz3C9YG8y3qQk1hsPi
BxUsS1/HsG81GHc/HHIrll6EimXSbv2vA0xzvJTZWKTJr60D7oJaYgagctUVBOlu
3RLVL6zpUyqKDpiPyELur4RhcSWmYUjy8KkOs/Pw9rA+E/0MeROXvEbgNIBZB8Mc
IHf805YTmMLlXGLahbPLamQKardcJrhJmNRLvAcY+XNEh2E4NbhKloPdteqQdQGu
3PTm/t57DcZft+W6O+H+TjqYM/sk2cWvLaXFsPaKtNdwdcYXWM+Uwtje2dGM5teQ
twMNTVUEXE7Uw8t+nFG65TcKDBNIG63xgqxQjiTUWD3lqFUhIQRd/Qizg2pr/Ool
JWJKAHStdJdAYgU/esu/Q26zYNaDjOm92W1bVr6G8lqJ5f2rxNiHHwof5AgnL2Hr
y1HAJcjRPdI96mkjfGWDzZ7/mAzeXLc82sx1R0hT7lYjPpnwdJGbt/H9F21MmgGi
p/f8yGJ8psEH3KlSsJa6CnHyOO/jFgnNctM2Z8htA6fDDVsFfLI=
=yX6I
-----END PGP SIGNATURE-----

--wmwzoiusobn632pd--
