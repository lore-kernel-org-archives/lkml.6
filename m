Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeEKWNA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 18:13:00 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41338 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeEKWM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 18:12:58 -0400
X-Google-Smtp-Source: AB8JxZo8zW4Xu/FIMb8rY7pq/r8PPs2OGj1/73tWuJbEGns/JuBLT16iawHXHFBZddoujDAbpVyAng==
From: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vaibhav Murkute <vaibhavmurkute88@gmail.com>
Subject: [PATCH] drivers: bluetooth: hci_serdev: Removed unnecessary curly braces
Date: Fri, 11 May 2018 15:12:32 -0700
Message-Id: <1526076752-5871-1-git-send-email-vaibhavmurkute88@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl shows a warning for these unnecessary curly braces.
so just removed those curly braces.

Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index e0e6461..137c314 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -204,9 +204,9 @@ static int hci_uart_setup(struct hci_dev *hdev)
 		return 0;
 	}
 
-	if (skb->len != sizeof(*ver)) {
+	if (skb->len != sizeof(*ver))
 		bt_dev_err(hdev, "Event length mismatch for version info");
-	}
+
 
 	kfree_skb(skb);
 	return 0;
-- 
2.7.4
