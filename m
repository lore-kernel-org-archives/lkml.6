Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5EF208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfAJW6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:58:25 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57678 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfAJW6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:58:25 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ghjHJ-0005pc-Px; Thu, 10 Jan 2019 23:58:21 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>
Subject: Re: [PATCH v4] drm/rockchip: update cursors asynchronously through atomic.
Date:   Thu, 10 Jan 2019 23:58:20 +0100
Message-ID: <2812027.QDNv8WpI9g@phil>
In-Reply-To: <20181205123310.7965-1-helen.koike@collabora.com>
References: <20181205123310.7965-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Dezember 2018, 13:33:10 CET schrieb Helen Koike:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Add support to async updates of cursors by using the new atomic
> interface for that.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> [updated for upstream]
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

applied to drm-misc-next after testing cursor operation on multiple
machines.

Thanks
Heiko


