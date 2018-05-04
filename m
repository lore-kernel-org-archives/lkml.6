Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeEDPW0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:22:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43087 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEDPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:22:25 -0400
X-Google-Smtp-Source: AB8JxZqLYJimrUQh4gBARxxZ7OFuiOyhklWvcYJZfdvzG+0wHWykpWx81gR3E+oyaglXRMpmet4lyg==
Date: Fri, 4 May 2018 17:22:21 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] ARM: dts: tegra114: Add IOMMU nodes to Host1x and
 its clients
Message-ID: <20180504152221.GF31229@ulmo>
References: <20180503234723.4368-1-digetx@gmail.com>
 <20180503234723.4368-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <20180503234723.4368-6-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:47:23AM +0300, Dmitry Osipenko wrote:
> Enable IOMMU support for Host1x and its clients.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

Thierry

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrseq0ACgkQ3SOs138+
s6ERHxAAjEuuW6tj1OiPGhaOm8J4BSL1VuBzboZvkqMeV3FtUzmbg6TKGKlOKYU6
AzkGF/R25rodshg418EH7RU3WRPdy1YitRzZBDJtyeFEDfackwgs21vucV6w2iLZ
T+qcwN8VGGkpdhieab2RRLXxWCMMrTsTWIXgzwP7Jy0QlC5mlasuLhvqOk8PpA0s
YjEH0LWsbMy02To0f1NWWLbvr+JvD5xO65kES/nkJL8jMM7e9rs9SyYaDhGpteld
FW9WcktWjrYFCduQ3bXbVxt146up6ON+bp9xZwIxhZtYzn0U/PHWGW653Ql1SO2w
FqIsPscEKblIx6zB/xkdqdM8+Y9qcYkGMv7AOm3TIHeLVYhI7uFIe/nK/EW+ZgYb
EGOrGLiKvoVEQkNjhCsvuFQ9YRS5Dr204H/UrLkLArlool34jV+bu/8EXudIlviU
ta3oJt1fwX4tFJJzt3RFqOvx6gNLu2U1KR7uBzph7yHSznZZuE7GMGVRomJ/f6A5
zt5hUeXUehxgESXy87ZxUZEnVSDLiDvSjurPtb5/mKZCosKE67lh4KG2OYxHM/c2
4R9G64GNW9Ub3DbFd2zRFaVrchwogwuj+5gx3+EPrtNANfVGRXPO2HLb47UWEs9n
c+E1vdreCarECYps9Lrp60yt+WFDzX9T13EvUJ+2Oq4MyNCuwp4=
=rDke
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
