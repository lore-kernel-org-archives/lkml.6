Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeDXWYp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:24:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:50510 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbeDXWYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:24:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="48814774"
Message-ID: <1524608680.26220.4.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: [PATCH 0/2] selftests: tracing: Update inter-event testcases
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date: Tue, 24 Apr 2018 17:24:40 -0500
In-Reply-To: <20180424152221.7049b706@gandalf.local.home>
References: <152292049091.15769.13306554953968999494.stgit@devbox>
         <20180424152221.7049b706@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 15:22 -0400, Steven Rostedt wrote:
> On Thu,  5 Apr 2018 18:28:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > I've fixed a testcase for inter-event extended error
> > and added a testcase for multiple actions on trigger,
> > which is based on what Tom shown in his mail.
> > 
> > This series can be applied on Steven's tracing repo.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> > ftrace/core
> > 
> > Tom, could you review it?
> 
> Even without Tom's review. I took both patches.
> 

Oops, sorry, completely forgot about these.. 

For both patches:

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks,

Tom

> Thanks Masami!
> 
> -- Steve
