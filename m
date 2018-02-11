Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbeBKScc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 13:32:32 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40314 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeBKScb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 13:32:31 -0500
X-Google-Smtp-Source: AH8x224EtbGiHZNxHyVBs4agrlVmoPVuHxujiBYtuXCYUTVqQIvnCqwwlCSPIusVKhv2kr6PMUF2Ew==
From: Max Filippov <jcmvbkbc@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL] build fix for xtensa architecture
Date: Sun, 11 Feb 2018 10:32:09 -0800
Message-Id: <1518373929-13313-1-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following patch that fixes build for xtensa when KASAN is
enabled.

The following changes since commit d48fcbd864a008802a90c58a9ceddd9436d11a49:

  Merge tag 'pci-v4.16-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2018-02-10 14:08:26 -0800)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20180211

for you to fetch changes up to f8d0cbf28df14b6b6801f027a396fd593971a922:

  xtensa: fix build with KASAN (2018-02-11 09:18:12 -0800)

----------------------------------------------------------------
Build fix for xtensa architecture with KASAN enabled.

----------------------------------------------------------------
Max Filippov (1):
      xtensa: fix build with KASAN

 arch/xtensa/include/asm/kasan.h | 2 ++
 1 file changed, 2 insertions(+)

-- 
Thanks.
-- Max
