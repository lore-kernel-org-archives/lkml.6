Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19954C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3F5219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3F5219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeHFESP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:18:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725777AbeHFESP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:18:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B16CD82CDCCF4;
        Mon,  6 Aug 2018 10:11:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 10:11:18 +0800
Message-ID: <5B67AE47.4080307@huawei.com>
Date:   Mon, 6 Aug 2018 10:11:19 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Gao Xiang <gaoxiang25@huawei.com>
CC:     <gregkh@linuxfoundation.org>, <yuchao0@huawei.com>,
        <rspringer@google.com>, <jnjoseph@google.com>,
        <benchan@chromium.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/staging: Remove some unneeded semicolon
References: <1533477429-17379-1-git-send-email-zhongjiang@huawei.com> <687229f8-549f-cec1-c83f-b8acfd32d767@huawei.com>
In-Reply-To: <687229f8-549f-cec1-c83f-b8acfd32d767@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/6 9:27, Gao Xiang wrote:
> Hi Jiang,
>
> On 2018/8/5 21:57, zhong jiang wrote:
>> That semicolons are unneeded, JUst remove them.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> Thanks for your patch. Since erofs and gasket are different feature, it is better to seperate into two patches.
> and could you please cc linux-erofs mailing list <linux-erofs@lists.ozlabs.org> as well?
>
> Yes, there is an extra semicolon in z_erofs_vle_unzip_all, it was reported by Julia Lawall several days ago.
> Actually, there is a patch in linux-erofs mailing list, but it seems that Chao hasn't reviewed it yet...
>
> https://lists.ozlabs.org/pipermail/linux-erofs/2018-August/000303.html
>
> I will add Signed-off-by: zhong jiang <zhongjiang@huawei.com> to the original patch if if you don't mind, do you?
 do it.  Thanks.  Then I will just resend the gasket feature separately.

 Thanks,
 zhong jiang
> Thanks,
> Gao Xiang
>
> .
>


