Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbeETTed (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 15:34:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:51585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751045AbeETTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 15:34:30 -0400
Date: Sun, 20 May 2018 21:34:14 +0200
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc section mismatch fixes for 4.17-rc6
Message-ID: <20180520193414.GA6452@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:K580FVMUduzHMaL2Zk2oW54h55GctiFCkPDgk3WW5NKgOyVnYxw
 l5DFLW0DDwwAywS8EaBh6mgdSHR/9Czc60GbfoU4ugJjjLcEacmji0GG313wmNiBzaWX/a4
 5QHvb79I9qT9xsTVcOnUeggsvZmgcgsFQer8o9Psbx4s9RX5hXofaI2hhKmb+CvNx5tHwGG
 SvmLWdY3Okyn+cK7tBvKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hz7hD2meMfM=:oqadR6g8NBrRQvjc+cq4LM
 1gRX1WgnFbcLkKkexeUoy2uOtvQd+6qx8QWLRafgWl5h0O10aKceHf/qGFtbJdopVCbsJRvSU
 OnLb2aUqG+iUR5pEFd8ovw7GO8OHWPrxQRyBS5LytMDh3WFqupIegTHfC39+BmqlkjghtpU6v
 kFv3OwHh9UycF9/iNuxvrMDxcMVDhqDixFxpBfsNur17IJlKWZHGBDSsr/mYFKhBvMYl53DEW
 mDBRBe3ykMAxWaai2g5vgGKj8WcGMyYWesGQ/t05JazkYlmuMMATq7bTG2SYdTQH18lpRh0zF
 dEDONFgR7Yh5MTg6gZPjqLHBFw5HhQTsQyGfJsaTCzyl3WXTC1ll32klOieZZX5kEYWYSWd8U
 xOmW7tdrV3d8oKhbiJo094PUHnjOF0wd970BfGTS7DyJPiPgmf4esn/VdINZkX8noA62aB6DP
 zoilphVl3Wmi6rRLUExSNdB8RAgTP2jWwBgLkffe7d6tIOOSUf/zZK9qwVXLSYdfJ7gz0+1Ue
 Y1KAHRGNf3cGulUy2jAMuuIfMub303KGQcHeqc5CKO9lZ3Uwd4mZXGcgDwJkfIwFozslLDELK
 xVqj4hvfY1UikGjb81WZY5X5Yj4kJoLOdCjR5HBeMxTWgb50tnW/5MR1/4TfjLj6rY89HyPfQ
 E0p99zhputNoolLy2uMqyICrnW/iVwNSXN7rNnC3idN4z46LwjzVbRPIV5S7Qj+vXP6hbYqyW
 qWCbOq3UfSHZYW8ZO8xp2daHbGT8Ullh6hekgo43m0SAAFJWV6mwOfxKwIQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three small section mismatch fixes for the parisc architecture from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.17-5

Three small section mismatch fixes, one of them was found by 0-day test
infrastructure.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (3):
      parisc: Move find_pa_parent_type() out of init section
      parisc: Move setup_profiling_timer() out of init section
      parisc: Move ccio_cujo20_fixup() into init section

 arch/parisc/kernel/drivers.c | 2 +-
 arch/parisc/kernel/smp.c     | 3 +--
 drivers/parisc/ccio-dma.c    | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)
