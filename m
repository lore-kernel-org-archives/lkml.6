Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967674AbeCALNq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:13:46 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35253 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967592AbeCALNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:13:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180301111339epoutp013344085fbba59f0dcf9b63228eed4f6c~Xx4-exx8O2655426554epoutp01N
X-AuditID: b6c32a38-ac3ff70000001054-96-5a97e06349b9
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Tejun Heo <tj@kernel.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_falcon: clarify license version and use SPDX header
Date: Thu, 01 Mar 2018 12:13:35 +0100
Message-id: <2054548.du6VOAbhqL@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCmnm7yg+lRBstPCVk8u7WXyeLYjkdM
        Fpd3zWGzWP5kLbPF3Nbp7Ba/lh9ldGDz2DnrLrvHplWdbB6HDncwepxs/cbi8XmTXABrFJdN
        SmpOZllqkb5dAlfGwvlXWQreclZ8mLmPpYFxBkcXIyeHhICJxNUNR9i6GLk4hAR2MEos6jsN
        5XxnlHjzcD8LTNWpjl+sILaQwAZGiZMPQyCKvjJKfNx3hREkwSZgJTGxfRWYLSIgK3Fl2kNG
        kCJmgc2MEm33n7OBJIQFPCUWNT8Es1kEVCWmzvrMDGLzCmhKXL55EswWFfCS2LKvnQkiLijx
        Y/I9sCuYBeQl9u2fygph60icPbYObIGEwAI2iRnfFgAVcQA5LhLbVmdAXC0s8er4FnaIsLTE
        paO2EOXNjBLfduxhhqiZwCixZ70QhG0tcfj4Raj5fBLvvvawQvTySnS0QZV4SFy/eB0aKI4S
        7/7sZIIESqzE37uv2ScwysxCcvUsJFfPQnL1AkbmVYxiqQXFuempxYYFJnrFibnFpXnpesn5
        uZsYwQlAy2IH455zPocYBTgYlXh4HfZPixJiTSwrrsw9xCjBwawkwnt6O1CINyWxsiq1KD++
        qDQntfgQozQHi5I4b0CAS5SQQHpiSWp2ampBahFMlomDU6qBse3NvKanqzcHFoglLpsTxLox
        SDn/1Z6P0Q4TFsh96Q//9OrWJutENq/wzDLfLeda1FX2vD22YIHc6qQKzrVFW/Pi9MuftYYY
        r0zcvPHpJZcL08QOz2f3CD4/987TzNScBbw6TbvEag56uU89cLs2m+dHbzzDtrcJZ0Mi2s1W
        huazz9x4+x2rsxJLcUaioRZzUXEiAH/sa3T8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsVy+t9jQd2kB9OjDE53clk8u7WXyeLYjkdM
        Fpd3zWGzWP5kLbPF3Nbp7Ba/lh9ldGDz2DnrLrvHplWdbB6HDncwepxs/cbi8XmTXABrFJdN
        SmpOZllqkb5dAlfGwvlXWQreclZ8mLmPpYFxBkcXIyeHhICJxKmOX6xdjFwcQgLrGCX2HFrH
        DuF8ZZS4/uATK0gVm4CVxMT2VYwgtoiArMSVaQ8ZQYqYBTYzShzufQZWJCzgKbGo+SEbiM0i
        oCoxddZnZhCbV0BT4vLNk2C2qICXxJZ97UwQcUGJH5PvsYDYzALyEvv2T2WFsLUk1u88zjSB
        kXcWkrJZSMpmISlbwMi8ilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMDy3Hdbq28F4
        f0n8IUYBDkYlHl6H/dOihFgTy4orcw8xSnAwK4nwnt4OFOJNSaysSi3Kjy8qzUktPsQozcGi
        JM57O+9YpJBAemJJanZqakFqEUyWiYNTqoEx/A9D1MbH4UqzsqOm799ut2/XVvlFW5wflq7M
        2R9ZvnL9L86irVtPblltePFdoJj+uq+OitNuZB/0krD0uhUxeXGI7mTtCy0VD99mhDu+YevJ
        dHx2caqqSq+6vk/Y587a5XETrVIfJynUtGxziDa6sDOmgC2iholjt07GvccnWWL49/0STxRU
        YinOSDTUYi4qTgQARfrExEsCAAA=
X-CMS-MailID: 20180301111338epcas1p3986304526e78000c4f7b00f7154fc92a
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180301111338epcas1p3986304526e78000c4f7b00f7154fc92a
X-RootMTR: 20180301111338epcas1p3986304526e78000c4f7b00f7154fc92a
References: <CGME20180301111338epcas1p3986304526e78000c4f7b00f7154fc92a@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- clarify license version (it should be GPL 2.0)
- use SPDX header

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_falcon.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_falcon.c
===================================================================
--- a/drivers/ata/pata_falcon.c	2018-01-30 18:00:36.384918948 +0100
+++ b/drivers/ata/pata_falcon.c	2018-03-01 12:04:30.369550503 +0100
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Atari Falcon PATA controller driver
  *
@@ -7,10 +9,6 @@
  * Based on falconide.c:
  *
  *     Created 12 Jul 1997 by Geert Uytterhoeven
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/kernel.h>
@@ -180,5 +178,5 @@ module_init(pata_falcon_init_one);
 
 MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("low-level driver for Atari Falcon PATA");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
