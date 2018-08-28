Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580B4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0779F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0779F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH1MFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:05:42 -0400
Received: from regular1.263xmail.com ([211.150.99.135]:58794 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeH1MFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:05:42 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.87])
        by regular1.263xmail.com (Postfix) with ESMTP id E6F19446;
        Tue, 28 Aug 2018 16:14:32 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.10.60] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 5D2FA3C1;
        Tue, 28 Aug 2018 16:14:30 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: sandy.huang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <47ebe7b5453a609b575a3c565f97bea6>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.10.60] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 12276KZZH48;
        Tue, 28 Aug 2018 16:14:32 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>, seanpaul@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] devicetree/bindings: display: Add document for
 rockchip RGB output
References: <1529997340-156879-1-git-send-email-hjc@rock-chips.com>
 <20180703182559.GA12809@rob-hp-laptop>
 <725cc93f-a441-22bc-ef58-b4b38ec34e17@rock-chips.com>
 <7915686.3ERLj9EHQN@phil>
Message-ID: <ae0ae53f-2933-c9dc-e09e-c3df6ec2dce9@rock-chips.com>
Date:   Tue, 28 Aug 2018 16:14:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7915686.3ERLj9EHQN@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2018/8/27 15:11, Heiko Stuebner 写道:
> Hi Sandy,
>
> trying to move this forward a bit :-)
Hi heiko,
      update at version5 and add SPDX-License-Identifier tag.
>
> Am Mittwoch, 4. Juli 2018, 14:09:56 CEST schrieb Sandy Huang:
> > Hi Rob Herring,
> > Thanks for your review.
> >
> > 在 2018/7/4 2:25, Rob Herring 写道:
> >> On Tue, Jun 26, 2018 at 03:15:39PM +0800, Sandy Huang wrote:
> >>> This path add support rv1108 and px30 rgb output interface driver.
> >>
> >> Bindings are for h/w, not drivers.
> >>
> > I will update at next version as following:
> > This patch add support rv1108 and px30 rgb output interface
> >>>
> >>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> >>> Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc@rock-chips.com
> >>> ---
> >>>
> >>> Changes in v4: Add support px30
> >>> Changes in v3: None
> >>> Changes in v2: None
> >>>
> >>> .../bindings/display/rockchip/rockchip-rgb.txt     | 73 ++++++++++++++++++++++
> >>>    1 file changed, 73 insertions(+)
> >>>    create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> >>> new file mode 100644
> >>> index 0000000..077b9ad
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> >>> @@ -0,0 +1,73 @@
> >>> +Rockchip RV1108 RGB interface
> >>> +================================
> >>> +
> >>> +Required properties:
> >>> +- compatible: matching the soc type:
> >>> +    - "rockchip,px30-rgb";
> >>> +    - "rockchip,rv1108-rgb";
> >>
> >> This doesn't look right? What (and how) is getting programmed here
> >> because you don't have any register interface.
> >>
> > This is register for DRM encoder and connecter or bridge for some RGB
> > convert chips driver.
> > so far we don't have any register for rgb interface, but it's most
> > probable need to config some register for rgb interface in feauture for
> > rockchip platform.
>
> I think the basic-issue Rob was pointing out is that the devicetree
> describes hardware blocks and not the software representation.
>
> And the rgb output is not a separate block, but instead just a property
> of the vop itself, hence should possibly not have a separate "device".
>
> As I'm currently tinkering with rk3188 display support [0] - which only has
> rgb output at all - I modified your patch a bit to to showcase how that
> could look [1], where the soc vop struct simply has a feature flag
> indicating indicating a raw rgb output and the rgb driver then
> looks for bridges in the vop endpoints to distinguish them from
> soc-internals output encoders.
>
> Let me know what you think :-)
> Heiko
>
> [0] https://github.com/mmind/linux-rockchip/commits/wip/rk3188-lcdc
> [1] https://github.com/mmind/linux-rockchip/commit/fe74d2c4d76bcb6035b7207753e6afb85335b6cd
> needs also https://github.com/mmind/linux-rockchip/commit/c5a48c772f3564211dcd1ec71004de1d6dbb0307
>
>
>
>
>
>


