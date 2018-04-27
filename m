Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932596AbeD0JgR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:36:17 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35647 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757251AbeD0JgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:36:14 -0400
X-Google-Smtp-Source: AB8JxZqZhuRBTEJnysSu3bO+hxEemsWbuSe6wyr+kO6Bgk8YO7vyoF+++NzsO+/IfH6MA6gIsvcK+g==
Date: Fri, 27 Apr 2018 11:36:11 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/15] dt-bindings: memory: tegra: Add hot resets
 definitions
Message-ID: <20180427093611.GF30388@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <cfec415d74fe708209905088bbe9944557f92415.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <cfec415d74fe708209905088bbe9944557f92415.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 10:28:26PM +0300, Dmitry Osipenko wrote:
> Add definitions for the Tegra20+ memory controller hot resets.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/memory/tegra114-mc.h | 19 +++++++++++++++++++
>  include/dt-bindings/memory/tegra124-mc.h | 25 +++++++++++++++++++++++++
>  include/dt-bindings/memory/tegra20-mc.h  | 21 +++++++++++++++++++++
>  include/dt-bindings/memory/tegra210-mc.h | 31 ++++++++++++++++++++++++++=
+++++
>  include/dt-bindings/memory/tegra30-mc.h  | 19 +++++++++++++++++++
>  5 files changed, 115 insertions(+)
>  create mode 100644 include/dt-bindings/memory/tegra20-mc.h

Applied, thanks.

Thierry

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri7wsACgkQ3SOs138+
s6GDxBAAsPES9+1Qt+53XDu+JU5D9dtRBx8HRl6Bu92GnHbYJmYWD3CwD18OyoJC
SkbUIc69kNRSI9XRyef+JZAOfEnTUw7nFH7+SJGBmdU5+SX5Bj848mh9E/IafXsd
GqOGoqd35gR0xCXsWK4NzOZo3cRSf7F2bZZ1hEkgQ7m9aHoYbLI5C7vhnoTGD+81
RWe29cLMRv41PT2gFYFuVnO6E5hFJreY9FDV+vUR9cksxrHuKxXjwzkcubBkbSBR
8ThTg5rbuafRXqQYhRQ/er5paBV+aMNJETENaKbH0QyNuPzZ8Dh7j5vz3cH/1ZYC
bsRiE84m2iAuQHRxX8Ds5mpz+mKQIJ68tOWrGg5ovscUVLvkyJJBI1NujfPt8iAk
5JyKuUiSJCnUqlNRFuLZPBTlIiTG5ITe7yOx9pzPJwrv7ytZUXK9M2CqfTzvNyE5
iveSBRahBg2PcDLPTtOSTcXTs3Uaot2XorgupM4arLPHKGZJ83tObQyBYTKHN4BY
iQHQSsy+RI03jsgHXYwUXzL13AhavKWzehgZP4r2SEzmClWiYrby86ao6JjT2qZy
pSpg2a8tdm3ygXKhswJAJy286l2V/jRV7JgF8wpxQMyBETYVJnWw4VC8+UDXxUA1
KioOerUukcgCMJLoPd2aCdeucpxhERTiJsV6UHxkQx6WRiJxdw8=
=NFOs
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
