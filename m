Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A064C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F661208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F661208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeH1DJf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:09:35 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44722 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeH1DJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:09:34 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 9755FFEE51;
        Mon, 27 Aug 2018 23:20:42 +0000 (UTC)
Date:   Tue, 28 Aug 2018 07:08:22 +0800
In-Reply-To: <153540143478.129321.8502068006504989469@swboyd.mtv.corp.google.com>
References: <20180820134013.16527-1-icenowy@aosc.io> <153540143478.129321.8502068006504989469@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to MMC module clocks
To:     linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-clk@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <D5B9F1CA-6108-41EB-9D6C-56883C79F361@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年8月28日 GMT+08:00 上午4:23:54, Stephen Boyd <sboyd@kernel.org> 写到:
>Quoting Icenowy Zheng (2018-08-20 06:40:13)
>> On the H6, the MMC module clocks are fixed in the new timing mode,
>> i.e. they do not have a bit to select the mode. These clocks have
>> a 2x divider somewhere between the clock and the MMC module.
>> 
>> To be consistent with other SoCs supporting the new timing mode,
>> we model the 2x divider as a fixed post-divider on the MMC module
>> clocks.
>> 
>> This patch adds the post-dividers to the MMC clocks, following the
>> approach on A64.
>> 
>> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6
>CCU")
>
>This commit doesn't exist. Did you mean:
>
>524353ea48
>
>instead?

Yes, it is.

Thanks!

>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
