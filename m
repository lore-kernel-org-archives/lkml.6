Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeC2JkC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:40:02 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:55582 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750971AbeC2Jj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:39:59 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517842800";
   d="scan'208";a="275221390"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Topic: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Index: AQHTxqA8Q/Tp1OQLo0C0CX9dPZ3BD6Pm9V/w
Date: Thu, 29 Mar 2018 09:39:38 +0000
Message-ID: <TY1PR01MB1769121CFDE3E1A4849944FFF5A20@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0048;7:T1wkWFMH96GQWqhuq/V+7ZW8gl80OQRasfkS0TcnFaZq/itvZql3sOfzOvPPId0AuzsyBk3lzPpl49HS6fV2IUuHcBqk1coH6xPEpyVpiYjKdjqxGcNHyLlLFViVxlWRr2w9QfRsR9yleNbyx2Uncc8yIv0czidIgY5WHgpZ74vZXotOoUh0u06RW0n9B7jSOBdVeTH8tFKsaj3hvBpSQJsW1F6vc1TcUa8fee7pDBKpZ8bsXFS0VVtjdG388JWM;20:V/HnDat3aZXHCMNIMFrcfrtk4GdKT9y59vH0QIkJdrf9dPvMmCCPGgXOn/Kbv3U0PxT8NoWbcimNRgI8LfdZHrcdPyrsG85j1rT+NyeV3i7+452gnY3ba8knFmQ/L+ahLGXlZPKwiU5BbJV3G9McSiZJJoDO6/qyjoRCt6m1ZKI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad8f5dc3-a1d1-4b3c-1733-08d59558fd8e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0048;
x-ms-traffictypediagnostic: TY1PR01MB0048:
x-microsoft-antispam-prvs: <TY1PR01MB00483CA3F8372EC9EEF95133F5A20@TY1PR01MB0048.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR01MB0048;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0048;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(396003)(346002)(376002)(199004)(189003)(6436002)(81166006)(486005)(486005)(316002)(476003)(105586002)(6116002)(3846002)(446003)(229853002)(11346002)(2900100001)(54906003)(99286004)(4326008)(26005)(186003)(97736004)(8936002)(53936002)(66066001)(5660300001)(478600001)(39060400002)(110136005)(6246003)(7736002)(3660700001)(305945005)(106356001)(86362001)(74316002)(2906002)(53546011)(8676002)(3280700002)(5250100002)(6506007)(7696005)(76176011)(59450400001)(25786009)(81156014)(14454004)(102836004)(68736007)(55016002)(9686003)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0048;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: iF0kn3aZrBeTxhacoDEt6csLy0RVqHmtzxOMdbCx82Rr5KxcebbGqQFU9BNC51GIR0cZTbaDj1r70XitWaNfZbMdJhpCwIFA0IcZ/gFXl/NZEVLVMTNBgMCpGEd0gH/FSAtfLznKbUkA+5HsFfyI9/LiNVHWOUrHYQcu63c0jTlL+hO3SpaqbzSiCcfrso2hw0bseqKaluxBBjxrD6V8x46pPWioGielf85nIfk5hR92Wht5cCfcEeXNiYjphs0Fcqnr4inrTHzCo/tjmC0vDjruGNROA5iZ0zCCHq9ReaA1pFeonMrmKF9x1FydJWNg9/zVPT2U708Td6I3Hiwayg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8f5dc3-a1d1-4b3c-1733-08d59558fd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 09:39:38.3901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0048
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2T9e7T5030397

Hi,

On 28 March 2018 15:23, Phil Edworthy wrote:
> The DesignWare GPIO IP can be configured for either 1 or 32 interrupts,
> but the driver currently only supports 1 interrupt. See the DesignWare
> DW_apb_gpio Databook description of the 'GPIO_INTR_IO' parameter.
> 
> This change allows the driver to work with up to 32 interrupts, it will
> get as many interrupts as specified in the DT 'interrupts' property.
> It doesn't do anything clever with the different interrupts, it just calls
> the same handler used for single interrupt hardware.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> Note: There are a few lines over 80 chars, but this is just guidance, right?
>       Especially as there are already some lines over 80 chars.
> ---
>  .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   | 10 ++++-
>  drivers/gpio/gpio-dwapb.c                          | 44 +++++++++++++++++-----
>  include/linux/platform_data/gpio-dwapb.h           |  3 +-
>  3 files changed, 45 insertions(+), 12 deletions(-)

This patch triggers a build error for Quark MFD driver, which is the only user
of the structure outside of the driver. I will fix that with an additional patch,
but I'll wait to see what other comments I get first.

Thanks
Phil


> diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> index 4a75da7..e343581 100644
> --- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> @@ -26,8 +26,14 @@ controller.
>    the second encodes the triger flags encoded as described in
>    Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  - interrupt-parent : The parent interrupt controller.
> -- interrupts : The interrupt to the parent controller raised when GPIOs
> -  generate the interrupts.
> +- interrupts : The interrupts to the parent controller raised when GPIOs
> +  generate the interrupts. If the controller provides one combined interrupt
> +  for all GPIOs, specify a single interrupt. If the controller provides one
> +  interrupt for each GPIO, provide a list of interrupts that correspond to each
> +  of the GPIO pins. When specifying multiple interrupts, if any of the GPIOs
> are
> +  not connected to an interrupt, use the interrupt-mask property.
> +- interrupt-mask : a 32-bit bit mask that specifies which interrupts in the list
> +  of interrupts is valid, bit is 1 for a valid irq.
>  - snps,nr-gpios : The number of pins in the port, a single cell.
>  - resets : Reset line for the controller.
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 226977f..47d82f9 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -441,14 +441,19 @@ static void dwapb_configure_irqs(struct
> dwapb_gpio *gpio,
>  	irq_gc->chip_types[1].handler = handle_edge_irq;
> 
>  	if (!pp->irq_shared) {
> -		irq_set_chained_handler_and_data(pp->irq,
> dwapb_irq_handler,
> -						 gpio);
> +		int i;
> +
> +		for (i = 0; i < pp->ngpio; i++) {
> +			if (pp->irq[i])
> +				irq_set_chained_handler_and_data(pp-
> >irq[i],
> +						dwapb_irq_handler, gpio);
> +		}
>  	} else {
>  		/*
>  		 * Request a shared IRQ since where MFD would have
> devices
>  		 * using the same irq pin
>  		 */
> -		err = devm_request_irq(gpio->dev, pp->irq,
> +		err = devm_request_irq(gpio->dev, pp->irq[0],
>  				       dwapb_irq_handler_mfd,
>  				       IRQF_SHARED, "gpio-dwapb-mfd", gpio);
>  		if (err) {
> @@ -524,7 +529,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio
> *gpio,
>  	if (pp->idx == 0)
>  		port->gc.set_config = dwapb_gpio_set_config;
> 
> -	if (pp->irq)
> +	if (pp->has_irq)
>  		dwapb_configure_irqs(gpio, port, pp);
> 
>  	err = gpiochip_add_data(&port->gc, port);
> @@ -535,7 +540,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio
> *gpio,
>  		port->is_registered = true;
> 
>  	/* Add GPIO-signaled ACPI event support */
> -	if (pp->irq)
> +	if (pp->has_irq)
>  		acpi_gpiochip_request_interrupts(&port->gc);
> 
>  	return err;
> @@ -601,13 +606,34 @@ dwapb_gpio_get_pdata(struct device *dev)
>  		if (dev->of_node && pp->idx == 0 &&
>  			fwnode_property_read_bool(fwnode,
>  						  "interrupt-controller")) {
> -			pp->irq =
> irq_of_parse_and_map(to_of_node(fwnode), 0);
> -			if (!pp->irq)
> +			struct device_node *np = to_of_node(fwnode);
> +			u32 irq_mask = 0xFFFFFFFF;
> +			int j;
> +
> +			/* Optional irq mask */
> +			fwnode_property_read_u32(fwnode, "interrupt-
> mask", &irq_mask);
> +
> +			/*
> +			 * The IP has configuration options to allow a single
> +			 * combined interrupt or one per gpio. If one per
> gpio,
> +			 * some might not be used.
> +			 */
> +			for (j = 0; j < pp->ngpio; j++) {
> +				if (irq_mask & BIT(j)) {
> +					pp->irq[j] =
> irq_of_parse_and_map(np, j);
> +					if (pp->irq[j])
> +						pp->has_irq = true;
> +				}
> +			}
> +			if (!pp->has_irq)
>  				dev_warn(dev, "no irq for port%d\n", pp-
> >idx);
>  		}
> 
> -		if (has_acpi_companion(dev) && pp->idx == 0)
> -			pp->irq =
> platform_get_irq(to_platform_device(dev), 0);
> +		if (has_acpi_companion(dev) && pp->idx == 0) {
> +			pp->irq[0] =
> platform_get_irq(to_platform_device(dev), 0);
> +			if (pp->irq[0])
> +				pp->has_irq = true;
> +		}
> 
>  		pp->irq_shared	= false;
>  		pp->gpio_base	= -1;
> diff --git a/include/linux/platform_data/gpio-dwapb.h
> b/include/linux/platform_data/gpio-dwapb.h
> index 2dc7f4a..5a52d69 100644
> --- a/include/linux/platform_data/gpio-dwapb.h
> +++ b/include/linux/platform_data/gpio-dwapb.h
> @@ -19,7 +19,8 @@ struct dwapb_port_property {
>  	unsigned int	idx;
>  	unsigned int	ngpio;
>  	unsigned int	gpio_base;
> -	unsigned int	irq;
> +	unsigned int	irq[32];
> +	bool		has_irq;
>  	bool		irq_shared;
>  };
> 
> --
> 2.7.4
