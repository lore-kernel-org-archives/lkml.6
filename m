Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeDMOoi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750824AbeDMOog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:44:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9BB2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 13 Apr 2018 10:44:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/6] tracing: Add trace event error log
Message-ID: <20180413104432.148f13dc@gandalf.local.home>
In-Reply-To: <1523629474.25328.14.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
        <194bd34e689dd6df9e48855111fd6c5c66e37fc9.1523545519.git.tom.zanussi@linux.intel.com>
        <20180412182001.75bfb4e2@gandalf.local.home>
        <1523577133.11817.31.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180413094515.19fb3691@gandalf.local.home>
        <1523629474.25328.14.camel@tzanussi-mobl.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2018 09:24:34 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Yeah, I agree - I'd rather get it right than get it in now.  I thought
> this made sense, and was based on input from Masami, which I may have
> misinterpreted, but I'll wait for some more ideas about the best way to
> do this.

Too bad we are not closer to November, as this would actually be a good
Plumbers topic. Maybe it's not that important and we should wait until
then. I'd like to get some brain storming ideas out before we decide on
anything, and this is something I believe is better done face to face
than over email.

-- Steve
