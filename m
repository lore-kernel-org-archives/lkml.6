Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeERIfC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:35:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41488 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753767AbeERIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:34:58 -0400
X-Google-Smtp-Source: AB8JxZpuq9kJDiFjyEjiHozmlv+igVrMtY6urQIY8Ero9aVRsfQb1gAR+LOhvtIB1xlCsJe5LMOUwQ==
Date: Fri, 18 May 2018 10:34:54 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 02/11] cpufreq: tegra20: Clean up whitespaces in the
 code
Message-ID: <20180518083454.GB14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-3-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:47PM +0300, Dmitry Osipenko wrote:
> Remove unneeded blank line and replace whitespaces with a tab in the code
> for consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+kC4ACgkQ3SOs138+
s6HOMg/+P1862k14OF7KHetlp3iGlPedTLXjTUPqaxmfzm7OfiR/PhhITB3Dk6Jn
vEIHGiWQmVzRa9FBXJ6PCspdwXWmogJ1hY3pLVXxzYeqY3lSIc3ndYJhrOhWJjS6
gZbXUp6zVJz3DdqYO65WPD2NG0IOS0TpFgjn/jlU8VLXDY6orx5FeEndHD/Anvmc
VIi0O1L+8atewwHqz7UhGZhJfekdzkqjgAqGhXM2q3KHuwXfCJ1EiJGYH+VfiuKt
wfIcYHTMLTiOdTVcyGw91xIMOfGW7wqJ3cVRB7uRLe3CRoQXTAtmh/azxkpvF5sM
PIYSLEfD11CVoSGlmGZN4H+MmiNp/G7vOkyRpP1o2t5tjxlLo2MgMAzF4jcZQRE2
a7voj/ZWDBvVNzi6C6WZ9Ql+FjZkb3ISdC+by7sCCCFPaCMEgDIi5QSExw9a8wXa
0arhIQo1pELHix5IUkcI8Jxw2Q7MGtBfJYA/U2sOucfgvNjrdMLv104ajFGqRok+
Pyl4RMfK3lhhcHHDjxIDciqhbP+dbL/+VxhYEDuxM/TRb3rdKSVz1A3VhUXTg5ob
HvO/V941vz5tz12qgu6awOyiA0jAgGBq2PXG5t5CGsy/A1pcl5BBWNoKoFUgZYar
K5vYQwZVrPCs5WDEU02wB/42SVka2epBYtv2y6kCkZciIYDoOK8=
=gyI2
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
