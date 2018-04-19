Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeDSADf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 20:03:35 -0400
Received: from ozlabs.org ([203.11.71.1]:33987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752245AbeDSADd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 20:03:33 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 19 Apr 2018 10:02:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jessica Yu <jeyu@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adding modules-linus branch to linux-next
Message-ID: <20180419100221.6e39d072@canb.auug.org.au>
In-Reply-To: <20180418205739.7bvi3hfmhozztbnf@redbean>
References: <20180418205739.7bvi3hfmhozztbnf@redbean>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QHUwvJwfThRqgnbXkMeNe.5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QHUwvJwfThRqgnbXkMeNe.5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

On Wed, 18 Apr 2018 22:57:39 +0200 Jessica Yu <jeyu@kernel.org> wrote:
>
> Could you please add the modules-linus branch at:
>=20
>     git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-=
linus
>=20
> to linux-next? The branch will contain rc fixes intended for the
> current release. A good name for it might be modules-current.

Added from today.  I called it modules-fixes.

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

--Sig_/QHUwvJwfThRqgnbXkMeNe.5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrX3I0ACgkQAVBC80lX
0GwcNAf/ajEon3h10ZzSENQ+6Nu0Lo4WTdP6DbUKqunTrBhF1OfStpoJZkb4aarf
yRQqSnZeOvmlVnaAeXf5c9SQPiStebRXkZMP87K0Gw8lxglyzGBm0FBnUB+wLfkQ
UXKIv+3OSf/4Nkxq/db1SnjmNNsxFjhoWAv9ROczvVYkdbUdVL+dDApv7F+tsiKf
onVx4GdigBj/jWHxfXM3tG2J40tkT8dTHKfq+Q2upbl6lIUzNcUwp9ak7oxpY2Na
qtkKHP6XmEorO3kke89iaz2hQGg2sTX5Hl5/Jrk2IjtC0g7L0idmVi53CP4Kngm/
4DV1zfkaSUSG1qL5Q9g2CIG+9xNNNQ==
=xhXa
-----END PGP SIGNATURE-----

--Sig_/QHUwvJwfThRqgnbXkMeNe.5--
