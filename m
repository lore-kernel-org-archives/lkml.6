Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF62C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1961524011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1961524011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeGFC3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:29:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17318 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753675AbeGFC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:29:45 -0400
X-UUID: ae6e180a76164dc68c3306084f09b123-20180706
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 76894617; Fri, 06 Jul 2018 10:29:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 6 Jul
 2018 10:29:38 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 6 Jul 2018 10:29:37 +0800
Message-ID: <1530844177.28645.49.camel@mhfsdcap03>
Subject: Re: [PATCH v22 1/4] dt-bindings: soc: Add documentation for the
 MediaTek GCE unit
From:   houlong wei <houlong.wei@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>,
        "Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?=" 
        <Bibby.Hsieh@mediatek.com>,
        YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= 
        <Yt.Shen@mediatek.com>,
        Daoyuan Huang =?UTF-8?Q?=28=E9=BB=83=E9=81=93=E5=8E=9F=29?= 
        <Daoyuan.Huang@mediatek.com>,
        Jiaguang Zhang =?UTF-8?Q?=28=E5=BC=A0=E5=8A=A0=E5=B9=BF=29?= 
        <Jiaguang.Zhang@mediatek.com>,
        Dennis-YC Hsieh =?UTF-8?Q?=28=E8=AC=9D=E5=AE=87=E5=93=B2=29?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        Monica Wang =?UTF-8?Q?=28=E7=8E=8B=E5=AD=9F=E5=A9=B7=29?= 
        <monica.wang@mediatek.com>,
        Hs Liao =?UTF-8?Q?=28=E5=BB=96=E5=AE=8F=E7=A5=A5=29?= 
        <Hs.Liao@mediatek.com>,
        Ginny Chen =?UTF-8?Q?=28=E9=99=B3=E6=B2=BB=E5=82=91=29?= 
        <ginny.chen@mediatek.com>,
        Enzhu Wang =?UTF-8?Q?=28=E7=8E=8B=E6=81=A9=E6=9F=B1=29?= 
        <enzhu.wang@mediatek.com>, <houlong.wei@mediatek.com>
Date:   Fri, 6 Jul 2018 10:29:37 +0800
In-Reply-To: <CAL_JsqLZ-+-kY2QSY3cZMoR2zZuuZA8C9VUoHG=F7rpa4s5fgA@mail.gmail.com>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
         <1530098172-31385-2-git-send-email-houlong.wei@mediatek.com>
         <20180703023040.GA24508@rob-hp-laptop>
         <1530661158.21991.45.camel@mhfsdcap03>
         <CAL_JsqLZ-+-kY2QSY3cZMoR2zZuuZA8C9VUoHG=F7rpa4s5fgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 04:08 +0800, Rob Herring wrote:
> On Tue, Jul 3, 2018 at 5:39 PM houlong wei <houlong.wei@mediatek.com> wrote:
> >
> > On Tue, 2018-07-03 at 10:30 +0800, Rob Herring wrote:
> > > On Wed, Jun 27, 2018 at 07:16:09PM +0800, Houlong Wei wrote:
> > > > This adds documentation for the MediaTek Global Command Engine (GCE) unit
> > > > found in MT8173 SoCs.
> > > >
> > > > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > > ---
> > > > Hi Rob,
> > > >   I don't add your ACK in this version since the dt-binding description
> > > > has been changed. Thanks.
> > > > ---
> > > >  .../devicetree/bindings/mailbox/mtk-gce.txt        |   65 ++++++++++++++++++++
> > > >  include/dt-bindings/gce/mt8173-gce.h               |   48 +++++++++++++++
> > > >  2 files changed, 113 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > > >  create mode 100644 include/dt-bindings/gce/mt8173-gce.h
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > > > new file mode 100644
> > > > index 0000000..26f65a4
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > > > @@ -0,0 +1,65 @@
> > > > +MediaTek GCE
> > > > +===============
> > > > +
> > > > +The Global Command Engine (GCE) is used to help read/write registers with
> > > > +critical time limitation, such as updating display configuration during the
> > > > +vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
> > > > +
> > > > +CMDQ driver uses mailbox framework for communication. Please refer to
> > > > +mailbox.txt for generic information about mailbox device-tree bindings.
> > > > +
> > > > +Required properties:
> > > > +- compatible: Must be "mediatek,mt8173-gce"
> > > > +- reg: Address range of the GCE unit
> > > > +- interrupts: The interrupt signal from the GCE block
> > > > +- clock: Clocks according to the common clock binding
> > > > +- clock-names: Must be "gce" to stand for GCE clock
> > > > +- thread-num: Maximum threads count of GCE.
> > >
> > > mediatek,thread-num
> > >
> > > Is this needed for anything other than error checking the thread id in
> > > the mbox cells? if that's it, then drop it.
> > >
> >
> > 'thread-num' is used to configure the GCE thread number, which is the
> > channel number of gce mailbox. This property is read in
> > cmdq_probe()/mtk-cmdq-mailbox.c and a mailbox's channel array is
> > allocated according to the number.
> > Since the thread number may be different on different SoC, we wish it
> > could be configured in device tree.
> 
> You should have different compatible strings for different SoCs and
> can imply the number of threads from that.
> 

