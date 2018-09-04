Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A509FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E9120867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E9120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIDNIw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:08:52 -0400
Received: from hermes.aosc.io ([199.195.250.187]:51012 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeIDNIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:08:52 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 4D927FFA36;
        Tue,  4 Sep 2018 08:44:37 +0000 (UTC)
Date:   Tue, 04 Sep 2018 16:44:30 +0800
In-Reply-To: <CAGb2v65y1W=52SAFFqyCOnHd80nx+oPHUDeysHWBy7o8_g=eeQ@mail.gmail.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-3-jernej.skrabec@siol.net> <CAGb2v65y1W=52SAFFqyCOnHd80nx+oPHUDeysHWBy7o8_g=eeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH 02/27] arm64: allwinner: h6: add system controller device tree node
To:     wens@csie.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <9915D9F1-1C60-4AEF-9074-CE040FCD7BF0@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年9月4日 GMT+08:00 下午4:40:56, Chen-Yu Tsai <wens@csie.org> 写到:
>On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net>
>wrote:
>>
>> From: Icenowy Zheng <icenowy@aosc.io>
>>
>> As we have already binding for the H6 system controller, add its node
>> to the device tree.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> [fixed compatible string]
>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
>Reviewed-by: Chen-Yu Tsai <wens@csie.org>

By the way can these patches be applied first? (patches
related to syscon).

They're also needed for EMAC.

