Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeE3Kca (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbeE3Kc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:32:26 -0400
Date: Wed, 30 May 2018 12:32:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>,
        Pavlos Parissis <pavlos.parissis@gmail.com>
Subject: Linux 4.14.46
Message-ID: <20180530103205.GA14214@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.46 kernel.

This release fixes a problem where perf would not build properly in the
4.14.45 kernel release.  If you do not use perf, there is no need to
upgrade at this time.

Many thanks to Pavlos Parissis for finding the problem so quickly and
reporting it.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                       |    2=20
 tools/arch/arm/include/uapi/asm/kvm.h          |    6=20
 tools/arch/arm64/include/uapi/asm/kvm.h        |    6=20
 tools/arch/powerpc/include/uapi/asm/kvm.h      |    2=20
 tools/arch/s390/include/uapi/asm/kvm.h         |    5=20
 tools/arch/x86/include/asm/cpufeatures.h       |  570 +++++++++++++-------=
-----
 tools/arch/x86/include/asm/disabled-features.h |   11=20
 tools/arch/x86/include/asm/required-features.h |    3=20
 tools/include/uapi/linux/kvm.h                 |    1=20
 tools/perf/.gitignore                          |    1=20
 tools/perf/builtin-record.c                    |    9=20
 tools/perf/perf.h                              |    1=20
 tools/perf/util/record.c                       |    8=20
 13 files changed, 340 insertions(+), 285 deletions(-)

Greg Kroah-Hartman (3):
      tools: sync up .h files with the repective arch and uapi .h files
      Revert "perf record: Fix crash in pipe mode"
      Linux 4.14.46

Ravi Bangoria (1):
      perf tools: Add trace/beauty/generated/ into .gitignore


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsOfaAACgkQONu9yGCS
aT5xzQ//eqIlHdsLGJkNIUwc6Foqbsz5846yRy22R05yR/SRJf2VXNkveVJ1eN0p
PnASEwHsIbuHSdZdd0ebgDDX11o5fzk7AM4aECUbM2aflNN0rVk8TZJIqFJvFKSH
YE2SOf0tDuhNeaX7N4WUfNiRBtAH3TVwX1S4/2LxIkZLRsYkLpP19ZpyZygLbqWG
It6KNNBwsu53bhTU4uwRfK77tp3lcl3FfFg4aMCHP0ZylcZAJ2r2n4ORVGj5yJ+6
gdRhoZVxlxRVQsMaM4J5t62VmGtoWzpzHONRH/jowDarYCEBApIsdX+z05osmVP/
2THG/kS3b3c/vTfcT7NR+OzKew4uPhzn5Rsh1/8LKCxXzSTMFmyDGLwUSUFMkf48
Qy9iYXqrq7LOhe4GkWTe+zMzTXb1/ymwGN2xPBIHmLw87k5b764PfulTdASWQ9BK
0XSD0i/WJZrjlDCVg1gZHiYFsOBNkHpBzYJCQTnAwPGMzqt762C1+RW/5Di1gNw+
dxbJHthnfznqu52QWVJ4DoYoP5+T4bvzEwr2ZPQVzbPS1q5rSj3it29FWP2g1Xtq
Nf/pCkL5oHuZtVEbEVL4P615oyJI2NLujZ5tAqnCdL2TmRqungIfA5BwdRiN563W
IDQ/BzUKOz7aCcbDTPMoVKXyOJZyH5DI70e3TVBtJGQpJsP6IL4=
=qZ9v
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
