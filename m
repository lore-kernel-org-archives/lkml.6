Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeCIMIg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:08:36 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39061 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCIMIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:08:34 -0500
X-Google-Smtp-Source: AG47ELu2+FHwLLAm88xvCFbqnihy3hpjbNqG3Rt9RPnnc8C2uklpVhA87FHCn7Xxb/8j2jKS1XhdTA==
Date: Fri, 9 Mar 2018 13:08:31 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: defconfig: Enable CONFIG_ARM_TEGRA186_CPUFREQ
Message-ID: <20180309120831.GA18609@ulmo>
References: <20171116114652.25321-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20171116114652.25321-1-mperttunen@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2017 at 01:46:51PM +0200, Mikko Perttunen wrote:
> Enable Tegra186 CPU frequency scaling support by default.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Both patches applied, thanks.

Thierry

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqieTsACgkQ3SOs138+
s6EzNQ//e2kMZUjzvdKlIsIr8hXj6sYBoxAvn3A01BVeurVUjSozlPDzTDDlUQMa
JHvzqHXd5loZPFB06ZUvNdJ8nK+7HYSvqD7Sh57UTgOrX2+qavmXHOySLHPWGr3i
OaL0WhWzXaVsgn9Gp5nbgrRE3WS4N6vyJpY4C2XSxwrmcFi4D3Vwe306xF3p2YoW
9/UFxQiAcyIImmxaRuHb4xJTEmqcGBERd3fRRVn2MAn5tpAV6ngCaJeE5kMy8fQX
UsibGkXfSSUAHrij5IOTD65FmkrbSg68E0Qd0NLa9rELqGJT9UgQbAD/cxM89Q4Q
HRvURGkX2XNsa80hiAXc/l3ks5zMUWSluHPSikI9h2MAg11Utz3cYzFBmHUC3EHX
iGyPtjIYHzTcdBGvt+X4cJn0mj6naKO5l4THUyzjsCWCYcByh7fc306qtTgm3Qms
1iaYY0PvbQjO2VqbDI5fOVgIlFz59zpBAtzJS2D1SmE1jK8E2xdbG6gW1jm68ZjV
X3Kzik8Q7fkNFDblpzTog6osLvSbOgMa+wBYi7bsTZ2mvUUOFZqP7CfdVhsdSvqV
kY5r/HDhgaIPGATn2hniT7XTl5hNMG5wpuJrxztothd/1uTw97eDDEmX/RpyAch9
Njfs4NmdCDKvp0oSONw728dAVDRVeCWwYaThG3F1Rwh/L1RlyKE=
=J/zq
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
