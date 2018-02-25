Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeBYVsL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 16:48:11 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46663 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeBYVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 16:48:10 -0500
X-Google-Smtp-Source: AG47ELtCYHsI2StNte4sdIclEM76Jo99RCEBoa4A+yf1o3VF/4GPUSGZvWHWvZ4OfTWySNZqbUbUmA==
From: Max Filippov <jcmvbkbc@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] Xtensa fixes for v4.16
Date: Sun, 25 Feb 2018 13:47:32 -0800
Message-Id: <20180225214732.16449-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following two fixes for reserved memory/DMA buffers
allocation in high memory on xtensa architecture.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20180225

for you to fetch changes up to 6137e4166004e2ec383ac05d5ca15831f4668806:

  xtensa: support DMA buffers in high memory (2018-02-16 19:19:54 -0800)

----------------------------------------------------------------
Xtensa fixes for 4.16

- fix memory accounting when reserved memory is in high memory region;
- fix DMA allocation from high memory.

----------------------------------------------------------------
Max Filippov (2):
      xtensa: fix high memory/reserved memory collision
      xtensa: support DMA buffers in high memory

 arch/xtensa/kernel/pci-dma.c | 40 ++++++++++++++++++-------
 arch/xtensa/mm/init.c        | 70 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 93 insertions(+), 17 deletions(-)

-- 
Thanks.
-- Max
