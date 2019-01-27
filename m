Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8820C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7202148D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfA0K2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 05:28:10 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46718 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfA0K2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 05:28:09 -0500
Received: from p5b12725f.dip0.t-ipconnect.de ([91.18.114.95] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gnhfU-0007at-DM; Sun, 27 Jan 2019 11:28:00 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm-misc-fixes tree
Date:   Sun, 27 Jan 2019 11:27:59 +0100
Message-ID: <2323380.JT0u9sGhZs@phil>
In-Reply-To: <20190127144126.6fc70a71@canb.auug.org.au>
References: <20190127144126.6fc70a71@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 27. Januar 2019, 04:41:26 CET schrieb Stephen Rothwell:
> Hi all,
> 
> In commit
> 
>   053ff09f1a8f ("drm/rockchip: rgb: update SPDX license identifier")
> 
> Fixes tag
> 
>   Fixes: 1f0f01515172 ("Add support for Rockchip Soc RGB output interface")

looks like I accidentially lost the "drm/rockchip:" prefix from the subject,
sorry about that. I think it should still be recognizable, as the original
was named 
	"drm/rockchip: Add support for Rockchip Soc RGB output interface"

It's too late to amend now anyway, so hopefully it will not cause too much
trouble.


Heiko


