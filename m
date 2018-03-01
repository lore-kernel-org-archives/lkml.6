Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967539AbeCAKdx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:33:53 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35464 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967523AbeCAKdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:33:46 -0500
X-Google-Smtp-Source: AG47ELuU4hsrQ8HdvvgPIWrYZj3YBsl00BGR8EHU8zKE9Jz/uh8OGQIh7YuclPbdCLzPNiFgckSJmw==
Date: Thu, 1 Mar 2018 16:03:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com
Subject: Re: [PATCH v3 01/10] dt-bindings: pinctrl: Add bindings for Actions
 S900 SoC
Message-ID: <20180301103334.jjyxiimsjs4d33nv@linaro.org>
References: <20180228181432.26847-1-manivannan.sadhasivam@linaro.org>
 <20180228181432.26847-2-manivannan.sadhasivam@linaro.org>
 <CACRpkdYG_aBJ0WME7NSOdv0pV5Vh_z8GVqQ+tUFnXGA7NGVMUg@mail.gmail.com>
 <20180301092556.x4a5ohx3iccwsugw@linaro.org>
 <20180301102300.z2abpg4ao62dibgm@oak.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301102300.z2abpg4ao62dibgm@oak.lan>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Mar 01, 2018 at 10:23:00AM +0000, Daniel Thompson wrote:
> On Thu, Mar 01, 2018 at 02:55:56PM +0530, Manivannan Sadhasivam wrote:
> > Hi Linus,
> > On Thu, Mar 01, 2018 at 10:20:29AM +0100, Linus Walleij wrote:
> > > On Wed, Feb 28, 2018 at 7:14 PM, Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > 
> > > > Add pinctrl bindings for Actions Semi S900 SoC
> > > >
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > The previous (v2) version had Rob's Review tag, did you just forget
> > > to add it or has something changed?
> > > 
> > 
> > My bad. Slipped through the cracks.
> > 
> > > If nothing is changed I can add his tag when applying.
> > >
> > 
> > I will send out a new version of the whole series, incorporating Andy's
> > pinctrl driver review.
> > 
> > Also, FYI this pacthseries depends on Clock driver patchset I have submitted
> > earlier. So far no reply from Stephen yet. He said that he is working on setting
> > up his new environment and will begin reviewing shortly.
> 
> Is the dependancy at runtime (driver is not functional without clocks) or compile
> time (driver cannot build without other patchset landing)?
>

There is no build time dependency only runtime dependency. Driver is pretty
much useless without clock driver.

Also, there will be merge conflicts when this series gets applied independently.
Since there is no build time dependency, if Linus decides to apply it now, I
can generate a new independent patchset.

Thanks,
Mani 
> 
> Daniel.
