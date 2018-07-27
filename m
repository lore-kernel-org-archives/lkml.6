Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C462DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87764208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87764208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbeG0Px7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730475AbeG0Px7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:53:59 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE112208B2;
        Fri, 27 Jul 2018 14:31:46 +0000 (UTC)
Date:   Fri, 27 Jul 2018 10:31:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v2 3/3] selftests/ftrace: Fix kprobe string testcase to
 not probe notrace function
Message-ID: <20180727103145.32ab23c9@gandalf.local.home>
In-Reply-To: <6129a34b-97dc-3e69-cc7d-3e5e9fe95a13@kernel.org>
References: <153258437722.11602.12405835083073480618.stgit@devbox>
        <153258446365.11602.5245508133014563916.stgit@devbox>
        <20180726164409.c4967698668b1816a8e9747c@kernel.org>
        <20180726155848.5d45aedb@gandalf.local.home>
        <555469b9-a866-60f1-6856-e8bd80f99591@kernel.org>
        <20180727214713.a6e5743c5aa5cb12413af72e@kernel.org>
        <6129a34b-97dc-3e69-cc7d-3e5e9fe95a13@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 08:26:40 -0600
Shuah Khan <shuah@kernel.org> wrote:

> Masami,
> 
> The patch isn't in my Inbox. Could you please send it.

You don't subscribe to LKML? ;-)

I just bounced it to you.

-- Steve
