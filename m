Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2C6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DC420856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfAQOvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfAQOvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:51:06 -0500
Received: from vmware.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2E220652;
        Thu, 17 Jan 2019 14:51:05 +0000 (UTC)
Date:   Thu, 17 Jan 2019 09:51:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobes: Fix output for multiple string
 arguments
Message-ID: <20190117095102.724939e2@vmware.local.home>
In-Reply-To: <5ceb9b3b-3f67-4e84-b029-6e6d8ccc0449@fau.de>
References: <20190116084021.34b0beee@gandalf.local.home>
        <20190116141629.5752-1-andreas.ziegler@fau.de>
        <20190117150107.17f2c0c37e41126120c5eebb@kernel.org>
        <b5defce3-b52a-db20-bfd1-81eec9972fab@fau.de>
        <20190117165807.64e95553ff397e7f73ba495b@kernel.org>
        <20190117092042.4f689462@vmware.local.home>
        <5ceb9b3b-3f67-4e84-b029-6e6d8ccc0449@fau.de>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 15:29:09 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:
  
>  From my side it's basically good to go, but I just realized that there 
> is no "Fixes: " tag in it but the problem it fixes goes back to 
> 5baaa59ef09e ("tracing/probes: Implement 'memory' fetch method for 
> uprobes") from 2013 (and is present in all current longterm and stable 
> kernels)... should I add a tag and resend a v3?
>

I was just about to ask you to provide the fixes tag. No need to
resend, I'll just add it manually. I asked Masami to resend because it
was a patch series. If it was just a single patch, I would have just
asked what the fixes was for that particular patch. I can handle one
patch, but not more than one ;-)

-- Steve
