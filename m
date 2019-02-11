Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1565FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD7321B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfBKQy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:54:57 -0500
Received: from sauhun.de ([88.99.104.3]:56566 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfBKQy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:54:56 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id E995D2E3542;
        Mon, 11 Feb 2019 17:54:54 +0100 (CET)
Date:   Mon, 11 Feb 2019 17:54:54 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>, Peter Rosin <peda@axentia.se>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] i2c: ocores: add SPDX tag
Message-ID: <20190211165454.4l5r2alhlxzvglxk@ninjato>
References: <20190211164913.5988-1-federico.vaga@cern.ch>
 <20190211164913.5988-5-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zmizvlegvhdlqnqf"
Content-Disposition: inline
In-Reply-To: <20190211164913.5988-5-federico.vaga@cern.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zmizvlegvhdlqnqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 05:49:12PM +0100, Federico Vaga wrote:
> It adds the SPDX tag and it removes the old text about the GPLv2.
>=20
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

I can convert the platform_data header to SPDX again. No need to resend
because of that.


--zmizvlegvhdlqnqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhqNoACgkQFA3kzBSg
KbbzRhAAlKQ23iLOTcTLq8pYfKvPFJGmjJLGEXqWNBXhGL0yH4omqvYMUNeR0O1q
HvvDqexRFbyxgTeeop8FMuVCGxLjcEeMPorNmsTX7GpTOnRupMPUQzm073lbhAra
Dk0GAAE7RlxAkWn8D4YmfWwH0OCziZLtdnUdf/T5LpIlfgyIjnaXd4VCMKmyIzkO
GTU8cMhVf1WXhq5MOpsBzJ+h0e6Lw9Ndrsj5tN+hsVOJ6WemXo309Dx7gC+WG/1j
1D0BKVCSv+nRfqcM6waLImg04Fdw3BDB6ltfoRu6h7Yq/QbM/6ptTi/i5q68TmjZ
A/3jQQmK8vSaoTAkXaRG1TT52M6uO4Vu/w7dyK5QlDi93xx7p2kG9iAsoCjGOvGo
16k3Q+H0Uzw8NtwHn3fdIA4Nh4Bjm+Ze8k7UwgY5IZXkvqo1gKm1BDFcBPfw38Dw
bvo70Q/QAcaF2V7+ZrqJeUT7KYMOjxAmyjMvD3woPPr5jqdaDYdChJLgz7dBti6e
ZldgrgrvtiglIX4bCOFBlXGn2HjbzEK97aZ+eEm7hTKevT2YxCz5iQmInitd7uIH
LIC+4PMchnkgJRBwcKfEU0+7diT/+E6kQXKSaffAJwjYALjbk8Ud2wbD5As1+S4T
qnnMRm4rF5Qu097nhUJalNszeiRzB6CUv9/hqfDcJHwahhYtJfg=
=siKX
-----END PGP SIGNATURE-----

--zmizvlegvhdlqnqf--
