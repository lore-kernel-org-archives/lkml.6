Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756177AbeDZNcB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:32:01 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33823 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755974AbeDZNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:31:56 -0400
X-Google-Smtp-Source: AIpwx4/OqaWn7mWJSkxXEMFjUiVr8r+ouIQfdJiMN9VrzkMpiaKjYnXf/UhJIaRqQIiSQrqdAJbC7A==
Date: Thu, 26 Apr 2018 19:01:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Todor Tomov <todor.tomov@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dragonboard@lists.96boards.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [dragonboard] [PATCH 1/1] dts: qcom: db820c: Add gpio-line-names
 property
Message-ID: <20180426133145.24dfnfarnuunf2wy@mani>
References: <20180414031811.11351-1-manivannan.sadhasivam@linaro.org>
 <20180414031811.11351-2-manivannan.sadhasivam@linaro.org>
 <9acdd412-9b6d-ec63-c5ca-c5fa8d98d489@linaro.org>
 <20180416100306.5f6bzkzlsx3ufvw7@mani>
 <CACRpkdZxwz5=oTxGWBgVHfy-D9s-f03qqjypUeJj6GrpXQcEcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZxwz5=oTxGWBgVHfy-D9s-f03qqjypUeJj6GrpXQcEcQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Apr 26, 2018 at 03:23:57PM +0200, Linus Walleij wrote:
> On Mon, Apr 16, 2018 at 12:03 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Mon, Apr 16, 2018 at 11:48:59AM +0300, Todor Tomov wrote:
> 
> >> > + * When the 96Board naming of a line and the schematic name of
> >> > + * the same line are in conflict, the 96Board specification
> >> > + * takes precedence, which means that the external UART on the
> >> > + * LSEC is named UART0 while the schematic and SoC names this
> >> > + * UART3. This is only for the informational lines i.e. "[FOO]",
> >>
> >> It seems to me that this can lead to some confusion for cases when
> >> some schematic names have 96board names and others don't. (An
> >> example below.) However I don't really see any better way to do
> >> it. I'm wondering whether adding the schematic name in
> >> the comment (for gpios which are named with 96board names)
> >> can help a little. What do you think? Or any other idea?
> >>
> >
> > Specifying the schematic names in comments is a good idea!
> >
> > Linus: Do you have any suggestion here?
> 
> Go for this.
> 

Thanks!

> Generally ask the question: what does the user need?
> 
> In this case, especially userspace libraries like mriaa (right name?)

MRAA :)

> should be able to work out-of-the-box without knowing what
> board it is but know it has a 96board connector.
>

I have sent out v2, incorporating the review comments from Todor.
Can you please review it?

Thanks,
Mani

> Yours,
> Linus Walleij
