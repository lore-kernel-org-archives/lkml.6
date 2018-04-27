Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932604AbeD0Jnd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:43:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51333 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeD0Jn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:43:29 -0400
X-Google-Smtp-Source: AB8JxZoLok/nTNLuQtmVl59HJ1tCTVsWny+dffySK2TlqP+x5GIFfixbDNsXMeVeBhPvWRjXPWAyJg==
Date: Fri, 27 Apr 2018 11:43:26 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] iommu/tegra: gart: Fix gart_iommu_unmap()
Message-ID: <20180427094326.GL30388@ulmo>
References: <cover.1523304324.git.digetx@gmail.com>
 <dd25a9ff7bad7c92b345c0c0ce2bf235c4c3b6e8.1523304324.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline
In-Reply-To: <dd25a9ff7bad7c92b345c0c0ce2bf235c4c3b6e8.1523304324.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 11:07:20PM +0300, Dmitry Osipenko wrote:
> It must return the number of unmapped bytes on success, returning 0 means
> that unmapping failed and in result only one page is unmapped.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri8L0ACgkQ3SOs138+
s6F/EQ//XwtuK53IT2hLJ632ZguS9Dbp77vbd7S36ww8dcafYkeJ+PsaKpetk9BU
whOnWe/elWUTkOtL6wHMerSHa1RoMpNR46cHkjqppPaNaWn5kJfdYIgvZj+GVBjG
7n5tYsZLsbjWlsXZoQu0cb0gcwybZzhrzXAu+tLYzI0p9WJO/dxz/VH1mEMxA6Bj
ykDHT5bSTzukiOlLbMYy+cwajd1lr6fe9UAJMQ8rAb6Zej/MTFpRuS18DeeGRkva
+CLvhX9DGi1Bc+Jt101EJ/SO9Edsg/poZ0ZpT+rYTLQgExJw6vEd4XZWyhiBR2QK
EzglVE+3mZ13mz7QmdWy2xJSn77lGrsA3pbMwv6rNTQ/VsXD0Tf0ljdc8xvL9B2H
UCRfXPICCw/8o8SNrLpZapq+Z12o/3a7a0yAHZFVNEyMB6I0Y6Rs8L+zUf8aY3dm
e1ruuoU23ryISE9de7LwpNAZIyb6y3tie+3XqlhAe8M4PFVDR6uWtXryo60d/6aS
ngEnv2oTqqmA3uE+yJHpHSNIrhNGnpkX02srWeHCIXZBW5HzwnzhlxPbK1jboyQB
qr1a+6rWqJfuSZXK3wT4uCP0YFdDW6Y2tolxxWDdnNKNKJpikgsLWJbg/9h7AquI
ACSNJ/dYE2OpdRGmcK2ymiwRQ/Ge4B94iIRGxB7k8LrgI8AbrAE=
=MkpY
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--
