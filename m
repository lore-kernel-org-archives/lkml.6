Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeFETsw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:48:52 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:12125 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751895AbeFETsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:48:50 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRWlGSWpSXmKPExsUSt3Opsa7CS7F
  og8mzVCymPnzCZjF39iRGi/tfjzJaXN41h81i68t3TBYPV85hsTi65x6zRd85dwcOj4lndT12
  zrrL7rFpVSebx51re9g8ni1cz+LxeZNcAFsUa2ZeUn5FAmtGY9875oKlFhWX+n+yNjA+Nuhi5
  OIQEljKKLH90UvGLkZODjYBQ4l5b96D2SIC6RLvLixgBCliFrjMJLFtcycrSEJYwFZi0eL5zB
  BFdhIPWv6xQdhGEv8+HWUCsVkEVCTeHXwCFucVCJBYf2wOUC8H0LYqic/fDUHCnALOEl9fbgf
  bxSggK/GlcTXYSGYBcYlbT+aDjZEQEJBYsuc8M4QtKvHy8T9WCFtBYt+vlWwQtr3E63vvWCBs
  fYlHjx8xQtiGEqumHYCKm0tM7XnICDFfR2LB7k9sELa2xLKFr5khzhSUODnzCcsERvFZSM6Yh
  aRlFpKWWUhaFjCyrGI0TyrKTM8oyU3MzNE1NDDQNTQ00jW0NNE1M9dLrNJN1Est1S1PLS7RNd
  RLLC/WK67MTc5J0ctLLdnECIx3BiDYwXjsW/IhRkkOJiVRXp1FYtFCfEn5KZUZicUZ8UWlOan
  FhxhlODiUJHg5XwDlBItS01Mr0jJzgIkHJi3BwaMkwnv+OVCat7ggMbc4Mx0idYpRUUqcNxSk
  TwAkkVGaB9cGS3aXGGWlhHkZgQ4R4ilILcrNLEGVf8UozsGoJMybBTKeJzOvBG76K6DFTECLn
  1UIgywuSURISTUwGtpvT/v36s7FlJ9Ot3/xFHw7YbVE9niyXpf/oTXZRnIBzfM/3Oh28+stq2
  HbmH+3ImjZzdUv/7/1XtU499LXld3PH7jfT7GpmnqI+b1BBQuDc839n0pnfDeYJ+gEp211M1v
  s9CnsR7/fRXZthZUdnnUferY4xxW052gprwpu/Fw4RXhy/DoHJZbijERDLeai4kQAqDbCzXED
  AAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-5.tower-268.messagelabs.com!1528228128!1244339!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Marek Vasut <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v3 02/10] mfd: da9063: Use REGMAP_IRQ_REG
Thread-Topic: [PATCH v3 02/10] mfd: da9063: Use REGMAP_IRQ_REG
Thread-Index: AQHT+lov59vIktDgN0a/0w/aY7SLqaRR6nJw
Date: Tue, 5 Jun 2018 19:48:47 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AD6BF@SW-EX-MBX02.diasemi.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-2-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180602101155.26375-2-marek.vasut+renesas@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.121]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 05/06/2018 15:14:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 June 2018 11:12, Marek Vasut wrote,

