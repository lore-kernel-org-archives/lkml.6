Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B045C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEAB2152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEAB2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbeITRSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:18:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727029AbeITRSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:18:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E5EFECB6DE9FA;
        Thu, 20 Sep 2018 19:34:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 19:34:53 +0800
Message-ID: <5BA385DC.6070302@huawei.com>
Date:   Thu, 20 Sep 2018 19:34:52 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <davem@davemloft.net>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: toshiba: remove a redundant local variable 'index_specified'
References: <1537408565-22315-1-git-send-email-zhongjiang@huawei.com> <17fba403-b5be-a406-bb25-4a0c2c4f27ca@cogentembedded.com>
In-Reply-To: <17fba403-b5be-a406-bb25-4a0c2c4f27ca@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/20 18:23, Sergei Shtylyov wrote:
> On 9/20/2018 4:56 AM, zhong jiang wrote:
>
>> The local variable 'index_specified' is never used after being assigned.
>> hence it should be redundant adn can be removed.
>
>    s/adn/and/.
>
Spelling mistake.  Thanks, checkpatch.pl can not find this. :-[ . I will be appreaciated
that David help me correct that.

Sincerely,
zhong jiang
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> [...]
>
> MBR, Sergei
>
>
>


