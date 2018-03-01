Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032626AbeCAPjk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:39:40 -0500
Received: from gloria.sntech.de ([95.129.55.99]:48940 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032594AbeCAPjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:39:36 -0500
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
Subject: Re: [PATCH v8 1/8] drm/bridge: analogix: Do not use device's drvdata
Date: Thu, 01 Mar 2018 16:39:18 +0100
Message-ID: <4651149.oDM8cr11nT@diego>
In-Reply-To: <20180110162348.22765-2-thierry.escande@collabora.com>
References: <20180110162348.22765-1-thierry.escande@collabora.com> <20180110162348.22765-2-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Januar 2018, 17:23:41 CET schrieb Thierry Escande:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> The driver that instantiates the bridge should own the drvdata, as all
> driver model callbacks (probe, remove, shutdown, PM ops, etc.) are also
> owned by its driver struct. Moreover, storing two different pointer
> types in driver data depending on driver initialization status is barely
> a good practice and in fact has led to many bugs in this driver.
> 
> Let's clean up this mess and change Analogix entry points to simply
> accept some opaque struct pointer, adjusting their users at the same
> time to avoid breaking the compilation.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Archit Taneja <architt@codeaurora.org>

applied to drm-misc-next as it had Reviews/Acks from drm-bridge people

Thanks
Heiko
