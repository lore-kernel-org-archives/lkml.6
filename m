Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827BDC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB922151B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB922151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeHHXMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:12:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:42113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbeHHXMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:12:42 -0400
Received: from ls3530 ([80.187.96.219]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAVV-1fZwcS0aBN-00MLNX; Wed, 08
 Aug 2018 22:51:13 +0200
Date:   Wed, 8 Aug 2018 22:51:10 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes
Message-ID: <20180808205110.GA3398@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:mz4CoIidVQgxl2ZhizFp6E/FwB0G03IJVNKIWJX6S2XCZmzfoyI
 rnNW3uIO7ucOg1SwtDkegfnXTdbbvFMG+Z3yO2yQSSDS/UtahpzOmsZ3Rs065RG07GB29QX
 mCqYOiiFJcrjnrSorxEIUu/ZB+5ITFeu3NqHzJbsLCHCrN60EXqQeB2ma1Mx5dwjh3k3V94
 BmtMERnan7BK4kz2J3OWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f4U9lsiei4M=:A9rqv2GgT3Om7L1aCfFdel
 3Yk0eAtK9aAPmDDoRCx8E4JIPi24J6kYFDNibis4KrIsNJrNUh/hr4zFoC7Sq21tgTvIro2Bp
 2xSK13MDplxPlEBQBP6RQtMeweVJ/wi0zyp/TPiKo3bTGvOTN8WAMUy/ryTNeyw6MVG8Op9b3
 o16lm9cXZwnV90KI/JZsNMSz9IZrSQleZYxfIL1nbWA2uFjLnWSwcdRFg1MYE+RYfKtO7ARM0
 15Y281N43T8C1hpI35FCYxVkqSWAZ/cmyEXJRzpWXcPixHp6EWSfXK8W0jSyAwGdm0QW78DDN
 SqSjILXZAP9WPq7YxYXMMksp3eSOEnUGSytt7nhyefb80RaGS82n/9rKN2/yCz5KC3r9wN0O/
 l7+AsWKD2OWtExdl4UbIc6+Gra4KQQShQUHJZOPbgv7HwTJy5/UcjtmelGKhD8fDa3/bvXUCS
 sgjARoPwcJ+e/MQxBn3B2qKSDxFZTFN4+RBgOcTsb1lPtKbpF3PYgYCgxxoG++8F4PWycVyYX
 c47lPQWb3zY1JnHTszEU6WG2ffPZ592OSpQE7q0XvDu3IBnroHLjhP8UxYShBJi+wdjbOETKt
 3vLjy/HqNu/8hcW1jOLzUi/PiD4607X5jBZ0xZHLEDDUPs0K8HwuFEEKwa3HIfShgIllMAkXK
 s4rf+fEr29bIvHkHICG3pTarfc6917VGa2ET3eQV6PLHoloRzWJ4jzXQmLfk6U3lDaGMkzjlw
 WPxH6F+aiWxQL5dGSAk2d97+D9Xl4GNEARzJNttp2LMvoPT8eu5OoibZ7co=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

would you please pull two important patches for the parisc architecture for kernel 4.18 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.18-2

The first patch is trivial and fixes the kernel build if someone chooses to
build the generic 64bit defconfig. Alex Ghiti ran into that issue when he tried
to build a 4.18 kernel with his hugetlb patches on parisc64.

The patch from Dave adds missing memory barriers to the assembler unlock
sequences. Our hope is, that this should help us to fix the issues we rarely
still see with spinlocks.

Both patches had been in the for-next branch for a few days without any
reported issues and are tagged to be backported to all kernels above v4.0.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Enable CONFIG_MLONGCALLS by default

John David Anglin (1):
      parisc: Define mb() and add memory barriers to assembler unlock sequences

 arch/parisc/Kconfig               |  2 +-
 arch/parisc/include/asm/barrier.h | 32 ++++++++++++++++++++++++++++++++
 arch/parisc/kernel/entry.S        |  2 ++
 arch/parisc/kernel/pacache.S      |  1 +
 arch/parisc/kernel/syscall.S      |  4 ++++
 5 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 arch/parisc/include/asm/barrier.h
