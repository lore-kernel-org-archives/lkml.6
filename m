Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3439FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02A0213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02A0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeHTPJx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:09:53 -0400
Received: from hermes.aosc.io ([199.195.250.187]:39366 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeHTPJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:09:53 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id CD418E0F05;
        Mon, 20 Aug 2018 11:54:13 +0000 (UTC)
Date:   Mon, 20 Aug 2018 19:53:58 +0800
In-Reply-To: <20180820115244.x5z6lm4i7tpqptgs@flea>
References: <20180815120745.36593-1-icenowy@aosc.io> <20180820115244.x5z6lm4i7tpqptgs@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] drm: sun4i: exclusively set HDMI-related clocks for dw-hdmi
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, stable@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <DA70F8EF-E64D-4295-A4A5-9F8EB616BB71@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年8月20日 GMT+08:00 下午7:52:44, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>Hi!
>
>On Wed, Aug 15, 2018 at 08:07:45PM +0800, Icenowy Zheng wrote:
>> The glue in sun4i-drm of dw-hdmi currently doesn't set the clocks of
>> dw-hdmi exclusively, which will lead the display fails to initialize
>in
>> some situations.
>
>Apart from the feedback already given, detailing which situations
>would be very helpful.

This patched is rewritten now, and new version will come
after -rc1.

>
>Maxime
