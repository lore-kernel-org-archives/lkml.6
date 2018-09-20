Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3E1ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54772152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54772152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbeITSJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:09:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeITSJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:09:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A010A46931F39;
        Thu, 20 Sep 2018 20:25:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 20:25:57 +0800
Message-ID: <5BA391D4.20205@huawei.com>
Date:   Thu, 20 Sep 2018 20:25:56 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     <davem@davemloft.net>, <hante.meuleman@broadcom.com>,
        <franky.lin@broadcom.com>, <arend.vanspriel@broadcom.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] brcm80211: remove redundant condition check before debugfs_remove_recursive
References: <1536761412-24932-1-git-send-email-zhongjiang@huawei.com> <20180920120709.5FE6960BF7@smtp.codeaurora.org>
In-Reply-To: <20180920120709.5FE6960BF7@smtp.codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/20 20:07, Kalle Valo wrote:
> zhong jiang <zhongjiang@huawei.com> wrote:
>
>> debugfs_remove_recursive has taken IS_ERR_OR_NULL into account. So just
>> remove the condition check before debugfs_remove_recursive.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> It seems you already submitted an identical patch four days earlier:
>
> https://patchwork.kernel.org/patch/10593061/
>
> Why the duplicate? Please ALWAYS add a changelog and increase the version number:
I am sorry for that. Maybe I send the patch earlier, but I remeber I should forget to cc to
netdev@vger.kernel.org and LMLK. So I repost it.  Plese ingore the current patch.

Sincerely,
zhong jiang

> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing
>


