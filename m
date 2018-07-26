Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0494CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D4820846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D4820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbeGZQoQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:44:16 -0400
Received: from hermes.aosc.io ([199.195.250.187]:54754 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730781AbeGZQoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:44:15 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 8003C9FA92;
        Thu, 26 Jul 2018 15:26:40 +0000 (UTC)
Date:   Thu, 26 Jul 2018 23:26:19 +0800
In-Reply-To: <20180726152427.cjji4ymwfjifja4q@flea>
References: <20180724163655.61365-1-icenowy@aosc.io> <20180726124119.dwne2sncws2p3sdi@flea> <BA51039A-02DD-42C2-A7A9-E1B866074CA6@aosc.io> <20180726152427.cjji4ymwfjifja4q@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to rebase on M2 Ultra
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <7A9506F1-7052-4801-B735-296370EBBA7C@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月26日 GMT+08:00 下午11:24:27, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Thu, Jul 26, 2018 at 08:47:34PM +0800, Icenowy Zheng wrote:
>> 
>> 
>> 于 2018年7月26日 GMT+08:00 下午8:41:19, Maxime Ripard
><maxime.ripard@bootlin.com> 写到:
>> >On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
>> >> Banana Pi designs the BPi M2 Berry board to be software compatible
>> >with
>> >> BPi M2 Ultra,
>> >
>> >Do you have a reference for this?
>> 
>> See [1], it says "BPI-M2U and BPI-M2 Berry share the same image".
>> 
>> [1] http://www.banana-pi.org/download.html
>
>Debian supports different SoC from different vendor using the same
>image, so it's not really a good argument to share the device tree. I
>mean, you can even boot an H3 to a shell using an A33 device tree.

Please note that the vendor image is fully functional BSP
image, neither a function limited one nor one without
HW configuration.

>
>Maxime
