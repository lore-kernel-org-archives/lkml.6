Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbeD0Jfr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:35:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32919 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757251AbeD0Jfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:35:43 -0400
X-Google-Smtp-Source: AB8JxZpzaIoiy1sDoJKv+MPEuAZzMrc5Y/gcr8Zpw/U31euZ+tapQChjDBSatj2n1QICVm/3nB3OPw==
Date: Fri, 27 Apr 2018 11:35:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/15] dt-bindings: memory: tegra: Document
 #reset-cells property of the Tegra30 MC
Message-ID: <20180427093540.GD30388@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <9efb02bebbb192696d2833eb78c920d774faa2f9.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <9efb02bebbb192696d2833eb78c920d774faa2f9.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 10:28:24PM +0300, Dmitry Osipenko wrote:
> Memory Controller has a memory client "hot reset" functionality, which
> resets the DMA interface of a memory client. So MC is a reset controller
> in addition to IOMMU.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt     | 5=
 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

Thierry

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri7uwACgkQ3SOs138+
s6FeDQ//XbMj/cPv6vBx+rY77gCB7OWCDK03mL/jn8UTQxpYf3oUma3MBSFum5KL
c/B+egzNO8Rncln8J4AHCUYen152+PFsIKY0h+f+Lnfpjwx9gB3SI6QYRnbQFS++
OYKe3MIjOvl5UfiK+BlA6BHU0LKO6RMccWTOLWalzwoHjQvrFaCqnN0oX3B/uwOv
AeAL1AsCbB4dr8g/Wn6JBc5ywNzLV8VytKDuW3z0HuVmwtdr1hJoBDEWLiC7lK3G
VFOMGkPiRbsSKKXGxsYuKLdRwPCHzx448ke87XuX0V/L9yLN9fDQ2BoeuOfe802N
MO1yGXAqn4eGg89NvR4rjbQ0mF2jaWQhDlEIdJWzRyk5trUaswo0IE8uPySIzaCG
j6nKsUHqOVR4nUTGMoAjvz0Jm5CqyOMwa7bBri+2iaJjKUrcMlxnKGCU1cowpp94
fbBKpTk4OZATBy4s9/IobujliSFiSSAKrJ06VNO+KpUwtwY9V/CPt7Q1sitJv2HQ
zv5oTR7UUcjPQbxLD/AZHip1P9zXO9KlWpZiavYhnMT+9F+bg566iyxwQ8rz59Pr
b3Hu8JF3w3+tzHOMDwJeXPuy7OAFXVz2wTwKv61VIJwO/ITUUgePft34+SaA4pqQ
0RvgXdbyyyZkXW2km/a7hvVFE0cifmjXUoVwLQWbtJbVF2uaNVk=
=3m6M
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
