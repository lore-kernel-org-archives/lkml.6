Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbeBENDq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:03:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41432 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbeBENDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:03:39 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180205130337euoutp024300d641bd3c97b84755cb739649fdea~Qb6JV21In2432324323euoutp02D
X-AuditID: cbfec7f2-f793b6d000003243-4d-5a785628a5be
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Add 1.31 version support
To: Philippe Cornu <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Mickael Reulier <mickael.reulier@st.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-id: <61f522e7-bdb7-7eba-ffb2-7dbb77ffa09e@samsung.com>
Date: Mon, 05 Feb 2018 14:03:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <20180122150819.22066-1-philippe.cornu@st.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUhUURTHuW+bpzX2Gqc6lSaNFNmibR9uWaFS9L5EgWQ1ITXoSyU3ZrIs
        i8xy3HLJ0dIxRUHDgqhmzI0WnXIdl0TTtDJTK8nCmhYaQm2cZ+C3/zn/37ln4bKkbJJexoZF
        nhLUkapwBeNIVTZaOzasCYhVbtQOu+L0jhYCPxg1I5yQ/JXGCaZWBlsGMxls+D5B455fEwye
        Hh6ncWH2BZxyrVSCDSO9NO6uvWnDhqZJ/LzOFxdN3qVxa72JwENXxmjc9rKOwkkpiYyPM18Q
        30Xx3RnpBF+jfyvhC5Lzaf5N7yOGr/o9RPPv0poI3lh6kZ/UP6X4qt4ikv/w5zHJ/zCsODBf
        6bgjWAgPOy2ovXYddwwdSbqOoqs9Ygs6b9PxqHZlKnJggdsK2dY2WtSL4cXgPSYVObIyrgxB
        YnEFIQY/EDws1VL/Kz4mj85StxD81b2WzBhSbiH80Q3aIZLzgLGf2ZQIfURQYv5ih5y5vZBU
        Umg35FwCBb2jN8mZgOQuEVCUZ0QzFGMrnzT2M+Kzu6DmSbsNYlmKWwWvHpMz6UXcYSjJ/WDH
        HThvMI5aCbGzG9T3fJqdYglcTuy3NwNuQAJZfbmMuMNum9FJitoZPjdVSETtAt26tNmCNASW
        zGaJGOQgmPqWN1vhDc+aumixhRNkV96wTwecFJK1MhHh4Z5hjBC1L1gapyTiLTIQjLeWEFnI
        TT/nZvo5N9PP2UI/Z4tiRN1BciFGExEiaLZ4alQRmpjIEM+gqAgDsn1K81STpRr9at5uQhyL
        FPOl+NgZpYxWndacjTAhYEmFXOrXZ0tJg1VnzwnqqGPqmHBBY0LLWUqxRLpTqT0i40JUp4ST
        ghAtqP+7BOuwLB5d5dLxlWAPY+znQbzt8rA2dHVATr1nXLVi3er62tzy6YZArNwcFxi0QG0J
        XhrTvt18cOp93d9y+bh1HtKV3fJ3LadS3T02N1z3VpitmYeCFrZMnH+230ed7urVEl+zfj/a
        J/fWJbi8PFoQlx/26L6fv3tITzj3e8QJ0qg9ZwZOKChNqGrTWlKtUf0DqKVWJZADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xq7rqYRVRBm/3mlv0njvJZLHxyWlG
        i6aOt6wWTYdOsVl8utfPZrHp43tWiytf37NZ/H/0mtVi7qRai86JS9gtNj2+xmpxedccoLIH
        /5ktjhxwtJj3dy2rxamDh5gsHrS8YLU4c/UAi0V7Zyubg7DH7IaLLB6X+3qZPHbOusvuMbtj
        JqvHnWt72Dy2f3vA6nG/+ziTx+Yl9R5/Z+1n8dh+bR6zx9Mfe5k9Pm+SC+CJ4rJJSc3JLEst
        0rdL4Mp43D6NsWCHZsXs8ytZGxh3KXYxcnJICJhIPOt4wgZhi0lcuLceyObiEBJYwijx6sUd
        ZpAEr4CgxI/J91i6GDk4mAXUJaZMyYWoecYosfnLF7BmYQF3ifaFc1lAEiICLSwSe5/eBJvE
        LNDMJNF5vpMRomUCo8T5bffAWtgENCX+br7JBrHCTmLnvrPMICtYBFQlbuwF2ywqECHRuXI+
        C4jNKWAtsfnJTyYQm1lAXuLglecsELa4RHPrTZYJjIKzkBw7C+HYWUg6ZiHpWMDIsopRJLW0
        ODc9t9hIrzgxt7g0L10vOT93EyMwmrcd+7llB2PXu+BDjAIcjEo8vBbx5VFCrIllxZW5hxgl
        OJiVRHidrgOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/buWR0pJJCeWJKanZpakFoEk2Xi4JRq
        YDR/oWjIlrPjK+cch7vHS1SCxLZdf1jsH+BgULrWSqeUs/uTxkexeXzxT7xu7dnY6Psl8AO3
        etJavh2z9N8uTojbzfnKZ6+28c7YlzFekp+4KvsT7nnvM1XPedKUsi9v+hP18pne//c/EleU
        bKn0SjOcU+y2LKHaq/PyMmuOZXOe9z8VeuXvrMRSnJFoqMVcVJwIAIMgD6PiAgAA
