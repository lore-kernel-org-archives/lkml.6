Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeCMUtD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:49:03 -0400
Received: from ozlabs.org ([103.22.144.67]:44901 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbeCMUtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:49:01 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 07:48:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Tree for Mar 13
Message-ID: <20180314074832.0fb08b90@canb.auug.org.au>
In-Reply-To: <20180313175205.GA15734@light.dominikbrodowski.net>
References: <20180313183326.0e93f359@canb.auug.org.au>
        <20180313175205.GA15734@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Up4weG3Z39ZovDdlJz62UAq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Up4weG3Z39ZovDdlJz62UAq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dominik,

On Tue, 13 Mar 2018 18:52:05 +0100 Dominik Brodowski <linux@dominikbrodowsk=
i.net> wrote:
>
> would it be possible to have
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscal=
ls-next
>=20
> added to -next? This will probably only be for one or two release cycles,
> but it might easen the development process of that patch series.

Added from today.  I put it near the start since Linus said he may take
(some of) it this release.

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

--Sig_/Up4weG3Z39ZovDdlJz62UAq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqoOSAACgkQAVBC80lX
0GxheQf/ejxB7t4jQANFEBGnxuHtIZTX1GRKkCzBrBItuQ+nlLoNE71zSj07zuV+
M91HNTlK+mFSRpVW985wmAXqYr6YdQq5kmeB3h5LRgCoWnOf198sFQLvO7ejBWdq
k5xXYBYX2rl1ruDKsWmLwbP6vtHyHJXfF//Yum5opTwpuTn9xjxdEaZfdYc2gQJV
x1bLRQLNwIENBKW+lRgC1vzplsksXw9r0QKJKt1vQELVeg2jVdCFvey4y/LD4h22
REXjnhhkwIsFa64ZWNgFm3RMW1bhp9Q81PmMlDNLvQ1FKEv9WrAnd36yVQ36YldE
yBxBP8nDPrUyfvWyS4mAYfbV83ARXA==
=SrND
-----END PGP SIGNATURE-----

--Sig_/Up4weG3Z39ZovDdlJz62UAq--
