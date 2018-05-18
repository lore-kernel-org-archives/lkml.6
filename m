Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeERBXB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:23:01 -0400
Received: from mail-ve1eur01on0073.outbound.protection.outlook.com ([104.47.1.73]:25232
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751664AbeERBW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:22:59 -0400
From: Andy Duan <fugang.duan@nxp.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 2/3] net: ethernet: freescale: Allow FEC with
 COMPILE_TEST
Thread-Topic: [PATCH net-next v3 2/3] net: ethernet: freescale: Allow FEC with
 COMPILE_TEST
Thread-Index: AQHT7hq+qaD5F3MV1kWp2grO9GyjJqQ0sQUg
Date: Fri, 18 May 2018 01:22:56 +0000
Message-ID: <AM4PR0401MB2260783E6F6A3D5295FE50AFFF900@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180517200745.19142-1-f.fainelli@gmail.com>
 <20180517200745.19142-3-f.fainelli@gmail.com>
In-Reply-To: <20180517200745.19142-3-f.fainelli@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1732;7:ps4uj44FggsErr0XjrbuPgGimIRKcCBAIkjg5rVqdb0uQyOWAm6jSE6Le8nqcA31bp8ly3Ytz19wc9lORn68l5qEiWLzy4J343TB+LwvbspTCUTrBgBc4q+adyEpzK48unjK4YgncUpKVsAPioFyuml+2pYqEwgmdNUbPZ3H0VHhrd0RSC1ey92PmBt5ZhmLNgaYobTSCUhETRfG7pySrp80oVsLcWsA/gMjHJtqOosLyfyQ/AMt3fdkU1HvkErZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB1732;
x-ms-traffictypediagnostic: AM4PR0401MB1732:
x-microsoft-antispam-prvs: <AM4PR0401MB17327A305FA1A207B968489CFF900@AM4PR0401MB1732.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB1732;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1732;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(346002)(39380400002)(199004)(189003)(7736002)(105586002)(81166006)(186003)(106356001)(76176011)(6506007)(6116002)(8936002)(99286004)(26005)(3846002)(7696005)(102836004)(25786009)(39060400002)(81156014)(3660700001)(305945005)(3280700002)(74316002)(53936002)(97736004)(5660300001)(8676002)(68736007)(4326008)(14454004)(2906002)(6246003)(2900100001)(55016002)(9686003)(446003)(229853002)(476003)(2501003)(33656002)(575784001)(110136005)(66066001)(11346002)(6436002)(5250100002)(54906003)(316002)(486006)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB1732;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jjsPdO6vsKh8vldEZScsjidznQt7xLkLQ2RS2bTiWkc8boeimt657CEPDetbaWWoB3/XKoMvuhAn8x1U998zsRyTeq+1s/bRRewDTOLz4MN/jVvdC9IAqTQ0j/gOYukSBA4dg/JliWsVpLa/rGimUz8QlKhsD3wGGH5JXzsINEzXEwxPPDqjPAg57s67aERM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5b2c86d6-7373-4484-c450-08d5bc5de2b4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2c86d6-7373-4484-c450-08d5bc5de2b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 01:22:56.3630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1732
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4I1N7m7025485

From: Florian Fainelli <f.fainelli@gmail.com> Sent: 2018Äê5ÔÂ18ÈÕ 4:08
> The Freescale FEC driver builds fine with COMPILE_TEST, so make that
> possible.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Fugang Duan <fugang.duan@nxp.com>

> ---
>  drivers/net/ethernet/freescale/Kconfig    | 2 +-
>  drivers/net/ethernet/freescale/fec.h      | 2 +-
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/Kconfig
> b/drivers/net/ethernet/freescale/Kconfig
> index 6e490fd2345d..a580a3dcbe59 100644
> --- a/drivers/net/ethernet/freescale/Kconfig
> +++ b/drivers/net/ethernet/freescale/Kconfig
> @@ -22,7 +22,7 @@ if NET_VENDOR_FREESCALE  config FEC
>  	tristate "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
>  	depends on (M523x || M527x || M5272 || M528x || M520x ||
> M532x || \
> -		   ARCH_MXC || SOC_IMX28)
> +		   ARCH_MXC || SOC_IMX28 || COMPILE_TEST)
>  	default ARCH_MXC || SOC_IMX28 if ARM
>  	select PHYLIB
>  	imply PTP_1588_CLOCK
> diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> index e7381f8ef89d..4778b663653e 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -21,7 +21,7 @@
> 
>  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) ||
> defined(CONFIG_M528x) || \
>      defined(CONFIG_M520x) || defined(CONFIG_M532x) ||
> defined(CONFIG_ARM) || \
> -    defined(CONFIG_ARM64)
> +    defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
>  /*
>   *	Just figures, Motorola would have to change the offsets for
>   *	registers in the same peripheral device on different models
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index f3e43db0d6cb..4358f586e28f 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2107,7 +2107,7 @@ static int fec_enet_get_regs_len(struct
> net_device *ndev)
>  /* List of registers that can be safety be read to dump them with ethtool
> */  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) ||
> defined(CONFIG_M528x) || \
>  	defined(CONFIG_M520x) || defined(CONFIG_M532x) ||
> defined(CONFIG_ARM) || \
> -	defined(CONFIG_ARM64)
> +	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
>  static u32 fec_enet_register_offset[] = {
>  	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0,
> FEC_X_DES_ACTIVE_0,
>  	FEC_ECNTRL, FEC_MII_DATA, FEC_MII_SPEED, FEC_MIB_CTRLSTAT,
> FEC_R_CNTRL,
> --
> 2.14.1
