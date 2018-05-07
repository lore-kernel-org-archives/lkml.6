Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeEGTHb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeEGTH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:07:29 -0400
Date: Mon, 7 May 2018 16:07:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, zhangshaokun@hisilicon.com,
        yao.jin@linux.intel.com, will.deacon@arm.com, ak@linux.intel.com,
        agustinv@codeaurora.org
Subject: Re: [V5 PATCH] perf parse-events: Specially handle uncore event
 alias in small groups
Message-ID: <20180507190727.GC13491@kernel.org>
References: <1525185096-13477-1-git-send-email-kan.liang@linux.intel.com>
 <20180501163340.GB11539@krava>
 <1c2fc5c1-2ad1-8caf-eac6-f08b5f42d7fc@linux.intel.com>
 <20180504182116.GA32709@kernel.org>
 <20180507183930.GA13491@kernel.org>
 <f1da4db7-e620-10a1-8cb2-ad65aecc61ef@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1da4db7-e620-10a1-8cb2-ad65aecc61ef@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 07, 2018 at 03:06:18PM -0400, Liang, Kan escreveu:
> On 5/7/2018 2:39 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, May 04, 2018 at 03:21:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, May 04, 2018 at 01:57:33PM -0400, Liang, Kan escreveu:
> > > > On 5/1/2018 12:33 PM, Jiri Olsa wrote:
> > > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > > > Thanks Jirka.
> > 
> > > > Are you OK with the patch?
> > > > It looks like Jirka has another patch which will touch the same code.
> > > > If it's OK for you, could you please merge the patch? So he can do the
> > > > changes on top of this patch.
> > > Yeah, I'm applying to my perf/core branch and pushing it out now.
> > 
> > So, this will probably break when merging with perf/urgent due to the
> > revert of a patch that touches the parser files, just a heads out.
 
> Yes, it probably be a conflict.
> Do you want me to send a re-base version of this patch after the revert?

That would be nice, please do so.

- Arnaldo
