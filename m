Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6633C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FDF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW22tHb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FDF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966900AbeFSQFE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966597AbeFSQFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:05:02 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B3120661;
        Tue, 19 Jun 2018 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424301;
        bh=MZkDM4Sir58IhHbQ2m4SQpBG2rCXqK+ktahtS7LyMVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IW22tHb/YpivnBcKiS+2JM2Da6YVSiYo4UmC0WwXT5r5Yfz/3DAK4vs+EbEFnsbLA
         Oi3co8COV9t8C8SwRXldTtxH1BaLQqgnpTbhKanrbXl8RHkVgAmNyYBBNlsVrSD5HN
         VtOrB+1RG4QG5NJEDOZZ4YKdkZED/RIN3IpjK9v4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH -tip v6 01/27] Documentation/kprobes: Fix to remove remaining jprobe
Date:   Wed, 20 Jun 2018 01:04:38 +0900
Message-Id: <152942427814.15209.6650206464370123166.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove jps from the document, since jprobe is removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/kprobes.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 22208bf2386d..5ae80baf3921 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -474,7 +474,7 @@ error occurs during registration, all probes in the array, up to
 the bad probe, are safely unregistered before the register_*probes
 function returns.
 
-- kps/rps/jps: an array of pointers to ``*probe`` data structures
+- kps/rps: an array of pointers to ``*probe`` data structures
 - num: the number of the array entries.
 
 .. note::

