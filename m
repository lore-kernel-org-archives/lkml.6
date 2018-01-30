Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeA3OX6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:23:58 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40756 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeA3OX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:23:57 -0500
X-Google-Smtp-Source: AH8x226wdwc2UOq8TYW/CdYe8sqaPfwhN1V7GEah9A4VHhGMD7BsdZjfM2VekA/nmxjntPEL7p9HsA==
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2] macintosh: Add module license to ans-lcd
Date: Tue, 30 Jan 2018 08:23:51 -0600
Message-Id: <20180130142351.23511-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 4.15, the modprobe step on my PowerBook G4 started complaining that
there was no module license for ans-lcd.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - fixed typo in commit message
---
 drivers/macintosh/ans-lcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index 1de81d922d8a..c8e078b911c7 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -201,3 +201,4 @@ anslcd_exit(void)
 
 module_init(anslcd_init);
 module_exit(anslcd_exit);
+MODULE_LICENSE("GPL v2");
-- 
2.16.1
