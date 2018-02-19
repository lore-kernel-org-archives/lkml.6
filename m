Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbeBSQAf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:00:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:51912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753009AbeBSQAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:00:34 -0500
From: Nikolay Borisov <nborisov@suse.com>
To: paulmck@linux.vnet.ibm.com
Cc: peterz@infradead.org, dbueso@suse.com, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] memory-barriers: Make sentence more clear.
Date: Mon, 19 Feb 2018 18:00:30 +0200
Message-Id: <1519056030-17882-1-git-send-email-nborisov@suse.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite the final sentence of data dependency memory barrier to express
the 'after' relationship in simpler words.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 Documentation/memory-barriers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a863009849a3..d7bc0132ef5a 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -399,8 +399,8 @@ VARIETIES OF MEMORY BARRIER
      where two loads are performed such that the second depends on the result
      of the first (eg: the first load retrieves the address to which the second
      load will be directed), a data dependency barrier would be required to
-     make sure that the target of the second load is updated before the address
-     obtained by the first load is accessed.
+     make sure that the target of the second load is updated to the value
+     obtained by the first load.
 
      A data dependency barrier is a partial ordering on interdependent loads
      only; it is not required to have any effect on stores, independent loads
-- 
2.7.4
