Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C6BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA39214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA39214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIQMmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:42:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbeIQMmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:42:12 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 94E29239B23C0;
        Mon, 17 Sep 2018 15:16:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 15:16:00 +0800
Message-ID: <5B9F54AF.7010208@huawei.com>
Date:   Mon, 17 Sep 2018 15:15:59 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <georgi.djakov@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] interconnect: Fix a GCC compiler warning
References: <1537108310-2086-1-git-send-email-zhongjiang@huawei.com> <5B9F4683.7010706@huawei.com> <20180917065428.GB26155@kroah.com>
In-Reply-To: <20180917065428.GB26155@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/17 14:54, Greg KH wrote:
> On Mon, Sep 17, 2018 at 02:15:31PM +0800, zhong jiang wrote:
>> On 2018/9/16 22:31, zhong jiang wrote:
>>> Fix the following compile warning:
>> +to  Andrew and Greg
>>
> +me for what?  Nothing is here :(
The drivers/interconnect/core.c is not updated since 2017. I think the maintainer
 is busy with other things.  Therefore,  I hope that you or Andrew and pick up the
patch. :-)  . if you can not do this.  I am sorry for disturbing you.

Thanks,
zhong jiang

