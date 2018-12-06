Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94671C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AD020868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AD020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeLFXms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:42:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61071 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeLFXms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:42:48 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id b46a8ab3a8a068d5; Fri, 7 Dec 2018 00:42:45 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.20-rc5: Lab setup broken by build-related x86 change
Date:   Fri, 07 Dec 2018 00:42:32 +0100
Message-ID: <3188426.lMJ4zZHNe7@aspire.rjw.lan>
In-Reply-To: <20181205143303.GI29510@zn.tnic>
References: <CAHk-=wizcNrsoyCM1EXQqoswMCYsJaby2iAkZb9wBAzDEhvxNg@mail.gmail.com> <1753172.TxHhsZQBsE@aspire.rjw.lan> <20181205143303.GI29510@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 5, 2018 3:33:03 PM CET Borislav Petkov wrote:
> On Wed, Dec 05, 2018 at 01:15:10PM +0100, Rafael J. Wysocki wrote:
> > After commit
> > 
> > commit 4cd24de3a0980bf3100c9dcb08ef65ca7c31af48
> > Author: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> > Date:   Fri Nov 2 01:45:41 2018 -0700
> > 
> >     x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support
> 
> I see Ingo committed a fix for this thing:
> 
> https://git.kernel.org/tip/25896d073d8a0403b07e6dec56f58e6c33678207
> 
> Does it work with that cherry-picked ontop?

Yes, it does, thanks!

