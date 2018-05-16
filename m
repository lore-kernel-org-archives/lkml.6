Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeEPTYh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:24:37 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43601 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeEPTYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:24:35 -0400
X-Google-Smtp-Source: AB8JxZryxid9/ASIhC3WAbnxVrFkEPyRmUKilS+kM7UUAlLAWTQsrm5f48jDYnCYDXe0y7nL2zM0lQ==
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: sort frequencies in
 ascending order
To: Viresh Kumar <viresh.kumar@linaro.org>, Markus Mayer <code@mmayer.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180516034954.56475-1-code@mmayer.net>
 <20180516043218.7ktq5vjq2rhcszz5@vireshk-i7>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <71309e94-90d4-2b58-729b-9ab488c6d554@gmail.com>
Date: Wed, 16 May 2018 12:24:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516043218.7ktq5vjq2rhcszz5@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 09:32 PM, Viresh Kumar wrote:
> On 15-05-18, 20:49, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> Most CPUfreq drivers (at least on ARM) seem to be sorting the available
>> frequencies from lowest to highest. To match this behaviour, we reverse
>> the sorting order in brcmstb-avs-cpufreq, so it is now also lowest to
>> highest.
> 
> The reasoning isn't correct. Just because everyone else is doing it
> doesn't make it right and so you shouldn't change just because of
> that.
> 
> What you must written instead in the commit log is that the cpufreq
> core performs better if the table is sorted (in any order), and so we
> must sort it as well.

Is there a reason why set_freq_table_sorted() tries an ascending or
descending sort, but does not enforce one versus another for all drivers?

> 
> But I feel the table is already sorted for your platform, isn't it?
> And I don't see a clear advantage of merging this patch.

The patch changes the order to have the lowest to highest, whereas the
current implementation has them from highest to lowest. From what you
are saying, it sounds like this is unnecessary, since the sorting is
already making things efficient enough, so this is just a cosmetic thing?

> 
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> index b07559b9ed99..7dac3205d3eb 100644
>> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> @@ -403,7 +403,7 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
>>  {
>>  	struct cpufreq_frequency_table *table;
>>  	unsigned int pstate;
>> -	int i, ret;
>> +	int p, i, ret;
>>  
>>  	/* Remember P-state for later */
>>  	ret = brcm_avs_get_pstate(priv, &pstate);
>> @@ -415,12 +415,13 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
>>  	if (!table)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> -	for (i = AVS_PSTATE_P0; i <= AVS_PSTATE_MAX; i++) {
>> -		ret = brcm_avs_set_pstate(priv, i);
>> +	for (p = AVS_PSTATE_MAX, i = 0; p >= 0; p--, i++) {
>> +		ret = brcm_avs_set_pstate(priv, p);
>>  		if (ret)
>>  			return ERR_PTR(ret);
>>  		table[i].frequency = brcm_avs_get_frequency(priv->base);
>> -		table[i].driver_data = i;
>> +		/* Store the corresponding P-state with each frequency */
>> +		table[i].driver_data = p;
>>  	}
>>  	table[i].frequency = CPUFREQ_TABLE_END;
>>  
>> -- 
>> 2.7.4
> 


-- 
Florian
