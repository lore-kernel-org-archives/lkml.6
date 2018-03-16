Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeCPQso (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbeCPQsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:48:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8706F21742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Mar 2018 12:48:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] kprobe: fix: Add ftrace_ops_assist_func to kprobe
 blacklist
Message-ID: <20180316124840.3e83bbec@gandalf.local.home>
In-Reply-To: <20180316124134.30fa47d5@gandalf.local.home>
References: <1500044315-9508-1-git-send-email-francis.deslauriers@efficios.com>
        <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <20170714142900.1c91949c@gandalf.local.home>
        <CADcCL0i_Rw9dRkrTUXiVK4dXOXD6QsRrBRc_pJ3XB_SyEqPR5w@mail.gmail.com>
        <20180316112517.66bdd85a@gandalf.local.home>
        <229385456.11580.1521217739037.JavaMail.zimbra@efficios.com>
        <20180316124134.30fa47d5@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018 12:41:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yes, kprobes are dangerous. I'm not saying it shouldn't be fixed, I'm
> saying that I don't have time to fix it now, but would be happy to
> accept patches if someone else does so.

And looking at what I replied before for the original patch. It would
probably be a good idea to blacklist directories. Like we do with
function tracing. We probably should black list both kernel/tracing and
kernel/events from being probed.

Did this come up at plumbers? You were there too, I don't remember
discussing it there.

-- Steve
