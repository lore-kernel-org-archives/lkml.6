Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C26DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E34C2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfACTwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:52:41 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.147]:41173 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfACTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:52:40 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 931B3400CE57B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jan 2019 13:52:39 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id f92lgwfys4FKpf92lgP8Mn; Thu, 03 Jan 2019 13:52:39 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.104] (port=46544 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gf92l-001Xwc-84; Thu, 03 Jan 2019 13:52:39 -0600
Subject: Re: [PATCH] drm/amdgpu_vm: fix boolean expressions
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190103173418.GA18739@embeddedor>
 <08f2d5c0-0e97-f44e-c07d-6a8cdfd277bb@amd.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <84e1befb-3cce-f85a-2b90-71f42c445eda@embeddedor.com>
Date:   Thu, 3 Jan 2019 13:52:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <08f2d5c0-0e97-f44e-c07d-6a8cdfd277bb@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.104
X-Source-L: No
X-Exim-ID: 1gf92l-001Xwc-84
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.78.104]:46544
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/19 1:17 PM, Kuehling, Felix wrote:
> On 2019-01-03 12:34 p.m., Gustavo A. R. Silva wrote:
>> Fix boolean expressions by using logical AND operator '&&'
>> instead of bitwise operator '&'.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Fixes: c8c5e569c5b0 ("drm/amdgpu: Consolidate visible vs. real vram check v2.")
> Actually, this bug goes back further, to 9a4b7d4c769e ("drm/amdgpu: Add
> vm context module param").
> 

You're right. I'll fix that and send v2 shortly. I'll add your RB.

> Anyway, the patch is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 

Thanks
--
Gustavo

