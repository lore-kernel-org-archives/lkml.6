Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D9C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A2D20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A2D20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeJEXvs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:51:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38669 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeJEXvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:51:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g8TKn-0004s3-Hl; Fri, 05 Oct 2018 18:52:13 +0200
Date:   Fri, 5 Oct 2018 18:52:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julia Cartwright <julia@ni.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd wakeup
Message-ID: <20181005165213.mbgixd7w4csu3xjh@linutronix.de>
References: <cover.1538089179.git.julia@ni.com>
 <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-28 21:03:51 [+0000], Julia Cartwright wrote:
> When PREEMPT_RT_FULL is enabled, all hrtimer expiry functions are
> deferred for execution into the context of ktimersoftd unless otherwise
> annotated.
…
> Signed-off-by: Julia Cartwright <julia@ni.com>

did s@HRTIMER_MODE_REL@HRTIMER_MODE_REL_HARD@ and then applied.

Thank you Julia.

Sebastian
