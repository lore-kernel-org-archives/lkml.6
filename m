Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83867C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4830120870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4830120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeLKRqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKRqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:46:14 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA5232086D;
        Tue, 11 Dec 2018 17:46:13 +0000 (UTC)
Date:   Tue, 11 Dec 2018 12:46:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] tracing: Fix a couple of memory leaks in the event
 trigger code
Message-ID: <20181211124612.58920ceb@gandalf.local.home>
In-Reply-To: <1913c8d0be777a59d59135c067abf270b0594c63.camel@linux.intel.com>
References: <20181210204126.603121253@goodmis.org>
        <1913c8d0be777a59d59135c067abf270b0594c63.camel@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 10:40:19 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Steve,
> 
> On Mon, 2018-12-10 at 15:41 -0500, Steven Rostedt wrote:
> > Tom,
> > 
> > While testing other changes, kmemleak pointed out a few leaks in the
> > trigger code. Can you take a look at them and give me a Reviewed-by
> > or Ack.
> > 
> > Thanks!
> > 
> > -- Steve
> > 
> > 
> > Steven Rostedt (VMware) (2):
> >       tracing: Fix memory leak in create_filter()
> >       tracing: Fix memory leak in set_trigger_filter()
> >   
> 
> Sure, these look fine to me.
> 
> Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
>

Thanks a lot Tom!

-- Steve
