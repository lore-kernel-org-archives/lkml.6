Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215FBECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A6D2082B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A6D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJ1Qpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeJ1Qpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:45:36 -0400
Received: from vmware.local.home (unknown [95.87.249.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895F22082B;
        Sun, 28 Oct 2018 08:01:40 +0000 (UTC)
Date:   Sun, 28 Oct 2018 04:01:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing: Fix synthetic event parser
Message-ID: <20181028040135.717a7b5d@vmware.local.home>
In-Reply-To: <154013446976.25576.14780785912268176178.stgit@devbox>
References: <154013446976.25576.14780785912268176178.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 00:07:50 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> I found another bug in synthetic event. This is a small fix, but
> confusingly, there is also a bug in a test case.
> 
> Steve, since the testcase bugfix ([2/2]) breaks the test result
> unless corresponding fix ([1/2]), I would like to ask you to send
> these fixes from your tree.

Hi Masami,

I'm currently in travel mode, but I'm letting you know that I'll be
working on these today. It might take a bit to get out.

I'll add them on top of my linux-next code, and include them in the
pull request I'm hoping to do on Tuesday.

-- Steve
