Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D6CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C9D2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C9D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeK2OuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeK2OuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:50:23 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F5462081B;
        Thu, 29 Nov 2018 03:46:28 +0000 (UTC)
Date:   Wed, 28 Nov 2018 22:46:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 00/12] tracing: Unifying dynamic event interface
Message-ID: <20181128224626.6fc4572b@vmware.local.home>
In-Reply-To: <ff8ca3062cad3747a664e6888790cc3c58e24c7e.camel@linux.intel.com>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
        <20181128163101.d86844338bcba3fc3b0580f1@kernel.org>
        <ff8ca3062cad3747a664e6888790cc3c58e24c7e.camel@linux.intel.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 17:42:22 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Masami,
> 
> On Wed, 2018-11-28 at 16:31 +0900, Masami Hiramatsu wrote:
> > Ping?
> > 
> > Hi Tom,
> > 
> > This series, especially [09/12] tracing: Remove unneeded
> > synth_event_mutex
> > will effect your current working series. Please tell me your opinion.
> >   
> 
> Sorry for the delay in reviewing this - I completely forgot about it in
> my inbox.
> 
> It's all very nice, and the mutex updates along with the dyn_event
> management make that part of the code much cleaner, thanks!
> 
> In any case, you can have my
> 
> Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
>

Thanks Tom! I'll take a look at this tomorrow.

-- Steve
