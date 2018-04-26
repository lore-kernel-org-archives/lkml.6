Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeDZDGZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 23:06:25 -0400
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:61900
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751683AbeDZDGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 23:06:20 -0400
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
Thread-Index: AQHT3N7YzkwH9nd9GEu5TmQiNB/zw6QSXDsA
Date: Thu, 26 Apr 2018 03:06:15 +0000
Message-ID: <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
In-Reply-To: <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1266;7:1SmP2MwHJ/9GxW7YDYbdDKmn1asndlqLtetM9HfuKYNstATmaeEM1/WdC2lMlyUxKhRG7mdCHOpIdHodrfi/Xw7gLzniFZqcbDFXb3/S/tvmqCxUpp3KbG7nGOUY6RAymrakSbOzevnqc7/kholWGPW31tG/tWnUECepEgkSXq/5t/RecNY6YLAxWscGwdVOrSmH4NwVwkqfvTcOf5Dwr4Buqab6dKiXWcRFw4UMYhphwHI6H5F+w1o0XeorunLv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1266;
x-ms-traffictypediagnostic: AM3PR04MB1266:
x-microsoft-antispam-prvs: <AM3PR04MB12667CD3C712D97C03AD4D0DF58E0@AM3PR04MB1266.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1266;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1266;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(13464003)(189003)(199004)(33656002)(99286004)(81166006)(6506007)(74316002)(66066001)(1411001)(2906002)(6916009)(8936002)(53546011)(102836004)(5250100002)(97736004)(6436002)(7736002)(26005)(2900100001)(446003)(55016002)(11346002)(305945005)(3280700002)(14454004)(478600001)(81156014)(44832011)(8676002)(4326008)(316002)(476003)(186003)(39060400002)(53936002)(9686003)(86362001)(25786009)(54906003)(5660300001)(76176011)(105586002)(229853002)(3660700001)(3846002)(106356001)(486006)(6116002)(68736007)(6246003)(7696005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1266;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: bD8v4wXxxgQ+R/l2maQnyrQazIIA7TCE/nbhvIU9d9BIn/21j1ip1K7MbM7z4BNXlm1UXL11StxsPbgmaUNChHcW6MVGmS0cyfOcX+NDjrECrOc7zJaTTi8fdCwA50AV4OC7pTrLRZM+A906wSC7vZpXSh/WvncUWksoC/QwOFA/MxTkG6cyZnRpFGHrovWu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0318b0ca-e563-4ec7-9798-08d5ab22acd8
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0318b0ca-e563-4ec7-9798-08d5ab22acd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 03:06:15.9226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1266
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3Q36W5s020517

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Thursday, April 26, 2018 5:46 AM
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
> On Wed, Apr 25, 2018 at 2:36 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> > +&i2c3 {
> > +       clock-frequency = <100000>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c3_2>;
> > +       status = "okay";
> > +
> > +       max7310_a: gpio@30 {
> > +               compatible = "maxim,max7310";
> > +               reg = <0x30>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +       };
> > +
> > +       max7310_b: gpio@32 {
> > +               compatible = "maxim,max7310";
> > +               reg = <0x32>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +       };
> 
> Please also add the users for the MAX7310 pins, such as Ethernet PHY.
 
MAX7310 pins are for PCIe, CAN, MLB. GPS etc., these modules are NOT enabled yet, so
I can NOT test it, I think we should add MAX7310 users when these modules are enabled,
ethernet PHY is NOT controlled by it.

Anson.
