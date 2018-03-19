Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeCSMp4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:45:56 -0400
Received: from mail-eopbgr10101.outbound.protection.outlook.com ([40.107.1.101]:55008
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932892AbeCSMps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:45:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH linux dev-4.16] drivers: i2c: master arbiter: create
 driver
To: Ken Chen <chen.kenyy@inventec.com>, linux@roeck-us.net,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: joel@jms.id.au
References: <20180319113808.23485-1-chen.kenyy@inventec.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b6263be4-83e4-e207-2ad1-6a5fd9aab5f5@axentia.se>
Date: Mon, 19 Mar 2018 13:45:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319113808.23485-1-chen.kenyy@inventec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM4PR05CA0032.eurprd05.prod.outlook.com (2603:10a6:205::45)
 To HE1PR0202MB2778.eurprd02.prod.outlook.com (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d273bc3e-80a1-4195-de04-08d58d9753e1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:sGvAO7xHsIKWkPFebtVHWTxRU8sSjQ6NIfS2Aveo/89v+eVrEANVW9cmFG+Pja7BNdUq5ZaaDUQNmGaFMsjMQLyIQNG6qdcesftsRmZwbeBKXik1O2LUbzOr2h2TtdCTxeYepVusa+bf6m6bS8YkXqb95mZfcCfr6O2gi0oIwceHXi4Kg8j/cile2+sSrVUH/sQrPdiXvgREOzMl3yrDtzHqgZv/vdpG0nwqt/cEEychpd5uC9R7IWD1H52WnL+l;25:0JcBoh3LI2fxMSACy5SByvoyvn/n7VDuC2Z4OcW8qpTAnbxOw3cGr7w5H15zk7zVUc0ftqjWn1DBxOwuWajWWu7+SWVVS3qlypdGck6JGK1Qljw6WYfA15NswIETs5Waqbhddn6SwQsGYzuhxIDTG2VLEX0zBDgbhKDFCSPkAvzUwxaMyasqFcseG7bDc1eRTlzzLfL3+jIFS3EDk3FKZ3LjkiwL4uwNGu2qG8D4KS3fmh97GRb9OklLC2OZjrviBhChMqvXXlOAhFxKW+RG6JGhyICIIQqO9dGV7r1LPDr1e0htKqun3zeW4kSY6hjgWp6duy3HUYghi317KYh3wA==;31:GtptLeadb2les7S7EhEXmKyx3rtc231OluYKZbhplCAknjc5algKmD9P3DMDu3wx9i9ZGn6xtnn8B6WprEbGIznYMSKA21OLdWh2np6s1TZEm3sxbtNMC6meLspMHQmuyjyC9yTd99FXy/vxmANEOI/Bmct19gH0ghxvmRa6CA/ByEcR8+uWqS/aAqAl4cDtIvAahiLrf13g6H5N12WgNPZpVsgp5KmWVAfBJS1n4Fw=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277804895B3B4C8C712B4734BCD40@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006)(278428928389397)(139265435329489)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501244)(52105095)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:oa+mftZCw7sW9MRnwmOdeD/EQm7pcBnTuHXf+Jzc1U7EjECuGTW5zgciWV0FvpZlk4YQoqrxijVD2Jwgoz28R3FQsVcmlvNP2bgFSPUUEU6uikzkqGEKpz4sQgupbiWaLaukI3/vLMnvQxDdFD5GCg9EJiX2wmO6vVTsKPglj5Wuic6FXCgQ9orngUH83tA5XAmBKAtsbrIYG5xUsO60G0z57I4YhZ+yO9OGY3WOWAVNBe8bW1WMdR/E9yYoNUtrhtvf0hZzjjzfcpcPOVLIJU7qGItGH7xClXAoXT+ui8OMtm9uKmcXGp+jc+skyTYLrXBx11qa4hcsG0rtfIv59aTnBSbtdlPPeLBXysHOoPE0c1+t8A0RjTjrWwt15e/HdYBJjzZMEmPf+4lOPKyztRrsr88eCPyTU2he7teoj3w=
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(366004)(396003)(376002)(346002)(39380400002)(377424004)(51914003)(199004)(189003)(52314003)(76176011)(23676004)(52116002)(36916002)(25786009)(52146003)(2486003)(478600001)(966005)(59450400001)(53546011)(5660300001)(16576012)(386003)(16526019)(186003)(77096007)(26005)(97736004)(4326008)(74482002)(3260700006)(3846002)(58126008)(2906002)(305945005)(6116002)(7736002)(65826007)(64126003)(47776003)(66066001)(106356001)(31696002)(229853002)(105586002)(6246003)(6306002)(68736007)(230700001)(8676002)(65806001)(117156002)(8936002)(50466002)(6666003)(6486002)(81166006)(316002)(36756003)(86362001)(65956001)(31686004)(81156014)(2950100002)(53936002)(13158425004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6TnBDTEkwS2Z0ekc5TmRzcFRWbTN6K1RL?=
 =?utf-8?B?VlBhTUJ5UDQ0ZjZPQlNLdElEWVA3alJpWWkvY0FoWU5yWlBidGFxMVlPTDFH?=
 =?utf-8?B?Ry9xZzhKSDJyTFliRVpqYnRkdyt2UzRPc3RndEJKUXR6TnpYWnowU2RYQUNF?=
 =?utf-8?B?K3hKaElGU1dndmNSeExZbndqT2ZwOTBEYlRyVkhlclBsRG5yYjVZR1FoZXJL?=
 =?utf-8?B?bS9ubFJrdXQ2VnNzSHRVRzl1dlBaSkkxeCt4eWxOYjRDVnRZL2pSUGF4VmdG?=
 =?utf-8?B?aExoRXlUL3MydmFHUlRLU05rQlFFZjkxbnBuVVh2V21va3NPUlArblAwNUJB?=
 =?utf-8?B?dmNNVXZiK3hoajQzb1gva0d5RW16ZDlOdkxwOENtNjB4cURrekZXM043MW1m?=
 =?utf-8?B?WVZMUjR2ZzZZWVZNek5rREo2MTNLYUhEcTQyNzdLTDVEV3pCYUNGVWkyM3Bo?=
 =?utf-8?B?Z3FIeERaOFJqancxOVNJWEE1QWlaSHVBNG5SYUZnRmUramVUZk0zV3FDN010?=
 =?utf-8?B?eXZJTUpDVmZFMStsSnd4QmJPRlFqQ2NwZ0tMSDNHSkVESHFNcXprWk5FcHI4?=
 =?utf-8?B?V1JOQUJPcWFvcmhZcE9FREJUSFpKVlpSQkt1aEV2Q2M5cHZNNFBTcW1ZU2th?=
 =?utf-8?B?TS9QWVY2ZytucTd3V2lnaEJnYmlNTEhnNnFqZEsyS3RvT1VrK21SaG9iSXI4?=
 =?utf-8?B?YUd0SFMydUQzdzZmZlNRbjNpb05tY2ZNVXJFVlB5eExRZ29nZ3lFTFNVUXZC?=
 =?utf-8?B?WldQR2FkUER6cGlXZEJOcXk0K0x3WUdmRGZ5WGtWa2V6dkNtaEFOWkVJSlR2?=
 =?utf-8?B?SlFSRkRZdWUwWWRFVHNQTnNyL1hCSStSajhDM3BkNk1QdGV2bGt6dFdqc1Js?=
 =?utf-8?B?M1dIeVduQy9EbnV0Mm5TaUVKQWh2Mi9kamptWmNPZUNpc2ZYTEtNQy9INUo0?=
 =?utf-8?B?cFk5bkJ2QlpLV0hkeGdYNXFtOWQ4L1U3UytHaUV0ZnpraVF3Y0d1bm9GSmpH?=
 =?utf-8?B?cm1KRmxXL2RkVjVKWXBzNEtmUWlwRTlqOEc1YWliaEJ4bVNVSzRQcnFEb2tq?=
 =?utf-8?B?U1huU3NmWEJLQVNCTWlITEtNZFhqVXp5QlBSZXBaQ1pXVGZwcG1MdUFkOStj?=
 =?utf-8?B?YWV0Z2RDenN4RDJUdXpMeVUreW9zbHVmU3A1dkxIRUFvK1ppWkR1em5WeWky?=
 =?utf-8?B?TUdqUThKc1NYWHZlTElqK21GWTZPbG9mNCtvL3I5dnZkRlhhQmVta2hBTGZX?=
 =?utf-8?B?UDl6NzNGdlBWTGlvVGJwbWpnSHV5Z1UzTFRSSkxIVzFKNHJCQUtYeTVncEVN?=
 =?utf-8?B?eTBhdi9BTHBvd2MvYWMrNW50UHlTUGJGdnY0ZXlObzM3QkhEc005blY1dFdS?=
 =?utf-8?B?REE1TGlXV0N5UEtOb21UTFhQc2RhdnlQNjA0TTFjY1lqZzlnVUVhMUFQSng3?=
 =?utf-8?B?NnlFNTFLanh3VnI1VXV0RzI2V2RpU3pHNmtIYWFnN0UzSzhtWFFsZzFua3Nk?=
 =?utf-8?B?UnNpZGJlckRjNmhMMHBPalBkUUZRMW9mWC94Wi96SFpNRGVrUzBFeWtCT2R6?=
 =?utf-8?B?TXlwQmxrYzExUDBFdzg0L2dvRFcxV09XV3IwUnBscXdaWFRKSGNpbkVWVGE2?=
 =?utf-8?B?anFrOWxQbEFJazdteFpGZmhrWTFBd2Exd21zN3ZKOXJsTm8zTW53c3RYbnZK?=
 =?utf-8?B?NjZRRi9wOXh5YlZFbFVmWk51N3puS0NscVRtK0tKaVYvbXYwUWtHQVp2Yi9M?=
 =?utf-8?B?TVdhQllURm1RQXVZUW5YdjV2OWNPeW14bXF0NTlIMmdOSXVqODk4TjNnTmlW?=
 =?utf-8?B?cGMvNU5CWXRBYnBPM3l5UFdMVVNTRmFvaUo4WFhqQWNTZ1lDUWFWZUZ2VzJX?=
 =?utf-8?B?YmdUajB3ajlFM1Z1V2RCZE1oL0ZKVHpjL2lxV3AxTmppYkxxZmxMd3pFcjVH?=
 =?utf-8?B?SThzWGUxNUhqOTBpK1ZXbDdidFdnazRSTUorY1UvbFBBMVZCbVg0alloY1JF?=
 =?utf-8?B?U0UrdWJlNUxpdCtzUDhJdWk3L1FZT3dUcTYxUVMvc0R0UFlmUXRhVEV5YWgv?=
 =?utf-8?B?TVFIc0d6dVNoakptUkx4ZmZSWStmVGRTQ0U4bi85bGRjMjJIbDVhdGorUlJm?=
 =?utf-8?Q?38yN4LkY2vV+yNPNqZpQU5yc8=3D?=
X-Microsoft-Antispam-Message-Info: 1Ah7/r0njg+zyRxo9FzbqFKkUuRRdzj++AZlOuzJJTyW9W+vYoKnz1r9jg7LBU9LBnlVN0e++iHLt20dRsaxPHDyVQiFjxfDiPdnN0unviJNXFsgNImu8LF+XtoBI9PYEu4S3hTqQQrdekSgx0CdlGgBAHT4U/ucVvpIW9wPlqgxnGvi5zrwDEpu1lFAefpA
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:PqVHlsEftgz0QPDd/ngYfhcyLEGYOR3Wjf5HcC+y9GbdLwu6TstBnQT9bES2E3xa3I2lPxINdz0hqZd+1b4J7et2dzb9nWV4WV9a76nvYlx9fSGYOfVT3dA556SLtHA9PqbuYbgJ9CecqSJdfAAvjjXZNS2ajFfyAOg50UmrTSY6plbEdhhQiu/Nk2Q1XKnDDZSFF0yPnX12/3/KLROa5P7xs56NZz1ayqmxm1V5mP3NAq2NutH5KXysP9+sTXyfySGsD5+hPvTmxZw4u6EPeUiL5xHcCuKWQVQtEJrlwIWEDA4y/YLLU0kdtkEXrfBYPFyJdqGfltbm0WeTwpt9dPww+ia/I6Hegj/gxurIFqA=;5:klSlyFQcckz0d+KdufgvLBZS9AGqTA8h/6OsdOmTA7QBMl7npj3aNw0ewTPfsou3jKnq6NdOgTaI3/CTHkr/QN9joucqFmJL0jc7cI4Jjm/KqAMUKliJF3ddhu61+4Y+yyJGjiyKS5ZW7iQNozWj6NtLxoUz26sJEH/v4i4EcEQ=;24:7vDZrhLD15RNWxOAXc6mBCTVzsY4b0uU/uG9YFEtFoeaw35KewXi2YfPqUDVyTidie+ZO/glnQYKMcf7Qjbfe3U4fG9lcz3lBwB924mavI0=;7:iuRRmBvKynBTVzcjPRKS0l3sq9rlvF4nV+zVh3SjGfxiCSHVV8rGt6DyCdLUZ1QkddBKZ4OodDG3dgYDesYO7vn/8qBcRyF/+7Ma1/bcV0i6OzB6r5/KmDq8pZSbwOIIqytjE1PrnnlcPe4rwex0Q0/G8lJYt+N2n4qjIhdgBZbcBOM/6CwFrD6bsoT7g/JHw+a7IbG0E+hrqeU8uVkQAyInscE0Ps19+yX/Dtfowk8BZYMcwGDuGZ712Vh+TXB9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 12:45:42.4057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d273bc3e-80a1-4195-de04-08d58d9753e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ken,

Thanks for the patch!

I would have liked this subject:
i2c: muxes: pca9641: new driver

On 2018-03-19 12:38, Ken Chen wrote:
> Initial PCA9641 2 chennel I2C bus master arbiter

channel

> with separate implementation. It has probe issue
> and difference device hehavior between PCA9541

behavior

> and PCA9641 in original PCA9641 patch.
> 
> Signed-off-by: Ken Chen <chen.kenyy@inventec.com>
> ---
>  drivers/i2c/muxes/Kconfig           |   9 +
>  drivers/i2c/muxes/Makefile          |   1 +
>  drivers/i2c/muxes/i2c-mux-pca9641.c | 360 ++++++++++++++++++++++++++++++++++++

Given the big similarities between this and the pca9541 driver,
I would very much prefer if you could extend that driver instead
of making an almost-copy like this.

I have added some comments below anyway, but most of them are
irrelevant given that I want this merged with the pca9541 driver.

But maybe Guenter feels differently about that merge?

>  3 files changed, 370 insertions(+)
>  create mode 100644 drivers/i2c/muxes/i2c-mux-pca9641.c
> 
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 52a4a92..f9c51b8 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -73,6 +73,15 @@ config I2C_MUX_PCA954x
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mux-pca954x.
>  
> +config I2C_MUX_PCA9641
> +	tristate "NXP PCA9641 I2C Master demultiplexer"
> +	help
> +	  If you say yes here you get support for the NXP PCA9641
> +	  I2C Master demultiplexer with an arbiter function.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-mux-pca9641.
> +
>  config I2C_MUX_PINCTRL
>  	tristate "pinctrl-based I2C multiplexer"
>  	depends on PINCTRL
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> index 6d9d865..a229a1a 100644
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_I2C_MUX_LTC4306)	+= i2c-mux-ltc4306.o
>  obj-$(CONFIG_I2C_MUX_MLXCPLD)	+= i2c-mux-mlxcpld.o
>  obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
>  obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
> +obj-$(CONFIG_I2C_MUX_PCA9641)	+= i2c-mux-pca9641.o
>  obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
>  obj-$(CONFIG_I2C_MUX_REG)	+= i2c-mux-reg.o
>  
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9641.c b/drivers/i2c/muxes/i2c-mux-pca9641.c
> new file mode 100644
> index 0000000..bcf45c8
> --- /dev/null
> +++ b/drivers/i2c/muxes/i2c-mux-pca9641.c
> @@ -0,0 +1,360 @@
> +/*
> + * I2C demultiplexer driver for PCA9641 bus master demultiplexer
> + *
> + * Copyright (c) 2010 Ericsson AB.
> + *
> + * Author: Ken Chen <chen.kenyy@inventec.com>

A bit rich to claim to be the sole author, when you clearly "just"
modified the pca9541 driver. Please state the history!

> + *
> + * Derived from:

Maybe you intended to add something here, but forgot?

> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/jiffies.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-mux.h>
> +
> +#include <linux/i2c/pca954x.h>

What is this last include for? We have moved away from specifying platform
data in (new) code.

> +
> +/*
> + * The PCA9641 is two I2C bus masters demultiplexer. It supports two I2C masters

"is two I2C bus masters" -> "is a two I2C bus master"

> + * connected to a single slave bus.
> + *
> + * It is designed for high reliability dual master I2C bus applications where
> + * correct system operation is required, even when two I2C master issue their
> + * commands at the same time. The arbiter will select a winner and let it work
> + * uninterrupted, and the losing master will take control of the I2C bus after
> + * the winnter has finished. The arbiter also allows for queued requests where

winner

> + * a master requests the downstream bus while the other master has control.
> + *
> + */
> +
> +#define PCA9641_ID		0x01
> +#define PCA9641_ID_MAGIC	0x38
> +
> +#define PCA9641_CONTROL		0x01
> +#define PCA9641_STATUS		0x02
> +#define PCA9641_TIME		0x03
> +
> +#define PCA9641_CTL_LOCK_REQ		BIT(0)
> +#define PCA9641_CTL_LOCK_GRANT		BIT(1)
> +#define PCA9641_CTL_BUS_CONNECT		BIT(2)
> +#define PCA9641_CTL_BUS_INIT		BIT(3)
> +#define PCA9641_CTL_SMBUS_SWRST		BIT(4)
> +#define PCA9641_CTL_IDLE_TIMER_DIS	BIT(5)
> +#define PCA9641_CTL_SMBUS_DIS		BIT(6)
> +#define PCA9641_CTL_PRIORITY		BIT(7)
> +
> +#define PCA9641_STS_OTHER_LOCK		BIT(0)
> +#define PCA9641_STS_BUS_INIT_FAIL	BIT(1)
> +#define PCA9641_STS_BUS_HUNG		BIT(2)
> +#define PCA9641_STS_MBOX_EMPTY		BIT(3)
> +#define PCA9641_STS_MBOX_FULL		BIT(4)
> +#define PCA9641_STS_TEST_INT		BIT(5)
> +#define PCA9641_STS_SCL_IO		BIT(6)
> +#define PCA9641_STS_SDA_IO		BIT(7)
> +
> +#define PCA9641_RES_TIME	0x03
> +
> +#define busoff(x, y)	(!((x) & PCA9641_CTL_LOCK_GRANT) && \
> +			!((y) & PCA9641_STS_OTHER_LOCK))
> +#define other_lock(x)	((x) & PCA9641_STS_OTHER_LOCK)
> +#define lock_grant(x)	((x) & PCA9641_CTL_LOCK_GRANT)
> +
> +/* arbitration timeouts, in jiffies */
> +#define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
> +#define ARB2_TIMEOUT	(HZ / 4)	/* 250 ms until acquisition failure */
> +
> +/* arbitration retry delays, in us */
> +#define SELECT_DELAY_SHORT	50
> +#define SELECT_DELAY_LONG	1000
> +
> +struct pca9641 {
> +	struct i2c_client *client;
> +	unsigned long select_timeout;
> +	unsigned long arb_timeout;
> +};
> +
> +static const struct i2c_device_id pca9641_id[] = {
> +	{"pca9641", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, pca9641_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id pca9641_of_match[] = {
> +	{ .compatible = "nxp,pca9641" },

You need to describe the DT binding in Documentation/devicetree/bindings/i2c
See nxp,pca9541.txt for inspiration.

> +	{}
> +};
> +#endif
> +
> +/*
> + * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
> + * as they will try to lock the adapter a second time.
> + */
> +static int pca9641_reg_write(struct i2c_client *client, u8 command, u8 val)
> +{
> +	struct i2c_adapter *adap = client->adapter;
> +	int ret;
> +
> +	if (adap->algo->master_xfer) {
> +		struct i2c_msg msg;
> +		char buf[2];
> +
> +		msg.addr = client->addr;
> +		msg.flags = 0;
> +		msg.len = 2;
> +		buf[0] = command;
> +		buf[1] = val;
> +		msg.buf = buf;
> +		ret = __i2c_transfer(adap, &msg, 1);
> +	} else {
> +		union i2c_smbus_data data;
> +
> +		data.byte = val;
> +		ret = adap->algo->smbus_xfer(adap, client->addr,
> +					     client->flags,
> +					     I2C_SMBUS_WRITE,
> +					     command,
> +					     I2C_SMBUS_BYTE_DATA, &data);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Read from chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
> + * as they will try to lock adapter a second time.
> + */
> +static int pca9641_reg_read(struct i2c_client *client, u8 command)
> +{
> +	struct i2c_adapter *adap = client->adapter;
> +	int ret;
> +	u8 val;
> +
> +	if (adap->algo->master_xfer) {
> +		struct i2c_msg msg[2] = {
> +			{
> +				.addr = client->addr,
> +				.flags = 0,
> +				.len = 1,
> +				.buf = &command
> +			},
> +			{
> +				.addr = client->addr,
> +				.flags = I2C_M_RD,
> +				.len = 1,
> +				.buf = &val
> +			}
> +		};
> +		ret = __i2c_transfer(adap, msg, 2);
> +		if (ret == 2)
> +			ret = val;
> +		else if (ret >= 0)
> +			ret = -EIO;
> +	} else {
> +		union i2c_smbus_data data;
> +
> +		ret = adap->algo->smbus_xfer(adap, client->addr,
> +					     client->flags,
> +					     I2C_SMBUS_READ,
> +					     command,
> +					     I2C_SMBUS_BYTE_DATA, &data);
> +		if (!ret)
> +			ret = data.byte;
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Arbitration management functions
> + */
> +static void pca9641_release_bus(struct i2c_client *client)
> +{
> +	pca9641_reg_write(client, PCA9641_CONTROL, 0);
> +}
> +
> +/*
> + * Channel arbitration
> + *
> + * Return values:
> + *  <0: error
> + *  0 : bus not acquired
> + *  1 : bus acquired
> + */
> +static int pca9641_arbitrate(struct i2c_client *client)
> +{
> +	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
> +	struct pca9641 *data = i2c_mux_priv(muxc);
> +	int reg_ctl, reg_sts;
> +
> +	reg_ctl = pca9641_reg_read(client, PCA9641_CONTROL);
> +	if (reg_ctl < 0)
> +		return reg_ctl;
> +	reg_sts = pca9641_reg_read(client, PCA9641_STATUS);
> +
> +	if (busoff(reg_ctl, reg_sts)) {
> +		/*
> +		 * Bus is off. Request ownership or turn it on unless
> +		 * other master requested ownership.
> +		 */
> +		reg_ctl |= PCA9641_CTL_LOCK_REQ;
> +		pca9641_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +		reg_ctl = pca9641_reg_read(client, PCA9641_CONTROL);
> +
> +		if (lock_grant(reg_ctl)) {
> +			/*
> +			 * Other master did not request ownership,
> +			 * or arbitration timeout expired. Take the bus.
> +			 */
> +			reg_ctl |= PCA9641_CTL_BUS_CONNECT \
> +					| PCA9641_CTL_LOCK_REQ;
> +			pca9641_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +			data->select_timeout = SELECT_DELAY_SHORT;
> +
> +			return 1;
> +		} else {
> +			/*
> +			 * Other master requested ownership.
> +			 * Set extra long timeout to give it time to acquire it.
> +			 */
> +			data->select_timeout = SELECT_DELAY_LONG * 2;
> +		}
> +	} else if (lock_grant(reg_ctl)) {
> +		/*
> +		 * Bus is on, and we own it. We are done with acquisition.
> +		 */
> +		reg_ctl |= PCA9641_CTL_BUS_CONNECT | PCA9641_CTL_LOCK_REQ;
> +		pca9641_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +
> +		return 1;
> +	} else if (other_lock(reg_sts)) {
> +		/*
> +		 * Other master owns the bus.
> +		 * If arbitration timeout has expired, force ownership.
> +		 * Otherwise request it.
> +		 */
> +		data->select_timeout = SELECT_DELAY_LONG;
> +		reg_ctl |= PCA9641_CTL_LOCK_REQ;
> +		pca9641_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +	}
> +	return 0;
> +}
> +
> +static int pca9641_select_chan(struct i2c_mux_core *muxc, u32 chan)
> +{
> +	struct pca9641 *data = i2c_mux_priv(muxc);
> +	struct i2c_client *client = data->client;
> +	int ret;
> +	unsigned long timeout = jiffies + ARB2_TIMEOUT;
> +		/* give up after this time */
> +
> +	data->arb_timeout = jiffies + ARB_TIMEOUT;
> +		/* force bus ownership after this time */
> +
> +	do {
> +		ret = pca9641_arbitrate(client);
> +		if (ret)
> +			return ret < 0 ? ret : 0;
> +
> +		if (data->select_timeout == SELECT_DELAY_SHORT)
> +			udelay(data->select_timeout);
> +		else
> +			msleep(data->select_timeout / 1000);
> +	} while (time_is_after_eq_jiffies(timeout));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int pca9641_release_chan(struct i2c_mux_core *muxc, u32 chan)
> +{
> +	struct pca9641 *data = i2c_mux_priv(muxc);
> +	struct i2c_client *client = data->client;
> +
> +	pca9641_release_bus(client);
> +	return 0;
> +}
> +
> +/*
> + * I2C init/probing/exit functions
> + */
> +static int pca9641_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adap = client->adapter;
> +	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
> +	struct i2c_mux_core *muxc;
> +	struct pca9641 *data;
> +	int force;
> +	int ret;
> +
> +	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;

Reading the data sheet, I noticed that the chip supports I2C device id.
There's a brand new function available in -next [1] that allows you to
check this. See the pca954x driver in -next for an example [2]. It checks
the I2C device id for the newer pca984x chips.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/i2c/i2c-core-base.c
i2c_get_device_id(), currently circa line 2000

[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/i2c/muxes/i2c-mux-pca954x.c

> +	/*
> +	 * I2C accesses are unprotected here.
> +	 * We have to lock the adapter before releasing the bus.
> +	 */
> +	i2c_lock_adapter(adap);
> +	pca9641_release_bus(client);
> +	i2c_unlock_adapter(adap);
> +
> +	/* Create mux adapter */
> +
> +	force = 0;
> +	if (pdata)
> +		force = pdata->modes[0].adap_id;
> +	muxc = i2c_mux_alloc(adap, &client->dev, 8, sizeof(*data),

Why 8? Should be 1, no?

> +			     I2C_MUX_ARBITRATOR,
> +			     pca9641_select_chan, pca9641_release_chan);
> +	if (!muxc)
> +		return -ENOMEM;
> +
> +	data = i2c_mux_priv(muxc);
> +	data->client = client;
> +
> +	i2c_set_clientdata(client, muxc);
> +
> +

Lose one of the empty lines here.

> +	ret = i2c_mux_add_adapter(muxc, force, 0, 0);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to register master demultiplexer\n");

This dev_err should go. i2c_mux_add_adapter provides a more
detailed error message on failure.

Cheers,
Peter

> +		return ret;
> +	}
> +
> +	dev_info(&client->dev, "registered master demultiplexer for I2C %s\n",
> +		 client->name);
> +
> +	return 0;
> +}
> +
> +static int pca9641_remove(struct i2c_client *client)
> +{
> +	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
> +
> +	i2c_mux_del_adapters(muxc);
> +	return 0;
> +}
> +
> +static struct i2c_driver pca9641_driver = {
> +	.driver = {
> +		   .name = "pca9641",
> +		   .of_match_table = of_match_ptr(pca9641_of_match),
> +		   },
> +	.probe = pca9641_probe,
> +	.remove = pca9641_remove,
> +	.id_table = pca9641_id,
> +};
> +
> +module_i2c_driver(pca9641_driver);
> +
> +MODULE_AUTHOR("Ken Chen <chen.kenyy@inventec.com>");
> +MODULE_DESCRIPTION("PCA9641 I2C master demultiplexer driver");
> +MODULE_LICENSE("GPL v2");
> 
