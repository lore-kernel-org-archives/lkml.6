Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeELHuq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 03:50:46 -0400
Received: from ozlabs.org ([203.11.71.1]:47965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbeELHuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 03:50:44 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 12 May 2018 17:50:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        0-Day Mailing List <lkp@lists.01.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Linus <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: a new pending-fixes branch
Message-ID: <20180512175041.70f99991@canb.auug.org.au>
In-Reply-To: <87603t1h2s.fsf@purkki.adurom.net>
References: <20180512143523.250ab803@canb.auug.org.au>
        <87603t1h2s.fsf@purkki.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=s/nL1DnZGwh4F=_vWaA4or"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=s/nL1DnZGwh4F=_vWaA4or
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

On Sat, 12 May 2018 10:14:19 +0300 Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Is there a list of branches you use available somewhere? I would like to
> check that wireless-drivers is included.

The current list of trees is always here:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Ne=
xt/Trees

The pending-fixes included trees are all the ones down to
drm-misc-fixes.

--=20
Cheers,
Stephen Rothwell

--Sig_/=s/nL1DnZGwh4F=_vWaA4or
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr2nNEACgkQAVBC80lX
0GyP0Qf+Lu3uIkVFGGw+WHBQHyZOcxY+Mll4DK6RZvRzc82VQYj9sbSc9DH1QYRN
mC/iBbqZVwp3yjQdWxBDHNiixPNeMBC4c/egm5ADn8L5crK+q+cG4kZSkQM7+Ruz
sj6ED+bF6dkhwi5J3B6j0mdDV8PeSSuqO4lZa33D9sBb3WBdhTB7NU0ApE8dpgRW
A/PpoBIXfRinQ4L3nlkZ7VY/EMngaGJfjdoKCLSXjKsaZgbr478xFyhBQ7c5nwuo
aLhymiPW8sRYNkPQcmTg9PPgDZC7FaRmKxPWXsfz4lCmKKu3gVzRQIPEEkXEOh3w
qIiEhmvP7+dGUOEAORumJpnnSeqhHg==
=sG4C
-----END PGP SIGNATURE-----

--Sig_/=s/nL1DnZGwh4F=_vWaA4or--
