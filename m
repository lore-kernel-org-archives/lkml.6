Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A400BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFA121557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFA121557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeHXEEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 00:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeHXEEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 00:04:34 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D29208E8;
        Fri, 24 Aug 2018 00:32:25 +0000 (UTC)
Date:   Thu, 23 Aug 2018 20:32:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tiejun Chen <tiejunc@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [ANNOUNCE] 4.14.63-rt40
Message-ID: <20180823203223.11dee5e8@vmware.local.home>
In-Reply-To: <CY1PR0501MB14666E51F4D066F2E0C5208AC5370@CY1PR0501MB1466.namprd05.prod.outlook.com>
References: <20180822141458.0b6b6af7@gandalf.local.home>
        <CY1PR0501MB14666E51F4D066F2E0C5208AC5370@CY1PR0501MB1466.namprd05.prod.outlook.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 09:31:09 +0000
Tiejun Chen <tiejunc@vmware.com> wrote:

> Steven,
> 
> commit 7f11a591bbdb111792298144c3476506aa7f1ca8 (HEAD -> v4.14.63-rt40-rebase, tag: v4.14.63-rt40-rebase, origin/v4.14-rt-rebase)
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Wed May 16 09:33:00 2018 -0400
> 
>     Linux 4.14.63-rt40 REBASE
> 
> diff --git a/localversion-rt b/localversion-rt
> index 90290c642ed5..a3b2408c1da6 100644
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt29
> +-rt37
>     ^
> Isn't it supposed to be rt40?
> 

Ug, the last step of creating the rebase is to manually update the
localversion-rt file. Which I did. But I forgot to add "-a" to the 
"git commit --amend" part. Thanks for pointing this out!

Luckily, this is the rebase branch, where I can just rebase it ;-)

-- Steve
