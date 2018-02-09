Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeBIDjD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 22:39:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:26970 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752203AbeBIDjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 22:39:01 -0500
X-UUID: b3c1aed328fd40598717a8456b24e102-20180209
Message-ID: <1518147536.9025.9.camel@mtkswgap22>
Subject: Re: [PATCH v2 01/16] dt-bindings: clock: mediatek: add missing
 required #reset-cells
From: Sean Wang <sean.wang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 9 Feb 2018 11:38:56 +0800
In-Reply-To: <391278e5-9b72-1142-0262-5d286fe17d8d@gmail.com>
References: <cover.1517910489.git.sean.wang@mediatek.com>
         <d58fcf36319254d6de4c7fe100cbdca1bbec27a5.1517910489.git.sean.wang@mediatek.com>
         <391278e5-9b72-1142-0262-5d286fe17d8d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 11:45 +0100, Matthias Brugger wrote:
> 
> On 02/06/2018 10:52 AM, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > All ethsys, pciesys and ssusbsys internally include reset controller, so
> > explicitly add back these missing cell definitions to related bindings
> > and examples.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt   | 2 ++
> >  Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt  | 2 ++
> >  Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt | 2 ++
> >  3 files changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> > index 7aa3fa1..8f5335b 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> > @@ -9,6 +9,7 @@ Required Properties:
> >  	- "mediatek,mt2701-ethsys", "syscon"
> >  	- "mediatek,mt7622-ethsys", "syscon"
> >  - #clock-cells: Must be 1
> > +- #reset-cells: Must be 1
> >  
> >  The ethsys controller uses the common clk binding from
> >  Documentation/devicetree/bindings/clock/clock-bindings.txt
> > @@ -20,4 +21,5 @@ ethsys: clock-controller@1b000000 {
> >  	compatible = "mediatek,mt2701-ethsys", "syscon";
> >  	reg = <0 0x1b000000 0 0x1000>;
> >  	#clock-cells = <1>;
> > +	#reset-cells = <1>;
> 
> The example is already fixed upstream, but I forgot the binding description,
> please rebase this patch.
> 
> And please don't forget to add all clock maintainers.
> 

okay, i will do it.

> Regards,
> Matthias
> 
