Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935251AbeBNJNm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:13:42 -0500
Received: from gloria.sntech.de ([95.129.55.99]:40334 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934847AbeBNJNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:13:39 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>, groeck@chromium.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chris Zhong <zyw@rock-chips.com>,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/3] Documentation: bindings: add dt documentation for cdn DP controller
Date: Wed, 14 Feb 2018 10:13:31 +0100
Message-ID: <2259273.IWOZNSGJqo@diego>
In-Reply-To: <20180213143549.15197-1-enric.balletbo@collabora.com>
References: <20180213143549.15197-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 13. Februar 2018, 15:35:47 CET schrieb Enric Balletbo i Serra:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> This patch adds a binding that describes the cdn DP controller for
> rk3399.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v1:
> - Add the cdn-dp bindings as requested by Heiko
>   - The bindingis were sent already and acked by Rob but for some reason
>     never landed. So as these series are related I incorporated this
>     patch again [1].
> 
> [1] https://patchwork.kernel.org/patch/9278077/

applied for 4.17 (into drm-misc).

The driver uses 3 additional resets now, which I just added to the
reset-names.


Heiko
