Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EAE20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfAQPfd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:35:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfAQPfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:35:33 -0500
Received: from vmware.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5CD20652;
        Thu, 17 Jan 2019 15:35:32 +0000 (UTC)
Date:   Thu, 17 Jan 2019 10:35:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobes: Fix output for multiple string
 arguments
Message-ID: <20190117103530.41ffc449@vmware.local.home>
In-Reply-To: <0F30FF42-AE03-45CC-8877-06E83038B6A4@fau.de>
References: <20190116084021.34b0beee@gandalf.local.home>
        <20190116141629.5752-1-andreas.ziegler@fau.de>
        <20190117150107.17f2c0c37e41126120c5eebb@kernel.org>
        <b5defce3-b52a-db20-bfd1-81eec9972fab@fau.de>
        <20190117165807.64e95553ff397e7f73ba495b@kernel.org>
        <20190117092042.4f689462@vmware.local.home>
        <5ceb9b3b-3f67-4e84-b029-6e6d8ccc0449@fau.de>
        <20190117095102.724939e2@vmware.local.home>
        <0F30FF42-AE03-45CC-8877-06E83038B6A4@fau.de>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 16:14:44 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> One more thing maybe, the code in question was rewritten
> by Masami in 9178412ddf5a ("tracing: probeevent: Return consumed
> bytes of dynamic area”) which is in v4.20 but the problem traces back
> to the original commit mentioned above, so it will need manual so we
> will need a slightly modified version for earlier kernels.

That's fine. When Greg (or other stable maintainer) process the commit,
it will produce a "FAILED" message and Cc all those in the tags
(obviously, you'll be one of them as the author), and then you can
reply to that email with the fixed up version and Greg (or whoever)
will take that patch in.

Thanks!

-- Steve
