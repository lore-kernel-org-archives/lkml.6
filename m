Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbeERIel (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:34:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37699 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeERIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:34:38 -0400
X-Google-Smtp-Source: AB8JxZp/nw459Ep7XyjZpn/C43q4tS0gLA6Ff8X5hMppWJjwe+FyG/oGXDo04fXaYXwIMrvygrAjLg==
Date: Fri, 18 May 2018 10:34:35 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 01/11] cpufreq: tegra20: Change module description
Message-ID: <20180518083435.GA14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-2-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:46PM +0300, Dmitry Osipenko wrote:
> Change module description to be in line with the other Tegra drivers, just
> for consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+kBgACgkQ3SOs138+
s6FUdRAAkWBNDambFNgE6PBnKqFIhzGOcyvMYuxvDdaAQ0vFDMXk4YIZIXmX5Pnl
DDFTRqfF+2sK+8/grurU8STmvER1dWPRa/orELlUQz1gQc65/DqZUtiXp1xoINMv
XFu3x5KO/HLcQBLjYYqVhV3xVwBvtOZzHItV8RdqpaYVSSparOVxC2iJCfYlA2Ds
46+I/bAzmpqRs66y0HiTxnGH4UL63xCaLztlu82WqeRiVHKIxu0sX2iMu5RVd3zo
fLtzUIiymXuByXuUZlIwLKGMEU6eotIj/AGjnrDNl4BXWcZLScAUeBNMv6lKgMvB
S8DJ3Ht4hdmSgjrW27Ew50oDwpWyKlOxQDPue/r5N+2j2y+7FnpVsYbl1VwGUalo
Je1Fb4C1k0GpSlEKvS4/5ABRDXRZfHsi8Lm8cctsohaQdHVolpOyIgsGoo+kvIfC
tryJ9md98cj/2VIsTTFFqrToxIbAEDDlt2MgiR9G2wOxAXWCGQTpg/uUnHzXnyXn
QUbEjIgzN82B1YZwtwmoZKtSG3AsJH2uwapUXUHz8jG3t6j2Ls/7z+2TGTzMvRPA
zySjPNAQtRNvJNrS77n6YvALFps3mtmMKl7ONBWJyt9zYKeFzmHlNUYn+uvk02eP
kJwXdsrPKJBjav/C7RqEM+fqePd5pTskUleALmawyl6hQtEnBiM=
=6Ula
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
