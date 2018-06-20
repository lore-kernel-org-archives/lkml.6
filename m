Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F305C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE31A20875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE31A20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbeFTTEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:04:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754836AbeFTTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:38 -0400
Received: from localhost (113x41x139x141.ap113.ftth.ucom.ne.jp [113.41.139.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6628EA6;
        Wed, 20 Jun 2018 19:04:37 +0000 (UTC)
Date:   Thu, 21 Jun 2018 03:51:38 +0900
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
Message-ID: <20180620185138.GD32326@kroah.com>
References: <20180618080608.851973560@linuxfoundation.org>
 <20180618080615.492002239@linuxfoundation.org>
 <7ef9ee41-877b-0cc3-bd2d-f495b1d354bb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef9ee41-877b-0cc3-bd2d-f495b1d354bb@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:10:31PM +0530, Kohli, Gaurav wrote:
> Hi Greg,
> 
> As more patches related to this are coming in 4.17, so it is better if all
> go together on different branches, plz suggest.

I do not understand, sorry.  What is wrong with this as-is?  If I need
to take other patches as well, please let me know what commits and what
stable tree(s) they belong on.

thanks,

greg k-h
