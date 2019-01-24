Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F78721872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAXPEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:04:02 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51872 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727755AbfAXPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:04:00 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OF1L0L027236;
        Thu, 24 Jan 2019 16:03:45 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2q3wv45bt4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 24 Jan 2019 16:03:42 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C481331;
        Thu, 24 Jan 2019 15:03:39 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9B8294FEB;
        Thu, 24 Jan 2019 15:03:39 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 24 Jan
 2019 16:03:39 +0100
Subject: Re: [Linux-stm32] [PATCH V3 1/2] mmc: mmci: add variant property to
 set command stop bit
From:   Ludovic BARRE <ludovic.barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
 <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFq7TZMKWMqmoDR0yfr2N2cf2nr4-BuEs5DPgJSGy-nvAA@mail.gmail.com>
 <35f22c1a-888d-5abd-7ffe-ecf47a74b69a@st.com>
 <9e22fd3d-f029-2a2a-18d1-af1987c94e4e@st.com>
Message-ID: <ab4cae87-0a5a-fe22-08ab-7c7661be7c8c@st.com>
Date:   Thu, 24 Jan 2019 16:03:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9e22fd3d-f029-2a2a-18d1-af1987c94e4e@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

I don't think you've seen my previous mail :-(
what is your feeling about "mmc: mmci: send stop command to clear the dpsm"

Regards
Ludo

On 1/3/19 11:35 AM, Ludovic BARRE wrote:
> hi Ulf
> 
> happy new years.
> 
> Just a gentleman ping about patch2 of this series
> "mmc: mmci: send stop command to clear the dpsm."
> 
> Regards
> Ludo
> 
> On 12/11/18 10:53 AM, Ludovic BARRE wrote:
>>
>>
>> On 12/11/18 10:47 AM, Ulf Hansson wrote:
>>> On Thu, 6 Dec 2018 at 16:13, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> On cmd12 (STOP_TRANSMISSION), STM32 sdmmc variant needs to set
>>>> cmdstop bit in command register. The CPSM ("Command Path State 
>>>> Machine")
>>>> treats the command as a Stop Transmission command and signals
>>>> abort to the DPSM ("Data Path State Machine").
>>>>
>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> Applied for next, thanks!
>>
>> thanks
>>
>>>
>>> Withholding patch2 for a while, as I need some more time to review it.
>>
>> No problem,
>>
>> Regards
>> Ludo
>>
>>>
>>> Kind regards
>>> Uffe
>>>
>>>> ---
>>>>   drivers/mmc/host/mmci.c | 6 ++++++
>>>>   drivers/mmc/host/mmci.h | 2 ++
>>>>   2 files changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>>> index 13fa640..e352f5a 100644
>>>> --- a/drivers/mmc/host/mmci.c
>>>> +++ b/drivers/mmc/host/mmci.c
>>>> @@ -21,6 +21,7 @@
>>>>   #include <linux/err.h>
>>>>   #include <linux/highmem.h>
>>>>   #include <linux/log2.h>
>>>> +#include <linux/mmc/mmc.h>
>>>>   #include <linux/mmc/pm.h>
>>>>   #include <linux/mmc/host.h>
>>>>   #include <linux/mmc/card.h>
>>>> @@ -274,6 +275,7 @@ static struct variant_data variant_stm32_sdmmc = {
>>>>          .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
>>>>          .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
>>>>          .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
>>>> +       .cmdreg_stop            = MCI_CPSM_STM32_CMDSTOP,
>>>>          .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
>>>>          .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
>>>>          .datactrl_first         = true,
>>>> @@ -1100,6 +1102,10 @@ mmci_start_command(struct mmci_host *host, 
>>>> struct mmc_command *cmd, u32 c)
>>>>                  mmci_reg_delay(host);
>>>>          }
>>>>
>>>> +       if (host->variant->cmdreg_stop &&
>>>> +           cmd->opcode == MMC_STOP_TRANSMISSION)
>>>> +               c |= host->variant->cmdreg_stop;
>>>> +
>>>>          c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>>>>          if (cmd->flags & MMC_RSP_PRESENT) {
>>>>                  if (cmd->flags & MMC_RSP_136)
>>>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>>>> index 550dd39..2422909 100644
>>>> --- a/drivers/mmc/host/mmci.h
>>>> +++ b/drivers/mmc/host/mmci.h
>>>> @@ -264,6 +264,7 @@ struct mmci_host;
>>>>    * @cmdreg_lrsp_crc: enable value for long response with crc
>>>>    * @cmdreg_srsp_crc: enable value for short response with crc
>>>>    * @cmdreg_srsp: enable value for short response without crc
>>>> + * @cmdreg_stop: enable value for stop and abort transmission
>>>>    * @datalength_bits: number of bits in the MMCIDATALENGTH register
>>>>    * @fifosize: number of bytes that can be written when 
>>>> MMCI_TXFIFOEMPTY
>>>>    *           is asserted (likewise for RX)
>>>> @@ -316,6 +317,7 @@ struct variant_data {
>>>>          unsigned int            cmdreg_lrsp_crc;
>>>>          unsigned int            cmdreg_srsp_crc;
>>>>          unsigned int            cmdreg_srsp;
>>>> +       unsigned int            cmdreg_stop;
>>>>          unsigned int            datalength_bits;
>>>>          unsigned int            fifosize;
>>>>          unsigned int            fifohalfsize;
>>>> -- 
>>>> 2.7.4
>>>>
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
