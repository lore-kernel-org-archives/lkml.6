Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032637AbeCAPkB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:40:01 -0500
Received: from gloria.sntech.de ([95.129.55.99]:48990 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032596AbeCAPkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:40:00 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org
Cc: Thierry Escande <thierry.escande@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sandy Huang <hjc@rock-chips.com>, linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/8] drm/bridge: analogix_dp: Fix connector and encoder cleanup
Date: Thu, 01 Mar 2018 16:39:47 +0100
Message-ID: <17473410.zGek1k5XFt@diego>
In-Reply-To: <20180110162348.22765-3-thierry.escande@collabora.com>
References: <20180110162348.22765-1-thierry.escande@collabora.com> <20180110162348.22765-3-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Januar 2018, 17:23:42 CET schrieb Thierry Escande:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Since we are initing connector in the core driver and encoder in the
> plat driver, let's clean them up in the right places.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

applied to drm-misc-next as it had also a Review from drm-bridge people

Thanks
Heiko
