Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCUNNN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:13:13 -0400
Received: from hwp1.icoremail.net ([139.162.50.94]:64778 "HELO
        hwp1.icoremail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751608AbeCUNNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:13:12 -0400
From: Guan Xuetao <gxt@pku.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Guan Xuetao <gxt@pku.edu.cn>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] MAINTAINERS: UNICORE32: Change email account
Date: Wed, 21 Mar 2018 21:10:56 +0800
Message-Id: <1521637856-26463-1-git-send-email-gxt@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 84FpogC3Fgz9WbJacemBBg--.6839S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4DtF15KrW8GFWfJr1DZFb_yoWDXrg_J3
        ykJFy7ur48ZrnrAw18tF97tryYv39rWws8WanavanrZan0yrWqq34vk3Wktw47u3W7Wrsr
        ZF13Xr9a93yfWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
        U-_-PUUUUU=
X-CM-SenderInfo: qqqqliixuslio6sn3hxhgxhubq/
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change email account for unicore32 arch and pkunity soc drivers
Since old email server mprc.pku.edu.cn was blocked in recent years

Signed-off-by: Guan Xuetao <gxt@pku.edu.cn>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 205c8fc..5b3f01f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11024,7 +11024,7 @@ F:	include/linux/pktcdvd.h
 F:	include/uapi/linux/pktcdvd.h
 
 PKUNITY SOC DRIVERS
-M:	Guan Xuetao <gxt@mprc.pku.edu.cn>
+M:	Guan Xuetao <gxt@pku.edu.cn>
 W:	http://mprc.pku.edu.cn/~guanxuetao/linux
 S:	Maintained
 T:	git git://github.com/gxt/linux.git
@@ -14269,7 +14269,7 @@ F:	include/linux/uwb.h
 F:	include/linux/uwb/
 
 UNICORE32 ARCHITECTURE:
-M:	Guan Xuetao <gxt@mprc.pku.edu.cn>
+M:	Guan Xuetao <gxt@pku.edu.cn>
 W:	http://mprc.pku.edu.cn/~guanxuetao/linux
 S:	Maintained
 T:	git git://github.com/gxt/linux.git
-- 
2.7.4
