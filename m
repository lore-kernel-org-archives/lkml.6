Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754985AbeE2H1i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:27:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43602 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754938AbeE2H1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:27:32 -0400
X-Google-Smtp-Source: AB8JxZou+heBi58IwzTamEPr/UqCu0JIFUsU0SvtzSD1CBffGzt1Mj8MLF+8DN4MRcZc4x/PaS6KKg==
Date: Tue, 29 May 2018 12:57:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com, Mars Cheng <mars.cheng@mediatek.com>,
        Saber Rezvani <irsaber@gmail.com>
Subject: Re: [PATCH 0/2] Add Mediatek X20 Development Board support
Message-ID: <20180529072719.GA5529@Mani-XPS-13-9360>
References: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
 <06dbc5ef-5bba-f3e0-1b57-3eaeab26ed68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06dbc5ef-5bba-f3e0-1b57-3eaeab26ed68@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Tue, May 29, 2018 at 08:38:27AM +0200, Matthias Brugger wrote:
> Hi Manivannan,
> 
> it's nice to see that someone at Linaro cares about upstreaming the 96 board.
> From what I can see, your patches add the very same support to the board as
> does the mt6797 evaluation board. Do you have plans to upstream more drivers for
> the board? Do you have a roadmap or something?
> 
> I'm asking becuase I don't want to have just another dead devicetree in the
> kernel which does nothing but provides a boot to rootfs. Especially as this can
> be achieved on the same board with the EVB dts.
> 

I can understand your concern here. I do have plans to add more drivers
in the future for this board but I can't give you any roadmap for that
since it mostly falls under the spare time work and I have been doing a
similar kind of work for the Bubblegum-96 board in parallel.

At most I can guarentee that this board's functionality will be added
gradually in upcoming days.

Thanks,
Mani

> Regards,
> Matthias
> 
> On 29/05/18 06:52, Manivannan Sadhasivam wrote:
> > Add devicetree support for Mediatek X20 Development Board by Archermind.
> > This board is based on the Deca-Core MT6797 SoC from Mediatek and is
> > one of the 96Boards Consumer Edition platform.
> > 
> > With this devicetree change, board can boot into initramfs.
> > 
> > More information about this board can be found in 96Boards product page:
> > https://www.96boards.org/product/mediatek-x20/
> > 
> > Manivannan Sadhasivam (2):
> >   dt-bindings: Add vendor prefix for ArcherMind
> >   arm64: dts: Add Mediatek X20 Development Board support
> > 
> >  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
> >  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
> >  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
> >  3 files changed, 35 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> > 
