Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755103AbeEYJVF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:21:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32607 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754909AbeEYJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:21:02 -0400
X-UUID: 55f3ce01740b4cd18443bf356dc8949a-20180525
Message-ID: <1527240058.11190.0.camel@mtksdccf07>
Subject: Re: [PATCH v3 1/8] drm/mediatek: update dt-bindings for mt2712
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date: Fri, 25 May 2018 17:20:58 +0800
In-Reply-To: <1527218292.27165.2.camel@mtksdaap41>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
         <1527215665-11937-2-git-send-email-stu.hsieh@mediatek.com>
         <1527218292.27165.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK:

On Fri, 2018-05-25 at 11:18 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Fri, 2018-05-25 at 10:34 +0800, stu.hsieh@mediatek.com wrote:
> > From: Stu Hsieh <stu.hsieh@mediatek.com>
> > 
> > Update device tree binding documentation for the display subsystem for
> > Mediatek MT2712 SoCs.
> > 
> 
> I've acked v2 of this patch and v3 is the same as v2, so you should keep
> my ack in commit message.
> 
> Regards,
> CK
OK

Regards,
Stu

> 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> > index 383183a89164..8469de510001 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> > @@ -40,7 +40,7 @@ Required properties (all function blocks):
> >  	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
> >  	"mediatek,<chip>-disp-mutex" - display mutex
> >  	"mediatek,<chip>-disp-od"    - overdrive
> > -  the supported chips are mt2701 and mt8173.
> > +  the supported chips are mt2701, mt2712 and mt8173.
> >  - reg: Physical base address and length of the function block register space
> >  - interrupts: The interrupt signal from the function block (required, except for
> >    merge and split function blocks).
> 
> 
