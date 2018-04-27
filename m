Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbeD0JoA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:44:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50792 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932411AbeD0Jn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:43:57 -0400
X-Google-Smtp-Source: AB8JxZo49GsYq0O8A4zjvWqk7RRpHVuYojpQ8FW7SLS+nQDBLGbDuNsoEtciuehkCqEsI/saxK7Cpw==
Subject: Re: [PATCH v2 1/2] soc: mediatek: introduce a CAPS flag for
 scp_domain_data
To: sean.wang@mediatek.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <2e16481e1477dfae0cfb24568d8111da81d92628.1524472331.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <b956be98-95d2-50c8-af5c-cfbb4666d7ae@gmail.com>
Date: Fri, 27 Apr 2018 11:43:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2e16481e1477dfae0cfb24568d8111da81d92628.1524472331.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/23/2018 10:36 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Instead of adding more and more fields to scp_domain_data which get
> checked in the code flow, add a caps field used for an indication the
> characteristics for each SCP domain.
> 
> At present, type u8 for the caps field is selected which can satisfy the
> current situation and doesn't take up extra space against type bool
> previously used.
> 
> Suggested-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 65 ++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)

pushed to v4.17-next/soc

Thanks.

> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index f140e71..b1b45e4 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -31,6 +31,9 @@
>  #define MTK_POLL_DELAY_US   10
>  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
>  
> +#define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
> +#define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
> +
>  #define SPM_VDE_PWR_CON			0x0210
>  #define SPM_MFG_PWR_CON			0x0214
>  #define SPM_VEN_PWR_CON			0x0230
> @@ -120,7 +123,7 @@ struct scp_domain_data {
>  	u32 sram_pdn_ack_bits;
>  	u32 bus_prot_mask;
>  	enum clk_id clk_id[MAX_CLKS];
> -	bool active_wakeup;
> +	u8 caps;
>  };
>  
>  struct scp;
> @@ -424,7 +427,7 @@ static struct scp *init_scp(struct platform_device *pdev,
>  		genpd->name = data->name;
>  		genpd->power_off = scpsys_power_off;
>  		genpd->power_on = scpsys_power_on;
> -		if (scpd->data->active_wakeup)
> +		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
>  			genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
>  	}
>  
> @@ -477,7 +480,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
>  		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
>  				 MT2701_TOP_AXI_PROT_EN_CONN_S,
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_DISP] = {
>  		.name = "disp",
> @@ -486,7 +489,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.clk_id = {CLK_MM},
>  		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_MM_M0,
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_MFG] = {
>  		.name = "mfg",
> @@ -495,7 +498,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(12, 12),
>  		.clk_id = {CLK_MFG},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_VDEC] = {
>  		.name = "vdec",
> @@ -504,7 +507,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(12, 12),
>  		.clk_id = {CLK_MM},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_ISP] = {
>  		.name = "isp",
> @@ -513,7 +516,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(13, 12),
>  		.clk_id = {CLK_MM},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_BDP] = {
>  		.name = "bdp",
> @@ -521,7 +524,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
>  		.ctl_offs = SPM_BDP_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_ETH] = {
>  		.name = "eth",
> @@ -530,7 +533,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_ETHIF},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_HIF] = {
>  		.name = "hif",
> @@ -539,14 +542,14 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_ETHIF},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2701_POWER_DOMAIN_IFR_MSC] = {
>  		.name = "ifr_msc",
>  		.sta_mask = PWR_STATUS_IFR_MSC,
>  		.ctl_offs = SPM_IFR_MSC_PWR_CON,
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  };
>  
> @@ -561,7 +564,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(8, 8),
>  		.sram_pdn_ack_bits = GENMASK(12, 12),
>  		.clk_id = {CLK_MM},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_VDEC] = {
>  		.name = "vdec",
> @@ -570,7 +573,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(8, 8),
>  		.sram_pdn_ack_bits = GENMASK(12, 12),
>  		.clk_id = {CLK_MM, CLK_VDEC},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_VENC] = {
>  		.name = "venc",
> @@ -579,7 +582,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_MM, CLK_VENC, CLK_JPGDEC},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_ISP] = {
>  		.name = "isp",
> @@ -588,7 +591,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(13, 12),
>  		.clk_id = {CLK_MM},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_AUDIO] = {
>  		.name = "audio",
> @@ -597,7 +600,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_AUDIO},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_USB] = {
>  		.name = "usb",
> @@ -606,7 +609,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(10, 8),
>  		.sram_pdn_ack_bits = GENMASK(14, 12),
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_USB2] = {
>  		.name = "usb2",
> @@ -615,7 +618,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(10, 8),
>  		.sram_pdn_ack_bits = GENMASK(14, 12),
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_MFG] = {
>  		.name = "mfg",
> @@ -625,7 +628,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_ack_bits = GENMASK(16, 16),
>  		.clk_id = {CLK_MFG},
>  		.bus_prot_mask = BIT(14) | BIT(21) | BIT(23),
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_MFG_SC1] = {
>  		.name = "mfg_sc1",
> @@ -634,7 +637,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(8, 8),
>  		.sram_pdn_ack_bits = GENMASK(16, 16),
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_MFG_SC2] = {
>  		.name = "mfg_sc2",
> @@ -643,7 +646,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(8, 8),
>  		.sram_pdn_ack_bits = GENMASK(16, 16),
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT2712_POWER_DOMAIN_MFG_SC3] = {
>  		.name = "mfg_sc3",
> @@ -652,7 +655,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
>  		.sram_pdn_bits = GENMASK(8, 8),
>  		.sram_pdn_ack_bits = GENMASK(16, 16),
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  };
>  
> @@ -752,7 +755,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_NONE},
>  		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_ETHSYS,
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT7622_POWER_DOMAIN_HIF0] = {
>  		.name = "hif0",
> @@ -762,7 +765,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_HIFSEL},
>  		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF0,
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT7622_POWER_DOMAIN_HIF1] = {
>  		.name = "hif1",
> @@ -772,7 +775,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_HIFSEL},
>  		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF1,
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT7622_POWER_DOMAIN_WB] = {
>  		.name = "wb",
> @@ -782,7 +785,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
>  		.sram_pdn_ack_bits = 0,
>  		.clk_id = {CLK_NONE},
>  		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  };
>  
> @@ -798,7 +801,7 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
>  		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
>  				 MT2701_TOP_AXI_PROT_EN_CONN_S,
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT7623A_POWER_DOMAIN_ETH] = {
>  		.name = "eth",
> @@ -807,7 +810,7 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_ETHIF},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT7623A_POWER_DOMAIN_HIF] = {
>  		.name = "hif",
> @@ -816,14 +819,14 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_ETHIF},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT7623A_POWER_DOMAIN_IFR_MSC] = {
>  		.name = "ifr_msc",
>  		.sta_mask = PWR_STATUS_IFR_MSC,
>  		.ctl_offs = SPM_IFR_MSC_PWR_CON,
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  };
>  
> @@ -889,7 +892,7 @@ static const struct scp_domain_data scp_domain_data_mt8173[] = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  		.clk_id = {CLK_NONE},
> -		.active_wakeup = true,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
>  		.name = "mfg_async",
> 
