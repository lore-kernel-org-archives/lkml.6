Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbeETLsz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 07:48:55 -0400
Received: from gloria.sntech.de ([95.129.55.99]:41464 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeETLsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 07:48:53 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/3] drm/rockchip: lvds: avoid duplicating drm_bridge_attach
Date: Sun, 20 May 2018 13:48:39 +0200
Message-ID: <2076868.NHBhtu2M9j@phil>
In-Reply-To: <20180502074025.12421-3-peda@axentia.se>
References: <20180502074025.12421-1-peda@axentia.se> <20180502074025.12421-3-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 2. Mai 2018, 09:40:24 CEST schrieb Peter Rosin:
> drm_bridge_attach takes care of these assignments, so there is no need
> to open-code them a second time.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

applied to drm-misc-next


Thanks
Heiko
