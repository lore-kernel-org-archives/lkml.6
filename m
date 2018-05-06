Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeEFLZZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 07:25:25 -0400
Received: from sauhun.de ([88.99.104.3]:37638 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeEFLYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 07:24:21 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ville Syrjala <syrjala@sci.fi>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] input: ati_remote2: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:49 +0200
Message-Id: <20180506112404.24872-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/input/misc/ati_remote2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index ded5b84e336dae..d8fd58fdf05086 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -22,7 +22,7 @@ MODULE_LICENSE("GPL");
 /*
  * ATI Remote Wonder II Channel Configuration
  *
- * The remote control can by assigned one of sixteen "channels" in order to facilitate
+ * The remote control can be assigned one of sixteen "channels" in order to facilitate
  * the use of multiple remote controls within range of each other.
  * A remote's "channel" may be altered by pressing and holding the "PC" button for
  * approximately 3 seconds, after which the button will slowly flash the count of the
-- 
2.11.0
