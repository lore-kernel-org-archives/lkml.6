Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79250C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512572186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfB0R4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:56:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfB0R4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:56:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DCDD30BCE61;
        Wed, 27 Feb 2019 17:56:43 +0000 (UTC)
Received: from krava (unknown [10.40.205.100])
        by smtp.corp.redhat.com (Postfix) with SMTP id ADCD34AB;
        Wed, 27 Feb 2019 17:56:41 +0000 (UTC)
Date:   Wed, 27 Feb 2019 18:56:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: Support sample context in perf report
Message-ID: <20190227175640.GB2890@krava>
References: <20190226030412.23485-1-andi@firstfloor.org>
 <20190227111801.GA18893@krava>
 <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
 <20190227161658.GA2890@krava>
 <20190227172954.kithpbfndc5jjg33@two.firstfloor.org>
 <20190227174120.GF13100@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227174120.GF13100@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 27 Feb 2019 17:56:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 02:41:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 27, 2019 at 09:29:54AM -0800, Andi Kleen escreveu:
> > On Wed, Feb 27, 2019 at 05:16:59PM +0100, Jiri Olsa wrote:
> > > On Wed, Feb 27, 2019 at 08:01:35AM -0800, Andi Kleen wrote:
> > > > > > Also available in
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2
> > > > > 
> > > > > your post is missing this patch, it's only in the branch:
> > > > >   perf tools: Add utility function to fetch executable
> > > > 
> > > > Because Arnaldo already merged it. But the branch is still based
> > > 
> > > can't see it on his perf/core branch,
> > > please paste me commit id
> > 
> > I don't know the commit id, but there was an email from him earlier
> > that said "applied". Maybe he hasn't pushed yet.
> 
> Perhaps you're referring to this one:
> 
> commit 94816add0005595ea33fc8456519be582330401e
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Sun Feb 24 07:37:19 2019 -0800
> 
>     perf tools: Add perf_exe() helper to find perf binary
> 
>     Also convert one existing user.
> 
>     Signed-off-by: Andi Kleen <ak@linux.intel.com>
>     Acked-by: Jiri Olsa <jolsa@kernel.org>
> 

this one:
  perf tools: Add utility function to fetch executable
  https://kernel.googlesource.com/pub/scm/linux/kernel/git/ak/linux-misc/+/32e6167f6881c5cfa43a88a9b7fea666d1dbc375%5E%21/


jirka
