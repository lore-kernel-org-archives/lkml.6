Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbeDVJOb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 05:14:31 -0400
Received: from m12-11.163.com ([220.181.12.11]:51931 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752661AbeDVJO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 05:14:29 -0400
From: Chen Lin <chen45464546@163.com>
To: john.stultz@linaro.org
Cc: tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        Chen Lin <chen45464546@163.com>
Subject: [PATCH] time: remove blank space
Date: Sun, 22 Apr 2018 17:13:57 +0800
Message-Id: <1524388437-10992-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowAAHgatYUtxakBMyQQ--.62959S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzPEfDUUUU
X-Originating-IP: [171.213.12.57]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/1tbiXQQwnlWBY1IlRAACsx
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove blank space

Signed-off-by: Chen Lin <chen45464546@163.com>
---
 include/linux/time64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 93d3949..35ce4aa 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -10,7 +10,7 @@ typedef __u64 timeu64_t;
 
 #if __BITS_PER_LONG == 64
 /* this trick allows us to optimize out timespec64_to_timespec */
-# define timespec64 timespec
+#define timespec64 timespec
 #define itimerspec64 itimerspec
 #else
 struct timespec64 {
-- 
2.7.4
