Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EB6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82EC20839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82EC20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeH3Xr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbeH3Xr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:47:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FADB20835;
        Thu, 30 Aug 2018 19:43:41 +0000 (UTC)
Date:   Thu, 30 Aug 2018 15:43:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, oleg@redhat.com, mhiramat@kernel.org,
        liu.song.a23@gmail.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v9 4/4] perf probe: Support SDT markers having reference
 counter (semaphore)
Message-ID: <20180830154339.1a14e4bf@gandalf.local.home>
In-Reply-To: <20180830185026.GI6097@kernel.org>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
        <20180820044250.11659-5-ravi.bangoria@linux.ibm.com>
        <20180830144531.3011e185@gandalf.local.home>
        <20180830185026.GI6097@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 15:50:27 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Aug 30, 2018 at 02:45:31PM -0400, Steven Rostedt escreveu:
> > 
> > Arnaldo,
> > 
> > I'm going to be playing with some of the probe code which may conflict
> > with these patches, so I would like to pull these in my tree. But this
> > patch requires an Acked-by from you before I can pull it in.
> > 
> > You OK with this?  
> 
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>  

Awesome, thanks Arnaldo,

-- Steve
