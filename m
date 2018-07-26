Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800E6C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361EB20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361EB20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbeGZRWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:22:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbeGZRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:22:05 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fiikh-0001s4-3D; Thu, 26 Jul 2018 18:04:31 +0200
Date:   Thu, 26 Jul 2018 18:04:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH RT] rtc: Disable RTC_DRV_EFI on RT
Message-ID: <20180726160430.ser3j5pfxnjh2bla@linutronix.de>
References: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de>
 <CAKv+Gu_+t_VwY3xDq3nWbnOTfzBc6OtQeRD2GKsseO2uK-uruw@mail.gmail.com>
 <20180726121504.ba35z3j3wsesryy3@linutronix.de>
 <5052E25B-9942-40C1-BD53-86E3D7014557@linaro.org>
 <20180726124613.xgmidioqd4mcqpiw@linutronix.de>
 <8640BE46-B141-44F9-BD92-58A21A2B0EA7@linaro.org>
 <20180726131323.ffecgeqnry6th4mp@linutronix.de>
 <20180726131424.nqkalmmncnfcrh2q@linutronix.de>
 <CAKv+Gu8FgcPZDDKWnC03eWVFH2npJz5_XQDoOzkGdDxxSqCj8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8FgcPZDDKWnC03eWVFH2npJz5_XQDoOzkGdDxxSqCj8g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-26 18:01:47 [+0200], Ard Biesheuvel wrote:
> Yes, that's what I was thinking. This way, you can still reboot into
> the same kernel occasionally with EFI runtime services enabled to,
> e.g., use efibootmgr.
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> for both patches if you queue them in the -rt tree. If you want them
> in mainline, please resend them as proper patches once
> CONFIG_PREEMPT_RT_BASE has been declared in mainline as well.
Okay, thank you.

Sebastian
