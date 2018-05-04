Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeEDIjh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:39:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51604 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbeEDIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:39:33 -0400
X-Google-Smtp-Source: AB8JxZpvtqR1ixDuYmWwSQlpp0zJlO5J793y706zwglHWG/zqMrLyWRAZ6gsX5F5c5emNJHnaKFQIw==
Subject: Re: [PATCH V4 5/8] soc: mediatek: pwrap: add pwrap for mt6797 SoCs
To: Sean Wang <sean.wang@mediatek.com>, Argus Lin <argus.lin@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>, wsd_upstream@mediatek.com,
        henryc.chen@mediatek.com, flora.fu@mediatek.com,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20180502092112.3991-1-argus.lin@mediatek.com>
 <20180502092112.3991-6-argus.lin@mediatek.com>
 <1525320067.14792.95.camel@mtkswgap22> <1525328436.6214.10.camel@mtkswgap22>
 <1525403052.14792.131.camel@mtkswgap22>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <69e4766f-8c7a-7729-93f8-4f87d2ceff8b@gmail.com>
Date: Fri, 4 May 2018 10:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525403052.14792.131.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2018 05:04 AM, Sean Wang wrote:
> On Thu, 2018-05-03 at 14:20 +0800, Argus Lin wrote:
>> On Thu, 2018-05-03 at 12:01 +0800, Sean Wang wrote:
>>>  };
> 
> [...]
> 
>>>> @@ -1503,11 +1581,13 @@ static int pwrap_probe(struct platform_device *pdev)
>>>>  	if (IS_ERR(wrp->base))
>>>>  		return PTR_ERR(wrp->base);
>>>>  
>>>> -	wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
>>>> -	if (IS_ERR(wrp->rstc)) {
>>>> -		ret = PTR_ERR(wrp->rstc);
>>>> -		dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
>>>> -		return ret;
>>>> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_RESET)) {
>>>> +		wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
>>>
>>> there should be a reset bit present for pwrap on infrasys.
>>>
>>> the specific condition can be dropped when the reset cell is exported from infrasys and then the device has a reference to it.
>> hmm, I think it need to keep here.
>> because after pwrap initialized, it can't be reset alone.
>> It needs to reset PMIC simultaneously, too.
> 
> Reset a pair, either a master or its slave, all had been a part of
> pwrap_init.
> 
> The reset controller provided here is just to reset pwrap device.
> And for its slave reset, it should be done by pwrap_reset_spislave. 
> 
> So for MT6397, it should be able to fall into the same procedure.
> 
>>>
>>>> +		if (IS_ERR(wrp->rstc)) {
>>>> +			ret = PTR_ERR(wrp->rstc);
>>>> +			dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
>>>> +			return ret;
>>>> +		}
>>>>  	}
>>>>  
>>>>  	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
>>>> @@ -1549,9 +1629,17 @@ static int pwrap_probe(struct platform_device *pdev)
>>>>  	if (ret)
>>>>  		goto err_out1;
>>>>  
>>>> -	/* Enable internal dynamic clock */
>>>> -	pwrap_writel(wrp, 1, PWRAP_DCM_EN);
>>>> -	pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
>>>> +	/*
>>>> +	 * add dcm capability check
>>>> +	 */
>>>> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {
>>>
>>> the specific condition can be dropped since so far all devices the driver can support are owning PWRAP_CAP_DCM
>> We did not support DCM for future chips.
>> MT6797 is the last one.
>> This why I want to add judgement here.
> 
> The series is only for MT6797 pwrap, so it's fine with only adding these
> things the SoC actually relies on. 
> 
> PWRAP_CAP_DCM should not be added until a new SoC without dcm is really
> introduced.
> 

I agree (and I think I said this already in a previous review).

Regards,
Matthias

>>>
>>>> +		if (wrp->master->type == PWRAP_MT6797)
>>>> +			pwrap_writel(wrp, 3, PWRAP_DCM_EN);
>>>
>>> the setup for MT6797 can be moved into .init_soc_specific callback ?
>>
>> I think put it here is more generally.
>>>
>>>> +		else
>>>> +			pwrap_writel(wrp, 1, PWRAP_DCM_EN);
>>>> +
>>>> +		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
>>>> +	}
>>>>  
>>>>  	/*
>>>>  	 * The PMIC could already be initialized by the bootloader.
>>>> @@ -1580,6 +1668,12 @@ static int pwrap_probe(struct platform_device *pdev)
>>>>  	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
>>>>  	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>>>>  	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
>>>> +	/*
>>>> +	 * We add INT1 interrupt to handle starvation and request exception
>>>> +	 * If we support it, we should enable them here.
>>>> +	 */
>>>> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
>>>> +		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>>>>  
>>>
>>> if there is no explicitly enabling on INT1, then ISR handling for INT1 is also unnecessary
>>
>> It's ok for me.
>>>
>>>>  	irq = platform_get_irq(pdev, 0);
>>>>  	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
>>>
>>>
>>>
>>
>>
> 
> 
