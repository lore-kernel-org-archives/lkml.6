Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB6CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4359A2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfANQSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfANQSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:18:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7FC220873;
        Mon, 14 Jan 2019 16:18:11 +0000 (UTC)
Date:   Mon, 14 Jan 2019 11:18:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [PATCH v2 0/9] kprobes: Fix and improve blacklist symbols
Message-ID: <20190114111810.79016d7d@gandalf.local.home>
In-Reply-To: <154725993986.18060.2759150647140353514.stgit@devbox>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2019 11:25:40 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the v2 series of kprobes blacklist bugfix and improvements mainly
> on x86 (since I started testing on qemu-x86).
> 
> >From v1, I just removed stable-ml from Cc (but tagged [1/9]) and added  
> Steve's Ack.

Ingo, I acted the ftrace change and also gave a review by to the added
function in kprobes.c.

Since this changes x86, could you take it in your tree?

Thanks!

-- Steve
