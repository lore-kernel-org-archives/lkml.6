Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F059CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905A820685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905A820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeJaSeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeJaSeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:34:09 -0400
Received: from vmware.local.home (unknown [217.16.13.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77E4020821;
        Wed, 31 Oct 2018 09:36:44 +0000 (UTC)
Date:   Wed, 31 Oct 2018 05:36:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mhiramat@kernel.org
Subject: Re: [GIT PULL] tracing: Updates for 4.20 (or 5.0)
Message-ID: <20181031053636.1063ed15@vmware.local.home>
In-Reply-To: <CAHk-=whmLFu=Cn2dti8oAAcPeVUSMeT_=uvuRvzdt-_xqjKSgQ@mail.gmail.com>
References: <20181030093734.6b4118bd@vmware.local.home>
        <CAHk-=whmLFu=Cn2dti8oAAcPeVUSMeT_=uvuRvzdt-_xqjKSgQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 10:02:16 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> As an explanation, the above kind of sucks. "SDT"? I had to look it
> up. I added a note to the commit message, but please, don't use random
> acronyms in kernel explanations unless they are industry-standard and
> comprehensible to kernel people.
> 
> Good acronyms: "TLB", "WTF", "LOL". People know what those mean.
> "SDT"? Not so much.

Apologies, this is one of the reasons I wanted to wait till the end of
the week to do the pull request. I'm currently traveling (on my way
home), and using my laptop for all my work (at home I use my
workstation). I almost sent the pull request without even mentioning
the SDT work. That's because I had tested that and pushed it into
linux-next some time ago and completely forgot about it. I caught the
error looking at the patches before sending, redid the signed tag by
mentioning it and sent it out.

I would have had a deeper explanation about the change otherwise. I
really hate merge windows while I'm traveling :-(

-- Steve
