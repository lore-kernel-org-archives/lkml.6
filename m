Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933246AbeEHIhH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:37:07 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36697 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932618AbeEHIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:37:02 -0400
X-Google-Smtp-Source: AB8JxZqbhgoYupN31AkU8xMOBZU/pcRytYaKdxHwtgawW5eMrH9PrN2WaG4zkndXNam17Se/TySBxg==
Date: Tue, 8 May 2018 09:36:58 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: kgunda@codeaurora.org
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
Message-ID: <20180508083658.mc7x7izthxjrv5ey@holly.lan>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-2-git-send-email-kgunda@codeaurora.org>
 <000201d3e3c0$4cdf87a0$e69e96e0$@gmail.com>
 <a9faa8c2866f44b46c3733c8165f6bae@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9faa8c2866f44b46c3733c8165f6bae@codeaurora.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 11:26:59AM +0530, kgunda@codeaurora.org wrote:
> Hi Jingoo Han,
> Thanks for the response.
> 
> Thanks,
> Kiran
> On 2018-05-04 21:25, Jingoo Han wrote:
> > On Thursday, May 3, 2018 6:12 AM, Kiran Gunda wrote:
> > 
> > If you really want someone to review your patch, please add more
> > detailed
> > explanations.
> > 
> > 1. Please add 0th patch.
> I have already added the 0th patch (cover letter). Following is the subject
> for the same.
> forwarding the same to you.
> [PATCH V2 0/5] backlight: qcom-wled: Support for QCOM wled driver

Perhaps you should interpret Jingoo's comment as a request to improve
the To: and Cc: list on the 0th patch the next time you circulate it.

Many maintainers configure their mailers to give patches where they are
in the To: or Cc: list special treatment so it confusing when a series
arrives with a spartan set of recipients for the 0th patch (and doubly
confusing when every patch in the set targets the same driver).


Daniel.
