Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCZVGP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752004AbeCZVFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:05:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695DB21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 17:05:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH] tracepoint: Provide tracepoint_kernel_find_by_name
Message-ID: <20180326170529.214b7e6e@gandalf.local.home>
In-Reply-To: <20180326204834.npkr26bdf5aprwnv@ast-mbp.dhcp.thefacebook.com>
References: <20180326191031.14939-1-mathieu.desnoyers@efficios.com>
        <20180326204834.npkr26bdf5aprwnv@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 13:48:36 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> 
> Mathieu, that's not enough.
> Commit log is also wrong.
> It needs to state that something like this is needed only because
> changing for_each_tracepoint_range() semantics will break lttng.
> I'll post a follow up patch shortly.

No it does not. This is needed because I find it cleaner. If you don't
want to pull this into your patch set. I'll pull it into mine.

-- Steve
