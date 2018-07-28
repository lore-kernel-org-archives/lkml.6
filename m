Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4121FC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E003B20873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6oY8Ee0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E003B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbeG1Dta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 23:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389093AbeG1Dta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 23:49:30 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B7820862;
        Sat, 28 Jul 2018 02:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532744692;
        bh=VQy3LhdeLk7rQZzSttR4FNfy4isSz3hNi7RgB1F/bP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F6oY8Ee0NW6gcnbhjEeUWHpTWCmF5nInAB09IADlEF6shXQG/onv8v3qHk04rbjq3
         r/m9a5U1+CkK2ge4w2loeqy06tge0EN9AiZiYWFrIhb9/EVc429rVFkGoH9Z41W6nY
         UBFPPyVxbDY4uj7UTRaHl4xovrjjgBCaHAiFMbq4=
Date:   Sat, 28 Jul 2018 11:24:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v2 3/3] selftests/ftrace: Fix kprobe string testcase to
 not probe notrace function
Message-Id: <20180728112449.cb2b564f2202d2ee1b1d3ce3@kernel.org>
In-Reply-To: <20180727103145.32ab23c9@gandalf.local.home>
References: <153258437722.11602.12405835083073480618.stgit@devbox>
        <153258446365.11602.5245508133014563916.stgit@devbox>
        <20180726164409.c4967698668b1816a8e9747c@kernel.org>
        <20180726155848.5d45aedb@gandalf.local.home>
        <555469b9-a866-60f1-6856-e8bd80f99591@kernel.org>
        <20180727214713.a6e5743c5aa5cb12413af72e@kernel.org>
        <6129a34b-97dc-3e69-cc7d-3e5e9fe95a13@kernel.org>
        <20180727103145.32ab23c9@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 10:31:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 27 Jul 2018 08:26:40 -0600
> Shuah Khan <shuah@kernel.org> wrote:
> 
> > Masami,
> > 
> > The patch isn't in my Inbox. Could you please send it.
> 
> You don't subscribe to LKML? ;-)
> 
> I just bounced it to you.
> 
> -- Steve

Sorry Shuah and Steve,

I've fixed a problem in this patch. I've sent v3 patch to you.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
