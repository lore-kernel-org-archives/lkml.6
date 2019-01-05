Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F21C43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952B62087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfAEKkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:40:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:44049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAEKkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:40:17 -0500
Received: from ls3530.dellerweb.de ([92.116.168.54]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSdz2-1gpjoq2v6S-00RaSH; Sat, 05
 Jan 2019 11:40:08 +0100
Date:   Sat, 5 Jan 2019 11:40:05 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fix for kernel v4.21
Message-ID: <20190105104005.GA32301@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:0vp5Sg3VSx2hk/tZU4glD8Fhw67I5UG3P7U3A44V+wrOMdi2aCO
 NcYIjSkMJZpEbtShtrQYo2MsWoraMEfb9x749QK1vYQyux5Mi4F7HGwhFayPrZ9JozxYkdK
 p9B1npxXfY98GV0srhTUgmGcYnjBXftWZY8Gu3Auu7npu8LvY8Mly3fXvNYKxjXXufxiPTs
 eAK/aPPglhqpgBlkeTrpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XaYniCaNWXM=:7Ij5cJCCoFVOQ8igbfwm5N
 5BnzRP0jJ5bcZkpm0VuLnRRv/q4NUt7fwmEQZfxM4Xs2d0BTs70UInS5+eAS6zySOqemNyIFK
 tZleX2Wqt06rVWdV7IJ3DNY3VvdD2M0wbO/qtWCrZ/ktB0tQAx2aHcOgtDxZTZnhLXIoJwxFD
 weJB0+bn/IlFBddFW21Zp+qqcVP4oNGiX87smEikNMtALWlgCqKHtLSrnk/NE55h3xYnH1/qa
 3SXj5R2svKHy4k6DEZWDtnyGbceiwqdvNHluozzevMk0aY3NUM6416Qz48EZQTosLPxhkpyuL
 TSlD9BzaxC3bKxG5FYqZaBDALvAFAmCAyuDP88uAFrf8jAYiblPz4xQdfFqLlsVQvV3pRu0A2
 /v7I7NocbyncQ8SCB+pHyjNQfMOPUVbGKDREN2RHzDwbL3cjaYnCVORSRE/XzzAJ3KRBNyU+k
 IySvxk38K23ULBbVYuC1xxIzKASuX+yJ9jTQ5mjEhHTnIhO0occaBtSt/p7+D4bH38zKDV/0z
 3PTF8P9U93qBCFJzt7ppAhXVFsb7VfN8QceA9+0XxDb6QhZmU1MK2yUSiTDYmkNGg604MawpH
 VzR/MibTKHMKNSfnwkhduyNkJkePu0+2eeFTROg3qVmMUC+R65HYFPjwzXXixWSQkE+EgyV1E
 rcBtQDtSoa37+xw6xAOd4GYCx9afDx0jb1Pb558QCMSdej5uITBC2j98g7zLjApXOXIb57gS6
 81XUv3pPPS71EcZP3PCa6kcJEF3A0gaPFZF08G5PZYIn9kGaA0HSBrVftLTqfQEI08vEL9EgM
 a8Qttc8slApqYHvxAbsdwpVDcjl1bA6B+P8WyPJJXWfXH11LlenVCjSrT7gg6VjsBCQpUls5p
 ehtBoWL3392GPYLcMDoe6unxsej69tkKqOjuc3oGY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one more patch for the parisc architecture for 4.21-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.21-2

Fix boot issues with a series of parisc servers since kernel 4.20.
Remapping kernel text with set_kernel_text_rw() missed to remap from
lowest up until the highest huge-page aligned kernel text addresss.
    
Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Remap hugepage-aligned pages in set_kernel_text_rw()

 arch/parisc/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
