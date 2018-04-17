Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeDQPXI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:23:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35594 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeDQPWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:22:54 -0400
X-Google-Smtp-Source: AIpwx4+9lhAaLtpzqTL9OPfNS3b8U1P7keRlZsUhRYsqYdcNOcMujaVmn+r85ji3lY3/iRCx/Rg5lA==
Subject: Re: [PATCH V3 2/4] soc: mediatek: pwrap: add pwrap for mt6797 SoCs
To: argus.lin@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, wsd_upstream@mediatek.com,
        henryc.chen@mediatek.com, flora.fu@mediatek.com,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "shailendra . v" <shailendra.v@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20180323083238.13569-1-argus.lin@mediatek.com>
 <20180323083238.13569-3-argus.lin@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8b00b434-7482-7917-3c0e-e1d1002b9529@gmail.com>
Date: Tue, 17 Apr 2018 17:22:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180323083238.13569-3-argus.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/23/2018 09:32 AM, argus.lin@mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> mt6797 is a highly integrated SoCs, it uses mt6351 for power
> management. We need to add pwrap support to access mt6351.
> Pwrap of mt6797 also add new feature include starvation and
> request exception interrupt, dynamic starvation priority
> adjustment mechanism. Pwrap of mt6797 support capability
> like dcm, priority selection and INT1 interrupt.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---

As already said in the last version, you have to split that in two patches.
1. introduce CAPss
2. add mt6797 support

More comments inline, please see below.

