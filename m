Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeERKch (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:32:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37990 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeERKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:32:34 -0400
X-Google-Smtp-Source: AB8JxZrMOiebG3XjHeErN4RKtTI984D0kUH5FDErXgIoWElwCF741kAk6B2HCf47qyP0nLkfn/I5ew==
Date: Fri, 18 May 2018 12:32:31 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] memory: tegra: Register SMMU after MC driver became
 ready
Message-ID: <20180518103231.GC5312@ulmo>
References: <20180508165530.12746-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20180508165530.12746-1-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 07:55:30PM +0300, Dmitry Osipenko wrote:
> Memory Controller driver invokes SMMU driver registration and MC's
> registers mapping is shared with SMMU. This mapping goes away if MC
> driver probing fails after SMMU registration.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Applied, thanks.

Thierry

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+q70ACgkQ3SOs138+
s6GC3Q//WZa1eeYRciS41fc3IW472cO4FXLPb8t/OavAP4smLyp4LRGY55dGu0Ju
tFNUv5D3iPSyEa8h+oAPEbve48AFLy3jbT7nb8T3OdKT/cXSQJSZp9ttIJUJXO65
8iZ8/v04xcefRT0KstVP2qi6ma/dZJoO5Xz5/g82XzXzag8mKcGHIV9em/RGQjjB
bBCAC/Z2EsPHWgpfh94wOYnNUDRmAGAzCjqM3ZWlR5nOD9/brUiBgFh+A3pFzlwP
4y7a9ZaFIRnPrY+YvFZ+cITinjBL4l/SmpadcBJeyhzhszjGrrXgC7hWp8CTTaEW
jZrvgryBtAMDtH4qli1Uk+JQBFLqhjNIHgHsrhJORclgXxi8xnQIaV08RiF5p+r9
jE0+vidjKIYqpMeZJe5gCTxl2R5UY8tcUDPNCss+JTmi323isjYQhbaqAKK+cKr0
6rCIbR8eqnXc2TwJjVmmldx7GynWBcGpOyNbuiUVdWiBe3WoB74HhLWApGB6JtIM
KpNHLnCcL2QSOg5jvLcPpn+gvEWc4Yf9UMXes8Go0c1KEDmlIlbD7qFtObuoqchu
IK143F3PfeSxLdQFCPc7oy2OwfDttnaSoY6SUtZvG/vGbSGbsDi5NbxvJsJy0RIk
71RcR0kOeX8Oi4hAnIlZLrOuZlYCswxy1gXIb3JoTJ1Qn3lmfBg=
=MLsU
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
