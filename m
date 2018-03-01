Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032688AbeCAPla (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:41:30 -0500
Received: from gloria.sntech.de ([95.129.55.99]:49052 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032684AbeCAPl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:41:28 -0500
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
Subject: Re: [PATCH v8 3/8] drm/rockchip: analogix_dp: Add a sanity check for rockchip_drm_psr_register()
Date: Thu, 01 Mar 2018 16:41:19 +0100
Message-ID: <1924595.cjJt1kUqps@diego>
In-Reply-To: <20180110162348.22765-4-thierry.escande@collabora.com>
References: <20180110162348.22765-1-thierry.escande@collabora.com> <20180110162348.22765-4-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Januar 2018, 17:23:43 CET schrieb Thierry Escande:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> The rockchip_drm_psr_register() can fail, so add a sanity check for that.
> 
> Also reorder the calls in unbind() to match bind().
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>

applied to drm-misc, after splitting out the reordering into a
separate patch. Having these surprise changes hidden behind
an "also" feels not ideal.


Heiko
