Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeECQyS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:54:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:37951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeECQyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:54:14 -0400
Date: Thu, 3 May 2018 18:54:00 +0200
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc fixes for 4.17-rc4
Message-ID: <20180503165400.GA6897@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:AqrPFRq7HdDaPiMHCqRngWd/jaKIdqlSaXNCqCxGzuPMEtLhXeO
 NbhDQdu5W//sO4LuLfo9fqVorES/JWbD+Ovrcn6ARb8HX62kbc4e+LSMOJ5oIfBKvox9Lsj
 de70OmPHh95foASJ70W9CtgJqF3KdPhZIM2U6Nxb4FxMR9hbKcxaL7AGdJX56IzQEVEnuox
 sfhGdCAbdkT37nYWXCugA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yOGlHZzQ3D8=:K6EYqeBmNlRIcFERfMdRWA
 dIEylfymIRoSZgGW4/0SFtasQtdKoj1YvYuIe+WR99HdYzUkQhvPPexG46F8iYgdH5ty7TF+r
 IB+GPJQwCSknuAzvq9xM9sUxmC6m+mhspIg2ehRo87f139CL5czO4abQIiC+UnmqQVQ9jBlLc
 lqyQGjbw1s4rCdAYoC5bUwE+miH70CZ3fcPHO/Fpy5ZybQ4OOAJsSTnBStjurUVVmjuq04v8f
 YUqKvrhyaSWr+QDcgsjrzTOc//Lsprdxj7uqPM7jbWNrNqe/cMRdqaA4yjIf8RFNxV9nDJCeT
 K5XVkf20o5gsaVx/LwFeN8PjsTlFxbmco5YUj/lNnomyypUmVXvyryzxCncfis+sTi60eigTB
 kpTxDH02rF0TWLS/Wn7/BYFgUZkn6h0nulTMZgHft6D0eWcZmDQU1iRWZMdNvn35latgZtK3K
 ygkieG56/4LTqN7SQoE2bx1ChXMbGXg50PU+t0ptvha7qPuRbIv5TOxF20seBXd7qI4tcO3z0
 BeYGpJw1dUUoukAwblkrlzCu7c0oo/Dbn1lNSyMFN+iMXC6yIn/Ljm8Aaya3q6i8Q/C7mh8uU
 etZtrJiDwUpBy+JneQVy/9FpG8QodBwguYs0SkY2PEHIjSCsg/9IfROVFgvxZ/TYnTBTcdXvt
 zxMmfrijEKaXhfffL6wdz+ZSHRHj3FJPLJFE9PPZRUvuQYwhG0VAm6B/gSI1CvyYAPbdO+p6I
 AfKStTr8qpN0eUiWPRNerpgVh/kgu6ssqNeUOctq3/Re/zOlEjw5rG02RkI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few fixes and documentation updates for the parisc architecture from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.17-4

Fix two section mismatches, convert to read_persistent_clock64(), add further
documentation regarding the HPMC crash handler and make bzImage the default
build target.

Thanks,
Helge

----------------------------------------------------------------
Baolin Wang (1):
      parisc: time: Convert read_persistent_clock() to read_persistent_clock64()

Helge Deller (4):
      parisc: Make bzImage default build target
      parisc: Document rules regarding checksum of HPMC handler
      parisc: drivers.c: Fix section mismatches
      parisc: Fix section mismatches

 arch/parisc/Makefile         |  3 +++
 arch/parisc/kernel/drivers.c |  7 ++++---
 arch/parisc/kernel/pci.c     |  2 +-
 arch/parisc/kernel/time.c    |  2 +-
 arch/parisc/kernel/traps.c   | 11 +++++++++++
 arch/parisc/mm/init.c        |  2 +-
 drivers/parisc/ccio-dma.c    |  2 +-
 7 files changed, 22 insertions(+), 7 deletions(-)
