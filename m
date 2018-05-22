Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeEVAiq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:38:46 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:36341 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751727AbeEVAin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:38:43 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:982:988:989:1260:1345:1437:1537:1561:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3867:3868:5007:6261:10004:10848:11658:11914:12296:12663:12679:12895:13069:13311:13357:14181:14384:14394:14721:21080:21451:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: plot71_4bf0732e4fd37
X-Filterd-Recvd-Size: 973
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 0/2] scripts: Improve patch recognition
Date: Mon, 21 May 2018 17:38:37 -0700
Message-Id: <cover.1526949367.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch and get_maintainer do properly recognize rename only and
mode-change only patches.  Improve their logic to do so.

Joe Perches (2):
  checkpatch: Improve patch recognition
  get_maintainer: Improve patch recognition

 scripts/checkpatch.pl     |  8 ++++++++
 scripts/get_maintainer.pl | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.15.0
