Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC41ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE67214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE67214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeIRULe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:11:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60839 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727348AbeIRULd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:11:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F8545613FA56;
        Tue, 18 Sep 2018 22:38:35 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 22:38:26 +0800
Subject: Re: [PATCH v2 0/8] staging: erofs: error handing and more tracepoints
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <1537280740-122019-1-git-send-email-gaoxiang25@huawei.com>
 <20180918143605.GA19347@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <744aeccc-8a8e-072a-501b-2208d0888240@huawei.com>
Date:   Tue, 18 Sep 2018 22:38:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180918143605.GA19347@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/9/18 22:36, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 10:25:32PM +0800, Gao Xiang wrote:
>> change log v2:
>>   - fix a gcc warning reported by Greg for the patch
>>         staging: erofs: clean up z_erofs_map_blocks_iter
>>
>>
>> In order to avoid conflicts with cleanup patches, Chao and I think
>> it is better to send reviewed preview patches in the erofs mailing list
>> to the community in time.
>>
>> So here is reviewed & tested patches right now, which clean up and
>> enhance the error handing and add some tracepoints for decompression.
>>
>> Note that in this patchset, bare use of 'unsigned' and NULL comparison are
>> also fixed compared with the preview patches according to the previous
>> discussion in the staging mailing list.
> 
> Thanks for the resend, looks good.

Thanks for applying...
p.s. sorry for just expression... I mean "with my pleasure", sorry about my english...

Thanks,
Gao Xiang

> 
> greg k-h
> 