Thanks. Will remove 'thread-num' form device tree and put it in match
table of cmdq dirver.

> Or if the number of threads doesn't vary greatly, just allocate the
> max # of channels. Or allocate the per thread data when a thread is
> actually in use.
> 
> >
> > > > +- #mbox-cells: Should be 4.
> > > > +   <&phandle channel timeout priority atomic_exec>
> > > > +   phandle: Label name of a gce node.
> > > > +   channel: Channel of mailbox. Be equal to the thread id of GCE.
> > > > +   timeout: Maximum time of software waiting GCE processing done, in unit
> > > > +           of millisecond.
> > > > +   priority: Priority of GCE thread.
> > > > +   atomic_exec: GCE processing continuous packets of commands in atomic
> > > > +           way.
> > > > +
> > > > +Required properties for a client device:
> > > > +- mboxes: Client use mailbox to communicate with GCE, it should have this
> > > > +  property and list of phandle, mailbox specifiers.
> > > > +- gce-subsys: Specify the sub-system id which is corresponding to the register
> > > > +  address.
> > >
> > > What is this for?
> >
> > You mean the new added property 'gce-subsys'?
> > It is used for GCE to distinguish the high 16-bit of a hardware register
> > address. When a client driver packets a register setting into a GCE
> > instruction, it uses a sub-system code and register offset instead of
> > the 32-bit register address.
> > Since sub-system code may be different on different SoC, we wish it
> > could be configured in device tree.
> 
> Okay. It needs a vendor prefix and to specify the size and type of the value.
> 

Will do.

> >
> > >
> > > > +
> > > > +Optional properties for a client device:
> > > > +- gce-event: Specify the event if the client has any. Because the event is
> > > > +  parsed by client, so client can replace 'gce-event' with other meaningful
> > > > +  name.
> > >
> > > If the client sets the name, then no point having here. It must be
> > > documented in the client binding. But then, what is this for in the
> > > first place?
> >
> > Since display driver will use GCE firstly, so we will move the
> > description to
> > 'Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt'
> > when display driver start using the GCE driver.
> > Is that ok?
> 
> Not sure. I don't understand how it is used.
> 
> > > > +
> > > > +Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'. Such as
> > > > +thread number, sub-system ids, thread priority, event ids.
> > > > +
> > > > +Example:
> > > > +
> > > > +   gce: gce@10212000 {
> > >
> > > mailbox@...
> >
> > Will do.
> >
> > >
> > > > +           compatible = "mediatek,mt8173-gce";
> > > > +           reg = <0 0x10212000 0 0x1000>;
> > > > +           interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
> > > > +           clocks = <&infracfg CLK_INFRA_GCE>;
> > > > +           clock-names = "gce";
> > > > +           thread-num = CMDQ_THR_MAX_COUNT;
> > > > +           #mbox-cells = <4>;
> > > > +   };
> > > > +
> > > > +Example for a client device:
> > > > +
> > > > +   mmsys: clock-controller@14000000 {
> > > > +           compatible = "mediatek,mt8173-mmsys";
> > > > +           mboxes = <&gce 0 2000 CMDQ_THR_PRIO_LOWEST 1>,
> > > > +                    <&gce 1 2000 CMDQ_THR_PRIO_LOWEST 1>;
> > > > +           gce-subsys = <SUBSYS_1400XXXX>;
> > > > +           mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> > > > +                           CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> > > > +
> > > > +           ...
> > > > +   };
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


