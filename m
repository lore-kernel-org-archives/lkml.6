Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751766AbeEFIdR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 04:33:17 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:1759 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751209AbeEFIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 04:33:16 -0400
X-IronPort-AV: E=Sophos;i="5.49,369,1520895600";
   d="scan'208";a="264463734"
Date: Sun, 6 May 2018 10:33:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Mike Isely <isely@pobox.com>
cc: kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] [media] pvrusb2: delete unneeded include
Message-ID: <alpine.DEB.2.20.1805061032120.3435@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pvrusb2-video-v4l.h only declares pvr2_saa7115_subdev_update and
includes pvrusb2-hdw-internal.h.  pvrusb2-cx2584x-v4l.c does not
use pvr2_saa7115_subdev_update and it explicitly includes
pvrusb2-hdw-internal.h.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

v2: Make the subject line a bit less generic

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

