Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeEHJxU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:53:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeEHJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:53:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 May 2018 15:23:15 +0530
From: kgunda@codeaurora.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, bjorn.andersson@linaro.org,
        "'Lee Jones'" <lee.jones@linaro.org>,
        "'Jacek Anaszewski'" <jacek.anaszewski@gmail.com>,
        "'Pavel Machek'" <pavel@ucw.cz>, "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 1/5] backlight: qcom-wled: Rename pm8941-wled.c to
 qcom-wled.c
In-Reply-To: <20180508083658.mc7x7izthxjrv5ey@holly.lan>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-2-git-send-email-kgunda@codeaurora.org>
 <000201d3e3c0$4cdf87a0$e69e96e0$@gmail.com>
 <a9faa8c2866f44b46c3733c8165f6bae@codeaurora.org>
 <20180508083658.mc7x7izthxjrv5ey@holly.lan>
Message-ID: <19e02b14f0b828b9470eb863ab9f3a11@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-08 14:06, Daniel Thompson wrote:
> On Mon, May 07, 2018 at 11:26:59AM +0530, kgunda@codeaurora.org wrote:
>> Hi Jingoo Han,
>> Thanks for the response.
>> 
>> Thanks,
>> Kiran
>> On 2018-05-04 21:25, Jingoo Han wrote:
>> > On Thursday, May 3, 2018 6:12 AM, Kiran Gunda wrote:
>> >
>> > If you really want someone to review your patch, please add more
>> > detailed
>> > explanations.
>> >
>> > 1. Please add 0th patch.
>> I have already added the 0th patch (cover letter). Following is the 
>> subject
>> for the same.
>> forwarding the same to you.
>> [PATCH V2 0/5] backlight: qcom-wled: Support for QCOM wled driver
> 
> Perhaps you should interpret Jingoo's comment as a request to improve
> the To: and Cc: list on the 0th patch the next time you circulate it.
> 
> Many maintainers configure their mailers to give patches where they are
> in the To: or Cc: list special treatment so it confusing when a series
> arrives with a spartan set of recipients for the 0th patch (and doubly
> confusing when every patch in the set targets the same driver).
> 
> 
> Daniel.
Ok. Got it. Not sure how the To: Cc: list on the 0th patch got shrink, 
while I was
using the To: Cc: list same for all the patches. Anyways, will double 
check of it while
circulating the next series.
