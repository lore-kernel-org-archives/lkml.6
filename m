Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757854AbeD0Jga (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:36:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42527 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757241AbeD0Jg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:36:27 -0400
X-Google-Smtp-Source: AB8JxZoWo97dJNr39NA1ABv1aG3/i5DxfIZkyGO0g0nGy0I/5LhuGZFx9EOM3ZWRecMJLaWk/fejhw==
Date: Fri, 27 Apr 2018 11:36:24 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/15] memory: tegra: Do not handle spurious interrupts
Message-ID: <20180427093624.GG30388@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <30ec0fb1941e2ea2e10808d59f478f022b06266b.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <30ec0fb1941e2ea2e10808d59f478f022b06266b.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 10:28:27PM +0300, Dmitry Osipenko wrote:
> The ISR reads interrupts-enable mask, but doesn't utilize it. Apply the
> mask to the interrupt status and don't handle interrupts that MC driver
> haven't asked for. Kernel would disable spurious MC IRQ and report the
> error. This would happen only in a case of a very severe bug.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri7xgACgkQ3SOs138+
s6EKfA/9EuWrkOgyGypy+rDLrOZFpN+Z4kHNX3Wnfcd5KwGOze65Jq6a3EhF7ean
E+oshoNq08Y516rPEiDjdKW5lIgazjc9hcy/yhzmVPttxdseFN7rYBF7hEQyK5SI
Ib2SkGsDnf5R2UhzG/A39iXddTVTfn2Ocm+xaWjCRbQOvKers2r7QnVipnn4mmTY
elmoR/G9rrvQsFWQ1ZnrW+6KmI++voFQ1cMYFwVZOROQcf9xCRyPIL9Er98Dj9Cv
0t0HGl4OyNv0Td53z/9sEHeDTt/WHlLxH682K4nICPcNd3BcOMVIeyYgGlkyPdSt
wzK6bqlj9HrR0RJIPfYiIbBCs1n3OMjnurD/kxsI2EiM+r8wUdUZYOjXnTqmdpsS
uLFDytPRMZwUyps8MeTrmEY+FMK0RDpVM9A/+W/n2NUNtTyClg6/JGFZeoBrC6fN
S5pPYxiVeFn/AuG/9hvCiX1KukD0/JjxgLCEwkSkCk7lzcxpMtmA0gEbeg224Kju
vec/s/jbob2McK3wsEi+SCEaSpMAmQttoFijlm/alppzH6YOrK6x5FvNO/p5DfUd
/47KdoODZsbSGHd2zjvNljV9voGOF7Zpi5av+TdMNDOjbVU7HVeCJ6mKnAjmJRZD
Cd76WF2/0h/iN7vcQhxuVRIEt+p08V2fNG8sSC5iPquteZ27E6w=
=1L0S
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
