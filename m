Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754875AbeEHKEY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:04:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754631AbeEHKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:04:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 May 2018 15:34:19 +0530
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
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 2/5] backlight: qcom-wled: Add support for WLED4
 peripheral
In-Reply-To: <20180507164534.GB21042@rob-hp-laptop>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-3-git-send-email-kgunda@codeaurora.org>
 <20180507164534.GB21042@rob-hp-laptop>
Message-ID: <398b0fafebdcad8072d592c2ab812286@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-07 22:15, Rob Herring wrote:
> On Thu, May 03, 2018 at 03:42:29PM +0530, Kiran Gunda wrote:
>> WLED4 peripheral is present on some PMICs like pmi8998
>> and pm660l. It has a different register map and also
>> configurations are different. Add support for it.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-
> 
> Please split bindings to a separate patch.
> 
> This is also a whole lot of churn re-formatting. That is fine, but 
> don't
> mix actual changes to the binding with re-formatting. You can do 2
> patches in this case:
> 
> - move and reformat (as long as the move shows up as a move
> and not a remove and add)
> - additions for new chips
> 
Sure. I will do it in the next series.
>>  drivers/video/backlight/qcom-wled.c                | 749 
>> +++++++++++++++------
>>  2 files changed, 696 insertions(+), 225 deletions(-)
