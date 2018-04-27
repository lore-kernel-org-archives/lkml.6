Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757938AbeD0Jgx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:36:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35936 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757361AbeD0Jgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:36:51 -0400
X-Google-Smtp-Source: AB8JxZqLdwl6Tm38dXVh9iQ9+ger2ltctDkPtNeyYBbGPBB6ciWQ8dYqAvZzvz+lsUcZB5c+jqyIHg==
Date: Fri, 27 Apr 2018 11:36:48 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/15] memory: tegra: Apply interrupts mask per SoC
Message-ID: <20180427093648.GI30388@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <82a5ab9342fa5ed3f57b62cab755086057a1a5fb.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <82a5ab9342fa5ed3f57b62cab755086057a1a5fb.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 10:28:29PM +0300, Dmitry Osipenko wrote:
> Currently we are enabling handling of interrupts specific to Tegra124+
> which happen to overlap with previous generations. Let's specify
> interrupts mask per SoC generation for consistency and in a preparation
> of squashing of Tegra20 driver into the common one that will enable
> handling of GART faults which may be undesirable by newer generations.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c       | 21 +++------------------
>  drivers/memory/tegra/mc.h       |  9 +++++++++
>  drivers/memory/tegra/tegra114.c |  2 ++
>  drivers/memory/tegra/tegra124.c |  6 ++++++
>  drivers/memory/tegra/tegra210.c |  3 +++
>  drivers/memory/tegra/tegra30.c  |  2 ++
>  include/soc/tegra/mc.h          |  2 ++
>  7 files changed, 27 insertions(+), 18 deletions(-)

Applied, thanks.

Thierry

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri7zAACgkQ3SOs138+
s6GDEhAAkCGDKOM5bRctkbc+kZumJZ3QP77GNHkoHiVXnDACZ7Ea7tIYg2MNVm/E
DK8RJzYpczMQtKufs2K10ZEzLWlXBE0ay8VQX1XYqv+L4UHcOe1PhgDKC1zAhAjz
sGdanSHTf5Q4PWzabAZI2vXVSrqPQUklohhhdwcV8aAo8DrvP9tLpKltbPKyppv/
mfXIk3XZk7pjqKU4bTEyBYzBy6+tbL3F6I0CRjTf3FSo6DmuG37+7JNSCwhX+Gpt
gb+vrplpZaYisJ+S7+eRDLPCBt5sUfiScUAGH0b4Mp5oxooFfhoQQxevWhpxyOd+
XA1yr78LRYHQiw9pCVQHVV3g0X2NKLMMXNi96oA8uEJNZKeuajN1mQk/zvOPishZ
I2CaQv11uucILTJ90TAzgsd3AHhO7BYUEER2jPAULYRi/ewHnKEe4IHjSLNHvQAZ
864ZH6L67zgtURyWLTjWwwmaUcn+0VJepV7ypWk8Tu3AO355lSsOGj46JXaIeeMj
0+PmoGH013ldyXNFiEKMyt4F+GwTTov5BXFMyHZpd40T9znFwdo9muJrcF0DWzQY
Ft5AFtq0uiV2hilBBwqi6ZRkO+TqT0u9Mw4jhNO0evIBr+ifec+6ltaxZVpngv/F
FYv4VjGNC/1AlEcAoPpgF02V9fahjHdsv4GJMVZLuh7XTKE+kek=
=8Dcw
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--
