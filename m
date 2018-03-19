Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755510AbeCSMSw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:18:52 -0400
Received: from mailxx.hitachi.co.jp ([133.145.228.50]:50525 "EHLO
        mailxx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754511AbeCSMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:18:49 -0400
Message-ID: <5AAFA69E.2050007@hitachi.com>
Date: Mon, 19 Mar 2018 21:01:34 +0900
From: KAMEI Hitoshi <hitoshi.kamei.xm@hitachi.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To: idryomov@gmail.com, sage@redhat.com, elder@kernel.org,
        ceph-devel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rbd: add 'thick' sysfs rbd device attribute
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the description of sysfs thick entry.

Signed-off-by: Hitoshi Kamei <hitoshi.kamei.xm@hitachi.com>
Cc: Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index f208ac58d613..3023f39328b1 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -119,3 +119,9 @@ parent

 	Information identifying the chain of parent images in a layered rbd
 	image.  Entries are separated by empty lines.
+
+thick
+
+	Specifying thick-provision image by writing "1" to this file.
+	And, releasing the flag of thick-provision image by writing
+	"0" to this file.
-- 
2.15.1
