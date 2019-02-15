Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D56321929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437022AbfBOM2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:28:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:37663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbfBOM2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:28:30 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LZzY9-1hMEm90UPd-00lmbI; Fri, 15 Feb 2019 13:28:29 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2 4/4] chardev: update comment based on the code
Date:   Fri, 15 Feb 2019 20:27:14 +0800
Message-Id: <20190215122714.28842-4-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215122714.28842-1-cgxu519@gmx.com>
References: <20190215122714.28842-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JANIsnEaDaHcePR1uQXq1zE51XpIfxqTUi4CGeRsD50QXLEwbk/
 y4Ln7Wg938Jsa7lZU+vdTvejEQ4lccLNmAuPuRrrO4qsCrWpZVqJ1eK92YGQPUOJxhc9uxs
 78PLVM/4yhkIRyDDUz38ERGh518QK8Z0HBThy0Nn2tU2i0nYZzgfb+HuAWWJbiJWyVBvsi+
 r4zcFPDVFJmB4JydAx25g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ct0mahYv3HA=:fOv3IUkEFTnEkXAjyuX6L0
 TNK1IZM/vfMvxHt6RbZZakgPov3hfpyuXJLHURFsbWVez5fiH0f3VybpaTWUKxGuWkyjovD0L
 JUB4v8EiP6mkXsp7gzzxbbjQdURuvlVhnR4t0G09UaViisgU4uJs1eWmNnBcFyJktDGS2YUR5
 qQyrVOOiKBeuiqeW5eLkxa+tWIEdG2L4LZHAKBiF/KAzygk0w1XhZDgIEMzsybfeVUbyRwKl7
 WNTwALVo/FsoX+UaCfAtIJ6JYJMI5AWH2kdC+rzkq8G62z04gtYSQ2B2IlvmEE7Sk8xQ0eOG7
 rgij7qQrDSHaeuVEtzBB4/RKJuHaZ3LT5hNeW8p3x25e84yJ99aJFmK6xVDyWTiYj6BZqJE9E
 hx/go4M2Fs3CF1awIoMF/3KjoRsAGrZFNf3P6hbPvfH2RB3voFSJZXn3LxehPnyw0wqHkCHeg
 VWSJVVB6ASalPR0peT8aeaCeoVEJq23KrDs4OsKxqDvb1snkosD6pyCp6ZQ0joJO7GOm7bHK2
 xjTeQpHnL7s3ZHXzuQNsbizQYfOBD7IJKIAN8IFuNkrVOtVHJW1ne20/TwbPOOCa7jax5BpOG
 5Wm+f4giDsBXYIYHYTNU5c4GYumpwJ99ubDXgrAeWJpbSd42nEZStdorUmAiar6dbD5pJ7lO/
 c1ozMbH1lbEP8zjDGiU7zqfrcSCHvfJAjgiJQ1OvCiGEOEzGvF3nYbTcOtJ7Gu4bMqCnGrCHX
 TcbtUIy1Hxfe/vNt6ly/WVqjXon6UO7wlRdfoYY8n5TWClqW/CdI6dWGmL2X6cYisKZdpTCxP
 mcqiCGzlQwBYvJ/wrJxX+m9t9s0y1/uq48QIMu0vHLf01l1HQbnmGt8mOfe+ZgQDEMlPGMBMJ
 k0ANXOKse8Y7whpof8n9DxAA2n8/8q7uQUSuYfKBQmWEwhf3OfcysZ7vtyknus
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function comment of __register_chrdev_region()
is out of date, so update it based on the code.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
v1->v2:
- Split fix and cleanup patches.
- Remove printing minor range in chrdev_show().

 fs/char_dev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index bd2bf1fd847e..d18cad28c1c3 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -88,13 +88,10 @@ static int find_dynamic_major(void)
 /*
  * Register a single major with a specified minor range.
  *
- * If major == 0 this functions will dynamically allocate a major and return
- * its number.
- *
- * If major > 0 this function will attempt to reserve the passed range of
- * minors and will return zero on success.
+ * If major == 0 this function will dynamically allocate an unused major.
+ * If major > 0 this function will attempt to reserve the range of minors
+ * with given major.
  *
- * Returns a -ve errno on failure.
  */
 static struct char_device_struct *
 __register_chrdev_region(unsigned int major, unsigned int baseminor,
-- 
2.20.1

