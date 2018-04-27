Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeD0JqX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:46:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50262 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbeD0JqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:46:17 -0400
X-Google-Smtp-Source: AB8JxZo2oWrhxwGggfeX/aRdofPV/tPdehCXlOAdbh1kL9Np/BPEPzEH3HsLli4Uki+0pH+H2rWOxw==
Subject: Re: [PATCH v2 2/2] soc: mediatek: add a fixed wait for SRAM stable
To: Sean Wang <sean.wang@mediatek.com>
Cc: rjw@rjwysocki.net, khilman@baylibre.com, ulf.hansson@linaro.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <2e16481e1477dfae0cfb24568d8111da81d92628.1524472331.git.sean.wang@mediatek.com>
 <0ef8e87ba7156e626d1a1a48388f222ce917099b.1524472331.git.sean.wang@mediatek.com>
 <51840588-96e4-2520-f3d7-a61e74da6814@gmail.com>
 <1524476340.12322.14.camel@mtkswgap22>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <0ec15c8a-ca90-26c3-1ea6-00bf0d48b62a@gmail.com>
Date: Fri, 27 Apr 2018 11:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524476340.12322.14.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On 04/23/2018 11:39 AM, Sean Wang wrote:
> On Mon, 2018-04-23 at 11:31 +0200, Matthias Brugger wrote:
>>
>> On 04/23/2018 10:36 AM, sean.wang@mediatek.com wrote:
>>> From: Sean Wang <sean.wang@mediatek.com>
>>>
>>> MT7622_POWER_DOMAIN_WB doesn't send an ACK when its managed SRAM becomes
>>> stable, which is not like the behavior the other power domains should
>>> have. Therefore, it's necessary for such a power domain to have a fixed
>>> and well-predefined duration to wait until its managed SRAM can be allowed
>>> to access by all functions running on the top.
>>>
>>> v1 -> v2:
>>>  - use MTK_SCPD_FWAIT_SRAM flag as an indication requiring force waiting.
>>>
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Cc: Weiyi Lu <weiyi.lu@mediatek.com>
>>> ---
>>>  drivers/soc/mediatek/mtk-scpsys.c | 24 ++++++++++++++++++------
>>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
>>> index b1b45e4..d4f1a63 100644
>>> --- a/drivers/soc/mediatek/mtk-scpsys.c
>>> +++ b/drivers/soc/mediatek/mtk-scpsys.c
>>> @@ -32,6 +32,7 @@
>>>  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
>>>  
>>>  #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
>>> +#define MTK_SCPD_FWAIT_SRAM		BIT(1)
>>>  #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>>>  
>>>  #define SPM_VDE_PWR_CON			0x0210
>>> @@ -237,11 +238,22 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>>>  	val &= ~scpd->data->sram_pdn_bits;
>>>  	writel(val, ctl_addr);
>>>  
>>> -	/* wait until SRAM_PDN_ACK all 0 */
>>> -	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
>>> -				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>> -	if (ret < 0)
>>> -		goto err_pwr_ack;
>>> +	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
>>> +	if (!MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {

After having another look on the patch, could you change the order of the if:
So that we check for the existence of the MTK_SCPD_FWAIT_SRAM and sleep and in
the else branch we to the readl_poll_timeout.

I think in the future this will make the code easier to understand as you can
easily oversee the '!' negation in the if.

Regards,
Matthias


>>> +		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
>>> +					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>> +		if (ret < 0)
>>> +			goto err_pwr_ack;
>>> +	} else {
>>> +		/*
>>> +		 * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
>>> +		 * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
>>> +		 * applied here. If there're more domains which need to force
>>> +		 * waiting for its own pre-defined value, the duration should
>>> +		 * be coded in the caps field.
>>> +		 */
>>
>> I would say, if necessary in the future we can add a switch statement here.
>> Other then that the patches look good. If you are OK, I'll just delete the last
>> sentence when applying the patch.
>>
> 
> yes, it's okay for me. 
> 
>> Regards,
>> Matthias
>>
>>> +		usleep_range(12000, 12100);
>>> +	};
>>>  
>>>  	if (scpd->data->bus_prot_mask) {
>>>  		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
>>> @@ -785,7 +797,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
>>>  		.sram_pdn_ack_bits = 0,
>>>  		.clk_id = {CLK_NONE},
>>>  		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
>>> -		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>>> +		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_FWAIT_SRAM,
>>>  	},
>>>  };
>>>  
>>>
> 
> 
