Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3EDC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CE9218F9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CE9218F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeHRJwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 05:52:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58510 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbeHRJwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 05:52:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2B18C464DB874;
        Sat, 18 Aug 2018 14:46:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Sat, 18 Aug 2018
 14:45:56 +0800
Message-ID: <5B77C0A0.2030704@huawei.com>
Date:   Sat, 18 Aug 2018 14:45:52 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <davem@davemloft.net>
CC:     <vz@mleia.com>, <slemieux.tyco@gmail.com>, <keescook@chromium.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] ethernet: Use NULL to compare with pointer-typed
 value rather than 0
References: <1534573773-17358-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534573773-17358-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ingore the patchset.  should be change the title  from [patch] to [patchv2].
On 2018/8/18 14:29, zhong jiang wrote:
> v1->v2:
>  - According to Vladimir's suggestion. change a common 0 and NULL comparsion form.
>
> zhong jiang (2):
>   ethernet: declance:  Use NULL to compare with pointer-typed value
>     rather than 0
>   ethernet: lpc_eth: Use NULL to compare with pointer-typed value
>     rather than 0
>
>  drivers/net/ethernet/amd/declance.c | 3 +--
>  drivers/net/ethernet/nxp/lpc_eth.c  | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>


