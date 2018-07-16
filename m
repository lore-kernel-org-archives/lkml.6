Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712FBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6320B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA6320B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeGPLuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:50:32 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:60157 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbeGPLuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:50:32 -0400
Received: from faui49t (faui49t.informatik.uni-erlangen.de [131.188.42.17])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id D9BDB58C4F6;
        Mon, 16 Jul 2018 13:23:29 +0200 (CEST)
Received: by faui49t (sSMTP sendmail emulation); Mon, 16 Jul 2018 13:23:29 +0200
From:   Andreas Ziegler <andreas.ziegler@fau.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Ziegler <andreas.ziegler@fau.de>
Subject: [PATCH 2/2] Documentation: kprobetrace: document 'trigger' file
Date:   Mon, 16 Jul 2018 13:05:58 +0200
Message-Id: <1531739158-31133-3-git-send-email-andreas.ziegler@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531739158-31133-1-git-send-email-andreas.ziegler@fau.de>
References: <1531739158-31133-1-git-send-email-andreas.ziegler@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the other files are documented explicitly, let's add a
short description for 'trigger' as well.

Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
---
 Documentation/trace/kprobetrace.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index c4aaef7d..8bfc75c 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -81,7 +81,7 @@ Per-probe event filtering feature allows you to set different filter on each
 probe and gives you what arguments will be shown in trace buffer. If an event
 name is specified right after 'p:' or 'r:' in kprobe_events, it adds an event
 under tracing/events/kprobes/<EVENT>, at the directory you can see 'id',
-'enable', 'format' and 'filter'.
+'enable', 'format', 'filter' and 'trigger'.
 
 enable:
   You can enable/disable the probe by writing 1 or 0 on it.
@@ -95,6 +95,9 @@ filter:
 id:
   This shows the id of this probe event.
 
+trigger:
+  This allows to install trigger commands which are executed when the event is
+  hit (for details, see Documentation/trace/events.rst, section 6).
 
 Event Profiling
 ---------------
-- 
2.7.4

