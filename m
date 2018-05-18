Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeERWDC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:03:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38166 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:02:57 -0400
X-Google-Smtp-Source: AB8JxZpJFo/aI4XRuGzNZvDGS6wCO6laHrW9eg0r04trcaErSjSd/bkRUzWSsY+0L9SnRK3B6Qxd5w==
Date: Sat, 19 May 2018 00:02:54 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v2 07/11] cpufreq: tegra20: Remove unnecessary parentheses
Message-ID: <20180518220254.GC28123@ulmo>
References: <20180518200642.24815-1-digetx@gmail.com>
 <20180518200642.24815-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20180518200642.24815-8-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 11:06:38PM +0300, Dmitry Osipenko wrote:
> Remove unnecessary parentheses as suggested by the checkpatch script.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr/TY4ACgkQ3SOs138+
s6GV0w/9HBba7yTfqCMIuBjab3jvfawUuz2FlU0wIrRbW+BseG11hf7kQes13hJD
8qJkC62nRsfjoGxzjO4aQSGJItS8R8wJ/3dkwCLlER51LmttsFzR92e7V+6CIU3Q
EsEfkavHF6qqw2UX8o/jdthxZVsMJ3C5U+tYKHgb1YjzP803U5VUQtvnOpc0FzAF
Utd4U5uto6HbxiKv8VNg8ES17EZY1ZtkQuVXsaP6Kpd4u2PScQpGh7Y6faAk1Dcm
UJiH74VP90iJHge4tlQH/ZHmAwrk+G3pZnMwbu3+x2NeH5ISWD6b55qfyPxSTUzM
L8bXH8LGo/i0olrEosj94tNbVVfaLNutMrwqC1d0KAnBakgbGlIigEzIKVB494uJ
XaUWsBaJvbuCLdMKfb3GJ30uWvluqxkau+16Yooqm2yKmurg6sSKU12zRFIw6i/x
TyEq6Imzkh+Jum0FTYx4DJs7NAh1x238OiwrsOCoMxYVYrrA+AI13emkXB/rIE97
ZdynmqrJRVK4dQJqORvMIZOW52zlSxXKCTqFGVcT+VhKr6R84vxLWEMahzcsfYmq
tyracS7vFBxYrvXrORZu14f9vVHugNf0oMojXwG55bAew5u/wmpEmSwjhs9mFHrD
pMWYRufv+n4TtXUevlcaGNjym0jPqFokXGIeaR/3I5156JaYFYI=
=V9cG
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
