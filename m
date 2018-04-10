Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeDJTtZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:49:25 -0400
Received: from sauhun.de ([88.99.104.3]:43264 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeDJTtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:49:23 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Joe Perches <joe@perches.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 1/2] MAINTAINERS: remove me as maintainer for I2C host drivers
Date: Tue, 10 Apr 2018 21:49:13 +0200
Message-Id: <20180410194914.7268-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of I2C host controller drivers keeps increasing, and although
I had some success acquiring specific driver maintainers, my bandwidth
is by far not enough to act as a fallback for the rest of the drivers.
To reflect this status-quo in MAINTAINERS, add a seperate entry for I2C
host drivers, let the I2C list (= community) be the contact point, and
mark this section as "Odd fixes".

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Changes since v1:
* explicitly state which files from include/linux I keep maintaining
* rename the new section to HOST DRIVERS instead of just DRIVERS
* explicitly state which subdirs belong to the HOST DRIVERS section

 MAINTAINERS | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 342895717506..1fe9149fa062 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6580,15 +6580,25 @@ W:	https://i2c.wiki.kernel.org/
 Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/
+F:	Documentation/devicetree/bindings/i2c/i2c.txt
 F:	Documentation/i2c/
-F:	drivers/i2c/
-F:	drivers/i2c/*/
+F:	drivers/i2c/*
 F:	include/linux/i2c.h
-F:	include/linux/i2c-*.h
+F:	include/linux/i2c-dev.h
+F:	include/linux/i2c-smbus.h
 F:	include/uapi/linux/i2c.h
 F:	include/uapi/linux/i2c-*.h
 
+I2C SUBSYSTEM HOST DRIVERS
+L:	linux-i2c@vger.kernel.org
+W:	https://i2c.wiki.kernel.org/
+Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/i2c/
+F:	drivers/i2c/algos/
+F:	drivers/i2c/busses/
+
 I2C-TAOS-EVM DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.11.0
