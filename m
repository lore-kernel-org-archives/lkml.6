Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1885EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8182214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8182214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeLFC3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:29:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLFC3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:29:48 -0500
Received: from vmware.local.home (unknown [184.48.106.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BAFB20700;
        Thu,  6 Dec 2018 02:29:47 +0000 (UTC)
Date:   Wed, 5 Dec 2018 21:29:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
Message-ID: <20181205212945.58edee31@vmware.local.home>
In-Reply-To: <20181205212651.488d9cd4@vmware.local.home>
References: <20181130150859.27366-1-anders.roxell@linaro.org>
        <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
        <20181205212651.488d9cd4@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 21:26:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 5 Dec 2018 17:08:34 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 

> I'll Ack the Makefile
> change in the tracing directory, but the rest belongs to others.
> 

I see I already acked that patch. BTW, when sending a patch series, you
really need a 0/3 patch as a header and the rest be threaded. I had a
hard time finding that patch in the sea of my INBOX.

If I was the one to pull it in, I wouldn't do it if the series was
unthreaded like this.

-- Steve
