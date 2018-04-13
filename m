Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeDMUyJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 16:54:09 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:43630 "EHLO
        15.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeDMUyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 16:54:08 -0400
From: Andi Shyti <andi@etezian.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi@etezian.org>
Subject: [PATCH v2] media: ir-spi: update Andi's e-mail
Date: Fri, 13 Apr 2018 22:48:29 +0900
Message-Id: <20180413134829.18872-1-andi@etezian.org>
X-Mailer: git-send-email 2.17.0
X-Ovh-Tracer-Id: 13058187122059494047
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtgedriedvgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Shyti <andi.shyti@samsung.com>

Because I will be leaving Samsung soon, update my e-mail to the
etezian.org mail.

CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Sean Young <sean@mess.org>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
Hi Sean,

thanks for the review and sorry for the late reply. Here is the
patch with my mail changed also in the MODULE_AUTHOR macro.

Thanks,
Andi

v1 - v2
changed the mail also in the MODULE_AUTHOR macro

 drivers/media/rc/ir-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index 7163d5ce2e64..66334e8d63ba 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -2,7 +2,7 @@
 // SPI driven IR LED device driver
 //
 // Copyright (c) 2016 Samsung Electronics Co., Ltd.
-// Copyright (c) Andi Shyti <andi.shyti@samsung.com>
+// Copyright (c) Andi Shyti <andi@etezian.org>
 
 #include <linux/delay.h>
 #include <linux/fs.h>
@@ -173,6 +173,6 @@ static struct spi_driver ir_spi_driver = {
 
 module_spi_driver(ir_spi_driver);
 
-MODULE_AUTHOR("Andi Shyti <andi.shyti@samsung.com>");
+MODULE_AUTHOR("Andi Shyti <andi@etezian.org>");
 MODULE_DESCRIPTION("SPI IR LED");
 MODULE_LICENSE("GPL v2");
-- 
2.17.0
