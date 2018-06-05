Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeFEQvW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:51:22 -0400
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:53279 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751805AbeFEQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:51:21 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2538:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3866:3867:4250:4321:4605:5007:6117:6119:6690:7901:7903:10004:10400:10482:10848:11658:11914:12555:12679:12760:13069:13311:13357:13439:14181:14394:14659:14721:19901:19997:21080:21451:21627:30054:30062:30067,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: moon52_45da5a05eac56
X-Filterd-Recvd-Size: 2168
Message-ID: <d08e49e8f6562c58a63792aa64306d1851f81f4b.camel@perches.com>
Subject: [PATCH] scripts: Use SPDX tag in get_maintainer and checkpatch
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@shadowen.org>, LKML <linux-kernel@vger.kernel.org>
Date: Tue, 05 Jun 2018 09:51:18 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the appropriate SPDX tag to these scripts.

Miscellanea:

o Add my copyright to checkpatch

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl     | 4 +++-
 scripts/get_maintainer.pl | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2d42eb9cd1a5..7aadfded3fe0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1,9 +1,11 @@
 #!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+#
 # (c) 2001, Dave Jones. (the file handling bit)
 # (c) 2005, Joel Schopp <jschopp@austin.ibm.com> (the ugly bit)
 # (c) 2007,2008, Andy Whitcroft <apw@uk.ibm.com> (new conditions, test suite)
 # (c) 2008-2010 Andy Whitcroft <apw@canonical.com>
-# Licensed under the terms of the GNU GPL License version 2
+# (c) 2010-2018 Joe Perches <joe@perches.com>
 
 use strict;
 use warnings;
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 99c96e86eccb..30eca36b4dad 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1,4 +1,6 @@
 #!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+#
 # (c) 2007, Joe Perches <joe@perches.com>
 #           created from checkpatch.pl
 #
@@ -7,8 +9,6 @@
 #
 # usage: perl scripts/get_maintainer.pl [OPTIONS] <patch>
 #        perl scripts/get_maintainer.pl [OPTIONS] -f <file>
-#
-# Licensed under the terms of the GNU GPL License version 2
 
 use warnings;
 use strict;
