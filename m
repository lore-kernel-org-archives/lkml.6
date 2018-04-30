Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeD3IJH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:09:07 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42431 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbeD3IJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:09:05 -0400
X-Google-Smtp-Source: AB8JxZoUuBA0O3BtUVHBIWtaNyK0OkWbhgH/y1EQBogko3jU+4uXiNk2JD4C/ziZxEwM5EeCe+zggA==
Date: Mon, 30 Apr 2018 10:09:02 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/15] memory: tegra: Add Tegra114 memory controller
 hot resets
Message-ID: <20180430080902.GE2484@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <57ac9eca965eaddc04ab8f885b11cc37a6c0c8e6.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <57ac9eca965eaddc04ab8f885b11cc37a6c0c8e6.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 02:33:52PM +0300, Dmitry Osipenko wrote:
> Define the table of memory controller hot resets for Tegra114.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra114.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Applied, thanks.

Thierry

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrmzx4ACgkQ3SOs138+
s6FBkw//aI+0RkiMD7qCaZHhmcy+Nyp4G7pze6A2+9/mInym5aXsR93ipHaklF0/
B9krllqG/Uhg1UvwgrZcFsqImduB3PsKz+VoeVPBhVEHHXBBR9509L36fgvcmoBT
7LI5A3XrqGgrxf6Hz8IRqD3RzsrbGJm+zXU4Oo0j+VV4X++2AVmUFTCftH9o1obt
Ll8FSo1fSSMRjrsS35PENX4XZyk2rrAH7CjAwEdZHJjatx+cisdz1UxsSHWk1IvA
eMXke6cFjikvNRK6O7aGQiJNgymjLjWflbqrgdqOvWods3InpH8Cym1cWQFi+gJ6
au7L+E1hCK/zHndNV1if7kwgo9VfpC/6CE0LTIhBHgLjZ5VavbiBTZa5he8Ehv2N
iQ1wOX+9DYKksowuZEhWFr0E4lfUd0kDZFGmKv48T6HJ9AWstqUGJ1n4KGZ8gf01
zp52g1nXmHLE6MhJNRVR84X4cXGuBiY1xOKwusQzADzOXFyqJRhfhfcFe7xWOJnl
gvx3Si7iwVV8BJPL9kNxZh8XHuxkLJnKBtMMIhhMWnmkh3gkL/0s8LOFtt64C0Zj
DtaixDUx6oN9oUmJ26Q8/vF5BD1D9oZ7D3vnQ/MJ2Ojk0IMncDz+Dj7P1v44bRlS
uvtJ7aA9YJp5xeAtEVwbMWZE/85IWMlLea+zcdtXxtJ2mZEaSlU=
=L7jn
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
