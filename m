Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeCZWjA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:39:00 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:49458 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751866AbeCZWi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:38:59 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1373:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2564:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4659:5007:7809:9025:10004:10049:10400:10848:11232:11257:11658:11914:12043:12555:12760:13069:13072:13311:13357:13439:14093:14096:14097:14181:14394:14659:14721:14764:14777:21080:21433:21451:21627:21691:30003:30022:30054:30070,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: cough67_88973a6966155
X-Filterd-Recvd-Size: 1777
Message-ID: <1522103936.12357.27.camel@perches.com>
Subject: [PATCH] MAINTAINERS: update bouncing aacraid@adaptec.com addresses
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Carroll <david.carroll@microsemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 26 Mar 2018 15:38:56 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adaptec is now part of Microsemi.

commit 2a81ffdd9da1 ("MAINTAINERS: Update email address for aacraid")
updated only one of the driver maintainer addresses.

Update the other two sections as the aacraid@adaptec.com address
bounces.

Signed-off-by: Joe Perches <joe@perches.com>
cc: Dave Carroll <david.carroll@microsemi.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0baa239af29d..b9c597354d93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4391,7 +4391,7 @@ S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethsw
 
 DPT_I2O SCSI RAID DRIVER
-M:	Adaptec OEM Raid Solutions <aacraid@adaptec.com>
+M:	Adaptec OEM Raid Solutions <aacraid@microsemi.com>
 L:	linux-scsi@vger.kernel.org
 W:	http://www.adaptec.com/
 S:	Maintained
@@ -7330,7 +7330,7 @@ F:	include/linux/ipmi*
 F:	include/uapi/linux/ipmi*
 
 IPS SCSI RAID DRIVER
-M:	Adaptec OEM Raid Solutions <aacraid@adaptec.com>
+M:	Adaptec OEM Raid Solutions <aacraid@microsemi.com>
 L:	linux-scsi@vger.kernel.org
 W:	http://www.adaptec.com/
 S:	Maintained
