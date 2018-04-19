Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeDSAkk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 20:40:40 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:41226 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeDSAkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 20:40:39 -0400
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Thu, 19 Apr 2018 09:40:33 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH 2/6] tracing: Add trace event error log
Message-ID: <20180419004033.GA13370@sejong>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
 <194bd34e689dd6df9e48855111fd6c5c66e37fc9.1523545519.git.tom.zanussi@linux.intel.com>
 <20180412182001.75bfb4e2@gandalf.local.home>
 <1523577133.11817.31.camel@tzanussi-mobl.amr.corp.intel.com>
 <20180413094515.19fb3691@gandalf.local.home>
 <1523629474.25328.14.camel@tzanussi-mobl.amr.corp.intel.com>
 <20180413104432.148f13dc@gandalf.local.home>
 <20180418183434.34eb10004275c9e89a9e709c@kernel.org>
 <20180418094924.3ad22dbf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418094924.3ad22dbf@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys, :)

On Wed, Apr 18, 2018 at 09:49:24AM -0400, Steven Rostedt wrote:
> On Wed, 18 Apr 2018 18:34:34 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Fri, 13 Apr 2018 10:44:32 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Fri, 13 Apr 2018 09:24:34 -0500
> > > Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> > >   
> > > > Yeah, I agree - I'd rather get it right than get it in now.  I thought
> > > > this made sense, and was based on input from Masami, which I may have
> > > > misinterpreted, but I'll wait for some more ideas about the best way to
> > > > do this.  
> > > 
> > > Too bad we are not closer to November, as this would actually be a good
> > > Plumbers topic. Maybe it's not that important and we should wait until
> > > then. I'd like to get some brain storming ideas out before we decide on
> > > anything, and this is something I believe is better done face to face
> > > than over email.  
> > 
> > OK, sounds good for me too :)
> > My point was that printk buffer is not good place for the parser error
> > of ftrace, nor each sub-features (like hist, trigger, probe_events etc.) 
> > has different place to show it. I just want to unify the user experience
> > over the ftrace UI.
> 
> I totally agree. I just want to make sure that whatever we come up with
> will be well thought out. Perhaps we can wait till November to talk
> about it.

I'm not sure I can go to LPC this year, but definitely interested in
improving error logging for tracing.

Thanks,
Namhyung
