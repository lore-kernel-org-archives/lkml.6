Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0CAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC3B2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHPy3YSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC3B2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbeGZOAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbeGZOAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:00:11 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B462083F;
        Thu, 26 Jul 2018 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532609010;
        bh=NwJibk8tqY0ar14Zq923lnR41oU4XDhE9DocW9STXSk=;
        h=From:To:Cc:Subject:Date:From;
        b=oHPy3YSnKmbE3293zGIMQW1DX2mCjJt9WRK2v5GQ4YPNohvV040sOzZFGOnz45SMR
         Lmursgw/Q4B10VobL59n5spWKsaDb37yKOAAJ7ycRMIMMucznd0sofGLPuqsz6pWT8
         n2hfOoT9sGFAgLgK2sE5MdTmzRzEGa24FhYSeb5E=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tracing: doc: cleanup typo and unused code
Date:   Thu, 26 Jul 2018 21:43:06 +0900
Message-Id: <153260898648.12474.8316095450186108842.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are tracing related patches to fix a typo in document and
remove unused functions which I found when improving ftracetest.

Note that those are not bug, just cleanup the source code,
so I don't forward it to stable-ML.

Thank you,

---

Masami Hiramatsu (3):
      doc: tracing: Fix a typo of trace_stat
      tracing: Remove orphaned function using_ftrace_ops_list_func().
      tracing: Remove orphaned function ftrace_nr_registered_ops()


 0 files changed

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

