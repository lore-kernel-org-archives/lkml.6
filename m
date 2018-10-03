Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDFDC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D25B208AE
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D25B208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJCJdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbeJCJdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:33:38 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2C8208AE;
        Wed,  3 Oct 2018 02:47:16 +0000 (UTC)
Date:   Tue, 2 Oct 2018 22:47:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [ftrace/kprobes PATCH 0/3] tracing: probeevent: Fix module
 symbol probing
Message-ID: <20181002224714.009682f0@vmware.local.home>
In-Reply-To: <20181001114855.75603699@gandalf.local.home>
References: <153547303754.26502.5265242979168613920.stgit@devbox>
        <20180927194858.7419c4ee4821f3985d3b0918@kernel.org>
        <20181001114855.75603699@gandalf.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018 11:48:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 27 Sep 2018 19:48:58 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hello Steve,
> > 
> > Could you also include this series to the branch?
> >   
> 
> Hi Masami, 
> 
> I just came back from Embedded / Kernel Recipes, I'll look at these
> today.
> 

Unfortunately, I've been pulled off to other tasks :-(

I'll make it a priority tomorrow (Wednesday).

-- Steve
