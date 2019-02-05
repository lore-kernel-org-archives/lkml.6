Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D231C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079CA2184E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfBEXXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:23:02 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36503 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfBEXXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:23:02 -0500
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A4AC960004;
        Tue,  5 Feb 2019 23:22:58 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH 0/2] Fix espressobin ethernet support on mainline u-boot
In-Reply-To: <20190128200728.17747-1-repk@triplefau.lt>
References: <20190128200728.17747-1-repk@triplefau.lt>
Date:   Wed, 06 Feb 2019 00:22:58 +0100
Message-ID: <87ef8l95wt.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Remi,
 
 On lun., janv. 28 2019, Remi Pommarel <repk@triplefau.lt> wrote:

> This patchset fixes ethernet and mv88e6341 switch support on espressobin
> board when bootloader does not initialize needed registers.
>
> This patchset should be applied along with pinctrl fixes from [1] which
> have been merged in next branch of linux-pinctrl tree.
>
> [1] https://lkml.org/lkml/2018/12/21/507
>
> Remi Pommarel (2):
>   arm64: dts: armada-3720-espressobin: Configure RGMII and SMI pins
>   arm64: dts: armada-3720-espressobin: Set mv88e6341 cpu port as
>     RGMII-ID
>

Both patches applied to mvebu/dt64

Thanks,

Gregory

>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 7 +++++++
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi            | 5 +++++
>  2 files changed, 12 insertions(+)
>
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
