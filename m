Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755309AbeDCIvF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:51:05 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14581 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbeDCIvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:51:03 -0400
X-IronPort-AV: E=Sophos;i="5.48,400,1517900400";
   d="scan'208";a="10230322"
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake: "Stoping" ->
 "Stopping"
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Colin King <colin.king@canonical.com>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180331085420.GE14180@piout.net>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <051e667b-6a62-1c9c-344f-c1aed341fe8d@microchip.com>
Date: Tue, 3 Apr 2018 10:50:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180331085420.GE14180@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2018 at 10:54, Alexandre Belloni wrote:
> On 30/03/2018 at 16:44:20 +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Trivial fix to spelling mistake in pr_debug message text
>>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   sound/soc/atmel/atmel_ssc_dai.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
>> index a1e2c5682dcd..1c7af0ca98ec 100644
>> --- a/sound/soc/atmel/atmel_ssc_dai.c
>> +++ b/sound/soc/atmel/atmel_ssc_dai.c
>> @@ -820,7 +820,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>>   		if (ret < 0) {
>>   			printk(KERN_WARNING
>>   					"atmel_ssc_dai: request_irq failure\n");
>> -			pr_debug("Atmel_ssc_dai: Stoping clock\n");
>> +			pr_debug("Atmel_ssc_dai: Stopping clock\n");
>>   			clk_disable(ssc_p->ssc->clk);
>>   			return ret;
>>   		}
>> -- 
>> 2.15.1
>>
> 


-- 
Nicolas Ferre
