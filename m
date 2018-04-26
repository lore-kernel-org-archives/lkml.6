Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932320AbeDZOKd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:10:33 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:39883 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeDZOK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:10:27 -0400
X-Google-Smtp-Source: AIpwx48GRO1oi8nMQxguJrpr+Kn9XFY8ZQ8DdDD3DWeUePs39DHCd2QVLUmzk8GkknB9F6HjM4u8jQ==
Date: Thu, 26 Apr 2018 16:10:23 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lin Huang <hl@rock-chips.com>
Cc: emil.l.velikov@gmail.com, briannorris@chromium.org, robh+dt@kernel.org,
        seanpaul@chromium.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/3] drm/panel: refactor INNOLUX P079ZCA panel driver
Message-ID: <20180426141023.GA31888@ulmo>
References: <1521018736-20980-1-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <1521018736-20980-1-git-send-email-hl@rock-chips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 05:12:14PM +0800, Lin Huang wrote:
> From: huang lin <hl@rock-chips.com>
>=20
> Refactor Innolux P079ZCA panel driver, let it support
> multi panel.
>=20
> Change-Id: If89be5e56dba8cb498e2d50c1bbeb0e8016123a2

When you send out a revised set of these patches, please drop the
Change-Id: line from the commit message. It is useless for upstream.

Thierry

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrh3c0ACgkQ3SOs138+
s6HZZBAAnhNfIbnGuaaADkHiCF7ONEimxOAw+BThaE5/CZeDMFpaR8bFSC4tYUVU
DzSjn8rflha0CFdPkJNMd0elcDpI3+vlMZk/aiHW9VxVBNAdaBd2OrAT7Cn4zJGL
cNIBR/KhpvgpRURtZA3pvak376esIqPjA90CGJ3x/KwgrGVwKMj2Sk3xBduiIqxh
PHrkRUtMGF3MzNr6a+AlXi5W5QwksPYSgDKVKYqqlySEbjvSybLsYVg23Hqn8dzb
C00Dw0UMngjHWZJ7Nxkq9xdJ9dph/1nqtUXSK2pmj0IHr0CgYqR4QntwIdI8gAbq
djxd7otBQoSN2G6cfcK1RlnAaI27zRNFWmz9ZTAB0v6jEABgbrt7oQ6xxNrLJmK7
NlTzOTwBjAX10NeRSCoPLOnPvleqjQZWz+U84+YomB4R7VQTE7Tpd6OGFlEa5Pza
/ckqvUb5MdJa+wb/3yvRahSm+w2P8pOwknZ9hnaQ5zuWRBWzGMWj0rCBsVBlnG5r
lnUKjBaODI2um0pVO1Jugjl+CmpmdvfTwzDU5az2aI6b7ajrG5WLcui+aXEcaxPX
PE82NjkujTNrR8SAWW0/c8U1PfZlE4CI65uDkRA6Z3TLapRt0MepxkH7NebcGm15
ao55BUUJgPpdO3yv3ySJhtEQx5FQqZ1lGMlHpCK3Nn5AQ/u+fbw=
=xMI+
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
