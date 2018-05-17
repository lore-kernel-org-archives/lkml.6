Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEQKxn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:53:43 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39901 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:53:41 -0400
X-Google-Smtp-Source: AB8JxZrxIPX2Jktb8BFan5Ulhb+N3e55/ImY9KVIMBlTAJZUe8KAkU1BwKCMBb1OU+o19haX2Z/+Ew==
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: fix some doc warnings.
To: Vinod Koul <vinod.koul@linaro.org>
Cc: agross@codeaurora.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
 <20180517105049.GZ13271@vkoul-mobl>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c3b63215-ed0f-93ee-69df-6b22053f0479@linaro.org>
Date: Thu, 17 May 2018 11:53:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180517105049.GZ13271@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/18 11:50, Vinod Koul wrote:
> On 17-05-18, 10:59, Srinivas Kandagatla wrote:
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index 4a828c18099a..a05fff8a1447 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -451,7 +451,7 @@ static void bam_reset_channel(struct bam_chan *bchan)
>>   /**
>>    * bam_chan_init_hw - Initialize channel hardware
>>    * @bchan: bam channel
>> - *
>> + * @dir: DMA transfer direction
> 
> Do you want to add an empty line here?
> 
TBH, Am not 100% sure it it adds any value.

Most of the function docs in the file have this same issue.. :-)

let me know if you still want an empty line, I can respin.

--srini

>>    * This function resets and initializes the BAM channel
