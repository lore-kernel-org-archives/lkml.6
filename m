Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbeCOXRA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:17:00 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:57990 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932539AbeCOXQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:16:56 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: arnd@arndb.de, venture@google.com, yuenn@google.co,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] arm: npcm: Enable L2 Cache in NPCM7xx
Date: Fri, 16 Mar 2018 01:10:12 +0200
Message-Id: <1521155412-29229-3-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable L2 Cache in Nuvoton NPCM7xx BMC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/mach-npcm/npcm7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-npcm/npcm7xx.c b/arch/arm/mach-npcm/npcm7xx.c
index 5f7cd88103ef..c5f77d854c4f 100644
--- a/arch/arm/mach-npcm/npcm7xx.c
+++ b/arch/arm/mach-npcm/npcm7xx.c
@@ -17,4 +17,6 @@ static const char *const npcm7xx_dt_match[] = {
 DT_MACHINE_START(NPCM7XX_DT, "NPCM7XX Chip family")
 	.atag_offset	= 0x100,
 	.dt_compat	= npcm7xx_dt_match,
+	.l2c_aux_val	= 0x0,
+	.l2c_aux_mask	= ~0x0,
 MACHINE_END
-- 
2.14.1
