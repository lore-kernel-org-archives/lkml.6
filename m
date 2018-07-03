Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7665EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDAF24785
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDAF24785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeGCXj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:39:26 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:30055 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752216AbeGCXjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:39:24 -0400
X-UUID: 8b188a3ab7be487fa10b2734cc0ef5b0-20180704
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 587974648; Wed, 04 Jul 2018 07:39:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Wed, 4 Jul
 2018 07:39:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 4 Jul 2018 07:39:18 +0800
Message-ID: <1530661158.21991.45.camel@mhfsdcap03>
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>,
        "Bibby Hsieh (?x???h)" <Bibby.Hsieh@mediatek.com>,
        YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= 
        <Yt.Shen@mediatek.com>,
        Daoyuan Huang =?UTF-8?Q?=28=3FS=E9=81=93=E5=8E=9F=29?= 
        <Daoyuan.Huang@mediatek.com>,
        Jiaguang Zhang =?UTF-8?Q?=28=E5=BC=A0=E5=8A=A0=E5=B9=BF=29?= 
        <Jiaguang.Zhang@mediatek.com>,
        Dennis-YC Hsieh =?UTF-8?Q?=28=3Fx=E5=AE=87=E5=93=B2=29?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        Monica Wang =?UTF-8?Q?=28=E7=8E=8B=E5=AD=9F=E5=A9=B7=29?= 
        <monica.wang@mediatek.com>,
        Hs Liao =?UTF-8?Q?=28=E5=BB=96=E5=AE=8F=E7=A5=A5=29?= 
        <Hs.Liao@mediatek.com>,
        "Ginny Chen =?UTF-8?Q?=28=3F=3F=3F=CE=82=3F=29?=" 
        <ginny.chen@mediatek.com>,
        "Enzhu Wang =?UTF-8?Q?=28=E7=8E=8B=E6=81=A9=E6=9F=B1=29?=" 
        <enzhu.wang@mediatek.com>, <houlong.wei@mediatek.com>
Date:   Wed, 4 Jul 2018 07:39:18 +0800
In-Reply-To: <20180703023040.GA24508@rob-hp-laptop>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
         <1530098172-31385-2-git-send-email-houlong.wei@mediatek.com>
         <20180703023040.GA24508@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 10:30 +0800, Rob Herring wrote:
> On Wed, Jun 27, 2018 at 07:16:09PM +0800, Houlong Wei wrote:
> > This adds documentation for the MediaTek Global Command Engine (GCE) unit
> > found in MT8173 SoCs.
> > 
> > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > ---
> > Hi Rob,
> >   I don't add your ACK in this version since the dt-binding description
> > has been changed. Thanks.
> > ---
> >  .../devicetree/bindings/mailbox/mtk-gce.txt        |   65 ++++++++++++++++++++
> >  include/dt-bindings/gce/mt8173-gce.h               |   48 +++++++++++++++
> >  2 files changed, 113 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> >  create mode 100644 include/dt-bindings/gce/mt8173-gce.h
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > new file mode 100644
> > index 0000000..26f65a4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > @@ -0,0 +1,65 @@
> > +MediaTek GCE
> > +===============
> > +
> > +The Global Command Engine (GCE) is used to help read/write registers with
> > +critical time limitation, such as updating display configuration during the
> > +vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
> > +
> > +CMDQ driver uses mailbox framework for communication. Please refer to
> > +mailbox.txt for generic information about mailbox device-tree bindings.
> > +
> > +Required properties:
> > +- compatible: Must be "mediatek,mt8173-gce"
> > +- reg: Address range of the GCE unit
> > +- interrupts: The interrupt signal from the GCE block
> > +- clock: Clocks according to the common clock binding
> > +- clock-names: Must be "gce" to stand for GCE clock
> > +- thread-num: Maximum threads count of GCE.
> 
> mediatek,thread-num
> 
> Is this needed for anything other than error checking the thread id in 
> the mbox cells? if that's it, then drop it. 
> 

'thread-num' is used to configure the GCE thread number, which is the
channel number of gce mailbox. This property is read in
cmdq_probe()/mtk-cmdq-mailbox.c and a mailbox's channel array is
allocated according to the number.
Since the thread number may be different on different SoC, we wish it
could be configured in device tree.

> > +- #mbox-cells: Should be 4.
> > +	<&phandle channel timeout priority atomic_exec>
> > +	phandle: Label name of a gce node.
> > +	channel: Channel of mailbox. Be equal to the thread id of GCE.
> > +	timeout: Maximum time of software waiting GCE processing done, in unit
> > +		of millisecond.
> > +	priority: Priority of GCE thread.
> > +	atomic_exec: GCE processing continuous packets of commands in atomic
> > +		way.
> > +
> > +Required properties for a client device:
> > +- mboxes: Client use mailbox to communicate with GCE, it should have this
> > +  property and list of phandle, mailbox specifiers.
> > +- gce-subsys: Specify the sub-system id which is corresponding to the register
> > +  address.
> 
> What is this for?

You mean the new added property 'gce-subsys'?  
It is used for GCE to distinguish the high 16-bit of a hardware register
address. When a client driver packets a register setting into a GCE
instruction, it uses a sub-system code and register offset instead of
the 32-bit register address.
Since sub-system code may be different on different SoC, we wish it
could be configured in device tree.

> 
> > +
> > +Optional properties for a client device:
> > +- gce-event: Specify the event if the client has any. Because the event is
> > +  parsed by client, so client can replace 'gce-event' with other meaningful
> > +  name.
> 
> If the client sets the name, then no point having here. It must be 
> documented in the client binding. But then, what is this for in the 
> first place?

Since display driver will use GCE firstly, so we will move the
description to
'Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt'
when display driver start using the GCE driver.
Is that ok?

> 
> > +
> > +Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'. Such as
> > +thread number, sub-system ids, thread priority, event ids.
> > +
> > +Example:
> > +
> > +	gce: gce@10212000 {
> 
> mailbox@...

Will do.

> 
> > +		compatible = "mediatek,mt8173-gce";
> > +		reg = <0 0x10212000 0 0x1000>;
> > +		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&infracfg CLK_INFRA_GCE>;
> > +		clock-names = "gce";
> > +		thread-num = CMDQ_THR_MAX_COUNT;
> > +		#mbox-cells = <4>;
> > +	};
> > +
> > +Example for a client device:
> > +
> > +	mmsys: clock-controller@14000000 {
> > +		compatible = "mediatek,mt8173-mmsys";
> > +		mboxes = <&gce 0 2000 CMDQ_THR_PRIO_LOWEST 1>,
> > +			 <&gce 1 2000 CMDQ_THR_PRIO_LOWEST 1>;
> > +		gce-subsys = <SUBSYS_1400XXXX>;
> > +		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> > +				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> > +
> > +		...
> > +	};


