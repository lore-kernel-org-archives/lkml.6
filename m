Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeD3IJb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:09:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54556 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbeD3IJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:09:28 -0400
X-Google-Smtp-Source: AB8JxZotEqfZct4pdmJfw0usfujS1LBfADgLKsFb97io9IEAypdvSmuSfBSGgBAPECAOMj+UiNqcig==
Date: Mon, 30 Apr 2018 10:09:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/15] memory: tegra: Add Tegra20 memory controller
 hot resets
Message-ID: <20180430080925.GG2484@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <960c7443136f862e366df1d09d0513ec337eb30a.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <960c7443136f862e366df1d09d0513ec337eb30a.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 02:33:54PM +0300, Dmitry Osipenko wrote:
> Define the table of memory controller hot resets for Tegra20 and add
> specific to Tegra20 hot reset operations.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20.c | 118 +++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)

Applied, thanks.

Thierry

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrmzzQACgkQ3SOs138+
s6HlsA//cWv5/NCz5MIl6G5Hs2Rf3xHh7rJesFCkcnfVhp9CirNsHam7uOyKEuDw
0Mt+EW0RHsrAuJGkQelEEHY1NxF45LV0vsgIh1kcQnP6H7j30sHYH5cB6fQ3dYPZ
qvFvhHHsBEaCUIqSD+jzYH1HiW6/+OhtAzdWuYsn1V6peYkez0N4skGCYVvmmMf/
jDuAiVOHYS/N0Y8U4susrqCzgNyJcvKi0Brobg5W/BH87wrOR0Uprqk2owtJDZ0r
YXM06O6zQXjLo9KOx95PUcl0MSgD3+l2Sl046hwinHMJSdkxKjHq6EDL59/GxPPY
WjGQ4QMbsxL8LIMKGjqfbI7yufFFXrGeLFVM17zflR4m8p+bW6ru95xuooRbQS9w
lkMkokcQo/OS8T4Fc5q+9FQseKzHTh7iMsbNLsv8um9ulVnObnRGe77+O7ywmGUr
ofDO7la4bYUvQHDNk8duxnTuucGFKATmNTm0huna48GpR3zWDZrP29VeOZRn1+GB
h5z2hCnsYbpygrBr08KcB7n9jA53RQKA6AqyMCmPRms1prNfQ8pn6z2gMZTT3oMM
M49W4pXwbwgDSBtWJoIc2GTz7Ui8CYrNfJCPmoE+HuvZDrv7yurkX+OyIGwdygfU
n1ZrqT1YwQlOuEavipoZMW97O2/ylACpRY/vZIrCJdORgZ2MWsk=
=uMsO
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
