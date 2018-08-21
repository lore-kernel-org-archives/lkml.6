Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F2FC43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0466521502
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbUGEfQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0466521502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeHUKMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbeHUKMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:12:20 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766AF214FF;
        Tue, 21 Aug 2018 06:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534834407;
        bh=R2IX/gXslMYpfqBjlGdvCUuu2hCCECzJPf08cE/ufPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IbUGEfQcK3Txnn+YhIFtAl2kFfcV8BgRGQ0OJG8nkPg2pwKWszHCpT2h9HUZ5PXWi
         zm7YzCgiCDprxaHFlLUMewltTHtJ/3NGHMo9ERE6xBV8Qy/Zi/KdxsZB3HVogAvV2P
         JSqrOtt4WcL/IZuRPGdzGeCFmjbn4RIqzhaGljic=
Date:   Tue, 21 Aug 2018 15:53:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/32] tracing: Allow gcov profiling on only ftrace
 subsystem
Message-Id: <20180821155324.1c99360e7edf1023b1659fa1@kernel.org>
In-Reply-To: <20180820113349.4fefbe0e@gandalf.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443697980.23257.9233992547183322108.stgit@devbox>
        <20180820113213.09497e0a@gandalf.local.home>
        <20180820113349.4fefbe0e@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 20 Aug 2018 11:33:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 20 Aug 2018 11:32:13 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Other than that, it looks fine to me.
> 
> This patch also seems out of place for the series.

Yes, this one is the patch for ftrace, not ftracetest.

> Want to resend it
> separately, and I'll apply it?

OK, I'll fix "config" and resend it :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
