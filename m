Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeBAUom (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:44:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39923 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeBAUoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:44:20 -0500
X-Google-Smtp-Source: AH8x224TAQu8VPnh2xjma0Z071P4CyYM34UQlMh7J55OSBpRgqTbAzCe4uC1sY3wjIDXJILbFT9XFA==
From: Corentin Labbe <clabbe@baylibre.com>
To: corbet@lwn.net, linux@roeck-us.net, wim@iguana.be
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/3] documentation: watchdog: remove documentation for ixp2000
Date: Thu,  1 Feb 2018 20:44:11 +0000
Message-Id: <1517517852-35113-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517517852-35113-1-git-send-email-clabbe@baylibre.com>
References: <1517517852-35113-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ixp2000 watchdog driver was removed in commit 065e8238302b ("watchdog: remove ixp2000 driver")

No need to keep its documentation, so remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/watchdog/watchdog-parameters.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 407d013b8643..603140485ac6 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -157,11 +157,6 @@ testmode: Watchdog test mode (1 = no reboot), default=0
 nowayout: Watchdog cannot be stopped once started
 	(default=kernel config parameter)
 -------------------------------------------------
-ixp2000_wdt:
-heartbeat: Watchdog heartbeat in seconds (default 60s)
-nowayout: Watchdog cannot be stopped once started
-	(default=kernel config parameter)
--------------------------------------------------
 ixp4xx_wdt:
 heartbeat: Watchdog heartbeat in seconds (default 60s)
 nowayout: Watchdog cannot be stopped once started
-- 
2.13.6
