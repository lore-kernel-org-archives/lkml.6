Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeERI6i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:58:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35743 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753616AbeERI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:58:35 -0400
X-Google-Smtp-Source: AB8JxZoGSvRh/QC7Sn54grM6C0yWGBKvoMhx/mVVHv1HiRki9wSOs2n38MVTX3ohAY+P47xRVtMfiA==
Date: Fri, 18 May 2018 10:58:32 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 08/11] cpufreq: tegra20: Remove unneeded variable
 initialization
Message-ID: <20180518085832.GH14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-9-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:53PM +0300, Dmitry Osipenko wrote:
> Remove unneeded variable initialization solely for consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+lbgACgkQ3SOs138+
s6EaqQ/9FM7q0piq9uUjVSU5Tc8btDXggWtn9s/TuoVwXviArgyYpESAPXqPELxn
2u49WMbyMUwDE6ZpGn8DARE7fT+S8E5Y8bdSd9ZnVP8LE36iPD5ni9+GsG9dxfp8
XyvFHfMVvmc6ACg8GK7zup5qPHhqk3YBGHWVZjG5hfAluhHXrRT+nyTSH2dgsZfx
J4xskdJ4mPfWexhFTr8d2lUZ9UGSA8lH6Kw1hYD/ttSgZECc9zx9eYBATcdpdqPD
bMWD7Nr8XlPe5g4uMFyU1WG8ab2RLdfM/eaNgqtc+6s0Km02cq6AKYbS03NU6OlZ
UyRMQUOSmiTWee4OGJ/0Ll4QL1bREiX0UXYnEGnp7Gsn5ezpldBCPs08BQfd1B9q
9lQH1lG/cZ8n7uq4dz6MNBTu7P9xg2CoUnaVdRjzzl8V/14fpzFwIo38+U8EPVWE
PyqadcB1OYKqXnz4Z6Du89CPOIQGooF2KpVJGuDRk+0hjngKKhrumi3wGwg8bXNs
evnAXeYQEqvN7YiDdjyGP6z0l4K2rj19vxRsKS1qP5H5it65g8/3NCX6oa9YUdC4
MxCXODVqyLveYHZWhMzMAqTcEDoIqSCbcelMSZ3VEzZ+/8gAIFBQg9/3Gtzv382c
sh99CK2r6P0ruhEmVu9pasROdL5aevDmTx0VdL3Tv1avjKIXznU=
=aSfH
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--
