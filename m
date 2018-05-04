Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeEDGKJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:10:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeEDGKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:10:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68525607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH] drm/bridge: adv7511: fix spelling of driver name in
 Kconfig
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>, Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
References: <20180426213644.29318-1-peda@axentia.se>
 <1577204.ITjXg41EEb@avalon>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <8dbfb13e-31d4-c4b0-77ec-0bee79890308@codeaurora.org>
Date: Fri, 4 May 2018 11:40:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1577204.ITjXg41EEb@avalon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 27 April 2018 03:11 AM, Laurent Pinchart wrote:
> Hi Peter,
> 
> Thank you for the patch.
> 
> On Friday, 27 April 2018 00:36:44 EEST Peter Rosin wrote:
>> Could perhaps prevent some confusion.

queued to drm-misc-next

Thanks,
Archit

>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> ---
>>   drivers/gpu/drm/bridge/adv7511/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/adv7511/Kconfig
>> b/drivers/gpu/drm/bridge/adv7511/Kconfig index 592b9d2ec034..944e440c4fde
>> 100644
>> --- a/drivers/gpu/drm/bridge/adv7511/Kconfig
>> +++ b/drivers/gpu/drm/bridge/adv7511/Kconfig
>> @@ -1,5 +1,5 @@
>>   config DRM_I2C_ADV7511
>> -	tristate "AV7511 encoder"
>> +	tristate "ADV7511 encoder"
>>   	depends on OF
>>   	select DRM_KMS_HELPER
>>   	select REGMAP_I2C
> 
> 
