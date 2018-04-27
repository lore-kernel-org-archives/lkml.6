Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbeD0JqR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:46:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46095 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbeD0JqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:46:15 -0400
X-Google-Smtp-Source: AB8JxZpl5zhLiPI3IVMBEpctHEsTymRfvLXwfPX+kzT6nUrcAumn90LElw0m2XTAY9p0DPyRRFdeFw==
Date: Fri, 27 Apr 2018 11:46:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] iommu/tegra: gart: Add debugging facility
Message-ID: <20180427094612.GM30388@ulmo>
References: <cover.1523304324.git.digetx@gmail.com>
 <fe55521bc6fb1c576fb532dd7fb64ede4904beb7.1523304324.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S66JdqtemGhvbcZP"
Content-Disposition: inline
In-Reply-To: <fe55521bc6fb1c576fb532dd7fb64ede4904beb7.1523304324.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 11:07:19PM +0300, Dmitry Osipenko wrote:
> Page mapping could overwritten by an accident (a bug). We can catch this
> case by checking 'VALID' bit of GART's page entry prior to mapping of a
> page. Since that check introduces a small performance impact, it should be
> enabled explicitly using new GART's kernel module 'debug' parameter.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

I think this was discussed before, but this really shouldn't be needed
unless the IOVA allocator or GART driver are buggy.

That said, I think this has some usefulness to find such bugs, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--S66JdqtemGhvbcZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri8WQACgkQ3SOs138+
s6E7txAAoPM4PpsDe7fX4an4inpH5dwTCZyy8PPX/S5a+G2NeU0TbdP2Aa7BrO3s
c9spqHrGl9NWSHWGAGhakYaNQzwrQN5SwvwxJFBTOlc5LIeJ73oAtl4+fHndot8E
hJW7E1rlPV4B0K4d4FNkp6CMmVECfINEGnUPJDDsNO4eIewlYi5mR2Mr5y/nwYAP
Y4nzJUQhC0dSvQhYatIdsTlebBiegjAC6/nadLKzUZ0UjnOY+xbf3uSK0Hb1o6D7
AJQ93Gt6k4DOVT3SlSqoLhpMOyxwLDOYZTQRfzneeiPc4ZoB2Y4Bt2CPWvyUJjHK
uTP8s7utmuily4y6SyP2bj11jV3pmKEPkAcTSN80jRvXy5+V/u0/N3JHpTWhRZ6v
MOid5FR5k8Eo/lQXU0YWqiw/IeKFM7hPT4rp9/Nld2VQF7ykHtL/XqF5CNd2xDLI
wrEj1Z6pCIksY0LeBzZRn3VrFFRziih6L4eYmzvxWAypvhi7Blfz8Fl2O0VTO/lh
cU65Ew1DbvBxXqpY8MidgL7QGYNifgdZaNtmOnXGLAsSwFt1DKm1aBiqtWlGdCe2
D4G1xJkwSuyzTbBZQoYKLGgAnx4Z4a3fuh2lJaT4HobcQGFuOdHk0kw3UIZzcyh7
Mnsq0Cmir0XsZnnKXheaLG75Vs4fFhJxWqNlK+HLdOJATYd3xxY=
=hFCV
-----END PGP SIGNATURE-----

--S66JdqtemGhvbcZP--
