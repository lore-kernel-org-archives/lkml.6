Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbeBBTwu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:52:50 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35797 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbeBBTwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:52:42 -0500
X-Google-Smtp-Source: AH8x225DjPg8B/D6ClNMmFOXfByTFOSkb1tGfyYc1epzrjZyEGcE6TkDGPc6x1m/Jk1/5y5wxuhZXA==
Date: Fri, 2 Feb 2018 11:52:39 -0800
From: Matt Turner <mattst88@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Michael Cree <mcree@orcon.net.nz>, Sinan Kaya <okaya@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, Tobias Klauser <tklauser@distanz.ch>,
        Eugene Syromiatnikov <esyr@redhat.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PULL] alpha.git
Message-ID: <20180202195239.GA15018@ivybridge.mattst88.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Linus,

Please pull my alpha git tree. It contains a few small fixes and clean ups.

Thanks,
Matt

The following changes since commit 8cbab92dff778e516064c13113ca15d4869ec883:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2018-01-16 16:47:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

for you to fetch changes up to 21ffceda1c8b3807615c40d440d7815e0c85d366:

  alpha: fix crash if pthread_create races with signal delivery (2018-01-20 17:01:16 -0800)

----------------------------------------------------------------
Arnd Bergmann (2):
      alpha: osf_sys.c: fix put_tv32 regression
      alpha: osf_sys.c: use timespec64 where appropriate

Eugene Syromiatnikov (1):
      alpha: make XTABS equivalent to TAB3

Michael Cree (1):
      alpha: Fix mixed up args in EXC macro in futex operations

Mikulas Patocka (3):
      alpha: fix reboot on Avanti platform
      alpha: fix formating of stack content
      alpha: fix crash if pthread_create races with signal delivery

Sinan Kaya (1):
      alpha: deprecate pci_get_bus_and_slot()

Tobias Klauser (1):
      alpha: make thread_saved_pc static

 arch/alpha/include/asm/futex.h         |  8 ++--
 arch/alpha/include/asm/processor.h     |  5 +--
 arch/alpha/include/uapi/asm/termbits.h |  6 ++-
 arch/alpha/kernel/osf_sys.c            | 72 +++++++++++++++++-----------------
 arch/alpha/kernel/pci.c                |  2 +-
 arch/alpha/kernel/pci_impl.h           |  3 +-
 arch/alpha/kernel/process.c            |  5 ++-
 arch/alpha/kernel/sys_nautilus.c       |  2 +-
 arch/alpha/kernel/traps.c              | 13 ++++--
 9 files changed, 62 insertions(+), 54 deletions(-)

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO7Y55W+GH6LoZQVpD91oLZdMpyoFAlp0wX0ACgkQD91oLZdM
pyr0/g//WdFtV+zRtEUo9nYzIfhF7YqftkXdUjIgzpzTkElJhNdDJkmNRWzAQP4j
BeFqPKYn5MqP9JKrZ/h8d+ihS4AmQRhBS7i7JU9dRFA6Pk7GzAaUeHA7I80sA8NX
G1dhFHgHEDe4XcjX8NpCUjBvCHpA7wuBR0BLxXh5O0Wld3wg/ocH7b2zTAOUkXmk
v3Nzm9ITfaWFEi+qFluzZSum9BlN7ltSxpsE2y3/SXkmHwZrim2/A9f0TqqPqg4a
5LXrdyPVnG3nXkX85w+jILal+36XgU9j1oT5Zpv8f8zIzsqkYCf0gNbfjxUrQL6O
4vkQmatW/aETZUAsD9jG+eN5Eu+6Wb3Ss4L+cKKSMdgIv+nOJE5bowzEt3zmJ8HE
D0WtAJdmkNVnI/6QD9sPRgUcPVOculq3kmr5IWWxrSW8Tjz/uy/WiyIleAA50VkN
egKll00365VaEwtp2YHqIbekOxmM7POC9id6O/E0qqlH6eZ+unXhBm+IVg+b8N/U
rkanRgprDZ7EEml+6y+RplZ8THEkNO0LsYaj7cUxpVf5ncW6fkEZcoxsauPBFbXg
b+JD7jvXn3UVMJiBpH4IcwCxKeNudUyhBA0yINMkhntIqYBgfO0RTMl+cMMzqN7s
HlIMVp6uSIz8Rpq6TKm/63p/V1uGbCMxtO0Mz4BeGVDSJhhX3Gk=
=lA59
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
