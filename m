Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeE1IeS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:34:18 -0400
Received: from mail-ve1eur01on0063.outbound.protection.outlook.com ([104.47.1.63]:28992
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753995AbeE1IeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:34:14 -0400
From: Anson Huang <anson.huang@nxp.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] irqchip: gpcv2: remove unnecessary functions
Thread-Topic: [PATCH V2] irqchip: gpcv2: remove unnecessary functions
Thread-Index: AQHT9kt2NFV/VK5arEmzqQC9hWil76REzSGQ
Date: Mon, 28 May 2018 08:34:09 +0000
Message-ID: <AM3PR04MB1315E908DF961784BDFB3922F56E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527487999-29768-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1527487999-29768-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1235;7:e9yn0zi15tqtHjxxjzME+hEvU07NyRl7cKqLJWGMeeitcKrXlO+kX71R9vzxWsZkoPrHrX0JWBgukmkNbw6OlNZyph2i4jQtnuBYzanXjm/wWnMbCN/9hKKe6lAVJrEq8gRYdFpIe8MLH6PNxjGKomG8GOSHgr85/uzdU0Zwjwe0fb9SoFMpr/JqOot3xSq3fvA2lA83+LvT0P7VHDv4l4GkfocagW0721n+L1oxvaF2qBF4jimrb2Fsz4ZVQzn4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1235;
x-ms-traffictypediagnostic: AM3PR04MB1235:
x-microsoft-antispam-prvs: <AM3PR04MB12357C1A35B8F088015495DDF56E0@AM3PR04MB1235.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1235;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1235;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(396003)(346002)(366004)(13464003)(199004)(189003)(26005)(7736002)(76176011)(3846002)(102836004)(6116002)(6506007)(2906002)(59450400001)(68736007)(186003)(53546011)(8676002)(6246003)(99286004)(81156014)(106356001)(5660300001)(86362001)(81166006)(105586002)(97736004)(7696005)(74316002)(305945005)(25786009)(2201001)(55016002)(478600001)(2501003)(2900100001)(9686003)(44832011)(6436002)(3280700002)(229853002)(8936002)(14454004)(66066001)(5250100002)(53936002)(4326008)(3660700001)(486006)(316002)(110136005)(54906003)(476003)(33656002)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1235;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
x-microsoft-antispam-message-info: O5cxs5lwHL0ssajdfvxGeopBNf8rEGrKPYn0TCQtebZcWpoNAI5EFbfK4rc7n7kIMsuuT7oEtbeKHgR8eTZg+eAAne9AAetiQ27mBG6feLVj2L7shm6Fo3wJR53DgthxPanaSOPajBZiVab7edkvB63ZvuPbeHZnhHAiiMYEPMaMU+HurmmgBVvSd+GexSWo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f800e6de-6b21-4e78-79cc-08d5c475c834
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f800e6de-6b21-4e78-79cc-08d5c475c834
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 08:34:09.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1235
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4S8YNd3003394

Please ignore this patch for now, I found something incorrect, since the gpc make/unmask and set wake uses same registers, there are some sync issue about it. So I think keep the old way is OK, although the save/restore looks a little confuse. Sorry for the noise.

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Monday, May 28, 2018 2:13 PM
> To: tglx@linutronix.de; jason@lakedaemon.net; marc.zyngier@arm.com
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-kernel@vger.kernel.org
> Subject: [PATCH V2] irqchip: gpcv2: remove unnecessary functions
> 
> GPC is in always-on domain, it never lost its content during suspend/resume, so
> no need to do save/restore for it during suspend/resume.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	Add missing wakeup source write into GPC IMR register;
> 	remove all necessary arrays;
> 	suspend/resume tested passed with u-boot I develop for suspend/resume
> support.
>  drivers/irqchip/irq-imx-gpcv2.c | 50 +++--------------------------------------
>  1 file changed, 3 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
> index 4760307..6bb6ba0 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -21,53 +21,11 @@
>  struct gpcv2_irqchip_data {
>  	struct raw_spinlock	rlock;
>  	void __iomem		*gpc_base;
> -	u32			wakeup_sources[IMR_NUM];
> -	u32			saved_irq_mask[IMR_NUM];
>  	u32			cpu2wakeup;
>  };
> 
>  static struct gpcv2_irqchip_data *imx_gpcv2_instance;
> 
> -static int gpcv2_wakeup_source_save(void) -{
> -	struct gpcv2_irqchip_data *cd;
> -	void __iomem *reg;
> -	int i;
> -
> -	cd = imx_gpcv2_instance;
> -	if (!cd)
> -		return 0;
> -
> -	for (i = 0; i < IMR_NUM; i++) {
> -		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> -		cd->saved_irq_mask[i] = readl_relaxed(reg);
> -		writel_relaxed(cd->wakeup_sources[i], reg);
> -	}
> -
> -	return 0;
> -}
> -
> -static void gpcv2_wakeup_source_restore(void) -{
> -	struct gpcv2_irqchip_data *cd;
> -	void __iomem *reg;
> -	int i;
> -
> -	cd = imx_gpcv2_instance;
> -	if (!cd)
> -		return;
> -
> -	for (i = 0; i < IMR_NUM; i++) {
> -		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> -		writel_relaxed(cd->saved_irq_mask[i], reg);
> -	}
> -}
> -
> -static struct syscore_ops imx_gpcv2_syscore_ops = {
> -	.suspend	= gpcv2_wakeup_source_save,
> -	.resume		= gpcv2_wakeup_source_restore,
> -};
> -
>  static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)  {
>  	struct gpcv2_irqchip_data *cd = d->chip_data; @@ -79,9 +37,9 @@
> static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
>  	raw_spin_lock_irqsave(&cd->rlock, flags);
>  	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
>  	mask = 1 << d->hwirq % 32;
> -	val = cd->wakeup_sources[idx];
> -
> -	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
> +	val = readl_relaxed(reg);
> +	val = on ? (val & ~mask) : (val | mask);
> +	writel_relaxed(val, reg);
>  	raw_spin_unlock_irqrestore(&cd->rlock, flags);
> 
>  	/*
> @@ -238,7 +196,6 @@ static int __init imx_gpcv2_irqchip_init(struct
> device_node *node,
>  	for (i = 0; i < IMR_NUM; i++) {
>  		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
>  		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
> -		cd->wakeup_sources[i] = ~0;
>  	}
> 
>  	/* Let CORE0 as the default CPU to wake up by GPC */ @@ -252,7 +209,6
> @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
>  	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
> 
>  	imx_gpcv2_instance = cd;
> -	register_syscore_ops(&imx_gpcv2_syscore_ops);
> 
>  	/*
>  	 * Clear the OF_POPULATED flag set in of_irq_init so that
> --
> 2.7.4
