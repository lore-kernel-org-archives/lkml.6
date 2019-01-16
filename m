Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B1FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAFE2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392716AbfAPM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390234AbfAPM1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:27:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8C120578;
        Wed, 16 Jan 2019 12:27:29 +0000 (UTC)
Date:   Wed, 16 Jan 2019 07:27:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH RT] printk: Shortcut out of waiter spinning on
 PREEMPT_RT
Message-ID: <20190116072728.1fcc54d0@gandalf.local.home>
In-Reply-To: <20190116114340.GA6322@tigerII.localdomain>
References: <20190115123910.2b18df54@gandalf.local.home>
        <20190115185433.e7hmlpmjvpyqdyhc@linutronix.de>
        <20190115145815.13713791@gandalf.local.home>
        <20190116100751.2glxadlpco7a46o5@pathway.suse.cz>
        <20190116114340.GA6322@tigerII.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 20:43:40 +0900
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> On (01/16/19 11:07), Petr Mladek wrote:
> > The patch makes perfect sense. But it is not ready for upstream
> > because CONFIG_PREEMPT_RT_FULL is not there yet. Do I get it
> > correctly, please?  
> 
> Yes. Hence Cc linux-rt-users.
> 
>

Actually it's the Subject line. We use "[PATCH RT]" to denote changes
caused by PREEMPT_RT existing.

-- Steve
