Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB214C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8034F21848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfAJXQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:16:16 -0500
Received: from sauhun.de ([88.99.104.3]:52758 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728787AbfAJXQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:16:16 -0500
Received: from localhost (p54B33797.dip0.t-ipconnect.de [84.179.55.151])
        by pokefinder.org (Postfix) with ESMTPSA id 4D87E3E48C4;
        Fri, 11 Jan 2019 00:16:14 +0100 (CET)
Date:   Fri, 11 Jan 2019 00:16:13 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V5] i2c: tegra: Fix Maximum transfer size
Message-ID: <20190110231613.GB3628@kunai>
References: <1546984750-26199-1-git-send-email-skomatineni@nvidia.com>
 <1546984750-26199-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <1546984750-26199-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 01:59:10PM -0800, Sowjanya Komatineni wrote:
> Tegra194 supports maximum 64K Bytes transfer per packet.
> Tegra186 and prior supports maximum 4K Bytes transfer per packet.
>=20
> This patch fixes this payload difference between Tegra194 and prior
> tegra chipsets using separate i2c_adapter_quirks.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied to for-current, thanks!


--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw30j0ACgkQFA3kzBSg
KbZUVg/9G5lAXsj4CaV1xLaAGyJuzOCt5aJw2DjO984npBoR8hNWCaBIzB0VDlG6
efDxcc+blmRuH31HXdQpdLAc+cypVXdhTVWPtaDHYl+veuw5pDuzKtq0DYmX6cfP
vjqV01k11g8y4GwmgpqXJzgIcNgMh3cv8VP7ID1zQEIt3wHWSkohhfk+Q+dLz5Ux
M53fix0OLM3pktpijSZS7FT5whVsfuijTCGqa8lpi0Rd655z5+ef4kr/e/5c5iOY
e/9cNWPsngZPRGiLQhI9KfYthe+XYHXCr4rsYti0D3ptgMGAcyfa876ZnixAEo78
JN+VUgm4IARs3Fm5zVXHC7Zj87wLvNCUKuNwygbakGwIx77SkunOPr4ph6+vKrjB
abK7rgmG0udlHGbdMyF9Pq7DYc6xLZcUSo1hYBnIJWeopcNUaIKsPnN67NA4K+rn
sq7/x61z083hAr2c6By4m623/XnEylN6jCbd0z0XnGW84nRUvm8OjO1AFCF95mxW
u/+Vm923uUqRvAiBKFHYM/YItrvicO11MRaIyO5cc5OU4qYi3qDQjA8JHjvtfnbN
ycbQXrQ6GpK4nhVWYLTaJ/PMqvrgCovARz5I6MYpIKVXrXjtksmvtRfSeFlVPeqv
7v4y8A/MAUIJESx12g+FEMuyhTWXR7Ou/+CHxPp0hVJ6sATvZBk=
=fJ7V
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
