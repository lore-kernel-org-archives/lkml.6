Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B1CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660B420870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfAWPB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:01:27 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:5391 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAWPB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:01:27 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 6940613F88D;
        Wed, 23 Jan 2019 16:01:14 +0100 (CET)
Subject: Re: Potential info leak: Kernel pointer leak?
To:     Vinod Koul <vkoul@kernel.org>,
        Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        DMA <dmaengine@vger.kernel.org>
References: <CABXRUiRP8fHvGkO3T9AOFV=prVUACiCm2frbAEnG2v6UhrTw0A@mail.gmail.com>
 <20190123122429.GO4635@vkoul-mobl>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <3409b71f-9b92-5e53-e87e-1486f493a55e@free.fr>
Date:   Wed, 23 Jan 2019 16:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123122429.GO4635@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2019 13:24, Vinod Koul wrote:

> On 22-01-19, 21:25, Fuqian Huang wrote:
>
>> Recently I came across some code and it seems to be able to leak kernel address?
>> Is the following code cause info leak in the Linux kernel?
>> linux-4.14.90
> 
> Doesn't %p not print kernel addresses anymore, see
> Documentation/core-api/printk-formats.rst

Commit ad67b74d2469d9b82aaa ("printk: hash addresses printed with %p")
was merged in v4.15-rc2 and not backported to v4.14 AFAICT.

Regards.
