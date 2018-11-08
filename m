Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99838ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF9520825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF9520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeKIAFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:05:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44309 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeKIAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:05:50 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKlJo-0000vA-J4; Thu, 08 Nov 2018 15:30:00 +0100
Date:   Thu, 8 Nov 2018 15:30:00 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] clocksource: rework Atmel TCB timer driver
Message-ID: <20181108143000.ve6d7jhfeno3huk6@linutronix.de>
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
 <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
 <20180925201456.GD3112@piout.net>
 <20181108124327.iqdiif6atfrxdkef@linutronix.de>
 <20181108140935.GI21694@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181108140935.GI21694@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 15:09:35 [+0100], Alexandre Belloni wrote:
> It is not part of that series as I prefer to keep the discussion of how
> to configure that for later. This has been raised previously without any
> conclusion and I'd really like to see this rework enter upstream soon.

Okay. Does it make sense to keep the lower resolution?

> > I'm currently replacing the v6 with this v7 in my RT tree. What is the
> > status of this series upstream wise?
> > 
> 
> I'll send v8 sometimes next week.
Thanks.

Sebastian
