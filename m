Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933316AbeCSLcz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:32:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39324 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933039AbeCSLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:32:43 -0400
X-Google-Smtp-Source: AG47ELtLymmDfNnA/d/yVhBI/s5Bb7CMCKQL1ZBd+Ub5sFFE6aoGPcOSEeQHBcdaquDB+uLdVe2stg==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: trailing statements
Date: Mon, 19 Mar 2018 11:32:21 +0000
Message-Id: <20180319113222.6725-3-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319113222.6725-1-paulmcquad@gmail.com>
References: <20180319113222.6725-1-paulmcquad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trailing statements should be on next line

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/bluetooth/hci_ll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 1b4417a623a4..06d859d82de8 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -567,7 +567,8 @@ static int read_local_version(struct hci_dev *hdev)
 	version = le16_to_cpu(ver->lmp_subver);
 
 out:
-	if (err) bt_dev_err(hdev, "Failed to read TI version info: %d", err);
+	if (err)
+	bt_dev_err(hdev, "Failed to read TI version info: %d", err);
 	kfree_skb(skb);
 	return err ? err : version;
 }
-- 
2.16.2
