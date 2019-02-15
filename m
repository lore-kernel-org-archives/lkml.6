Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F2B222DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392484AbfBOVnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:43:03 -0500
Received: from sauhun.de ([88.99.104.3]:36650 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfBOVnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:43:03 -0500
Received: from localhost (unknown [195.52.228.164])
        by pokefinder.org (Postfix) with ESMTPSA id AD58C2E3551;
        Fri, 15 Feb 2019 22:43:00 +0100 (CET)
Date:   Fri, 15 Feb 2019 22:42:59 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] i2c: tegra: change phrasing, "fallbacking" to
 "falling back"
Message-ID: <20190215214259.lijzlwaelm3najwr@ninjato>
References: <20190215153126.18575-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cydg23admer3cmh5"
Content-Disposition: inline
In-Reply-To: <20190215153126.18575-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cydg23admer3cmh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 03:31:26PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The phrasing in two dev_err messages is using fallbacking which
> os less understandable than "falling back", so fix this up.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-next, thanks!


--cydg23admer3cmh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxnMl4ACgkQFA3kzBSg
KbbuyQ/+MbAm4ZxfTLByL3Bler1Blvc9fJOX5r3PFhmKT4oKXhC9i21188LEW7VY
hXcoZT9xpQtBjzUpo+1M5SyHXBF60gY9CFbrogQ18qbyJxW5KfxIoJbwPHLRZ0kQ
aawr+Qo3pBm8X/+NwMuSTlNxcUHN4jhNZ1Od1mwvmqln5O1WTVCXzNQYCrE3ifyi
kLCL4/Y0FHjTZrYksUFMYUA3uYhoaKb8xBNW4qxrETclEJSEvne5MN+K4WIbO/90
+DDz+83dX1Xnn7Eyy5j1WQ+eRgswoKl8K9iOlCcXVlgejXgOCYthbdLGdQRqZdq8
89BuXvZygaPNvaAoIhZ5xZmQc5z20g7pUOS3MghwSCwUELK2AweHd7CwSvaxz4YD
ptm9vdwlvbHBnMT3TXjwLFdgtF/uLhpmcuXLv6VHx4e4LM7OMXvvRu+uOUOvpgX9
g5pYhZRLT7+Xr6piQDZ1AYDGYrzH0WBM6VDz7uHq38I8JTWDNmrIhgA/QP3eqtqW
J5wGxFdyz8yX+dTHCOtANTxjYNKgAMe1zCHYtvBSz6/eI6srZ0r/kN94sV9mlYwK
AkoFzQoMgOFTJGGBkoHsmD+9uYoySbUpIukt+CmUCJo7/9aE8qGq656jz6tlZst+
+xao2NUDWhENDjEFWQdkxlShUDnd0UT1miMH43vCl6bp772RjtE=
=3c33
-----END PGP SIGNATURE-----

--cydg23admer3cmh5--
