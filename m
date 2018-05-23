Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeEWECV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:02:21 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43086 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeEWECT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:02:19 -0400
X-Google-Smtp-Source: AB8JxZqkTVn5ETioNIt9Pn4TX6lefZWZCfIQUEQ5W3QqAhOpgozrObxs7XD4Ily+v4rcdumdlX7fug==
Date: Tue, 22 May 2018 21:02:17 -0700
From: Matt Turner <mattst88@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Sinan Kaya <okaya@codeaurora.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PULL] alpha.git
Message-ID: <20180523040217.GA6512@ivybridge.mattst88.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull a few small changes for alpha.

Thanks,
Matt


The following changes since commit c61a56ababa404961fa769a2b24229f18e461961:

  Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2018-04-29 10:06:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

for you to fetch changes up to 92d7223a74235054f2aa7227d207d9c57f84dca0:

  alpha: io: reorder barriers to guarantee writeX() and iowriteX() ordering #2 (2018-05-22 18:10:36 -0700)

----------------------------------------------------------------
Christoph Hellwig (2):
      alpha: use dma_direct_ops for jensen
      alpha: simplify get_arch_dma_ops

Sinan Kaya (1):
      alpha: io: reorder barriers to guarantee writeX() and iowriteX() ordering #2

 arch/alpha/Kconfig                   |  1 +
 arch/alpha/include/asm/dma-mapping.h |  8 ++++++--
 arch/alpha/kernel/io.c               | 14 +++++++-------
 arch/alpha/kernel/pci-noop.c         | 33 ---------------------------------
 arch/alpha/kernel/pci_iommu.c        |  4 +---
 5 files changed, 15 insertions(+), 45 deletions(-)

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO7Y55W+GH6LoZQVpD91oLZdMpyoFAlsE58UACgkQD91oLZdM
pyoH0RAAjH0zXHAixaRf1rrKhXtytCnW/Zwv/XcrewOnbJFVWUmjJi5iIg+Nbooi
7WVfpf2f843FMG55/Ie/KVA3f5VA9NdHvOJ5tNBq3Nj2oi+K0PBr7il+DOCRWIWE
yMWa/hcjw1aoO7nWsqodKYtn/X44yY1KRxUcrPtW1Mrzy6XYDaJxlkCLiWMrEvXe
2YjU9UKHRusvPaVJAemYU++qnAoUbnu2nlnk/3J+txTQLUGc0oPcqYkp5fhfOneR
9L+k3XLenvsZWwdcvhR/rghoL16spVaS7bkeIFtZCs3HWqnNTBo7fo2ulXT221ei
ERpBfQPyf9vhWx+w5tyKSrDXQbNnaWFFNeDA0oe/JsPP+krW1JgEtD1uE8pbqrx+
5gsSSreF974MzOIXLFJt8yaWisnWHTBny0PSWkexx/QwfOFH8rzl/QCjgxe/X4re
BdjYTzIPMFPtGWWnqxsmq3YxpgncpNtubgzDcUtsLuuxqyhwylmRqQCNXIgg+2GU
FqUmAGBI4EqqAGaP7eB7WjefshxxS7ETOUQ0alm3ilarsb2rXp7nP9j35dHFN9xL
UedwzJAULLm/WRS/O8m3b8SoJ5mRlZk6kFAojIxpdfqrHgB7+3BvpUOPsMwC/cao
MeRPOW+URajpGp6hVVRlKofY0pRsN26Al8qeW+Xh6qvmWtyPYAE=
=eVuD
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
