Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeCNUsJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:48:09 -0400
Received: from ozlabs.org ([103.22.144.67]:39139 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeCNUsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:48:08 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 07:47:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Johansen <john.johansen@canonical.com>
Cc: LKLM <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: add apparmor-next tree
Message-ID: <20180315074738.03182668@canb.auug.org.au>
In-Reply-To: <1f3373ca-7cfb-93f9-814c-633c9ea87c38@canonical.com>
References: <1f3373ca-7cfb-93f9-814c-633c9ea87c38@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A9_CGln.9Le4=PL3AgKv_cd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A9_CGln.9Le4=PL3AgKv_cd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi John,

On Tue, 13 Mar 2018 23:47:04 -0700 John Johansen <john.johansen@canonical.c=
om> wrote:
>
> can you please add apparmor-next from
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor#apparmor-=
next
>=20
> to the linux-next tree
>=20
> I have run through a test merge, build, and set of regression tests again=
st the March 13 tree without any issues.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/A9_CGln.9Le4=PL3AgKv_cd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqpimoACgkQAVBC80lX
0GzX3ggAgFXfA2u3/dAXO6loOgE0fxRgVfzh1BVAAp0NCAvInXAHJd/bzCiK3WVj
/oTVE9wQEiJ0xfPm93YZU5ougYJfZaEaIRF2KMtcPtOZdLRIuiCVw5iAmZOp76Li
AJxaRdAgVD/VcL7V4oyZyw7dsy+L8EhD53SW1V5h4ueibXDyBexZDWswPJ1mg054
htTHeiKlnjfLjkTHAgKSpO7sdvdexrADuQVPDDsA8MStjBGhsjeLz5wj0gc3kgma
Nu1HKFsO+shQPVuKSXKgojoT/mSV90PXtEaXCvfR4TJuE8qtNLdHJhSL5gUN75fm
PNTau3h9bYDRU078oDWHUiqse7nNoA==
=0PyT
-----END PGP SIGNATURE-----

--Sig_/A9_CGln.9Le4=PL3AgKv_cd--
