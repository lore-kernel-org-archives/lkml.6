Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8384C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE2921738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfBSQ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:28:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfBSQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:28:43 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gw8G9-00029O-H3; Tue, 19 Feb 2019 17:28:41 +0100
Date:   Tue, 19 Feb 2019 17:28:41 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 1/2] softirq: Avoid "local_softirq_pending" messages
 if ksoftirqd is blocked
Message-ID: <20190219162841.rypvpb6p3fd75zwv@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190219145826.GH21785@localhost.localdomain>
 <20190219160606.jwjrgf6nxarnd2wt@linutronix.de>
 <20190219162741.GI21785@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219162741.GI21785@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-19 17:27:41 [+0100], Juri Lelli wrote:
> It is better. Warning message doesn't appear anymore.

Okay, thanks.

Sebastian
