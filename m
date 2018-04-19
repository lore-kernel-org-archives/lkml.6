Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeDSSD2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:03:28 -0400
Received: from mail.windriver.com ([147.11.1.11]:49860 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeDSSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:03:27 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] rcu: ensure whatisRCU.txt actually says what RCU is.
Date: Thu, 19 Apr 2018 13:59:36 -0400
Message-ID: <20180419175936.19936-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It came to my attention that the file "whatisRCU.txt" does not
manage to actually ever spell out what is RCU.

This might not be an issue for a lot of people, but we have to
assume the consumers of these documents are starting from ground
zero; otherwise they'd not be reading the docs.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/RCU/whatisRCU.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index a27fbfb0efb8..65eb856526b7 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -1,3 +1,5 @@
+What is RCU?  --  "Read, Copy, Update"
+
 Please note that the "What is RCU?" LWN series is an excellent place
 to start learning about RCU:
 
-- 
2.14.1
