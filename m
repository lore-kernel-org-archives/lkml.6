Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83453C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395D2215F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395D2215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbeHOQqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbeHOQqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:46:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BC0215A5;
        Wed, 15 Aug 2018 13:54:15 +0000 (UTC)
Date:   Wed, 15 Aug 2018 09:54:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH 00/24] tools lib traceevent: Rename pevent to tep
 for preparation for library
Message-ID: <20180815095413.42211001@gandalf.local.home>
In-Reply-To: <20180815070459.GC3180@krava>
References: <20180808155548.510187543@goodmis.org>
        <20180810092137.GB14485@krava>
        <20180810090010.4537e14a@gandalf.local.home>
        <20180810131401.GB4162@krava>
        <20180810165706.GH5395@kernel.org>
        <20180814225435.370210d7@vmware.local.home>
        <20180815070459.GC3180@krava>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018 09:04:59 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Tue, Aug 14, 2018 at 10:54:35PM -0400, Steven Rostedt wrote:
> > On Fri, 10 Aug 2018 13:57:06 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >   
> > > > Arnaldo takes care of that, but I guess pulling from branch is the prefered way    
> > > 
> > > I'll try pulling and building it automatically patch by patch,  
> > 
> > Hi Arnaldo,
> > 
> > Were you able to take this? We have another patch series that's ready
> > to go (it can wait till after the merge window though).  
> 
> I see all that in Arnaldo's perf/core branch
> 


OK, cool. I don't have Arnaldo's branch, but was looking for tip pulls.

-- Steve
