Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DADC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670CD247B1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670CD247B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754969AbeF0UWH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:22:07 -0400
Received: from hermes.aosc.io ([199.195.250.187]:53548 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbeF0UWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:22:05 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 93FA847DBE;
        Wed, 27 Jun 2018 20:21:55 +0000 (UTC)
Date:   Thu, 28 Jun 2018 04:21:30 +0800
In-Reply-To: <20180627183721.jmmsmp3u3mq4drvb@flea>
References: <20180622122615.55836-1-icenowy@aosc.io> <20180627183721.jmmsmp3u3mq4drvb@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 0/7] Allwinner A64 DE2 CCU support with dedicated DE2 bus driver
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-clk@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <EB513C5E-4BBD-46B2-9B61-18ED0B14C0E4@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年6月28日 GMT+08:00 上午2:37:21, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Fri, Jun 22, 2018 at 08:26:08PM +0800, Icenowy Zheng wrote:
>> This patchset tries to implement the Allwinner A64 DE2 as a bus
>driver,
>> in order to model the fact that the SRAM claim controls the access to
>> the whole DE2 memory space.
>> 
>> PATCH 1 and PATCH 4 are for the CCU part.
>> 
>> PATCH 2 is the device tree binding for the A64 DE2 bus, and PATCH 3
>> implements the bus driver.
>> 
>> PATCH 5 adds the DE2 CCU device tree node, with the DE2 bus node.
>> 
>> PATCH 6 and 7 are HDMI simplefb patches for A64. They're present as a
>> test to this patchset.
>
>Applied all the patches with the minor modifications Chen-Yu and I
>suggested.
>
>The threading was broken on your serie though, so you probably want to
>check your git configuration.

In fact I think I should check my ISP configuration.

The breakage is introduced due to too long delay between aosc.io
mail server and my computer, so I must start to send the
remaining patches again.

>
>Thanks!
>Maxime
