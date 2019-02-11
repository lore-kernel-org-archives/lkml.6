Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BBCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD8D2229F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549904130;
	bh=M1kLY/NFl2v5YnniEhkTfVO3u+ko0q5SP+co4gjIzcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xMwvV+r2oXcTw6z0ewX1Dzj1T2mK6WymUeZcdj6vXBRY5SloZzW6o1euWQxbxk1go
	 QdTcIQGzVbrZqtQgMXXFwIIJGzjB0QbdtXgHZhjvDiV5cdnBd9QTC6KHUrcXKCBpof
	 L/d5+yL1M+9l0JJhM/0fzCzK0j843H2QuwphNm0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfBKQz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:55:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfBKQz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:55:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75DED21B69;
        Mon, 11 Feb 2019 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549904127;
        bh=M1kLY/NFl2v5YnniEhkTfVO3u+ko0q5SP+co4gjIzcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njo+I0lGo1q7U3kmohF24pWpm2RujeI3Ops9j1G5ssDMljE6dT3Q0eYMzY5itG5/J
         60NO9OfT+k3ZiikLNQ4Z+dAjXoY7M5U+fudL1W/cvZMWIU8cHAl5Rz7pLR17TkcapU
         600ZnuBTQSQaA2GRz149y7DgurgWxoKNDuiNtZMs=
Date:   Mon, 11 Feb 2019 17:55:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 138/352] tracing: Have trace_stack nr_entries
 compare not be so subtle
Message-ID: <20190211165524.GD21634@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141855.296924278@linuxfoundation.org>
 <20190211094907.41712c44@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211094907.41712c44@gandalf.local.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:49:07AM -0500, Steven Rostedt wrote:
> On Mon, 11 Feb 2019 15:16:05 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> > 
> 
> This is not a bug fix and was not meant for stable. Please do not apply.

Thanks for letting me know, now dropped from all queues.

greg k-h
