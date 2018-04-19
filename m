Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeDSOgv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752628AbeDSOgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:36:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68152170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 19 Apr 2018 10:36:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH 2/6] tracing: Add trace event error log
Message-ID: <20180419103645.5e244e22@gandalf.local.home>
In-Reply-To: <20180419004033.GA13370@sejong>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
        <194bd34e689dd6df9e48855111fd6c5c66e37fc9.1523545519.git.tom.zanussi@linux.intel.com>
        <20180412182001.75bfb4e2@gandalf.local.home>
        <1523577133.11817.31.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180413094515.19fb3691@gandalf.local.home>
        <1523629474.25328.14.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180413104432.148f13dc@gandalf.local.home>
        <20180418183434.34eb10004275c9e89a9e709c@kernel.org>
        <20180418094924.3ad22dbf@gandalf.local.home>
        <20180419004033.GA13370@sejong>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 09:40:33 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > I totally agree. I just want to make sure that whatever we come up with
> > will be well thought out. Perhaps we can wait till November to talk
> > about it.  
> 
> I'm not sure I can go to LPC this year, but definitely interested in
> improving error logging for tracing.

Feel free to send any ideas to us that you would like for us to add to
this discussion.

-- Steve
