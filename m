Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbeCOXRB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:17:01 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:57991 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932841AbeCOXQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:16:56 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: arnd@arndb.de, venture@google.com, yuenn@google.co,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] arm: npcm: Modify NPCM7XX machine code
Date: Fri, 16 Mar 2018 01:10:10 +0200
Message-Id: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed patches from:
Arnd Bergmann: https://www.spinics.net/lists/arm-kernel/msg639250.html
			   https://www.spinics.net/lists/arm-kernel/msg639249.html
			   
Modify the NPCM and NPCM7XX configuration and enable L2 cache in 
the DT_MACHINE_START.

Tomer Maimon (2):
  arm: npcm: modify configuration for the NPCM7xx BMC.
  arm: npcm: Enable L2 Cache in NPCM7xx

 arch/arm/mach-npcm/Kconfig   | 40 +++++++++++-----------------------------
 arch/arm/mach-npcm/Makefile  |  4 +++-
 arch/arm/mach-npcm/npcm7xx.c |  2 ++
 3 files changed, 16 insertions(+), 30 deletions(-)

-- 
2.14.1
