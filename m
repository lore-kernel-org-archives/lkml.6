Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3052420859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAQOUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:20:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbfAQOUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:20:45 -0500
Received: from vmware.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C50820856;
        Thu, 17 Jan 2019 14:20:44 +0000 (UTC)
Date:   Thu, 17 Jan 2019 09:20:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobes: Fix output for multiple string
 arguments
Message-ID: <20190117092042.4f689462@vmware.local.home>
In-Reply-To: <20190117165807.64e95553ff397e7f73ba495b@kernel.org>
References: <20190116084021.34b0beee@gandalf.local.home>
        <20190116141629.5752-1-andreas.ziegler@fau.de>
        <20190117150107.17f2c0c37e41126120c5eebb@kernel.org>
        <b5defce3-b52a-db20-bfd1-81eec9972fab@fau.de>
        <20190117165807.64e95553ff397e7f73ba495b@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 16:58:07 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Ah, I got it.
> Hmm, in that case, I have to update my patch in the previous mail.
> Anyway,
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

So this patch is good to go? If so, I'll pull it in and start testing
it.

I'm currently traveling (as you probably received my OoO emails), but I
can still do a bit of work remotely.

-- Steve
