Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeEVN4O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:56:14 -0400
Received: from gloria.sntech.de ([95.129.55.99]:45858 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbeEVN4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:56:12 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 13/33] clk: rockchip: use match_string() helper
Date: Tue, 22 May 2018 15:56:01 +0200
Message-ID: <3184431.yyZBj8V0y7@phil>
In-Reply-To: <1526903890-35761-14-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-14-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 21. Mai 2018, 13:57:50 CEST schrieb Yisheng Xie:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

> @@ -312,6 +304,8 @@ static struct clk *rockchip_clk_register_frac_branch(
>  
>  		/* notifier on the fraction divider to catch rate changes */
>  		if (frac->mux_frac_idx >= 0) {
> +			pr_debug("%s: find fractional parent in mux at pos %d\n",
> +				 __func__, frac->mux_frac_idx);

applied to my Rockchip clk branch for 4.18 after changing the "find" above
to "found" again ;-) .


Thanks for the nice cleanup
Heiko
