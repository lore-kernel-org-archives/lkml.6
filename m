Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBECECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149302054F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149302054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJ1Qx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeJ1Qx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:53:26 -0400
Received: from vmware.local.home (unknown [95.87.249.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B5C2054F;
        Sun, 28 Oct 2018 08:09:29 +0000 (UTC)
Date:   Sun, 28 Oct 2018 04:09:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing: Fix synthetic event parser
Message-ID: <20181028040924.1eca8002@vmware.local.home>
In-Reply-To: <20181028040135.717a7b5d@vmware.local.home>
References: <154013446976.25576.14780785912268176178.stgit@devbox>
        <20181028040135.717a7b5d@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018 04:01:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'll add them on top of my linux-next code, and include them in the
> pull request I'm hoping to do on Tuesday.

Bah, I think this is on a different branch, and that will make it go as
a separate pull. Anyway, it probably will still be on Tuesday where I
push it to Linus.

-- Steve
