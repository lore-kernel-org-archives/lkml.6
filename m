Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeDAUnU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754516AbeDAUnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:17 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 30/45] C++: Include linux/hrtimer.h from linux/timer.h
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:15 +0100
Message-ID: <152261539582.30503.3206805855407181027.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/timer.h needs stuff from linux/hrtimer.h so include the latter from
the former.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/timer.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 2448f9cc48a3..f99724c1288e 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -7,6 +7,7 @@
 #include <linux/stddef.h>
 #include <linux/debugobjects.h>
 #include <linux/stringify.h>
+#include <linux/hrtimer.h>
 
 struct tvec_base;
 
