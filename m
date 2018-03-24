Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeCXW5d (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:57:33 -0400
Received: from sauhun.de ([88.99.104.3]:44740 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbeCXW5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:57:32 -0400
Date: Sat, 24 Mar 2018 23:57:30 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add different features for I2C
Message-ID: <20180324225730.drpjbvr7nl7yol5q@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jsauxyjddxejapp2"
Content-Disposition: inline
In-Reply-To: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jsauxyjddxejapp2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2018 at 05:48:54PM +0100, Pierre-Yves MORDRET wrote:
> Append new I2C STM32F7 feature set. This includes 10 bit support, slave
> support, SMBBus protocols support, DMA Support and eventually an I2C recovery
> mechanism.

So, I gave a few comments. For hardware details (especially DMA), some
additional review from Maxime or Alexandre would be great.


--jsauxyjddxejapp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq219oACgkQFA3kzBSg
KbYAig//Y7P2q2lmOYbFvDtXHezFlzJjlRR4oSuniUjRvIeX5mdDqe5kRpiLSiax
6azwUzVrXL+6pl2c+KSNaemHj74Z1v3lnInbH8HblyYeUFNlQwF6Oz1rrQV8hWKd
7vzAox/QQTUAATB7c72h0+zuzk5HZaXC3jtrwfzZ/0UNY+1i3BvfnfwnBuZmIDP+
yzKcq70ZNNmrU0ZlF88f1PenAsWBjurx7hMkpl6EwJnpJdoTIjLZCFelnCGNIIbb
4mq9Kxx9m9lwXfkbrBUbXZrrPGonMQ6rCpVqnuUacdYkjxM4o7AhQDVbvezFsFy1
FSNKj+JEpba/zG8YDuBye3KBjrUHsm2zy/ZQwfqkfEKzyeKbVlsm/YPpwyoilxy2
Ovbj4p4K72wfDHpxf0WWEgrLrm2YWo5CMXPd35ETw7XqsMqzOegefr/zjDzdqMBb
3hGQaZK6up+WQVrNbReF+S1T2lB4GCIYFwycXpoEKBabY1DvEOhxVlGosvyu6n2G
12x5qk0WLvsSQ0fSRYWgtpQakokB2Fbo4g/GWpKrX5IUyTwJwVOEKZ/79wOOIaRY
i5hQFrj6LLv0+mITjsASXdEcniMjFkGBkm53F4b7AKYnFNO8Ef0kk0IUPbifo2OF
RM+9F4vhIwfkceJ8cAazCflr/zbxPDFWc3UhsTOBLSgytWPu1n4=
=8wJL
-----END PGP SIGNATURE-----

--jsauxyjddxejapp2--
