Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938246AbeBUPVs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:21:48 -0500
Received: from pv33p00im-asmtp001.me.com ([17.142.194.250]:39625 "EHLO
        pv33p00im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935739AbeBUPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:21:46 -0500
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-02-21_05:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=4 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1802210186
From: Xiongwei Song <sxwjean@me.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        sxwjean@gmail.com
Subject: [PATCH] tracing: Remove redundant subject
Date: Wed, 21 Feb 2018 23:21:25 +0800
Message-id: <20180221152125.5490-1-sxwjean@me.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two consecutive 'we' to represent subject, remove one of the two.

Signed-off-by: Xiongwei Song <sxwjean@me.com>
---
 Documentation/trace/events.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
index 1d486660b40f..813b140cfe2c 100644
--- a/Documentation/trace/events.txt
+++ b/Documentation/trace/events.txt
@@ -878,10 +878,10 @@ The following commands are supported:
   Because the default sort key above is 'hitcount', the above shows a
   the list of call_sites by increasing hitcount, so that at the bottom
   we see the functions that made the most kmalloc calls during the
-  run.  If instead we we wanted to see the top kmalloc callers in
-  terms of the number of bytes requested rather than the number of
-  calls, and we wanted the top caller to appear at the top, we can use
-  the 'sort' parameter, along with the 'descending' modifier:
+  run.  If instead we wanted to see the top kmalloc callers in terms
+  of the number of bytes requested rather than the number of calls,
+  and we wanted the top caller to appear at the top, we can use the
+  'sort' parameter, along with the 'descending' modifier:
 
     # echo 'hist:key=call_site.sym:val=bytes_req:sort=bytes_req.descending' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
-- 
To unsubscribe from this list: send the line "unsubscribe linux-doc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
