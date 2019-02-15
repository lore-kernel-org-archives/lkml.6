Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4644E222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfBOStJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:49:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37648 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfBOStJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:49:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6F1EA78;
        Fri, 15 Feb 2019 10:49:08 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FA9E3F589;
        Fri, 15 Feb 2019 10:49:06 -0800 (PST)
Date:   Fri, 15 Feb 2019 18:49:04 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 00/10] locking/rwsem: Rwsem rearchitecture part 1
Message-ID: <20190215184904.GD15084@fuggles.cambridge.arm.com>
References: <1550017627-14504-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550017627-14504-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 07:26:57PM -0500, Waiman Long wrote:
> This is part 1 of a 3-part (0/1/2) series to rearchitect the internal
> operation of rwsem. This depends on the part 0 patches sent out previously
> 
> https://lore.kernel.org/lkml/1549913486-16799-1-git-send-email-longman@redhat.com
> 
> This part lays the foundation for part 2 without making any functional
> changes. This part includes the following changes:

Did you post part 2 anywhere? I can't seem to find it for some reason.

Cheers,

Will
