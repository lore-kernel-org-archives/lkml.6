Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79205C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CC52083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CC52083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeIACpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:45:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:33938 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeIACpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:45:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 90A8B2B0;
        Fri, 31 Aug 2018 22:35:44 +0000 (UTC)
Date:   Fri, 31 Aug 2018 16:35:31 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: tracing: Add stacktrace filter command
Message-ID: <20180831163531.4b1cf1e4@lwn.net>
In-Reply-To: <20180816085031.531732d3@gandalf.local.home>
References: <153441301698.6024.1680500212551396320.stgit@devbox>
        <153441304709.6024.553337906391633027.stgit@devbox>
        <20180816085031.531732d3@gandalf.local.home>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 08:50:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 16 Aug 2018 18:50:47 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add a description of stacktrace filter command.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org  
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Jon, want to pull this patch into your tree?

Applied (finally), thanks.

jon
