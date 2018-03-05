Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeCEU0i convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:26:38 -0500
Received: from gloria.sntech.de ([95.129.55.99]:40884 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752975AbeCEU0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:26:35 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: rockchip: power-domain: Add a sanity check on pd->num_clks
Date: Mon, 05 Mar 2018 21:26:23 +0100
Message-ID: <2446754.ohlkqz2d1D@diego>
In-Reply-To: <20180305091722.22246-1-jeffy.chen@rock-chips.com>
References: <20180305091722.22246-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 5. März 2018, 10:17:22 CET schrieb Jeffy Chen:
> The of_count_phandle_with_args() can fail and return error(for example,
> rk3399 pd_vio doesn't have clocks). That would break the pd probe.
> 
> Add a sanity check on pd->num_clks to avoid that.
> 
> Fixes: 65084121d59d ("soc: rockchip: power-domain: use clk_bulk APIs")
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

applied for 4.17


Thanks
Heiko
