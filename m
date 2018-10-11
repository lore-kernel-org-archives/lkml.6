Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE812C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B642087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B642087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJKJXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbeJKJXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:23:38 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7199C20870;
        Thu, 11 Oct 2018 01:58:41 +0000 (UTC)
Date:   Wed, 10 Oct 2018 21:58:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Message-ID: <20181010215839.6a01c039@vmware.local.home>
In-Reply-To: <7B4458A1-20B3-4BDE-9DCF-5E87EBD2D485@fb.com>
References: <20181002053636.1896903-1-songliubraving@fb.com>
        <20181002081206.GS3439@hirez.programming.kicks-ass.net>
        <7B4458A1-20B3-4BDE-9DCF-5E87EBD2D485@fb.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018 16:55:47 +0000
Song Liu <songliubraving@fb.com> wrote:


> > Works for me,
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>  
> 
> Thanks Peter!
> 
> Steven, could you please test/apply this? 

Sorry for the late reply. Yeah, I just pulled this into my queue and
I've started running tests on it.

Thanks Song!

-- Steve

