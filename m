Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeDJIn7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:43:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53381 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeDJIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:43:58 -0400
X-Google-Smtp-Source: AIpwx4/ysfAb60Ig2+lupjvd4atOjR0ycF0/Obmq6FrP/551YFD/f+4WOj8JMuxhekgFpr92xM2BzQ==
From: Neil Armstrong <narmstrong@baylibre.com>
To: arm@kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        linux-oxnas@lists.tuxfamily.org, linux-oxnas@groups.io,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Migrate oxnas list to groups.io
Date: Tue, 10 Apr 2018 10:43:45 +0200
Message-Id: <1523349825-1969-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-oxnas migrates from tuxfamily to groups.io for a simpler
administration and maintainance.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d296bd..f846da2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1743,7 +1743,7 @@ F:	arch/arm/mach-orion5x/ts78xx-*
 ARM/OXNAS platform support
 M:	Neil Armstrong <narmstrong@baylibre.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-oxnas@lists.tuxfamily.org (moderated for non-subscribers)
+L:	linux-oxnas@groups.io (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-oxnas/
 F:	arch/arm/boot/dts/ox8*.dts*
-- 
2.7.4
