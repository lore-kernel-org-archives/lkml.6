Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeD3HWg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:22:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36849 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeD3HWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:22:33 -0400
X-Google-Smtp-Source: AB8JxZq/l2EP9rBMvBG7/k9xA0Ll8xU4TEFU408QJExbCItlLqEClYZcYaeGf3q7gUmCL3HX5mLA2A==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com
Subject: [PATCH 2/3] nds32: To refine readability of INT_MASK_INITAIAL_VAL
Date: Mon, 30 Apr 2018 15:20:40 +0800
Message-Id: <ec252c56d4e56b769a57e4a91ddd9dfdd440d641.1525072600.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <a42871ba8088e343cdfd405426ea25e5727116af.1525072600.git.greentime@andestech.com>
References: <a42871ba8088e343cdfd405426ea25e5727116af.1525072600.git.greentime@andestech.com>
In-Reply-To: <a42871ba8088e343cdfd405426ea25e5727116af.1525072600.git.greentime@andestech.com>
References: <a42871ba8088e343cdfd405426ea25e5727116af.1525072600.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refine readability of INT_MASK_INITAIAL_VAL with meaningful macro instead
of magic number.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/bitfield.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index c73f71d67744..28b7d797fd59 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -336,7 +336,7 @@
 #define INT_MASK_mskIDIVZE	( 0x1  << INT_MASK_offIDIVZE )
 #define INT_MASK_mskDSSIM	( 0x1  << INT_MASK_offDSSIM )
 
-#define INT_MASK_INITAIAL_VAL	0x10003
+#define INT_MASK_INITAIAL_VAL	(INT_MASK_mskDSSIM|INT_MASK_mskIDIVZE)
 
 /******************************************************************************
  * ir15: INT_PEND (Interrupt Pending Register)
-- 
1.9.5
