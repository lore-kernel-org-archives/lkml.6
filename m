Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC6BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CE720847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CE720847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934134AbeGDMKQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:10:16 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:37038 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbeGDMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:10:13 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.242])
        by regular1.263xmail.com (Postfix) with ESMTP id 011AB9488;
        Wed,  4 Jul 2018 20:09:54 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.10.60] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 17264394;
        Wed,  4 Jul 2018 20:09:55 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: sandy.huang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <a20a8eab65a025907bdfe8f656a902e4>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.10.60] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 12494AZJPEB;
        Wed, 04 Jul 2018 20:09:56 +0800 (CST)
Subject: Re: [PATCH v4 1/2] devicetree/bindings: display: Add document for
 rockchip RGB output
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>, seanpaul@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1529997340-156879-1-git-send-email-hjc@rock-chips.com>
 <1529997340-156879-2-git-send-email-hjc@rock-chips.com>
 <20180703182559.GA12809@rob-hp-laptop>
From:   Sandy Huang <hjc@rock-chips.com>
Message-ID: <725cc93f-a441-22bc-ef58-b4b38ec34e17@rock-chips.com>
Date:   Wed, 4 Jul 2018 20:09:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703182559.GA12809@rob-hp-laptop>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob Herring,
Thanks for your review.

ÔÚ 2018/7/4 2:25, Rob Herring Ð´µÀ:
> On Tue, Jun 26, 2018 at 03:15:39PM +0800, Sandy Huang wrote:
>> This path add support rv1108 and px30 rgb output interface driver.
> 
> Bindings are for h/w, not drivers.
> 
I will update at next version as following:
This patch add support rv1108 and px30 rgb output interface
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc@rock-chips.com
>> ---
>>
>> Changes in v4: Add support px30
>> Changes in v3: None
>> Changes in v2: None
>>
>> .../bindings/display/rockchip/rockchip-rgb.txt     | 73 ++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>> new file mode 100644
>> index 0000000..077b9ad
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>> @@ -0,0 +1,73 @@
>> +Rockchip RV1108 RGB interface
>> +================================
>> +
>> +Required properties:
>> +- compatible: matching the soc type:
>> +	- "rockchip,px30-rgb";
>> +	- "rockchip,rv1108-rgb";
> 
> This doesn't look right? What (and how) is getting programmed here
> because you don't have any register interface.
> 
This is register for DRM encoder and connecter or bridge for some RGB 
convert chips driver.
so far we don't have any register for rgb interface, but it's most 
probable need to config some register for rgb interface in feauture for 
rockchip platform.

>> +
>> +Optional properties:
>> +- pinctrl-names: should be a "lcdc" entry or a "default" entry.
>> +- pinctrl-0: pin control group to be used for this interface.
>> +
>> +The rgb has two video ports described by:
>> +	Documentation/devicetree/bindings/media/video-interfaces.txt
>> +Their connections are modeled using the OF graph bindings specified in
>> +	Documentation/devicetree/bindings/graph.txt.
>> +
>> +- video port 0 for the VOP input, the remote endpoint maybe vopb/vopl/vop
> 
> So there is a mux for these inputs and they are switched with pinctrl?
> 
connetced can connect to vopb/vopl/vop which is same with other 
connenter like edp/dsi/lvds, there is a sample for edp 
at:Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> Just put the pinctrl nodes of the sources and enable whichever one is
> active.
> 
Do you think i need add pinctrl nodes here? Or am I wrong?
> Rob
> 
> 
> 

