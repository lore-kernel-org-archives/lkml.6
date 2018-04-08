Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeDHUSn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752612AbeDHUSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC202183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201833.827191417@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 04/23] ktest: Comment about other names than just ktest.conf
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0004-ktest-Comment-about-other-names-than-just-ktest.conf.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

ktest.pl will read any file as long as its name is specified as the first
argument on the command line. Comment this fact in sample.conf.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/sample.conf | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index e628e7c8d875..695983a72465 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -1,8 +1,10 @@
 #
 # Config file for ktest.pl
 #
-# Place your customized version of this, named ktest.conf, in the
-# working directory that ktest.pl is run from.
+# Place your customized version of this, in the working directory that
+# ktest.pl is run from. By default, ktest.pl will look for a file
+# called "ktest.conf", but you can name it anything you like and specify
+# the name of your config file as the first argument of ktest.pl.
 #
 # Note, all paths must be absolute
 #
-- 
2.16.3
