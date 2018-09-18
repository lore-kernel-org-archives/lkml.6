Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085CEECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8016121471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8016121471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeIROlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:41:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbeIROlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:41:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E3C006EEE6206;
        Tue, 18 Sep 2018 17:10:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 17:09:58 +0800
Message-ID: <5BA0C0E5.3040600@huawei.com>
Date:   Tue, 18 Sep 2018 17:09:57 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <tomas.winkler@intel.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc: remove redundant include moduleparam.h
References: <1537259682-44758-1-git-send-email-zhongjiang@huawei.com> <20180918085534.GA3374@kroah.com>
In-Reply-To: <20180918085534.GA3374@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 16:55, Greg KH wrote:
> On Tue, Sep 18, 2018 at 04:34:42PM +0800, zhong jiang wrote:
>> module.h already contains moduleparam.h,  so it is safe to remove
>> the redundant include.
>>
>> The issue is detected with the help of Coccinelle.
>>
>> eePlease enter the commit message for your changes. Lines starting
> Odd line to have in a changelog text :)
>
> Please fix up and resend.
It's my fault to have a odd line.  I will resend. Thanks.

Sincerely,
zhong jiang
> tanks,
>
> greg k-h
>
> .
>


