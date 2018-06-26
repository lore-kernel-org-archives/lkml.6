Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B10C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9081266BE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9081266BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeFZIXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:23:04 -0400
Received: from gloria.sntech.de ([95.129.55.99]:35556 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbeFZIXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:23:01 -0400
Received: from ip5f5a8448.dynamic.kabel-deutschland.de ([95.90.132.72] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fXjFY-00043V-HC; Tue, 26 Jun 2018 10:22:56 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
Date:   Tue, 26 Jun 2018 10:22:55 +0200
Message-ID: <61227765.LN80DIZAeb@diego>
In-Reply-To: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
References: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 26. Juni 2018, 10:16:44 CEST schrieb Sandy Huang:
> linebuffer mode should be LB_YUV_3840X5 when width is bigger
> than 1280 in yuv mode.
> seperate yuv and rgb case make the scl_vop_cal_lb_mode() logic
> is clearer.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Link:
> https://patchwork.freedesktop.org/patch/msgid/1523960108-190541-1-git-send-> email-hjc@rock-chips.com

Missing the "v2" in the subject, but I remembered and found the v1 from april. 
And it looks great now.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



