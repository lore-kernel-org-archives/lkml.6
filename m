Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F067FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD815217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549990144;
	bh=FwUIRWzlLKGrKOodSqeTD2mZdhGYxvDxcdjG1+NpKDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lDUFbu/vCm9WPOJNMkoG5ab+CDIO44Ig73lxYwKcb5tsnyne/FZwsZWHVeVtiGWv+
	 dpgTo7MGLWn1SwZVTUytGdkqDg3mzCxPMqyyJbFF7oaajw0o/k/Xu9EGmYbSukUSxn
	 pZokALJ+R8yFgR5JTZdcGmxQZKQ5zU5b/VD6WNZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfBLQtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfBLQtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:49:02 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A2C217D9;
        Tue, 12 Feb 2019 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549990142;
        bh=FwUIRWzlLKGrKOodSqeTD2mZdhGYxvDxcdjG1+NpKDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kgEYY/jQgua70JT3K5jWfWRft0BqIe5NqaBvFpcw57pIdCObqA7rbTE5H6YevZOyJ
         kcgX71BM3hXOkqlG2Kskzw2srIuo/VeXtZ6H0BVz6NmwPDkLOgo3E/2tHj35VYnkzq
         qIKHbTvXaNGIDfAvhbP3NhlqKYNRtwA49Cftz9aQ=
Date:   Wed, 13 Feb 2019 01:48:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [PATCH v2 0/9] kprobes: Fix and improve blacklist symbols
Message-Id: <20190213014859.4c8e52469f131d1463b6291c@kernel.org>
In-Reply-To: <20190211135056.GA36142@gmail.com>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
        <20190114111810.79016d7d@gandalf.local.home>
        <20190201223153.0ccdf06378ac953eb2651ea9@kernel.org>
        <20190211135056.GA36142@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 14:50:56 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Ingo,
> > 
> > Can I ask you to pick this series and Andrea's patch?
> > Or would I better update this series on the latest tip/master?
> 
> Yeah, an updated series with Andrea's patch included, against latest 
> -tip, would be nice.

Hi, I sent the series on the latest -tip with Andrea's patch.

Thank you!



-- 
Masami Hiramatsu <mhiramat@kernel.org>