X-CMS-MailID: 20180205130335eucas1p10dbbf3eb1f8fa869df936f61b7f3f12a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180122150916epcas5p14fc276bc3320d82685b3c19dd62f5273
X-RootMTR: 20180122150916epcas5p14fc276bc3320d82685b3c19dd62f5273
References: <CGME20180122150916epcas5p14fc276bc3320d82685b3c19dd62f5273@epcas5p1.samsung.com>
        <20180122150819.22066-1-philippe.cornu@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.2018 16:08, Philippe Cornu wrote:
> From: Philippe CORNU <philippe.cornu@st.com>
>
> Add support for the Synopsys DesignWare MIPI DSI version 1.31
> Two registers need to be updated/added for supporting 1.31:
> * PHY_TMR_CFG 0x9c (updated)
>   1.30 [31:24] phy_hs2lp_time
>        [23:16] phy_lp2hs_time
>        [14: 0] max_rd_time
>
>   1.31 [25:16] phy_hs2lp_time
>        [ 9: 0] phy_lp2hs_time
>
> * PHY_TMR_RD_CFG 0xf4 (new)
>   1.31 [14: 0] max_rd_time
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 52 +++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 735f38429c06..20a2ca14a7ad 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -25,7 +25,13 @@
>  #include <drm/bridge/dw_mipi_dsi.h>
>  #include <video/mipi_display.h>
>  
> +#define HWVER_130			0x31333000	/* IP version 1.30 */
> +#define HWVER_131			0x31333100	/* IP version 1.31 */
> +#define HWVER_OLDEST			HWVER_130
> +#define HWVER_NEWEST			HWVER_131
> +
>  #define DSI_VERSION			0x00
> +#define VERSION				GENMASK(31, 8)
>  
>  #define DSI_PWR_UP			0x04
>  #define RESET				0
> @@ -161,11 +167,12 @@
>  #define PHY_CLKHS2LP_TIME(lbcc)		(((lbcc) & 0x3ff) << 16)
>  #define PHY_CLKLP2HS_TIME(lbcc)		((lbcc) & 0x3ff)
>  
> -/* TODO Next register is slightly different between 1.30 & 1.31 IP version */
>  #define DSI_PHY_TMR_CFG			0x9c
> -#define PHY_HS2LP_TIME(lbcc)		(((lbcc) & 0xff) << 24)
> -#define PHY_LP2HS_TIME(lbcc)		(((lbcc) & 0xff) << 16)
> -#define MAX_RD_TIME(lbcc)		((lbcc) & 0x7fff)
> +#define PHY_HS2LP_TIME_V130(lbcc)	(((lbcc) & 0xff) << 24)
> +#define PHY_LP2HS_TIME_V130(lbcc)	(((lbcc) & 0xff) << 16)
> +#define MAX_RD_TIME_V130(lbcc)		((lbcc) & 0x7fff)
> +#define PHY_HS2LP_TIME_V131(lbcc)	(((lbcc) & 0x3ff) << 16)
> +#define PHY_LP2HS_TIME_V131(lbcc)	((lbcc) & 0x3ff)
>  
>  #define DSI_PHY_RSTZ			0xa0
>  #define PHY_DISFORCEPLL			0
> @@ -204,7 +211,9 @@
>  #define DSI_INT_ST1			0xc0
>  #define DSI_INT_MSK0			0xc4
>  #define DSI_INT_MSK1			0xc8
> +
>  #define DSI_PHY_TMR_RD_CFG		0xf4
> +#define MAX_RD_TIME_V131(lbcc)		((lbcc) & 0x7fff)
>  
>  #define PHY_STATUS_TIMEOUT_US		10000
>  #define CMD_PKT_STATUS_TIMEOUT_US	20000
> @@ -215,6 +224,7 @@ struct dw_mipi_dsi {
>  	struct drm_bridge *panel_bridge;
>  	struct device *dev;
>  	void __iomem *base;
> +	u32 hw_version;
>  
>  	struct clk *pclk;
>  	struct clk *px_clk;
> @@ -616,8 +626,14 @@ static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
>  	 * note: DSI_PHY_TMR_CFG.MAX_RD_TIME should be in line with
>  	 * DSI_CMD_MODE_CFG.MAX_RD_PKT_SIZE_LP (see CMD_MODE_ALL_LP)
>  	 */
> -	dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME(0x40)
> -		  | PHY_LP2HS_TIME(0x40) | MAX_RD_TIME(10000));
> +	if (dsi->hw_version == HWVER_131) {
> +		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME_V131(0x40) |
> +			  PHY_LP2HS_TIME_V131(0x40));
> +		dsi_write(dsi, DSI_PHY_TMR_RD_CFG, MAX_RD_TIME_V131(10000));
> +	} else {
> +		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME_V130(0x40) |
> +			  PHY_LP2HS_TIME_V130(0x40) | MAX_RD_TIME_V130(10000));
> +	}
>  
>  	dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG, PHY_CLKHS2LP_TIME(0x40)
>  		  | PHY_CLKLP2HS_TIME(0x40));
> @@ -791,6 +807,28 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
>  	.attach	      = dw_mipi_dsi_bridge_attach,
>  };
>  
> +static void dsi_get_version(struct dw_mipi_dsi *dsi)
> +{
> +	u32 hw_version;
> +
> +	clk_prepare_enable(dsi->pclk);
> +	hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
> +	clk_disable_unprepare(dsi->pclk);
> +
> +	if (hw_version > HWVER_NEWEST) {
> +		DRM_DEBUG("hw version: use 0x%08x for this recent 0x%08x\n",
> +			  HWVER_NEWEST, hw_version);
> +		hw_version = HWVER_NEWEST;
> +
> +	} else if (hw_version < HWVER_OLDEST) {
> +		DRM_DEBUG("hw version: use 0x%08x for this old 0x%08x\n",
> +			  HWVER_OLDEST, hw_version);
> +		hw_version = HWVER_OLDEST;
> +	}
> +
> +	dsi->hw_version = hw_version;
> +}
> +
>  static struct dw_mipi_dsi *
>  __dw_mipi_dsi_probe(struct platform_device *pdev,
>  		    const struct dw_mipi_dsi_plat_data *plat_data)
> @@ -870,6 +908,8 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>  		clk_disable_unprepare(dsi->pclk);
>  	}
>  
> +	dsi_get_version(dsi);
> +
>  	pm_runtime_enable(dev);

Two questions:
1. You have generally two variants:
- older than 131,
- not older than 131.
Wouldn't be better to just assume that since 131 registers slightly differ?
So you just stores:
    dsi->hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
And if neccessary performs comparison:
    if (dsi->hw_version >= HWVER_131)
        ...
    else
        ...

This way you can remove these HWVER_(NEWEST|OLDEST).

2. You are using pm_runtime, but not in dsi_get_version. I guess it is
SoC dependant  but I suppose performing registry read should be safer
after runtime_get.

Regards
Andrzej

>  
>  	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
