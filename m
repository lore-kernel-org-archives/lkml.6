Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeEVP6P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:58:15 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:46758 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEVP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:58:11 -0400
X-Google-Smtp-Source: AB8JxZpEEa2r79uDgvOCpCxw4MbLHFn7YI6l3KUqBaqWvM0RzcI+CnGVNsSr0bq9UinP8GftdialPQ==
Date: Tue, 22 May 2018 10:58:09 -0500
From: Rob Herring <robh@kernel.org>
To: Lin Huang <hl@rock-chips.com>
Cc: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        kishon@ti.com, dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/5] Documentation: dt-bindings: phy: add phy_config
 for Rockchip USB Type-C PHY
Message-ID: <20180522155809.GA3988@rob-hp-laptop>
References: <1526895424-22894-1-git-send-email-hl@rock-chips.com>
 <1526895424-22894-2-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526895424-22894-2-git-send-email-hl@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 05:37:01PM +0800, Lin Huang wrote:
> If want to do training outside DP Firmware, need phy voltage swing
> and pre_emphasis value.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - None 
> Changes in v3:
> - modify property description and add this property to Example
> Changes in v4:
> - None
> Changes in v5:
> - None
> Changes in v6:
> - change rockchip,phy_config to rockchip,phy-config and descript it in detail.
>  
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 36 +++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
