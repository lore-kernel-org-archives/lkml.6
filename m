Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBBJOM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:14:12 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38722 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBBJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:14:05 -0500
X-Google-Smtp-Source: AH8x225/n4RbGf+zapXy9KkgHZ1O0rMtB/6r2gZjj2JSEJdGYuUO0jUPlqquDInb3Srah3Zn4zxLIA==
From: Andrea Parri <parri.andrea@gmail.com>
To: corbet@lwn.net, stern@rowland.harvard.edu, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: list file memory-barriers.txt within the LKMM entry
Date: Fri,  2 Feb 2018 10:13:42 +0100
Message-Id: <1517562822-6293-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that a formal specification of the LKMM has become available to
the developer, some concern about how to track changes to the model
on the level of the "high-level documentation" was raised.

A first "mitigation" to this issue, suggested by Will, is to assign
maintainership (and responsibility!!)  of such documentation (here,
memory-barriers.txt) to the maintainers of the LKMM themselves.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 On top of: https://marc.info/?l=linux-kernel&m=151748668632046&w=2 

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08454be9237d7..9466907aa4db1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8106,6 +8106,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
 F:	tools/memory-model/
+F:	Documentation/memory-barriers.txt
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
-- 
2.7.4