> Subject: [PATCH v3 02/10] mfd: da9063: Use REGMAP_IRQ_REG
> 
> Convert the regmap_irq table to use REGMAP_IRQ_REG().
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V3: New patch
> Note: A sed oneliner was used:
>       sed -i "/\[DA9063_IRQ_/
> {N;N;N;s/\n//g;s/.*\[\(DA9063_IRQ_[^]]\+\)].*reg_offset = \([^,]\+\),.* =
> \([^,]\+\),.*/\tREGMAP_IRQ_REG(\1, \2, \3),/}" drivers/mfd/da9063-irq.c
> ---
>  drivers/mfd/da9063-irq.c | 145 ++++++++++-------------------------------------
>  1 file changed, 29 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
> index 207bbfe55449..5b406ecfc14a 100644
> --- a/drivers/mfd/da9063-irq.c
> +++ b/drivers/mfd/da9063-irq.c
> @@ -28,125 +28,38 @@
> 
>  static const struct regmap_irq da9063_irqs[] = {
>  	/* DA9063 event A register */
> -	[DA9063_IRQ_ONKEY] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_ONKEY,
> -	},
> -	[DA9063_IRQ_ALARM] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_ALARM,
> -	},
> -	[DA9063_IRQ_TICK] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_TICK,
> -	},
> -	[DA9063_IRQ_ADC_RDY] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_ADC_RDY,
> -	},
> -	[DA9063_IRQ_SEQ_RDY] = {
> -		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> -		.mask = DA9063_M_SEQ_RDY,
> -	},
> +	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY,
> DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_ALARM,
> DA9063_REG_EVENT_A_OFFSET, DA9063_M_ALARM),
> +	REGMAP_IRQ_REG(DA9063_IRQ_TICK, DA9063_REG_EVENT_A_OFFSET,
> DA9063_M_TICK),
> +	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY,
> DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY,
> DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
>  	/* DA9063 event B register */
> -	[DA9063_IRQ_WAKE] = {
> -		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
> -		.mask = DA9063_M_WAKE,
> -	},
> -	[DA9063_IRQ_TEMP] = {
> -		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
> -		.mask = DA9063_M_TEMP,
> -	},
> -	[DA9063_IRQ_COMP_1V2] = {
> -		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
> -		.mask = DA9063_M_COMP_1V2,
> -	},
> -	[DA9063_IRQ_LDO_LIM] = {
> -		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
> -		.mask = DA9063_M_LDO_LIM,
> -	},
> -	[DA9063_IRQ_REG_UVOV] = {
> -		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
> -		.mask = DA9063_M_UVOV,
> -	},
> -	[DA9063_IRQ_DVC_RDY] = {
> -		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
> -		.mask = DA9063_M_DVC_RDY,
> -	},
> -	[DA9063_IRQ_VDD_MON] = {
> -		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
> -		.mask = DA9063_M_VDD_MON,
> -	},
> -	[DA9063_IRQ_WARN] = {
> -		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
> -		.mask = DA9063_M_VDD_WARN,
> -	},
> +	REGMAP_IRQ_REG(DA9063_IRQ_WAKE,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_WAKE),
> +	REGMAP_IRQ_REG(DA9063_IRQ_TEMP,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_TEMP),
> +	REGMAP_IRQ_REG(DA9063_IRQ_COMP_1V2,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_COMP_1V2),
> +	REGMAP_IRQ_REG(DA9063_IRQ_LDO_LIM,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_LDO_LIM),
> +	REGMAP_IRQ_REG(DA9063_IRQ_REG_UVOV,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_UVOV),
> +	REGMAP_IRQ_REG(DA9063_IRQ_DVC_RDY,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_DVC_RDY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_VDD_MON,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_MON),
> +	REGMAP_IRQ_REG(DA9063_IRQ_WARN,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_WARN),
>  	/* DA9063 event C register */
> -	[DA9063_IRQ_GPI0] = {
> -		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
> -		.mask = DA9063_M_GPI0,
> -	},
> -	[DA9063_IRQ_GPI1] = {
> -		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
> -		.mask = DA9063_M_GPI1,
> -	},
> -	[DA9063_IRQ_GPI2] = {
> -		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
> -		.mask = DA9063_M_GPI2,
> -	},
> -	[DA9063_IRQ_GPI3] = {
> -		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
> -		.mask = DA9063_M_GPI3,
> -	},
> -	[DA9063_IRQ_GPI4] = {
> -		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
> -		.mask = DA9063_M_GPI4,
> -	},
> -	[DA9063_IRQ_GPI5] = {
> -		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
> -		.mask = DA9063_M_GPI5,
> -	},
> -	[DA9063_IRQ_GPI6] = {
> -		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
> -		.mask = DA9063_M_GPI6,
> -	},
> -	[DA9063_IRQ_GPI7] = {
> -		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
> -		.mask = DA9063_M_GPI7,
> -	},
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI0, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI0),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI1, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI1),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI2, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI2),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI3, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI3),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI4, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI4),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI5, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI5),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI6, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI6),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI7, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI7),
>  	/* DA9063 event D register */
> -	[DA9063_IRQ_GPI8] = {
> -		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
> -		.mask = DA9063_M_GPI8,
> -	},
> -	[DA9063_IRQ_GPI9] = {
> -		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
> -		.mask = DA9063_M_GPI9,
> -	},
> -	[DA9063_IRQ_GPI10] = {
> -		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
> -		.mask = DA9063_M_GPI10,
> -	},
> -	[DA9063_IRQ_GPI11] = {
> -		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
> -		.mask = DA9063_M_GPI11,
> -	},
> -	[DA9063_IRQ_GPI12] = {
> -		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
> -		.mask = DA9063_M_GPI12,
> -	},
> -	[DA9063_IRQ_GPI13] = {
> -		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
> -		.mask = DA9063_M_GPI13,
> -	},
> -	[DA9063_IRQ_GPI14] = {
> -		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
> -		.mask = DA9063_M_GPI14,
> -	},
> -	[DA9063_IRQ_GPI15] = {
> -		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
> -		.mask = DA9063_M_GPI15,
> -	},
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI8, DA9063_REG_EVENT_D_OFFSET,
> DA9063_M_GPI8),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI9, DA9063_REG_EVENT_D_OFFSET,
> DA9063_M_GPI9),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI10,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI10),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI11,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI11),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI12,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI12),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI13,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI13),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI14,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI14),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI15,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI15),
>  };
> 
>  static const struct regmap_irq_chip da9063_irq_chip = {
> --
> 2.16.2

Hi Marek,

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
