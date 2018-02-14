Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966935AbeBNJ3c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:29:32 -0500
Received: from gloria.sntech.de ([95.129.55.99]:40574 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966446AbeBNJ3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:29:30 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>, groeck@chromium.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chris Zhong <zyw@rock-chips.com>,
        kernel@collabora.com
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: add cdn-dp node for rk3399.
Date: Wed, 14 Feb 2018 10:29:26 +0100
Message-ID: <1603021.5cKYStphhr@diego>
In-Reply-To: <20180213143549.15197-2-enric.balletbo@collabora.com>
References: <20180213143549.15197-1-enric.balletbo@collabora.com> <20180213143549.15197-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 13. Februar 2018, 15:35:48 CET schrieb Enric Balletbo i Serra:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> Add a node for the cdn DP controller which is embedded in the rk3399
> SoC.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied for 4.17 after some fixups:

- the patch used whitespaces instead of tabs for indentation
- address+size-cells are only necessary above the endpoint nodes
  (see the hdmi node for example)
- the interrupts property had the wrong number of elements
  dtc should have warned about that


Heiko
