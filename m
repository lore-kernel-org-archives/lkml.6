Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEGF5E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 01:57:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeEGF5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 01:57:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 11:26:59 +0530
From: kgunda@codeaurora.org
To: Jingoo Han <jingoohan1@gmail.com>
Cc: bjorn.andersson@linaro.org, "'Lee Jones'" <lee.jones@linaro.org>,
        "'Daniel Thompson'" <daniel.thompson@linaro.org>,
        "'Jacek Anaszewski'" <jacek.anaszewski@gmail.com>,
        "'Pavel Machek'" <pavel@ucw.cz>, "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 1/5] backlight: qcom-wled: Rename pm8941-wled.c to
 qcom-wled.c
In-Reply-To: <000201d3e3c0$4cdf87a0$e69e96e0$@gmail.com>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-2-git-send-email-kgunda@codeaurora.org>
 <000201d3e3c0$4cdf87a0$e69e96e0$@gmail.com>
Message-ID: <a9faa8c2866f44b46c3733c8165f6bae@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingoo Han,
Thanks for the response.

Thanks,
Kiran
On 2018-05-04 21:25, Jingoo Han wrote:
> On Thursday, May 3, 2018 6:12 AM, Kiran Gunda wrote:
> 
> If you really want someone to review your patch, please add more 
> detailed
> explanations.
> 
> 1. Please add 0th patch.
I have already added the 0th patch (cover letter). Following is the 
subject for the same.
forwarding the same to you.
[PATCH V2 0/5] backlight: qcom-wled: Support for QCOM wled driver

> 2. Please add what the difference is between V1 and V2 patches.
> 
Already added the difference between V1 and V2 in the cover letter (0th 
patch).
Please let me know if you are looking for any other info. Following is 
the difference
added between v1 and v2.
>>> 
changes from v1:
     Fixed the commit message for
     backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c

> If you cannot understand what I am saying, just ask another person who 
> have
> an experience to send patches to Linux mailing-list.
> 
> Best regards,
> Jingoo Han
> 
>> 
>> pm8941-wled.c driver is supporting the WLED peripheral
>> on pm8941. Rename it to qcom-wled.c so that it can support
>> WLED on multiple PMICs.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 
>> +-
>>  drivers/video/backlight/Kconfig                                   | 8
> ++++----
>>  drivers/video/backlight/Makefile                                  | 2 
>> +-
>>  drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
>>  4 files changed, 6 insertions(+), 6 deletions(-)
>>  rename 
>> Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt
>> => qcom-wled.txt} (95%)
>>  rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)
>> 
>> diff --git a/Documentation/devicetree/bindings/leds/backlight/pm8941-
>> wled.txt 
>> b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> similarity index 95%
>> rename from Documentation/devicetree/bindings/leds/backlight/pm8941-
>> wled.txt
>> rename to 
>> Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> index e5b294d..fb39e32 100644
>> --- a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
>> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> @@ -1,4 +1,4 @@
>> -Binding for Qualcomm PM8941 WLED driver
>> +Binding for Qualcomm Technologies, Inc. WLED driver
>> 
>>  Required properties:
>>  - compatible: should be "qcom,pm8941-wled"
>> diff --git a/drivers/video/backlight/Kconfig
>> b/drivers/video/backlight/Kconfig
>> index 4e1d2ad..8c095e3 100644
>> --- a/drivers/video/backlight/Kconfig
>> +++ b/drivers/video/backlight/Kconfig
>> @@ -299,12 +299,12 @@ config BACKLIGHT_TOSA
>>  	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
>>  	  for its backlight
>> 
>> -config BACKLIGHT_PM8941_WLED
>> -	tristate "Qualcomm PM8941 WLED Driver"
>> +config BACKLIGHT_QCOM_WLED
>> +	tristate "Qualcomm PMIC WLED Driver"
>>  	select REGMAP
>>  	help
>> -	  If you have the Qualcomm PM8941, say Y to enable a driver for the
>> -	  WLED block.
>> +	  If you have the Qualcomm PMIC, say Y to enable a driver for the
>> +	  WLED block. Currently it supports PM8941 and PMI8998.
>> 
>>  config BACKLIGHT_SAHARA
>>  	tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
>> diff --git a/drivers/video/backlight/Makefile
>> b/drivers/video/backlight/Makefile
>> index 5e28f01..6fd76ef 100644
>> --- a/drivers/video/backlight/Makefile
>> +++ b/drivers/video/backlight/Makefile
>> @@ -49,8 +49,8 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)		+=
> omap1_bl.o
>>  obj-$(CONFIG_BACKLIGHT_OT200)		+= ot200_bl.o
>>  obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
>>  obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
>> -obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+= pm8941-wled.o
>>  obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
>> +obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
>>  obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
>>  obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
>>  obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
>> diff --git a/drivers/video/backlight/pm8941-wled.c
>> b/drivers/video/backlight/qcom-wled.c
>> similarity index 100%
>> rename from drivers/video/backlight/pm8941-wled.c
>> rename to drivers/video/backlight/qcom-wled.c
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>>  a Linux Foundation Collaborative Project
