Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CDCC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5502098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPPf/o1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5502098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJCUOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeJCUOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:14:45 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D582082A;
        Wed,  3 Oct 2018 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538573180;
        bh=N8H9X78cVynQtrAkNhzDOts6ouhHfUVPUAHaJU15eDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nPPf/o1s69CZBE4jS3DgIG7XzvR1WVOy0VgVGEFnpnt8ZVRRk83/zoglcyUKx4doD
         64mRBd4O2aIri7hHiOLnvgZjM1FLA1UQzcNOFkjYqjhHtdNRhwCJ6kzrjl0j4dOyR8
         d7s8lIo5v1gUypAfy00gd/uDFqm2DBHMuc8cr80Q=
Date:   Wed, 3 Oct 2018 22:26:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [ftrace/kprobes PATCH 0/3] tracing: probeevent: Fix module
 symbol probing
Message-Id: <20181003222617.b4906d8b7156ebf6aec2c1c1@kernel.org>
In-Reply-To: <20181002224714.009682f0@vmware.local.home>
References: <153547303754.26502.5265242979168613920.stgit@devbox>
        <20180927194858.7419c4ee4821f3985d3b0918@kernel.org>
        <20181001114855.75603699@gandalf.local.home>
        <20181002224714.009682f0@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018 22:47:14 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 1 Oct 2018 11:48:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 27 Sep 2018 19:48:58 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Hello Steve,
> > > 
> > > Could you also include this series to the branch?
> > >   
> > 
> > Hi Masami, 
> > 
> > I just came back from Embedded / Kernel Recipes, I'll look at these
> > today.
> > 
> 
> Unfortunately, I've been pulled off to other tasks :-(
> 
> I'll make it a priority tomorrow (Wednesday).

No problem, thank you for reviewing :)


> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
