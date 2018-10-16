Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C704C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1DB205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1DB205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJQAt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQAt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:49:59 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CBD8205C9;
        Tue, 16 Oct 2018 16:58:39 +0000 (UTC)
Date:   Tue, 16 Oct 2018 12:58:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Add color to the PASS / FAIL results
Message-ID: <20181016125838.2af4e1b9@gandalf.local.home>
In-Reply-To: <ccadb761-025d-2447-c3e8-5762ea209347@kernel.org>
References: <20181012222106.7f38b667@vmware.local.home>
        <20181015234231.e163ab77fd42dbd3ac9c84d5@kernel.org>
        <20181017002632.20fcb18bf94efb79aa58219b@kernel.org>
        <20181016113952.59893943@gandalf.local.home>
        <ccadb761-025d-2447-c3e8-5762ea209347@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 10:40:55 -0600
Shuah Khan <shuah@kernel.org> wrote:

> >> The last one should be "\e[0m" (reset), "\e[30m" just set the color "black".
> >> That doesn't work on my terminal, which is "white on black".
> >>
> >>  
> > 
> > Ah thanks for the feedback. Want to write a patch on top, that Shuah
> > can add?
> > 
> > -- Steve
> >   
> 
> That will be great. I can apply the updated patch with Masami's Reviewed-by
> perhaps.

I was hoping that Masami could write the patch ;-)

-- Steve
