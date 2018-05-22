Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeEVRfj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:35:39 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33336 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeEVRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:35:37 -0400
X-Google-Smtp-Source: AB8JxZou/S+bRlW83QJZFp1knB2Ts6+QNl32K9NOO0jTRXsWHynWwkfQTrGKcm+DnZdyzT1oxJZW7w==
Date: Tue, 22 May 2018 12:35:34 -0500
From: Rob Herring <robh@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: heiko@sntech.de, mark.rutland@arm.com, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v2 05/13] dt-bindings: power: add RK3128 SoCs header for
 power-domain
Message-ID: <20180522173534.GA15794@rob-hp-laptop>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
 <1526268602-9760-1-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526268602-9760-1-git-send-email-zhangqing@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:30:02AM +0800, Elaine Zhang wrote:
> According to a description from TRM, add all the power domains.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/power/rk3128-power.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3128-power.h
> 
> diff --git a/include/dt-bindings/power/rk3128-power.h b/include/dt-bindings/power/rk3128-power.h
> new file mode 100644
> index 000000000000..26aef519cd94
> --- /dev/null
> +++ b/include/dt-bindings/power/rk3128-power.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
> + * Author: Elaine Zhang <zhangqing@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Use SPDX tag instead, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>
