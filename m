Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56921C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA7A21976
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA7A21976
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeHFEFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:05:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725266AbeHFEFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:05:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4F04A80BADAE5;
        Mon,  6 Aug 2018 09:58:37 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 09:58:28 +0800
Subject: Re: [PATCH] drivers/staging: Remove some unneeded semicolon
To:     Gao Xiang <gaoxiang25@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>
CC:     <gregkh@linuxfoundation.org>, <rspringer@google.com>,
        <jnjoseph@google.com>, <benchan@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <1533477429-17379-1-git-send-email-zhongjiang@huawei.com>
 <687229f8-549f-cec1-c83f-b8acfd32d767@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e80780ed-42c8-3f8c-9197-1c6ac386fb30@huawei.com>
Date:   Mon, 6 Aug 2018 09:58:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <687229f8-549f-cec1-c83f-b8acfd32d767@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2018/8/6 9:27, Gao Xiang wrote:
> Hi Jiang,
> 
> On 2018/8/5 21:57, zhong jiang wrote:
>> That semicolons are unneeded, JUst remove them.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> 
> Thanks for your patch. Since erofs and gasket are different feature, it is better to seperate into two patches.
> and could you please cc linux-erofs mailing list <linux-erofs@lists.ozlabs.org> as well?
> 
> Yes, there is an extra semicolon in z_erofs_vle_unzip_all, it was reported by Julia Lawall several days ago.
> Actually, there is a patch in linux-erofs mailing list, but it seems that Chao hasn't reviewed it yet...

Oh, sorry, I missed this one, let me check/review all recent patches again and
update them in tree later.

Thanks,

> 
> https://lists.ozlabs.org/pipermail/linux-erofs/2018-August/000303.html
> 
> I will add Signed-off-by: zhong jiang <zhongjiang@huawei.com> to the original patch if if you don't mind, do you?
> 
> Thanks,
> Gao Xiang
> 
> .
> 

