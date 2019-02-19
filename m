Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529E12177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfBSDDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:03:33 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:3809 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725308AbfBSDDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:03:33 -0500
X-UUID: cad6f202ab1049e4832e8dcd40e5834f-20190219
X-UUID: cad6f202ab1049e4832e8dcd40e5834f-20190219
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1068112833; Tue, 19 Feb 2019 11:03:27 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 11:03:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 11:03:25 +0800
Message-ID: <1550545405.2210.30.camel@mhfsdcap03>
Subject: Re: [PATCH v2 01/10] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chen Yu <chenyu56@huawei.com>
CC:     Rob Herring <robh@kernel.org>, <liuyu712@hisilicon.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Binghui Wang" <wangbinghui@hisilicon.com>
Date:   Tue, 19 Feb 2019 11:03:25 +0800
In-Reply-To: <a944cd27-f7d5-eece-1ef5-c7dc5dbc311b@huawei.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
         <20190218112310.17860-2-chenyu56@huawei.com> <20190218201824.GA23724@bogus>
         <a944cd27-f7d5-eece-1ef5-c7dc5dbc311b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, 2019-02-19 at 09:50 +0800, Chen Yu wrote:
> Hi,
> 
> On 2019/2/19 4:18, Rob Herring wrote:
> > On Mon, Feb 18, 2019 at 07:23:01PM +0800, Yu Chen wrote:
> >> This patch adds binding documentation for supporting the hi3660 usb
> >> phy on boards like the HiKey960.
> >>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: John Stultz <john.stultz@linaro.org>
> >> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> >> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> >> ---
> >> v1:
> >> * Fix some format error as suggested by Rob.
> >> v2:
> >> * Change hi3660 usb PHY to hi3660 USB PHY
> >> ---
> >> ---
> >>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt     | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> >> new file mode 100644
> >> index 000000000000..f9a3d56cfdd2
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> >> @@ -0,0 +1,21 @@
> >> +Hisilicon hi3660 USB PHY
> >> +-----------------------
> >> +
> >> +Required properties:
> >> +- compatible: should be "hisilicon,hi3660-usb-phy"
> >> +- #phy-cells: must be 0
> >> +- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
> >> +- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
> >> +- hisilicon,usb3-otg-bc-syscon: phandle of syscon used to control phy.
> >> +- hisilicon,eye-diagram-param: parameter set for phy
> >> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> >> +
> >> +Example:
> >> +	usb-phy {
> >> +		compatible = "hisilicon,hi3660-usb-phy";
> >> +		#phy-cells = <0>;
> >> +		hisilicon,pericrg-syscon = <&crg_ctrl>;
> >> +		hisilicon,pctrl-syscon = <&pctrl>;
> >> +		hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
> > 
> > Are most of the registers within one of these blocks? If so, make this 
> > node a child of that node.
> I met a problem when I made this node a child of the syscon node,
> the driver "phy-hi3660-usb3" was not probed.
> Do you have any idea about how to make it probed when it is a child node?
call of_platform_populate() in parent node's driver,
but I don't know whether it's a standard way
> > 
> >> +		hisilicon,eye-diagram-param = <0x22466e4>;
> >> +	};
> >> -- 
> >> 2.15.0-rc2
> >>
> > 
> > .
> > 
> 
> Thanks
> Yu Chen
> 


