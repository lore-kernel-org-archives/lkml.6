Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4261AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BD720866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeLSLgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:36:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58447 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbeLSLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:36:53 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gZa9j-0002bK-5r; Wed, 19 Dec 2018 12:36:51 +0100
Date:   Wed, 19 Dec 2018 12:36:51 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: RT-Kernel boot stalls because of change in fs/dcache.c
Message-ID: <20181219113650.ak3wj3h3oapfy3tj@linutronix.de>
References: <cfff1645-aab1-7b39-5f75-31b94f3365d1@kontron.de>
 <4aa4a0f1-373f-4978-42b1-6b676d6f1950@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4aa4a0f1-373f-4978-42b1-6b676d6f1950@kontron.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-19 07:50:17 [+0000], Schrempf Frieder wrote:
> + linux-rt-users
> 
> On 17.12.18 11:42, Frieder Schrempf wrote:
> > Hi,
> > 
> > I have tried to boot a 4.14-Kernel with the RT-patches and 
> > PREEMPT_RT_FULL on an i.MX6UL board. Unfortunately the boot stalls at 
> > some point and never finishes.
> > 
> > I did some bisecting and found out, that reverting this change: [1], 
> > makes the board boot correctly.
> > 
> > Can anyone help to come up with a proper fix for this?

can you check if the hashtable is initialized twice?

> > Thanks,
> > Frieder
> > 
> > [1]: 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v4.14-rt&id=56684d21f7f8341f7a5ed1433714112f49294590 

Sebastian
