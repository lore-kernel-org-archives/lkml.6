Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F8CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4331E23F44
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4331E23F44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933033AbeGFOaJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:30:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54770 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeGFOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:30:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fbRkI-00055L-GZ; Fri, 06 Jul 2018 16:30:02 +0200
Date:   Fri, 6 Jul 2018 16:30:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     gengdongjiu <gengdongjiu@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        anna-maria@linutronix.de, john.stultz@linaro.org,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        yangchuanlong@huawei.com,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        liupeifeng3@huawei.com
Subject: Re: hrtimer become inaccurate with RT patch
Message-ID: <20180706143002.kojp3smig75w736b@linutronix.de>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
 <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
 <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
 <bce8b710-a57b-fb7b-f784-b13d415aa451@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bce8b710-a57b-fb7b-f784-b13d415aa451@monom.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-06 16:22:16 [+0200], Daniel Wagner wrote:
> Who can edit this page:
> 
> https://wiki.linuxfoundation.org/realtime/preempt_rt_versions
> 
> ? It still lists 4.1-rt as supported.

updated.

Sebastian
