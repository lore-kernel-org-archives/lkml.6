Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeDXTWa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeDXTWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:22:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0AB217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 24 Apr 2018 15:22:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests: tracing: Update inter-event testcases
Message-ID: <20180424152221.7049b706@gandalf.local.home>
In-Reply-To: <152292049091.15769.13306554953968999494.stgit@devbox>
References: <152292049091.15769.13306554953968999494.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Apr 2018 18:28:11 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> I've fixed a testcase for inter-event extended error
> and added a testcase for multiple actions on trigger,
> which is based on what Tom shown in his mail.
> 
> This series can be applied on Steven's tracing repo.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> ftrace/core
> 
> Tom, could you review it?

Even without Tom's review. I took both patches.

Thanks Masami!

-- Steve
