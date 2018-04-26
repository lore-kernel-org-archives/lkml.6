Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbeDZGbS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:31:18 -0400
Received: from mail-he1eur01on0086.outbound.protection.outlook.com ([104.47.0.86]:9738
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753482AbeDZGbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:31:12 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
Thread-Topic: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
Thread-Index: AQHT3N7YzkwH9nd9GEu5TmQiNB/zw6QSXDsAgAA3nYCAAACu8A==
Date: Thu, 26 Apr 2018 06:31:08 +0000
Message-ID: <DB5PR04MB13205A0A7134C969748560B4F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
 <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AZLbUoL7FWgUFA7qc3q3wcz9UBLSQhMXXkUJeiRz8X4A@mail.gmail.com>
In-Reply-To: <CAOMZO5AZLbUoL7FWgUFA7qc3q3wcz9UBLSQhMXXkUJeiRz8X4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1206;7:9PK6KUX0WmPODgkto+8X2bx7eHOMmwc0LPKPt7qQcZSLleT091RdqO223hLg629OyU5yFG5zwcyZqtXQsqaJSs/dakLKRy7oudsbVAzUZ5WwToHYl6gwzJd4i1vZtwzUeZNQHAfiaMkPCsPBINvS37YJ1ebUzOwLInSfXy37hLjRS6tTNeZd42uCywTdhuNOWnHuS7QGL67qggkjLRP2WprgKMRa0yp7ugeTev75uOkO+pjbhDNXnHyFYE+EZkbJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1206;
x-ms-traffictypediagnostic: DB5PR04MB1206:
x-microsoft-antispam-prvs: <DB5PR04MB120650CF4E0B2C1AB4D19FBCF58E0@DB5PR04MB1206.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR04MB1206;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1206;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(376002)(39860400002)(366004)(396003)(13464003)(199004)(189003)(5250100002)(53936002)(44832011)(25786009)(33656002)(229853002)(7736002)(4326008)(2900100001)(86362001)(1411001)(54906003)(9686003)(81156014)(99286004)(106356001)(8676002)(74316002)(6436002)(81166006)(14454004)(39060400002)(305945005)(55016002)(97736004)(8936002)(26005)(6246003)(66066001)(486006)(7696005)(76176011)(3846002)(3660700001)(93886005)(3280700002)(2906002)(53546011)(186003)(105586002)(316002)(476003)(68736007)(446003)(6916009)(59450400001)(5660300001)(6506007)(478600001)(6116002)(11346002)(102836004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1206;H:DB5PR04MB1320.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vkbIPQ7GOPgddak8oMVaSnWob2CXFbhbf1WqBeXDWIrPmlJqMTwFlJFvZ+wGkIAbUoPU8KLCN64ZrzeTAdiqYj6g3UlDOwQxpnUqM5Q849tpcJVT+Jb46TqUZ9ZoxHdIlgXJlpBAes1OBM9iraseY66jGcYcfN35rKPuG/IvpBT0ZF1QRj2edqmsvZCBrT2K
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9b918ad6-bf60-4af5-6267-08d5ab3f4ba0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b918ad6-bf60-4af5-6267-08d5ab3f4ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 06:31:08.1165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3Q6VOHR003840



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Thursday, April 26, 2018 2:21 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Russell King - ARM Linux <linux@armlinux.org.uk>; dl-linux-imx
> <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
> max7310 support
> 
> On Thu, Apr 26, 2018 at 12:06 AM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > MAX7310 pins are for PCIe, CAN, MLB. GPS etc., these modules are NOT
> > enabled yet, so I can NOT test it, I think we should add MAX7310 users
> > when these modules are enabled, ethernet PHY is NOT controlled by it.
> 
> You said previously that MAX7310 also controls the Ethernet PHY. Is the vendor
> dts wrong then?
> 
> If there are no MAX7310 users, why are you adding support for MAX7310 then?
> 
> Confused.

I searched the mail I sent, I can NOT found where I said "MAX7310 controls the ethernet phy"....

There are MAX7310 users, it is just because currently those users are NOT enabled, so I can
NOT verify them. MAX7310 is an independent I2C device, why we can NOT enable it first?
I tested it from sysfs interface, we can control the MAX7310's IO output via echo different value
to GPIO value, that means MAX7310 itself as an IO expander chip is working just fine, similar with PMIC,
it is a I2C device, can be enabled independently, then consumers can be added later when they are enabled.
Just my personal opinion, thanks.

Anson.
