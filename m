Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEVRex (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:34:53 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45987 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeEVRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:34:51 -0400
X-Google-Smtp-Source: AB8JxZogkL73KnFe9nJQpiiiZCj23Pz7OBT+6V4hASbB2HaCOv4YENKyRBZKsoptf3Wm+u6poyPuyQ==
Date: Tue, 22 May 2018 12:34:48 -0500
From: Rob Herring <robh@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: heiko@sntech.de, mark.rutland@arm.com, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v2 02/13] dt-bindings: add binding for rk3036 power
 domains
Message-ID: <20180522173448.GA15232@rob-hp-laptop>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
 <1526268528-9247-1-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526268528-9247-1-git-send-email-zhangqing@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:28:48AM +0800, Elaine Zhang wrote:
> From: Caesar Wang <wxt@rock-chips.com>
> 
> Add binding documentation for the power domains
> found on Rockchip RK3036 SoCs.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