>  drivers/soc/mediatek/mtk-pmic-wrap.c | 199 +++++++++++++++++++++++++++++++++--
>  1 file changed, 189 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index e9e054a15b7d..d0a0a3d7e88d 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -76,6 +76,13 @@
>  #define PWRAP_SLV_CAP_SECURITY	BIT(2)
>  #define HAS_CAP(_c, _x)	(((_c) & (_x)) == (_x))
>  
> +/* Group of bits used for shown pwrap capability */
> +#define PWRAP_CAP_BRIDGE	BIT(0)
> +#define PWRAP_CAP_RESET		BIT(1)
> +#define PWRAP_CAP_DCM		BIT(2)
> +#define PWRAP_CAP_PRIORITY_SEL	BIT(3)
> +#define PWRAP_CAP_INT1_EN	BIT(4)
> +
>  /* defines for slave device wrapper registers */
>  enum dew_regs {
>  	PWRAP_DEW_BASE,
> @@ -278,6 +285,30 @@ enum pwrap_regs {
>  	PWRAP_DVFS_WDATA7,
>  	PWRAP_SPMINF_STA,
>  	PWRAP_CIPHER_EN,
> +
> +	/* MT6797 series regs */
> +	PWRAP_INT1_EN,
> +	PWRAP_INT1_FLG_RAW,
> +	PWRAP_INT1_FLG,
> +	PWRAP_INT1_CLR,
> +	PWRAP_PRIORITY_USER_SEL_0,
> +	PWRAP_PRIORITY_USER_SEL_1,
> +	PWRAP_ARBITER_OUT_SEL_0,
> +	PWRAP_ARBITER_OUT_SEL_1,
> +	PWRAP_STARV_COUNTER_0,
> +	PWRAP_STARV_COUNTER_1,
> +	PWRAP_STARV_COUNTER_2,
> +	PWRAP_STARV_COUNTER_3,
> +	PWRAP_STARV_COUNTER_4,
> +	PWRAP_STARV_COUNTER_5,
> +	PWRAP_STARV_COUNTER_6,
> +	PWRAP_STARV_COUNTER_7,
> +	PWRAP_STARV_COUNTER_8,
> +	PWRAP_STARV_COUNTER_9,
> +	PWRAP_STARV_COUNTER_10,
> +	PWRAP_STARV_COUNTER_11,
> +	PWRAP_STARV_COUNTER_12,
> +	PWRAP_STARV_COUNTER_13,
>  };
>  
>  static int mt2701_regs[] = {
> @@ -366,6 +397,61 @@ static int mt2701_regs[] = {
>  	[PWRAP_ADC_RDATA_ADDR2] =	0x154,
>  };
>  
> +static int mt6797_regs[] = {
> +	[PWRAP_MUX_SEL] =		0x0,
> +	[PWRAP_WRAP_EN] =		0x4,
> +	[PWRAP_DIO_EN] =		0x8,
> +	[PWRAP_SIDLY] =			0xC,
> +	[PWRAP_RDDMY] =			0x10,
> +	[PWRAP_CSHEXT_WRITE] =		0x18,
> +	[PWRAP_CSHEXT_READ] =		0x1C,
> +	[PWRAP_CSLEXT_START] =		0x20,
> +	[PWRAP_CSLEXT_END] =		0x24,
> +	[PWRAP_STAUPD_PRD] =		0x28,
> +	[PWRAP_HARB_HPRIO] =		0x50,
> +	[PWRAP_HIPRIO_ARB_EN] =		0x54,
> +	[PWRAP_MAN_EN] =		0x60,
> +	[PWRAP_MAN_CMD] =		0x64,
> +	[PWRAP_WACS0_EN] =		0x70,
> +	[PWRAP_WACS1_EN] =		0x84,
> +	[PWRAP_WACS2_EN] =		0x98,
> +	[PWRAP_INIT_DONE2] =		0x9C,
> +	[PWRAP_WACS2_CMD] =		0xA0,
> +	[PWRAP_WACS2_RDATA] =		0xA4,
> +	[PWRAP_WACS2_VLDCLR] =		0xA8,
> +	[PWRAP_INT_EN] =		0xC0,
> +	[PWRAP_INT_FLG_RAW] =		0xC4,
> +	[PWRAP_INT_FLG] =		0xC8,
> +	[PWRAP_INT_CLR] =		0xCC,
> +	[PWRAP_INT1_EN] =		0xD0,
> +	[PWRAP_INT1_FLG_RAW] =		0xD4,
> +	[PWRAP_INT1_FLG] =		0xD8,
> +	[PWRAP_INT1_CLR] =		0xDC,
> +	[PWRAP_TIMER_EN] =		0xF4,
> +	[PWRAP_WDT_UNIT] =		0xFC,
> +	[PWRAP_WDT_SRC_EN] =		0x100,
> +	[PWRAP_DCM_EN] =		0x1CC,
> +	[PWRAP_DCM_DBC_PRD] =		0x1D4,
> +	[PWRAP_PRIORITY_USER_SEL_0] =	0x288,
> +	[PWRAP_PRIORITY_USER_SEL_1] =	0x28C,
> +	[PWRAP_ARBITER_OUT_SEL_0] =	0x290,
> +	[PWRAP_ARBITER_OUT_SEL_1] =	0x294,
> +	[PWRAP_STARV_COUNTER_0] =	0x298,
> +	[PWRAP_STARV_COUNTER_1] =	0x29C,
> +	[PWRAP_STARV_COUNTER_2] =	0x2A0,
> +	[PWRAP_STARV_COUNTER_3] =	0x2A4,
> +	[PWRAP_STARV_COUNTER_4] =	0x2A8,
> +	[PWRAP_STARV_COUNTER_5] =	0x2AC,
> +	[PWRAP_STARV_COUNTER_6] =	0x2B0,
> +	[PWRAP_STARV_COUNTER_7] =	0x2B4,
> +	[PWRAP_STARV_COUNTER_8] =	0x2B8,
> +	[PWRAP_STARV_COUNTER_9] =	0x2BC,
> +	[PWRAP_STARV_COUNTER_10] =	0x2C0,
> +	[PWRAP_STARV_COUNTER_11] =	0x2C4,
> +	[PWRAP_STARV_COUNTER_12] =	0x2C8,
> +	[PWRAP_STARV_COUNTER_13] =	0x2CC,
> +};
> +
>  static int mt7622_regs[] = {
>  	[PWRAP_MUX_SEL] =		0x0,
>  	[PWRAP_WRAP_EN] =		0x4,
> @@ -641,6 +727,7 @@ enum pmic_type {
>  
>  enum pwrap_type {
>  	PWRAP_MT2701,
> +	PWRAP_MT6797,
>  	PWRAP_MT7622,
>  	PWRAP_MT8135,
>  	PWRAP_MT8173,
> @@ -681,9 +768,12 @@ struct pmic_wrapper_type {
>  	enum pwrap_type type;
>  	u32 arb_en_all;
>  	u32 int_en_all;
> +	u32 int1_en_all;
>  	u32 spi_w;
>  	u32 wdt_src;
>  	unsigned int has_bridge:1;

That's not needed anymore, we do this with PWRAP_CAP_BRIDGE now, please delete.
Same of course in the instances of pmic_wrapper_type below.

> +	/* Flags indicating the capability for the target pwrap */
> +	u32 caps;

We could use u8 here for now. Only 4 CAPs up to now.

>  	int (*init_reg_clock)(struct pmic_wrapper *wrp);
>  	int (*init_soc_specific)(struct pmic_wrapper *wrp);
>  };
> @@ -998,6 +1088,12 @@ static void pwrap_init_chip_select_ext(struct pmic_wrapper *wrp, u8 hext_write,
>  static int pwrap_common_init_reg_clock(struct pmic_wrapper *wrp)
>  {
>  	switch (wrp->master->type) {
> +	case PWRAP_MT6797:
> +		pwrap_writel(wrp, 0x8, PWRAP_RDDMY);
> +		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_RDDMY_NO],
> +			    0x8);
> +		pwrap_init_chip_select_ext(wrp, 0x88, 0x55, 3, 0);
> +		break;
>  	case PWRAP_MT8173:
>  		pwrap_init_chip_select_ext(wrp, 0, 4, 2, 2);
>  		break;
> @@ -1068,11 +1164,14 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  		break;
>  	case PWRAP_MT2701:
>  	case PWRAP_MT8173:
> +	case PWRAP_MT6797:
>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
>  		break;
>  	case PWRAP_MT7622:
>  		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
>  		break;
> +	default:
> +		break;
>  	}
>  
>  	/* Config cipher mode @PMIC */
> @@ -1226,6 +1325,27 @@ static int pwrap_mt7622_init_soc_specific(struct pmic_wrapper *wrp)
>  	return 0;
>  }
>  
> +static int pwrap_set_starvation(struct pmic_wrapper *wrp)
> +{
> +	pwrap_writel(wrp, 0x0007, PWRAP_HARB_HPRIO);

Reading the public available datasheet, it is not clear to me what you are
trying to achieve here. From my understanding MDINF has a higher priority then
C2kINF, and the latter a higher priority then MD_DVFSINF. So bumping these to 1
doesn't change anything in the end.

Why do we need this?
If we really need that, then please, no magic values here. Better explain at
least in a comment which components get a higher priority.

> +	pwrap_writel(wrp, 0x0402, PWRAP_STARV_COUNTER_0);
> +	pwrap_writel(wrp, 0x0402, PWRAP_STARV_COUNTER_1);
> +	pwrap_writel(wrp, 0x0403, PWRAP_STARV_COUNTER_2);
> +	pwrap_writel(wrp, 0x0414, PWRAP_STARV_COUNTER_3);
> +	pwrap_writel(wrp, 0x0420, PWRAP_STARV_COUNTER_4);
> +	pwrap_writel(wrp, 0x0420, PWRAP_STARV_COUNTER_5);
> +	pwrap_writel(wrp, 0x0420, PWRAP_STARV_COUNTER_6);
> +	pwrap_writel(wrp, 0x0428, PWRAP_STARV_COUNTER_7);
> +	pwrap_writel(wrp, 0x0428, PWRAP_STARV_COUNTER_8);
> +	pwrap_writel(wrp, 0x0417, PWRAP_STARV_COUNTER_9);
> +	pwrap_writel(wrp, 0x0563, PWRAP_STARV_COUNTER_10);
> +	pwrap_writel(wrp, 0x047c, PWRAP_STARV_COUNTER_11);
> +	pwrap_writel(wrp, 0x0740, PWRAP_STARV_COUNTER_12);
> +	pwrap_writel(wrp, 0x0740, PWRAP_STARV_COUNTER_13);

Can you somehow make clear that 0x0400 actually enables starvation mechanism.
As above try to minimize magic values.

> +
> +	return 0;
> +}
> +
>  static int pwrap_init(struct pmic_wrapper *wrp)
>  {
>  	int ret;
> @@ -1298,7 +1418,7 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>  	pwrap_writel(wrp, 1, PWRAP_INIT_DONE0);
>  	pwrap_writel(wrp, 1, PWRAP_INIT_DONE1);
>  
> -	if (wrp->master->has_bridge) {
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
>  		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE3);
>  		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE4);
>  	}
> @@ -1317,6 +1437,15 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  
>  	pwrap_writel(wrp, 0xffffffff, PWRAP_INT_CLR);
>  
> +	/* If we support INT1 interrupt, we also need to clear it */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN)) {
> +		rdata = pwrap_readl(wrp, PWRAP_INT1_FLG);
> +
> +		dev_err(wrp->dev, "unexpected interrupt int1=0x%x\n", rdata);
> +
> +		pwrap_writel(wrp, rdata, PWRAP_INT1_CLR);
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -1391,9 +1520,11 @@ static const struct pmic_wrapper_type pwrap_mt2701 = {
>  	.type = PWRAP_MT2701,
>  	.arb_en_all = 0x3f,
>  	.int_en_all = ~(u32)(BIT(31) | BIT(2)),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE_NEW,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 0,

As said above, has_bridge should be deleted.

> +	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_mt2701_init_reg_clock,
>  	.init_soc_specific = pwrap_mt2701_init_soc_specific,
>  };
> @@ -1403,9 +1534,11 @@ static const struct pmic_wrapper_type pwrap_mt7622 = {
>  	.type = PWRAP_MT7622,
>  	.arb_en_all = 0xff,
>  	.int_en_all = ~(u32)BIT(31),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 0,
> +	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt7622_init_soc_specific,
>  };
> @@ -1415,9 +1548,11 @@ static const struct pmic_wrapper_type pwrap_mt8135 = {
>  	.type = PWRAP_MT8135,
>  	.arb_en_all = 0x1ff,
>  	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 1,
> +	.caps = PWRAP_CAP_BRIDGE | PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt8135_init_soc_specific,
>  };
> @@ -1427,13 +1562,29 @@ static const struct pmic_wrapper_type pwrap_mt8173 = {
>  	.type = PWRAP_MT8173,
>  	.arb_en_all = 0x3f,
>  	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_NO_STAUPD,
>  	.has_bridge = 0,
> +	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt8173_init_soc_specific,
>  };
>  
> +static const struct pmic_wrapper_type pwrap_mt6797 = {
> +	.regs = mt6797_regs,
> +	.type = PWRAP_MT6797,
> +	.arb_en_all = 0x01fff,
> +	.int_en_all = 0xfffffffd,
> +	.int1_en_all = 0x0001ffff,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.has_bridge = 0,
> +	.caps = PWRAP_CAP_DCM | PWRAP_CAP_PRIORITY_SEL | PWRAP_CAP_INT1_EN,
> +	.init_reg_clock = pwrap_common_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>  static const struct of_device_id of_pwrap_match_tbl[] = {
>  	{
>  		.compatible = "mediatek,mt2701-pwrap",
> @@ -1448,6 +1599,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>  		.compatible = "mediatek,mt8173-pwrap",
>  		.data = &pwrap_mt8173,
>  	}, {
> +		.compatible = "mediatek,mt6797-pwrap",
> +		.data = &pwrap_mt6797,
> +	}, {
>  		/* sentinel */
>  	}
>  };
> @@ -1491,14 +1645,16 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (IS_ERR(wrp->base))
>  		return PTR_ERR(wrp->base);
>  
> -	wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
> -	if (IS_ERR(wrp->rstc)) {
> -		ret = PTR_ERR(wrp->rstc);
> -		dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> -		return ret;
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_RESET)) {
> +		wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
> +		if (IS_ERR(wrp->rstc)) {
> +			ret = PTR_ERR(wrp->rstc);
> +			dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
> -	if (wrp->master->has_bridge) {
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  				"pwrap-bridge");
>  		wrp->bridge_base = devm_ioremap_resource(wrp->dev, res);
> @@ -1529,6 +1685,16 @@ static int pwrap_probe(struct platform_device *pdev)
>  		return PTR_ERR(wrp->clk_wrap);
>  	}
>  
> +	/* Add priority adjust setting, it used to avoid starvation */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_PRIORITY_SEL)) {
> +		pwrap_writel(wrp, 0x6543C210, PWRAP_PRIORITY_USER_SEL_0);
> +		pwrap_writel(wrp, 0xFEDBA987, PWRAP_PRIORITY_USER_SEL_1);
> +		pwrap_writel(wrp, 0x87654210, PWRAP_ARBITER_OUT_SEL_0);
> +		pwrap_writel(wrp, 0xFED3CBA9, PWRAP_ARBITER_OUT_SEL_1);
> +
> +		pwrap_set_starvation(wrp);
> +	}
> +
>  	ret = clk_prepare_enable(wrp->clk_spi);
>  	if (ret)
>  		return ret;
> @@ -1537,9 +1703,16 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_out1;
>  
> -	/* Enable internal dynamic clock */
> -	pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> -	pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> +	/*
> +	 * add dcm capability check
> +	 */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {
> +		if (wrp->master->type == PWRAP_MT6797)
> +			pwrap_writel(wrp, 3, PWRAP_DCM_EN);
> +		else
> +			pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> +		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);

bike shedding alarm:
I'd add a newline after the else branch.

Thanks!
Matthias

> +	}
>  
>  	/*
>  	 * The PMIC could already be initialized by the bootloader.
> @@ -1568,6 +1741,12 @@ static int pwrap_probe(struct platform_device *pdev)
>  	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
>  	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>  	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
> +	/*
> +	 * We add INT1 interrupt to handle starvation and request exception
> +	 * If we support it, we should enable them here.
> +	 */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
> +		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>  
>  	irq = platform_get_irq(pdev, 0);
>  	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
> -- 
> 2.12.5
> 
> ************* Email Confidentiality Notice ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe 
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 
