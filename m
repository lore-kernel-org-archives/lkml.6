Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031850AbeCAPWe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:22:34 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:37567 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031659AbeCAPWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:22:33 -0500
X-Google-Smtp-Source: AG47ELs9mztyLnGNSJgnPXQpn3N3+vW9Gc9voxiCevD0TtC0W/bii5U2vo125iJXZ+7OHWdir1vvGQ==
Date: Thu, 1 Mar 2018 05:22:28 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sound/pci/ice1712: replace strcpy() with strlcpy()
Message-ID: <20180301152228.4hup3qvizqef3hax@gmail.com>
References: <20180301114535.bf3ibzcpvohyjweu@gmail.com>
 <CAHp75Vf6kfPE_sRPj_mLMvLQfn9Fe9B_MeXqnGAHGAdzR7HX+Q@mail.gmail.com>
 <20180301141707.cp5dc6zbh6bur4xw@gmail.com>
 <s5hk1uvj0b7.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="avggzieuidntpp7i"
Content-Disposition: inline
In-Reply-To: <s5hk1uvj0b7.wl-tiwai@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--avggzieuidntpp7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 04:13:48PM +0100, Takashi Iwai wrote:
> Thanks, applied now.

Cheers

--=20
Joey Pabalinas

--avggzieuidntpp7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqYGrQACgkQruvLfWhy
VBlzSQ//SFpqmTRHoUHlGB4RtwASD0xcLA7rUqSQ64R14XLABXM0AnQjpbr8YMmM
yqiVQYkJSLxGSSvB8mWpy+A2Qlm8Ubh0mBNrOxOOUACVtQclmR20Nk1Oy5Sc8wYP
rnxUd1eOPFfThoXshQGp06QUy3UbLL9Z0fZQ+ZTP3Qwi0JwfPV92deOr88PVMWmA
F6TpZYi11hmHDo3QcXETm/gvl1nFHCVB5BD10q1P1BvnVSeBS5proug1fzqRYckS
mCSJqDi+8L/dRPMeJqZpIOFipWf8ArVeihBRleaHY8LcHUODQun41FEKJB/zKRVX
32IloNkeu+26Ok2n4z4xi8Hmn6MlQraiZA6myZzkTadXaopbqoKDPisrh0/+csgF
8xgQYx5nXkOr0c8Fw0y/1QnIoxwT/BnDkkCURDzm4cjIaWA8PxdjuPqvrp1/D1Rm
cgjqcWKSoP0TUMglWmm2m6W1dI0M3XiDuZ4AxVmFpUrE5+ECNqinIA5wJHMbq6o1
Tv5S/ViGp6dA6tiLD28ghuZLOF6goRcPh5Widn75+EYumSFG6xMeuNqHDwp1fF7x
L5DubSRpkRFtJtsOfa2R0DBy+ERNzSKKdMO0Sd4x4U+Foec/9AdaVM73cM4k+9X3
QBI2AafBvySSaafkGAupVzWqXK3015PZPwLU+OzqHgOqC+kFTdc=
=hXto
-----END PGP SIGNATURE-----

--avggzieuidntpp7i--
