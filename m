Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29F62147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29F62147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeHQCIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 22:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbeHQCIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 22:08:25 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA68C21470;
        Thu, 16 Aug 2018 23:07:25 +0000 (UTC)
Date:   Thu, 16 Aug 2018 19:07:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] tracing: Add SPDX License format to bpf_trace.c
Message-ID: <20180816190724.7cc823fd@gandalf.local.home>
In-Reply-To: <1e3da13d-39fd-bb19-7e73-e53e118fe877@iogearbox.net>
References: <20180816154817.6e8f0b93@gandalf.local.home>
        <20180816222056.2fddxbzpjox2for4@ast-mbp.dhcp.thefacebook.com>
        <1e3da13d-39fd-bb19-7e73-e53e118fe877@iogearbox.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 00:34:21 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> On 08/17/2018 12:20 AM, Alexei Starovoitov wrote:
> > On Thu, Aug 16, 2018 at 03:48:17PM -0400, Steven Rostedt wrote:  
> >> [ Alexei and/or Daniel, I'm adding SPDX headers to the tracing
> >>   directory. Can you ack this patch? Thanks ]
> >>
> >> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> >>
> >> Add the SPDX License header to ease license compliance management.
> >>
> >> Cc: Alexei Starovoitov <ast@plumgrid.com>  
> > 
> > ohh. did you get a reply from that address? ;)
> >   
> >> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> > 
> > Acked-by: Alexei Starovoitov <ast@kernel.org>  
> 
> Also from my side:
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks!

> 
> +// SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2011-2015 PLUMgrid, http://plumgrid.com
>   * Copyright (c) 2016 Facebook
>   *
> 
> You probably also want to remove that single '*' line as well in your patch.

Done.

-- Steve

> 
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
>   */
> 
> Thanks,
> Daniel

