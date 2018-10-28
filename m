Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E9FC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAD520664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAD520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeJ2D6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 23:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeJ2D6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 23:58:52 -0400
Received: from vmware.local.home (unknown [95.87.249.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 694A220664;
        Sun, 28 Oct 2018 19:13:17 +0000 (UTC)
Date:   Sun, 28 Oct 2018 15:13:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing: Fix synthetic event parser
Message-ID: <20181028151313.43f11167@vmware.local.home>
In-Reply-To: <c160ec5e-debd-74dd-43e8-a7792a63f06e@kernel.org>
References: <154013446976.25576.14780785912268176178.stgit@devbox>
        <20181028040135.717a7b5d@vmware.local.home>
        <20181028040924.1eca8002@vmware.local.home>
        <c160ec5e-debd-74dd-43e8-a7792a63f06e@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018 12:10:17 -0600
Shuah Khan <shuah@kernel.org> wrote:

> Here it is
> 
> Acked-by: Shuah Khan <shuah@kernel.org>
>

Thanks a lot Shuah!

-- Steve
