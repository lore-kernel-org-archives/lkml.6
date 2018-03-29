Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeC2Cb1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 22:31:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9289 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751052AbeC2CbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 22:31:24 -0400
X-UUID: 4769b45f9ed4485db485bc160196baf7-20180329
Message-ID: <1522290675.17084.8.camel@mhfsdcap03>
Subject: Re: [PATCH v6 0/6] Add MediaTek PMIC keys support
From: Chen Zhong <chen.zhong@mediatek.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, "Rob Herring" <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>, <a.zummo@towertech.it>,
        <devicetree@vger.kernel.org>, <linus.walleij@linaro.org>,
        <jcsing.lee@samsung.com>, <linux-kernel@vger.kernel.org>,
        <krzk@kernel.org>, <javier@osg.samsung.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-input@vger.kernel.org>,
        <eddie.huang@mediatek.com>, <beomho.seo@samsung.com>,
        <linux-rtc@vger.kernel.org>
Date: Thu, 29 Mar 2018 10:31:15 +0800
In-Reply-To: <20180328102640.yx6nv5abfexmouuf@dell>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
         <808b2029da224ab687fb0553cbc1c68e@mtkmbs08n1.mediatek.inc>
         <1521685073.28226.10.camel@mtkswgap22> <20180323185418.GD255819@dtor-ws>
         <20180327080507.pgil6pw2mn4y2f4d@dell>
         <3ece050c-7573-ef4e-2c89-61645a243a33@gmail.com>
         <20180328102640.yx6nv5abfexmouuf@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23748.000
X-TM-AS-Result: No-13.431000-8.000000-10
X-TMASE-MatchedRID: L8tZF6zWW2oOwH4pD14DsPHkpkyUphL9fjJOgArMOCYXdhT0BAdFzsYR
        +i1NmBQlTrRReN4GcU2JpFkx2/WYwE6AMNXtOIvdQpxiLlDD9FVG/JUd7BvSQheZ77Ep2+iBk2T
        /+ntghnUcctoI3AaL4YJKpSo2qR4kyUEGXxYlhT8zw5Ejs3g1llwKy6arPaSXNRzQTdxQvcpjLO
        Ro1y6rxnvbdTV7/1LgZxDuWcYIo97YMEqhScrQBbU+IyHhkXf1wPI816T179qbKItl61J/ycnjL
        TA/UDoASXhbxZVQ5H/3FLeZXNZS4KBkcgGnJ4WmMMJ/f3Xn7DKbQBTQBGFkKTsz1JDpRIqD5eeI
        DhtMZ2d+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.431000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23748.000
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 11:26 +0100, Lee Jones wrote:
> On Tue, 27 Mar 2018, Matthias Brugger wrote:
> 
> > 
> > 
> > On 03/27/2018 10:05 AM, Lee Jones wrote:
> > > On Fri, 23 Mar 2018, Dmitry Torokhov wrote:
> > >> On Thu, Mar 22, 2018 at 10:17:53AM +0800, Sean Wang wrote:
> > >>> Hi, Dmitry and Lee
> > >>>
> > >>> The series seems not being got merged. Are they good enough to be ready
> > >>> into the your tree?
> > >>>
> > >>> Recently I've tested the series with focusing on pwrkey event generated
> > >>> through interrupt when push and release the key on bpi-r2 board and then
> > >>> finally it's working fine. but for homekey it cannot be found on the
> > >>> board and thus I cannot have more tests more about it.
> > >>>
> > >>> Tested-by: Sean Wang <sean.wang@mediatek.com>
> > >>
> > >> You have my Ack on the input patch; I expect it go through Lee's tree as
> > >> there are some dependencies on mfd core piece.
> > > 
> > > Are you happy for me to merge the Input dt-bindings without your Ack?
> > > 
> > 
> > They got both Acked in v5, but the commit message was not updated:
> > https://patchwork.kernel.org/patch/9973721/
> > https://patchwork.kernel.org/patch/9973723/
> 
> Thanks Matthias.
> 
> Chen, can you collect all the Acks and repost as a RESEND please?
> 

Thanks Matthias, Lee, Dmitry and Sean for your comments.

Hi Lee,

I have collected the Acks by Rob and sent the v6:
https://patchwork.kernel.org/patch/10026705
https://patchwork.kernel.org/patch/10026707

Are they enough to be merged?

Thank you.
