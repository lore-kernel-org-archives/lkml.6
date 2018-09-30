Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41211C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F004A206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F004A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=softrans.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeI3J1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:27:30 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:58577 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727519AbeI3J1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:27:30 -0400
Received: from smtp.starsoftware.com.au (n175-33-222-186.meb2.vic.optusnet.com.au [175.33.222.186])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTP id 1E3CDD69007;
        Sun, 30 Sep 2018 12:56:18 +1000 (AEST)
Received: from [192.168.0.9] (unknown [192.168.0.1])
        by smtp.starsoftware.com.au (Postfix) with ESMTP id 2BC26677E223;
        Sun, 30 Sep 2018 12:56:16 +1000 (AEST)
Subject: Re: [patch V2 11/11] x66/vdso: Add CLOCK_TAI support
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
References: <20180917124533.329334911@linutronix.de>
 <20180917130707.823878601@linutronix.de>
From:   Matthew Rickard <matt@softrans.com.au>
Message-ID: <6cc5d7e8-1769-e0c9-1ed1-cec0f5305856@softrans.com.au>
Date:   Sun, 30 Sep 2018 12:56:17 +1000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917130707.823878601@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=I9sVfJog c=1 sm=1 tr=0
        a=aTCbjYUTaYEOZ0hOHfbu0w==:117 a=aTCbjYUTaYEOZ0hOHfbu0w==:17
        a=IkcTkHD0fZMA:10 a=JBFolyDoGHsA:10 a=PIVNZ80yAAAA:8
        a=9TZYBPk20JEULVQbo48A:9 a=QEXdDO2ut3YA:10 a=3YJQTRF3V1zcZZCg0gjL:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/09/2018 10:45 PM, Thomas Gleixner wrote:
> With the storage array in place it's now trivial to support CLOCK_TAI in
> the vdso. Extend the base time storage array and add the update code.
> 
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>

That's much better. Thanks

Tested-by: Matt Rickard <matt@softrans.com.au>
