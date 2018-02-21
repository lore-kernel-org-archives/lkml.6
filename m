Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBUXYC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:24:02 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:43808 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUXX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:23:59 -0500
X-Google-Smtp-Source: AH8x227shDbaCzurl3FBBPBhFqSdKYBPj8KLN56ezI91WFxxyVFjaiYoYCzwVST/6ycZZ+1Q7yw17O4sZwhd36DwpKg=
MIME-Version: 1.0
In-Reply-To: <20180219163651.66936056@why.wild-wind.fr.eu.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org> <20180216060503.22006-4-rnayak@codeaurora.org>
 <20180219163651.66936056@why.wild-wind.fr.eu.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 21 Feb 2018 15:23:57 -0800
X-Google-Sender-Auth: cwYfaeBXLmfcJ1GbRx223shBdtI
Message-ID: <CAD=FV=WgyX-O8haJp3WpzPodV2f1sokL9hW_qe7R8hVYy3v+sg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Andy Gross <andy.gross@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, evgreen@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 19, 2018 at 8:36 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> +                     interrupts = <GIC_SPI 208 IRQ_TYPE_NONE>;
>
> Please do not use IRQ_TYPE_NONE, ever. It doesn't exist in the GIC
> binding. Set it to the actual trigger value.
>

>> +                     interrupts = <GIC_SPI 481 IRQ_TYPE_NONE>;
>
> Same here.

Thanks for the review Marc!


Andy: If I'm reading everything correctly you're the one who would
collect these patches and apply them.  Is that right?  Do they look OK
to you in general?  Would you prefer that Rajendra send out a v5 with
the fixes pointed out by Marc, or would you prefer to fix them up
yourself when applying?  Is now a good time or would you prefer to
wait?

Thanks!  :)

-Doug
