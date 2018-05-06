Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEFIZS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 04:25:18 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:41033
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750961AbeEFIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 04:25:15 -0400
X-IronPort-AV: E=Sophos;i="5.49,369,1520895600";
   d="scan'208";a="264463429"
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>, Xinming Hu <huxm@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mwifiex: delete unneeded include
Date: Sun,  6 May 2018 09:53:53 +0200
Message-Id: <1525593233-10968-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing that is defined in 11ac.h is referenced in cmdevt.c.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 7014f44..9cfcdf6 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -25,7 +25,6 @@
 #include "main.h"
 #include "wmm.h"
 #include "11n.h"
-#include "11ac.h"
 
 static void mwifiex_cancel_pending_ioctl(struct mwifiex_adapter *adapter);
 
