Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91103C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCA22088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 13:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCA22088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbeFPNAd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 09:00:33 -0400
Received: from gloria.sntech.de ([95.129.55.99]:48232 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932788AbeFPNAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 09:00:32 -0400
Received: from ip5f5a8448.dynamic.kabel-deutschland.de ([95.90.132.72] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fUAoJ-0006oP-OC; Sat, 16 Jun 2018 15:00:08 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Lin Huang <hl@rock-chips.com>
Cc:     seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dgreid@chromium.org, broonie@kernel.org, dianders@chromium.org,
        briannorris@chromium.org, linux-rockchip@lists.infradead.org,
        daniel.vetter@intel.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeffy.chen@rock-chips.com
Subject: Re: [PATCH 1/2] drm/rockchip: cnd-dp: adjust spdif register setting
Date:   Sat, 16 Jun 2018 15:00:06 +0200
Message-ID: <1713657.Ecv5Pr7be3@diego>
In-Reply-To: <1526979222-32478-1-git-send-email-hl@rock-chips.com>
References: <1526979222-32478-1-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 22. Mai 2018, 10:53:41 CEST schrieb Lin Huang:
> We use jitter bypass mode for spdif, so do not need to set jitter mode
> related bit in SPDIF_CTRL_ADDR register. Also, we need to enable
> SPDIF_ENABLE bit.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>

applied to drm-misc-next after adapting the commit message
to make it clear that we need to keep the SPDIF_ENABLE bit.


Thanks
Heiko


