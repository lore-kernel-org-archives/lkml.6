Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757208AbeD0BdG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:33:06 -0400
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:28800
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeD0BdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:33:04 -0400
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
Thread-Index: AQHT3N7YzkwH9nd9GEu5TmQiNB/zw6QSXDsAgAA3nYCAAACu8IAAuJUAgACE/MA=
Date: Fri, 27 Apr 2018 01:33:00 +0000
Message-ID: <AM3PR04MB1315E21D05BC3EA5F9E6D2EAF58D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
 <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AZLbUoL7FWgUFA7qc3q3wcz9UBLSQhMXXkUJeiRz8X4A@mail.gmail.com>
 <DB5PR04MB13205A0A7134C969748560B4F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
 <CAOMZO5DWeYCbWn9LEi1e+tc4gZsjBBpXtiwzmwLbYp=E4TERrg@mail.gmail.com>
In-Reply-To: <CAOMZO5DWeYCbWn9LEi1e+tc4gZsjBBpXtiwzmwLbYp=E4TERrg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1363;7:nzFdO00hoov28XCVZcCXuuNz3JzGRepAY9T6PbrCIvTIwGP6jzuO1Cvu4h5ei7McXLi1LUIOu43JeDFIhWnD/4acOBBDXV0scD77LVQC9OMk5W2846TmMGvYxhgOOeKAqwuGjKxz5r18f3JhNzzuzrS8NapgFCjJv8tHqujE762sN1RoqmRl8hR48DXS/KSCQ8kzwCxRY05LcpymVq6Yc2Y+hj3iPFGdfu10issZdmIi5msiV38q357DO0DGTE19
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1363;
x-ms-traffictypediagnostic: AM3PR04MB1363:
x-microsoft-antispam-prvs: <AM3PR04MB1363CB542E5BBD5470625221F58D0@AM3PR04MB1363.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB1363;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1363;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(13464003)(1411001)(53936002)(316002)(25786009)(476003)(39060400002)(4326008)(3280700002)(5250100002)(26005)(99286004)(66066001)(76176011)(59450400001)(9686003)(102836004)(6246003)(54906003)(93886005)(55016002)(53546011)(6506007)(2900100001)(6916009)(7696005)(44832011)(478600001)(6116002)(186003)(106356001)(14454004)(86362001)(229853002)(6436002)(68736007)(486006)(3660700001)(97736004)(33656002)(11346002)(446003)(3846002)(81166006)(7736002)(5660300001)(2906002)(74316002)(305945005)(81156014)(8936002)(8676002)(105586002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1363;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: l/S+nvat46BaAbs+h2iDpqYrdK6/9kb3zBGbdxRqDWRjFXeeRgXIhaxpX38Kb/n9N67OUG7RAOMziddW0+2TWdCdAY9VtLQ/E7W1YWxTa/q7E+WxOtaE33fi0K8Ir8QR12QTHmDCksdJH4FOpMYPlzIS35OYiHefT5GqxLANcWWZxDWJGRbLXRROJlh9TlkG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1400cc42-bca2-4dab-2d77-08d5abdecfdf
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1400cc42-bca2-4dab-2d77-08d5abdecfdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 01:33:00.0581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1363
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3R1XCMR018204



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Friday, April 27, 2018 1:24 AM
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
> On Thu, Apr 26, 2018 at 3:31 AM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > I searched the mail I sent, I can NOT found where I said "MAX7310 controls
> the ethernet phy"....
> 
> Initially you passed:  pinctrl-assert-gpios = <&max7322 0 GPIO_ACTIVE_HIGH>
> inside the fec1 node.
> 
> Then I explained that 'pinctrl-assert-gpios' is not a valid property in mainline. It
> only exists in NXP vendor tree.
> 
> Then you explained:
> 
> "Sorry, I made a mistake here, the MAX7320 IO0 is for adjusting FEC1's voltage"

The ' pinctrl-assert-gpios ' is ONLY in NXP local tree, FEC owner added it because he
wants to set this GPIO ONCE during kernel boot up, but upstream kernel does NOT
support the pinctrl-assert-gpio, so we have to drop it, the MAX7322 IO0 is for adjusting
FEC's voltage, I meant for FEC IO's voltage, 1.5V or 1.8V. If I made any confuse, I am
sorry for that, I think it should be clear now, all we want/need is to set this GPIO ONCE
to get the IO voltage we want.

> 
> > There are MAX7310 users, it is just because currently those users are
> > NOT enabled, so I can NOT verify them. MAX7310 is an independent I2C
> device, why we can NOT enable it first?
> > I tested it from sysfs interface, we can control the MAX7310's IO
> > output via echo different value to GPIO value, that means MAX7310
> > itself as an IO expander chip is working just fine, similar with PMIC, it is a I2C
> device, can be enabled independently, then consumers can be added later when
> they are enabled.
> > Just my personal opinion, thanks.
> 
> Right, but if FEC needs max7322 IO0 at level 1 then better describe it in dts.
 
Agree, since currently our FEC driver does NOT support adjusting such IO voltage in driver, 
and there is NO such requirement of runtime switching IO voltage for FEC, so I think it
should be good here, just use the default settings of MAX7322 IO0 described in 'reg_fec',
if there is any further requirement of runtime adjusting FEC IO voltage, I think FEC driver
needs to add such support, and there will be new patch for it.

Thanks.

Anson.  
