Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbeERJAl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:00:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36329 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeERJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:00:37 -0400
X-Google-Smtp-Source: AB8JxZorhG9S2ObVaKdTuyLFAgRsrrRj6Oo8Mbdrygv7gR60AAlWc/EroDkzaH4L7G9BwyAHVWAkOw==
Date: Fri, 18 May 2018 11:00:34 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 09/11] cpufreq: tegra20: Allow cpufreq driver to be
 built as loadable module
Message-ID: <20180518090034.GI14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-10-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:54PM +0300, Dmitry Osipenko wrote:
> Nothing prevents Tegra20 CPUFreq module to be unloaded, hence allow it to
> be built as a non-builtin kernel module.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+ljEACgkQ3SOs138+
s6G6lw/6A0TjcEZ7YHWpfVyHRS/qflZINwz4Cg4yL5+AjERPIxboV8ynTm5dJhFL
KtGE+wrCn/svTRbO6l/EPAqvSp9CJLlqMhtiLuhv3kTeLiaWInVX6BAJ4Ve+Hxc9
Jk5Fyb5slRbP+UN7IhSQkW5NTvUmoBUEdz0jC8QmTM9rsjR3ee+bmWmbkniB19lQ
Wnp5J5+rmfhZPq1MVTo2s/nOaPQzj9l3S0VSvhfjNU+LOcxcfOj48YxShIllyX2o
2zyGs242/7lRZ2bZ6aIvAfqNdtfe71Y/kzXZx5RN2lXva6KUUXlWWIx9R0wY7vrT
bwKmdmHTYbeYW9AFvd+FPJ53nbqqgGZsAYVeqwuzr0q61pdM8TWbz42hjr2LF9Pn
T/iPpG3IRY382EEspILGsvh3rxlVx/SPjt2xSrHdCRL+XOspKuPWBVcudHISYLNB
NtCOAMECQSTSpG7lzR7z0kNw4A2o137WrGxoqRO1TWzTZqwNGMlvCcv3ggQzQqwR
rwBZyj7FZr1LicEMuwbj7yI//5OKEhuI9WQ6HsAbIjkwpXXbUl1nO5JbxkB6zkJ3
3MkgkZi3fi7kE7LD6aL3iO5AqhY9yqolydz5v1zJdBWoBB4o0Zh4wkZFgyUoM+KA
RU21YBwsjNdrc5Js4mftL4nEMtzklhzcMVSyHzBMoNu4EY2Pp3A=
=fMi5
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
