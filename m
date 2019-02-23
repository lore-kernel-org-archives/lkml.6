Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5530EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E4320684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfBWJ3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:29:14 -0500
Received: from sauhun.de ([88.99.104.3]:53536 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBWJ3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:29:13 -0500
Received: from localhost (p57BC9845.dip0.t-ipconnect.de [87.188.152.69])
        by pokefinder.org (Postfix) with ESMTPSA id 43BBF3E6026;
        Sat, 23 Feb 2019 10:29:11 +0100 (CET)
Date:   Sat, 23 Feb 2019 10:29:10 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V5 2/2] i2c: tegra: remove multi-master support
Message-ID: <20190223092910.GB1018@kunai>
References: <1550597332-21018-1-git-send-email-skomatineni@nvidia.com>
 <1550597332-21018-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <1550597332-21018-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 09:28:52AM -0800, Sowjanya Komatineni wrote:
> Multi-master support is defeatured on Tegra210 and Tegra186 due to
> known bugs.
>=20
> This patch removes multi-master support for Tegra210 and Tegra186
> I2C HW feature.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied to for-next, thanks!


--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxxEmYACgkQFA3kzBSg
KbaIOhAAmsLQKzbadkaYmPRFyB+FZOq0KXzWJX2alnw3oiHivJ1MYMyJZo7Fhk0z
EVZ4Oyg34vimF2xYiawyA+iReCU9+7FaBHP9sJwXhgW9Om8cTqOLNfkNCcYs1+Zg
R2zXphMkIEFZHTCJWvm+F60xzICoXbrh9zNrOGMWnTkceso2/PhIJbn6SWnpLtxG
mwYpGIAkQBAPLG76XJWw1ilcRQb9a6FzqZg8+39TGuHoV/g0aXokOrdaQrOT985/
ln/w+Ms/db0Vyibxm2Kzkbw7d1JDcU+L+Oa3K+XJzRjKc58GMTMQm0PIcxJce0f6
/CP38qWx9pYWo3UPCiosjiP93F+wZS+niTeEOT5TZfVVBrFPa6zUqJLhjZTOtIr3
kpXiB+TVuiPWcNkirQB6+IszyU8PEji9PcdUwdodPTo52jeFI2hIxhOcivK/2WP/
8tdwZB6w+OcfTTpKt+evbQvbPXYZW8RG72xRO/WFYJ0ZgM6+3uVlWEfiy1olOLgL
9g0mukmFxm3uwE22gOCUH4qEO0c5FwLh4B8WnSJMYAcYovFGnHLzZYPvaut8asFx
ZJyqsPJdt2JT95bf86BtRkimvwtNT8Ra78wQT6vywAlK6LX9yxclJYszT4mVu96P
MzTLiKt4uMJ9LCBVdLuohhiezgBH2mgMEujc4dANbC0RIjw4Gpw=
=JSWo
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
