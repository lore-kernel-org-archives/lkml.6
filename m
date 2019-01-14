Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6489C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB3D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfANR13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:27:29 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.228]:12061 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbfANR13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:27:29 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 96E624B0FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:27:27 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j61HgDZe090onj61Hggd5u; Mon, 14 Jan 2019 11:27:27 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46476 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gj61H-003BRU-7s; Mon, 14 Jan 2019 11:27:27 -0600
Subject: Re: [PATCH] Input: mcs_touchkey - use struct_size() in kzalloc()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190108211556.GA5760@embeddedor>
 <20190114063102.GA217283@dtor-ws>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <be6bfdc9-8179-a500-c87f-eb9a90671880@embeddedor.com>
Date:   Mon, 14 Jan 2019 11:27:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114063102.GA217283@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gj61H-003BRU-7s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:46476
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 12:31 AM, Dmitry Torokhov wrote:

>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied, thank you.
> 

Thanks, Dmitry.

--
Gustavo
