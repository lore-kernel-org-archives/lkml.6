Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18809C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DDD208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DDD208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbeHAOTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:19:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33638 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387673AbeHAOTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:19:18 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fkqJt-00057G-Nd; Wed, 01 Aug 2018 14:33:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, ajitn.linux@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Convert drm_atomic_helper_suspend/resume()
Date:   Wed, 01 Aug 2018 14:33:36 +0200
Message-ID: <16141309.kTfAWOe8rM@phil>
In-Reply-To: <20180731203430.GA30136@jordon-HP-15-Notebook-PC>
References: <20180731203430.GA30136@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

Am Dienstag, 31. Juli 2018, 22:34:30 CEST schrieb Souptick Joarder:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
> 
> With this conversion, rockchip_drm_fb_resume() and
> rockchip_drm_fb_suspend() will not be used anymore.
> Both of these functions can be removed.
> 
> Also, in struct rockchip_drm_private state will not be
> used anymore. So this can be removed forever.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>

the patch itself looks great, just a simple bookkeeping question.

What role did Ajit play in creating the patch? If I remember correctly
it is meant to be
- 1st Signed-off: Patch-Author
- 2nd Signed-off: E-Mail sender + patch possibly patch changes
(optional of course if the same)

So was this meant to be a Reviewed-by from Ajit?


Thanks
Heiko


