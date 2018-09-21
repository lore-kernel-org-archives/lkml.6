Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA4FECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DA821533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DA821533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbeIUJXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:23:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbeIUJXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:23:31 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C4D0953F1E239;
        Fri, 21 Sep 2018 11:36:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 11:36:35 +0800
Message-ID: <5BA46742.4010804@huawei.com>
Date:   Fri, 21 Sep 2018 11:36:34 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Todor Tomov <todor.tomov@linaro.org>
CC:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: qcom: remove duplicated include file
References: <1537419595-29990-1-git-send-email-zhongjiang@huawei.com> <43b41757-18ea-cbb3-1578-ba4068b13ab1@linaro.org>
In-Reply-To: <43b41757-18ea-cbb3-1578-ba4068b13ab1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/20 13:55, Todor Tomov wrote:
> Thank you for spotting that!
>
> On 19.09.2018 21:59, zhong jiang wrote:
>> device.h have duplicated include. hence just remove
>> redundant include file.
> I think it will be better to remove the second occurrence because
> it will keep the alphabetical order of the includes.
Yep,  I forget the point.  Will change in v2.

Thanks,
zhong jiang
> Best regards,
> Todor Tomov
>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/media/platform/qcom/camss/camss.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
>> index 418996d..0823a71 100644
>> --- a/drivers/media/platform/qcom/camss/camss.h
>> +++ b/drivers/media/platform/qcom/camss/camss.h
>> @@ -10,7 +10,6 @@
>>  #ifndef QC_MSM_CAMSS_H
>>  #define QC_MSM_CAMSS_H
>>  
>> -#include <linux/device.h>
>>  #include <linux/types.h>
>>  #include <media/v4l2-async.h>
>>  #include <media/v4l2-device.h>
>>
>
>


