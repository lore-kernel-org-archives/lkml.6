Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbeERI6T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:58:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34595 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeERI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:58:16 -0400
X-Google-Smtp-Source: AB8JxZprwKVadAWc5EMZ3vB4jXXjnd8DETb4J/gegBTxqd/4ly8v/RmvwfqtH/SuxIzV7vaC5XJhLQ==
Date: Fri, 18 May 2018 10:58:13 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 07/11] cpufreq: tegra20: Check if this is Tegra20
 machine
Message-ID: <20180518085813.GG14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-8-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:52PM +0300, Dmitry Osipenko wrote:
> Don't even try to request the clocks during of module initialization on
> non-Tegra20 machines (this is the case for a multi-platform kernel) for
> consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+laUACgkQ3SOs138+
s6HFcA//aK/hiIfIrFe2Rtv7UWHEMxSWLuJG37fb1wlxp8UjewTpJkio/5BGiqzx
k+l1fJdlO/C2UHck6JQQXhRJNhyOZGrabVel/q+giufB+mJjzIzeEMQ8zbGZ4DI4
mwaAnvEG+vklgRSQe7EOhH7M+ukC+plB2Sw1zBLhLPi69liompbjvsspRDJwHORx
FV9AYziFNR62RinfU2MlQe1Jamxduy6xelMjqKr9QTC5pr51P4guu6CyY5kD89mm
q849rExxtXhhh5lVTREYouY0nyGu2MRCwxsKYDXmMrLpDusMkmlv/3Xld0SLuAbq
moIIqj0/mArMv978BnxqPSZvlcumHMw/Ucj3mPIppsL6qBMMnWzCvYvT15AW9ztL
nIR/kbKodKjpVD3hwCddmWf/gZOG+HKRZaBK6zQN87vfUgC69cfpSe/IfesHFEv9
pniiqgbxPCVQaqn+vrs99FLmn844eY4xPAHknSzzFUiOM8B5+k2LsRp+46oU9P8l
E2gG1tar5PONzWPhhJYEeILkBnvpNVMDIbG12Sy5CKF88OL1EhbUm0U3LXDJFflU
DvUrmY1yCPn8PZNcpWzi+gtVCo/J+/i1/eO5tUYf0ZgZcUKle8aewp0dfS3yDJTK
eMXf9iQaGJFxJIU6Ia23C8pTP3Is6RJzxJKy3qQmdbjCE4fiF3U=
=RTGP
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
