Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA24C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD76520856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD76520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbeGXQNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:13:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53410 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388333AbeGXQNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:13:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA52280D;
        Tue, 24 Jul 2018 08:06:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8C283F237;
        Tue, 24 Jul 2018 08:06:40 -0700 (PDT)
Date:   Tue, 24 Jul 2018 16:06:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4 01/12] atomic/tty: Fix up atomic abuse in ldsem
Message-ID: <20180724150638.a3vw5gn3efzvlwmv@lakrids.cambridge.arm.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-2-mark.rutland@arm.com>
 <20180724071518.GA7300@gmail.com>
 <20180724092036.GN2494@hirez.programming.kicks-ass.net>
 <20180724092324.vnfowffsla4kja5c@lakrids.cambridge.arm.com>
 <20180724111313.GA14212@gmail.com>
 <20180724130515.ung6ox2p4rgzn746@lakrids.cambridge.arm.com>
 <20180724134048.GA30682@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724134048.GA30682@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 03:40:48PM +0200, Ingo Molnar wrote:
> 
> * Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > > Ok, then these bits will have to wait until Greg's tree goes upstream
> > > in about two weeks.
> > 
> > Ok.
> > 
> > > Which patches can I apply as a preparatory step?
> > 
> > Patches 2-6 can be applied now.
> 
> Ok, will apply those.

Cheers!

> > I guess I should rebase and resend the remaining bits once Greg's tree
> > goes upstream?
> 
> Yeah, easiest would be to do that once Greg's and tip:locking/core changes (with 
> patches 2-6) both got merged by Linus.

I'll keep an eye out for both of these.

Thanks,
Mark.
