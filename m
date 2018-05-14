Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeENVjh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:39:37 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41612 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeENVjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:39:35 -0400
X-Google-Smtp-Source: AB8JxZrEedlaRBkg5W/DCAOahiz88GliMiYbhFNlJ0TgNgouIp4nwnQ2SR5s9A2nWBanxHJnvy/MWg==
From: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vaibhav Murkute <vaibhavmurkute88@gmail.com>
Subject: [PATCH] drivers: bluetooth: hci_serdev: Removed unnecessary curly braces
Date: Mon, 14 May 2018 14:38:47 -0700
Message-Id: <1526333927-21222-1-git-send-email-vaibhavmurkute88@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl shows a warning for these unnecessary curly braces.
so just removed those curly braces.

Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index e0e6461..a0e9398 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -204,9 +204,8 @@ static int hci_uart_setup(struct hci_dev *hdev)
 		return 0;
 	}
 
-	if (skb->len != sizeof(*ver)) {
+	if (skb->len != sizeof(*ver))
 		bt_dev_err(hdev, "Event length mismatch for version info");
-	}
 
 	kfree_skb(skb);
 	return 0;
-- 
2.7.4
