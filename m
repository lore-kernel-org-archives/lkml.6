Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeEFIaU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 04:30:20 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:55094
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750961AbeEFIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 04:30:17 -0400
X-IronPort-AV: E=Sophos;i="5.49,369,1520895600";
   d="scan'208";a="264463638"
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Mike Isely <isely@pobox.com>
Cc: kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] media: delete unneeded include
Date: Sun,  6 May 2018 09:58:58 +0200
Message-Id: <1525593538-11340-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pvrusb2-video-v4l.h only declares pvr2_saa7115_subdev_update and
includes pvrusb2-hdw-internal.h.  pvrusb2-cx2584x-v4l.c does not
use pvr2_saa7115_subdev_update and it explicitly includes
pvrusb2-hdw-internal.h.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/media/usb/pvrusb2/pvrusb2-cx2584x-v4l.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-cx2584x-v4l.c b/drivers/media/usb/pvrusb2/pvrusb2-cx2584x-v4l.c
index 242b213..d5bec0f 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-cx2584x-v4l.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-cx2584x-v4l.c
@@ -23,7 +23,6 @@
 */
 
 #include "pvrusb2-cx2584x-v4l.h"
-#include "pvrusb2-video-v4l.h"
 
 
 #include "pvrusb2-hdw-internal.h"
