Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92FEC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACFA263AD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACFA263AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965531AbeF0NfS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:35:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47100 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965286AbeF0NfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:35:17 -0400
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2018 09:35:17 EDT
Received: from [94.134.91.246] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fYAD8-0007iF-1Q; Wed, 27 Jun 2018 15:10:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
Date:   Wed, 27 Jun 2018 15:10:12 +0200
Message-ID: <2037317.Zy9BHlEm4Q@phil>
In-Reply-To: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
References: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy,

Am Dienstag, 26. Juni 2018, 10:16:44 CEST schrieb Sandy Huang:
> linebuffer mode should be LB_YUV_3840X5 when width is bigger
> than 1280 in yuv mode.
> seperate yuv and rgb case make the scl_vop_cal_lb_mode() logic
> is clearer.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

applied to drm-misc-next


Heiko


