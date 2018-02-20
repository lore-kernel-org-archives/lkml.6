Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeBTJep (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:34:45 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:39818 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeBTJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:34:42 -0500
X-Google-Smtp-Source: AH8x2245vQa2FysgZ4L+Ho6JQwUrolFWQ6B3I+36dUBi9hNyeR9YBPR1pGvcKR0fb1wHHKpq2oQR7Q==
Subject: Re: [alsa-devel] [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to
 Q6AFE
To: Rohit Kumar <rohitkr@codeaurora.org>, andy.gross@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org,
        spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
 <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2360f3a9-f207-bc84-b0da-2675b7c9f0e0@linaro.org>
Date: Tue, 20 Feb 2018 09:34:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review comments



On 19/02/18 10:30, Rohit Kumar wrote:
>> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
>> index d5280355c24f..748f5e891dcf 100644
>> --- a/sound/soc/qcom/Makefile
>> +++ b/sound/soc/qcom/Makefile
>> @@ -13,6 +13,11 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += 
>> snd-soc-lpass-apq8016.o
>>   # Machine
>>   snd-soc-storm-objs := storm.o
>>   snd-soc-apq8016-sbc-objs := apq8016_sbc.o
>> +snd-soc-msm8996-objs := apq8096.o
> This needs to be moved out of this patch

Will fix it in next version.

>>   obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>>   obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>> +obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-msm8996.o
>> +
>> +#DSP lib 
