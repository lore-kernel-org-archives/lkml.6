Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeCXA0n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:26:43 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:52578 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeCXA0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:26:43 -0400
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Stefani Seibold <stefani@seibold.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jiri Kosina <jkosina@suse.cz>, Sean Young <sean@mess.org>,
        linux-kernel@vger.kernel.org,
        Valentin Vidic <Valentin.Vidic@CARNet.hr>
Date: Sat, 24 Mar 2018 01:26:30 +0100
Message-Id: <20180324002630.13046-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH] kfifo: fix comment
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup unusual formatting in the note about locking.

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 include/linux/kfifo.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index e251533a5939..89fc8dc7bf38 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -41,11 +41,11 @@
  */
 
 /*
- * Note about locking : There is no locking required until only * one reader
- * and one writer is using the fifo and no kfifo_reset() will be * called
- *  kfifo_reset_out() can be safely used, until it will be only called
+ * Note about locking: There is no locking required until only one reader
+ * and one writer is using the fifo and no kfifo_reset() will be called.
+ * kfifo_reset_out() can be safely used, until it will be only called
  * in the reader thread.
- *  For multiple writer and one reader there is only a need to lock the writer.
+ * For multiple writer and one reader there is only a need to lock the writer.
  * And vice versa for only one writer and multiple reader there is only a need
  * to lock the reader.
  */
-- 
2.16.2
