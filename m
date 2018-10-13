Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E62C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F25020865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F25020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJMJkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbeJMJkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:40:08 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2225C20865;
        Sat, 13 Oct 2018 02:04:54 +0000 (UTC)
Date:   Fri, 12 Oct 2018 22:04:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH] docs: Fix typos in histogram.rst
Message-ID: <20181012220452.57d23a82@vmware.local.home>
In-Reply-To: <20181013013057.10677-1-standby24x7@gmail.com>
References: <20181013013057.10677-1-standby24x7@gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2018 10:30:57 +0900
Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fixes some spelling typos.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  Documentation/trace/histogram.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index 5ac724baea7d..7dda76503127 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -1765,7 +1765,7 @@ For example, here's how a latency can be calculated::
>    # echo 'hist:keys=pid,prio:ts0=common_timestamp ...' >> event1/trigger
>    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...' >> event2/trigger
>  
> -In the first line above, the event's timetamp is saved into the
> +In the first line above, the event's timestamp is saved into the
>  variable ts0.  In the next line, ts0 is subtracted from the second
>  event's timestamp to produce the latency, which is then assigned into
>  yet another variable, 'wakeup_lat'.  The hist trigger below in turn
> @@ -1811,7 +1811,7 @@ the command that defined it with a '!'::
>      /sys/kernel/debug/tracing/synthetic_events
>  
>  At this point, there isn't yet an actual 'wakeup_latency' event
> -instantiated in the event subsytem - for this to happen, a 'hist
> +instantiated in the event subsystem - for this to happen, a 'hist

The first two appear to show that Tom has a faulty 's' key ;-)

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve



>  trigger action' needs to be instantiated and bound to actual fields
>  and variables defined on other events (see Section 2.2.3 below on
>  how that is done using hist trigger 'onmatch' action). Once that is
> @@ -1837,7 +1837,7 @@ output can be displayed by reading the event's 'hist' file.
>  A hist trigger 'action' is a function that's executed whenever a
>  histogram entry is added or updated.
>  
> -The default 'action' if no special function is explicity specified is
> +The default 'action' if no special function is explicitly specified is
>  as it always has been, to simply update the set of values associated
>  with an entry.  Some applications, however, may want to perform
>  additional actions at that point, such as generate another event, or

