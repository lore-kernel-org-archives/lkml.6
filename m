Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeBRUn4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 15:43:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51521 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbeBRUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 15:43:54 -0500
X-Google-Smtp-Source: AH8x2265x8dqFvhKiPG78S/EIPHfg2f/hPYP4/vBebZ1JK3klTMwpUzS3ZoLp11ZiasTHX5xFKImzw==
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: linux-leds@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH] MAINTAINERS: Remove Richard Purdie from LED maintainers
Date: Sun, 18 Feb 2018 21:42:32 +0100
Message-Id: <1518986552-4289-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard has been inactive on the linux-leds list for a long time.
After email discussion we agreed on removing him from
the LED maintainers, which will better reflect the actual status.

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e458da6..1ce261c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7909,7 +7909,6 @@ S:	Maintained
 F:	scripts/leaking_addresses.pl
 
 LED SUBSYSTEM
-M:	Richard Purdie <rpurdie@rpsys.net>
 M:	Jacek Anaszewski <jacek.anaszewski@gmail.com>
 M:	Pavel Machek <pavel@ucw.cz>
 L:	linux-leds@vger.kernel.org
-- 
2.1.4
