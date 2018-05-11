Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbeEKOnJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:43:09 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35492 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbeEKOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:43:07 -0400
X-Google-Smtp-Source: AB8JxZqZiqX/TU5p9f+q5jQtKWZguN3peXvGTVqFkSes+kW0iCctzY5kA/KAyuMxzVXfZ89Y28NlbA==
Date: Fri, 11 May 2018 10:43:05 -0400
From: Sean Paul <seanpaul@chromium.org>
To: Lin Huang <hl@rock-chips.com>
Cc: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v2 3/4] Documentation: bindings: add phy_config for
 Rockchip USB Type-C PHY
Message-ID: <20180511144305.GP33053@art_vandelay>
References: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
 <1525861364-26323-3-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525861364-26323-3-git-send-email-hl@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 06:22:43PM +0800, Lin Huang wrote:
> If want to do training outside DP Firmware, need phy voltage swing
> and pre_emphasis value.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>

Adding Rob Herring so he has a hope of seeing this.

> ---
> Changes in v2:
> - rebase
> 
>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> index 960da7f..eda26dd 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -17,7 +17,9 @@ Required properties:
>  
>  Optional properties:
>   - extcon : extcon specifier for the Power Delivery
> -
> + - rockchip,phy_config : That's phy voltage swing and pre_emphasis
> +			 setting, if want to do dp training outside
> +			 dp firmware, need to add these value.

What are the units?

Sean

>  Required nodes : a sub-node is required for each port the phy provides.
>  		 The sub-node name is used to identify dp or usb3 port,
>  		 and shall be the following entries:
> -- 
> 2.7.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
