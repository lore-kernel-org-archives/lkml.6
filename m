Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FA6C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BAB21C18
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BAB21C18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeFUUnp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:43:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeFUUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:43:43 -0400
Received: from localhost (unknown [61.115.201.81])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7FD3CB6;
        Thu, 21 Jun 2018 20:43:42 +0000 (UTC)
Date:   Fri, 22 Jun 2018 05:43:40 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Kohli, Gaurav" <gkohli@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 161/279] kthread, sched/wait: Fix kthread_parkme()
 completion issue
Message-ID: <20180621204340.GA19443@kroah.com>
References: <20180618080608.851973560@linuxfoundation.org>
 <20180618080615.492002239@linuxfoundation.org>
 <7ef9ee41-877b-0cc3-bd2d-f495b1d354bb@codeaurora.org>
 <20180620185138.GD32326@kroah.com>
 <37979107-e550-61b4-1e7a-d331584af9fa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37979107-e550-61b4-1e7a-d331584af9fa@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 07:10:11PM +0530, Kohli, Gaurav wrote:
> HI Greg,
> 
> Yes more patches related to this are coming,
> https://lkml.org/lkml/2018/6/7/317
> 
> So i thought, if all go together then it is good.

I still do not understand what you are asking me to do here.  Maybe it's
the jetlag, but can you spell it out for me?

thanks,

greg k-h
