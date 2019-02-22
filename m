Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8436DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5456B20657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfBVTDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBVTDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:03:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD4D20657;
        Fri, 22 Feb 2019 19:03:49 +0000 (UTC)
Date:   Fri, 22 Feb 2019 14:03:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     shuah <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Replace \e with \033
Message-ID: <20190222140346.3171015d@gandalf.local.home>
In-Reply-To: <9da084b1-7f60-ecbd-a956-76d72eb2309d@kernel.org>
References: <20190220161333.28109-1-juergh@canonical.com>
        <20190222091021.10178-1-juergh@canonical.com>
        <20190222091021.10178-3-juergh@canonical.com>
        <20190222235915.bdf82008eef24f8189bd33ec@kernel.org>
        <9da084b1-7f60-ecbd-a956-76d72eb2309d@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 08:59:42 -0700
shuah <shuah@kernel.org> wrote:

> On 2/22/19 7:59 AM, Masami Hiramatsu wrote:
> > On Fri, 22 Feb 2019 10:10:21 +0100
> > Juerg Haefliger <juerg.haefliger@canonical.com> wrote:
> >   
> >> The \e sequence character is not POSIX. Fix that by using \033 instead.
> >>
> >> Signed-off-by: Juerg Haefliger <juergh@canonical.com>  
> > 
> > This also looks good to me.
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Thank you!
> >   
> 
> 
> I wasn't on the To or Cc on the original patch. Make sure to
> run the get_maintainers and include the people it recommends.
> 
> Please resend the patch to me, so I can take it for 5.1-rc1


And add both Masami and my Acked-by when you send it to Shuah (for both
patches).

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
