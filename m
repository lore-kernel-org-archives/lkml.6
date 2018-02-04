Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeBDKOr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 05:14:47 -0500
Received: from pv33p00im-asmtp002.me.com ([17.142.194.251]:59356 "EHLO
        pv33p00im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBDKOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 05:14:40 -0500
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-02-03_07:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=1 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1802040135
From: Xiongwei Song <sxwjean@me.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        sxwjean@gmail.com
Subject: [PATCH] tracing: Fix incorrect file name
Date: Sun, 04 Feb 2018 18:14:24 +0800
Message-id: <20180204101424.9562-1-sxwjean@me.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no file named 'enabled' in the directory tracing/events. It should
be the file 'enable'.

Signed-off-by: Xiongwei Song <sxwjean@me.com>
---
 Documentation/trace/events.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
index 2cc08d4a326e..1d486660b40f 100644
--- a/Documentation/trace/events.txt
+++ b/Documentation/trace/events.txt
@@ -294,7 +294,7 @@ PID listed in the set_event_pid file.
 
 # cd /sys/kernel/debug/tracing
 # echo $$ > set_event_pid
-# echo 1 > events/enabled
+# echo 1 > events/enable
 
 Will only trace events for the current task.
 
-- 
2.15.1
