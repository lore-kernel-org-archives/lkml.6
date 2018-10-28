Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DA3C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032E22082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032E22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJ2CxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeJ2CxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:53:20 -0400
Received: from vmware.local.home (unknown [95.87.249.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D8BB2082D;
        Sun, 28 Oct 2018 18:07:55 +0000 (UTC)
Date:   Sun, 28 Oct 2018 14:07:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing: Fix synthetic event parser
Message-ID: <20181028140749.1658aaeb@vmware.local.home>
In-Reply-To: <2ea8d301-c140-f256-e8d0-20b107fcb1be@kernel.org>
References: <154013446976.25576.14780785912268176178.stgit@devbox>
        <20181028040135.717a7b5d@vmware.local.home>
        <2ea8d301-c140-f256-e8d0-20b107fcb1be@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018 11:33:35 -0600
Shuah Khan <shuah@kernel.org> wrote:

> Hi Steve,
> 
> Are there any dependencies on my pull request I sent to Linus? It hasn't
> been pulled in yet. If there is one, could please you mention that in your
> pull request for this.

There's no dependency on the patches you took. But if you could ack the
selftest one that would be awesome.

Thanks,

-- Steve
