Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbeDTM4T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:56:19 -0400
Received: from gloria.sntech.de ([95.129.55.99]:52114 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTM4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:56:17 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm: dts: rockchip: default serial for Tinker Board
Date: Fri, 20 Apr 2018 14:56:06 +0200
Message-ID: <2049472.10qBoIBg0j@phil>
In-Reply-To: <20180417205623.764-1-xypron.glpk@gmx.de>
References: <20180417205623.764-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 17. April 2018, 22:56:23 CEST schrieb Heinrich Schuchardt:
> The Asus Tinker Board uses serial 2 with 115,200 baud by default for
> communication in U-Boot. The same value is also chosen for other RK3288
> boards.
> 
> So let us set the same value in the Tinker Board device tree.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

applied for 4.18

Thanks
Heiko
