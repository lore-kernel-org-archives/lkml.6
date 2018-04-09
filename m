Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeDIJMX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:12:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751688AbeDIJLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:11:11 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH v2 5/9] Input: elantech_query_info() can be static
Date: Mon,  9 Apr 2018 11:10:47 +0200
Message-Id: <20180409091051.2944-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
new in v2, raised by kbuild test robot
---
 drivers/input/mouse/elantech.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index d485664f1563..980dfd7e861e 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1662,8 +1662,8 @@ static int elantech_set_properties(struct elantech_device_info *info)
 	return 0;
 }
 
-int elantech_query_info(struct psmouse *psmouse,
-			struct elantech_device_info *info)
+static int elantech_query_info(struct psmouse *psmouse,
+			       struct elantech_device_info *info)
 {
 	unsigned char param[3];
 
-- 
2.14.3
