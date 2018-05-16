Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeEPBT4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 21:19:56 -0400
Received: from mail-he1eur01on0061.outbound.protection.outlook.com ([104.47.0.61]:10496
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751309AbeEPBTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 21:19:54 -0400
From: Andy Duan <fugang.duan@nxp.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/3] net: ethernet: freescale: Allow FEC with
 COMPILE_TEST
Thread-Topic: [PATCH net-next 2/3] net: ethernet: freescale: Allow FEC with
 COMPILE_TEST
Thread-Index: AQHT7KdPfyc1Ci3nOkqrfd6EJZgyRqQxjmHw
Date: Wed, 16 May 2018 01:19:51 +0000
Message-ID: <AM4PR0401MB22603C8701762CBCE1D2706AFF920@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180515234825.11240-1-f.fainelli@gmail.com>
 <20180515234825.11240-3-f.fainelli@gmail.com>
In-Reply-To: <20180515234825.11240-3-f.fainelli@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB2241;7:KRMpjnnGbuUko7axZSpC03JbncmEQE/oNYGy72rNuk4Y1i3mmI/Yo7eoNddx+1kMWD7IddKQWv2aUkE8fLbsC4OUQxWHZb+YVuUbWLvfjgXPjdOXy3LDDDHJqUhbnk6PZd6qn1/PZxboK/1HOSxi2yTQRBoo0kFzv1/YsL4pJzFPVYaej9UCmsNxSDfyklp9p6PCjcX6gWoJR51jW25tmJYJMKl50N7Ge9X/aAfbp+aFD6Hsr1174bUAMc8f3rf6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2241;
x-ms-traffictypediagnostic: AM4PR0401MB2241:
x-microsoft-antispam-prvs: <AM4PR0401MB224182445D28E9F0F100B1EEFF920@AM4PR0401MB2241.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR0401MB2241;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2241;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(66066001)(14454004)(81166006)(81156014)(8936002)(476003)(106356001)(105586002)(6506007)(59450400001)(6116002)(76176011)(99286004)(8676002)(7696005)(102836004)(3846002)(55016002)(97736004)(2501003)(9686003)(446003)(5250100002)(486006)(11346002)(86362001)(53936002)(25786009)(2900100001)(74316002)(4326008)(39060400002)(5660300001)(229853002)(68736007)(3280700002)(186003)(26005)(316002)(305945005)(7736002)(6246003)(33656002)(2906002)(54906003)(110136005)(3660700001)(478600001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2241;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zHfq2G/YnLPGZPZmoiPoOI/jdWxGYFQ5YgCUFPTyR6PMm/g1cSAkyvD2sQSDixg9XoP3KqowwL9o9IgNrVlYuUU4zEG14sCJTFpsNNe5d5iwarxjHsxvzHhgLfu2ImAiLZZEuQ9q12ibTfO046TaEJ9GK7BMyzRWJlXn2WtUvyfT7qqARA2EjkmPL/gWGZ87
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7df31265-a76c-46af-3fd4-08d5bacb1f82
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df31265-a76c-46af-3fd4-08d5bacb1f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 01:19:51.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2241
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4G1K1Ld007796

From: Florian Fainelli <f.fainelli@gmail.com> Sent: 2018Äê5ÔÂ16ÈÕ 7:48
> The Freescale FEC driver builds fine with COMPILE_TEST, so make that
> possible.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Fugang Duan <fugang.duan@nxp.com>

> ---
>  drivers/net/ethernet/freescale/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/Kconfig
> b/drivers/net/ethernet/freescale/Kconfig
> index 6e490fd2345d..a580a3dcbe59 100644
> --- a/drivers/net/ethernet/freescale/Kconfig
> +++ b/drivers/net/ethernet/freescale/Kconfig
> @@ -22,7 +22,7 @@ if NET_VENDOR_FREESCALE  config FEC
>  	tristate "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
>  	depends on (M523x || M527x || M5272 || M528x || M520x || M532x || \
> -		   ARCH_MXC || SOC_IMX28)
> +		   ARCH_MXC || SOC_IMX28 || COMPILE_TEST)
>  	default ARCH_MXC || SOC_IMX28 if ARM
>  	select PHYLIB
>  	imply PTP_1588_CLOCK
> --
> 2.14.1
