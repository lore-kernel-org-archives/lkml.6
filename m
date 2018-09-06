Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AFCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4E1206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4E1206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIFMNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:13:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32782 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFMNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:13:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fxosq-00083j-Sg; Thu, 06 Sep 2018 09:39:21 +0200
Date:   Thu, 6 Sep 2018 09:39:20 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:974
Message-ID: <20180906073920.mgqunl4sfcsore35@linutronix.de>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
 <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
 <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
 <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
 <c744c81c-752e-499e-ffe1-32df30a7831b@ti.com>
 <20180831193053.e3wvssdrxxnw2qah@linutronix.de>
 <1bb777d4-7d72-ecdf-4b78-7d60ec49b815@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bb777d4-7d72-ecdf-4b78-7d60ec49b815@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-31 14:42:25 [-0500], Grygorii Strashko wrote:
> 
> 
> On 08/31/2018 02:30 PM, Sebastian Andrzej Siewior wrote:
> > On 2018-08-31 14:19:53 [-0500], Grygorii Strashko wrote:
> >>
> >> I've tried this and do not see warnings. I'm sending 4.14-rt patches i have as
> >> I could miss smth while cherry-picking.
> > 
> > perfect. Thanks for the confirmation.
> > I saw your three patches. Could you please instead just backport the two
> > patches I have in v4.16 so that it applies on v4.14?
> > 
> 
> Do you mean these two:
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.16.y-rt&id=c7a3334c762a9b1dd2e39cb2ded00ce66e8a06d1
Yes,

> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.16.y-rt&id=e083f14dc2e98ced872bf077b4d1cccf95b7e4f8
no, just 
	https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.16.y-rt-rebase&id=d6914631a84f47eaf5647da3bb09d58eca156b3f

Sebastian
