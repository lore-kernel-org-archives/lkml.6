Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932229AbeEHK0C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:26:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34518 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754371AbeEHKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:25:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 May 2018 15:55:58 +0530
From: kgunda@codeaurora.org
To: Rob Herring <robh@kernel.org>
Cc: bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V2 1/5] backlight: qcom-wled: Rename pm8941-wled.c to
 qcom-wled.c
In-Reply-To: <20180507164056.GA21042@rob-hp-laptop>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-2-git-send-email-kgunda@codeaurora.org>
 <20180507164056.GA21042@rob-hp-laptop>
Message-ID: <2ab86a91013f444c222f11b23ec31f7e@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-07 22:10, Rob Herring wrote:
> On Thu, May 03, 2018 at 03:42:28PM +0530, Kiran Gunda wrote:
>> pm8941-wled.c driver is supporting the WLED peripheral
>> on pm8941. Rename it to qcom-wled.c so that it can support
>> WLED on multiple PMICs.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 
>> +-
> 
> Please split DT bindings from driver patches.
> 
Sure. Will do that in the next series.
>>  drivers/video/backlight/Kconfig                                   | 8 
>> ++++----
>>  drivers/video/backlight/Makefile                                  | 2 
>> +-
>>  drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
>>  4 files changed, 6 insertions(+), 6 deletions(-)
>>  rename 
>> Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => 
>> qcom-wled.txt} (95%)
>>  rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
