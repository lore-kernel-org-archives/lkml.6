Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4F8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD6721838
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD6721838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbeHIRUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:20:35 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F4A214FF;
        Thu,  9 Aug 2018 14:55:18 +0000 (UTC)
Date:   Thu, 9 Aug 2018 10:55:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 0/7] tracing: Hist trigger snapshot and onchange
 additions
Message-ID: <20180809105516.41b68a83@gandalf.local.home>
In-Reply-To: <1533826297.1918.2.camel@kernel.org>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
        <20180809104711.7962b340@gandalf.local.home>
        <1533826297.1918.2.camel@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Aug 2018 09:51:37 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> On Thu, 2018-08-09 at 10:47 -0400, Steven Rostedt wrote:
> > On Thu,  9 Aug 2018 09:34:10 -0500
> > Tom Zanussi <zanussi@kernel.org> wrote:
> >   
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> > > Hi,
> > > 
> > > This is v3 of the hist trigger snapshot and onchange additions
> > > patchset.  It's rebased on top of the latest ftrace/core and adds a
> > > few fixes to some handler/action problems I noticed while testing.  
> > 
> > Hi Tom,
> > 
> > How ready is this? I'm still dealing with the fallout of the preempt
> > irqs tracepoint updates, and trying to get that stable before pushing
> > to linux-next. Are you confident that these are solid enough to pull
> > in
> > this late before the merge window opens? Or should I ignore them
> > until
> > the merge window closes and push this for the following release?
> >   
> 
> I wasn't really expecting they'd go into this merge window, so no
> problem ignoring them until the next release..
>

Great, that makes things easier. Can you ping me after the merge window
closes to remind me to take a look at these? Much appreciated if you
do :-)

-- Steve
