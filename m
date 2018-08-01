Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D470C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C95520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C95520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbeHANyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:54:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10605 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388579AbeHANye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:54:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ADE14440F0FA7;
        Wed,  1 Aug 2018 20:09:01 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 1 Aug 2018
 20:08:54 +0800
Subject: Re: [PATCH RESEND 1/2] staging: erofs: add the missing break in
 z_erofs_map_blocks_iter
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <yuchao0@huawei.com>,
        <linux-erofs@lists.ozlabs.org>, <hsiangkao@aol.com>,
        <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        <miaoxie@huawei.com>, <chao@kernel.org>
References: <ea978a27-efd4-9d58-e4c0-f9d00420304f@huawei.com>
 <1533116214-70017-1-git-send-email-gaoxiang25@huawei.com>
 <20180801113620.3ufakhg3z62q46mw@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <69349ab1-e38f-c755-e966-6bf787ccc896@huawei.com>
Date:   Wed, 1 Aug 2018 20:08:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180801113620.3ufakhg3z62q46mw@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018/8/1 19:36, Dan Carpenter wrote:
> On Wed, Aug 01, 2018 at 05:36:54PM +0800, Gao Xiang wrote:
>> This patch adds a missing break after adding the default case.
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>> As pointed out by Dan Carpenter:
>>  - fix the wrong place of fallthrough comments
> Thanks.  Looks good.  Next time use [PATCH v2] instead of RESEND.  The
> word RESEND basically means you are resending a patch exactly the same
> as it was before.  You would only need to do that if we accidentally
> deleted your first patch or whatever...
> 
> regards,
> dan carpenter
> 
> 
OK, it should not be titled RESEND, and I will take care the next time.
Thanks for taking the time to review :)

Thanks,
Gao Xiang
