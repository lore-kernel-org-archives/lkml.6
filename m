Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeBVKCN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:02:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44670 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753151AbeBVKCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:02:12 -0500
From: Colin King <colin.king@canonical.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] HID: fix spelling mistake, "registred" -> "registered"
Date: Thu, 22 Feb 2018 10:02:07 +0000
Message-Id: <20180222100207.2741-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in hid_err error message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-elan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 803a725785cf..52381d1beba3 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -362,7 +362,7 @@ static int elan_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return 0;
 
 	if (!drvdata->input) {
-		hid_err(hdev, "Input device is not registred\n");
+		hid_err(hdev, "Input device is not registered\n");
 		ret = -ENAVAIL;
 		goto err;
 	}
-- 
2.15.1
