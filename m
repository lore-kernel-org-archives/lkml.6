Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeEFLYa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 07:24:30 -0400
Received: from sauhun.de ([88.99.104.3]:37654 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbeEFLYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 07:24:24 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] NTB: ntb_hw_idt: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:50 +0200
Message-Id: <20180506112404.24872-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 8d98872d0983b7..dbe72f116017ab 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1401,7 +1401,7 @@ static int idt_ntb_peer_mw_clear_trans(struct ntb_dev *ntb, int pidx,
  *                          5. Doorbell operations
  *
  *    Doorbell functionality of IDT PCIe-switches is pretty unusual. First of
- * all there is global doorbell register which state can by changed by any
+ * all there is global doorbell register which state can be changed by any
  * NT-function of the IDT device in accordance with global permissions. These
  * permissions configs are not supported by NTB API, so it must be done by
  * either BIOS or EEPROM settings. In the same way the state of the global
-- 
2.11.0
