Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489F4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC9B20863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfBLMVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:21:36 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54712 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726550AbfBLMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:21:36 -0500
X-IronPort-AV: E=Sophos;i="5.58,361,1544457600"; 
   d="scan'208";a="54168451"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Feb 2019 20:21:34 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 725B14BAD9BE;
        Tue, 12 Feb 2019 20:21:30 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Feb 2019 20:21:28 +0800
Subject: Re: [PATCH] x86/boot: comments cleanup & indentation fix
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190104120428.26847-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <3a55f276-1247-575e-274b-6336d7dfce36@cn.fujitsu.com>
Date:   Tue, 12 Feb 2019 20:18:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190104120428.26847-1-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 725B14BAD9BE.A9D20
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 8:04 PM, Cao jin wrote:
> No real code modification, just cleanup:
> 1. remove redundant comments which have already appeared above
> 2. comments improvement:
>       "aligned to a 2M boundary"
>       -->
>       "aligned up to CONFIG_PHYSICAL_ALIGN boundary"

Finally I see why I have inaccurate understanding in 2. Sorry for the noise.

> 3. typo fix: uncompression --> decompression
> 4. indentation fix in linker script: spaces -> tab
> 

I will leave the other 3 alone, unless they are wanted.
-- 
Sincerely,
Cao jin


