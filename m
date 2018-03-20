Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCTCNW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:13:22 -0400
Received: from mail-db5eur01on0084.outbound.protection.outlook.com ([104.47.2.84]:49888
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751014AbeCTCNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:13:18 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx7d-pinfunc: update sai select input value
Thread-Topic: [PATCH] ARM: dts: imx7d-pinfunc: update sai select input value
Thread-Index: AQHTv0b+K0O1n16tGEO5LlocERjcUqPYXxqAgAAD8lA=
Date: Tue, 20 Mar 2018 02:13:14 +0000
Message-ID: <AM3PR04MB1315B6C5A16ACC2C7D709C71F5AB0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521429281-23394-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5A0fA2h_T__vFzGXPzrzKZJuMyiRLRvNag43Xffif1EZQ@mail.gmail.com>
In-Reply-To: <CAOMZO5A0fA2h_T__vFzGXPzrzKZJuMyiRLRvNag43Xffif1EZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1476;7:1RlcSv26V8LaiKJ7G+EhIuzWOzfA4kn4dfYO0GR31RTPjNtEHLZ3F04jo4j+a73+RfWRBvGpkmcHhkXMcHuGbDLFtwHWtS/jChQ+H4Fnz3+CpPRN/NMfiibmSDXYWcWs9BoNxt42dnxXSiGC+WZhMJYFEBV/u6QC952ehKtUzC763Da6q8lSW170i884aoep+T0KQzgFVihpb0ygMHkQlNribAYjo7q215R3C8uVjXAgsmaJqilNoIjpcLiDCqqr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8febaef-194e-4a33-07de-08d58e08239a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1476;
x-ms-traffictypediagnostic: AM3PR04MB1476:
x-microsoft-antispam-prvs: <AM3PR04MB14762ADD53E41B506CECD99DF5AB0@AM3PR04MB1476.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1476;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1476;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(199004)(189003)(13464003)(76176011)(316002)(4326008)(54906003)(25786009)(6246003)(7696005)(53936002)(59450400001)(9686003)(55016002)(5660300001)(229853002)(305945005)(2900100001)(99286004)(74316002)(97736004)(186003)(7736002)(3280700002)(3660700001)(6506007)(478600001)(39060400002)(26005)(5250100002)(53546011)(8936002)(14454004)(2906002)(6916009)(86362001)(2950100002)(81166006)(81156014)(106356001)(66066001)(8676002)(6116002)(3846002)(6436002)(33656002)(15650500001)(68736007)(1411001)(105586002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1476;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2roJafNbH+gk43fVmp6b1VKc/dOTzwDjNTWyHY7OL9HIVgtYAhBw41HYzMi8b/KCc3+wwCWnT0tyzHMegdL5ikMLVZyAYlbwoa3ny83sE50XUuKpfiY956bli8yelEpZuoNlal2wsLSLDUGQjj3JolrLi9K9lc3LNmzD/B1+a9eWuESVrpMd/xpAE9tWvM+m+M1TCD8uvuMzRjD4m7fJBDW9EKdjDL8Yaw09//hhUYogLKy1DA/ngu+N1QWshmb/7/Pd5Ln7ZQMwKuDVJN68KF0wgDnH8AEXqzhmCu633+g9vJ/aLSSYiGp5vMGGfHorT1nJMzu2BI7WJ4qFumfjAw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8febaef-194e-4a33-07de-08d58e08239a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 02:13:15.0191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1476
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2K2DUSf024628

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Tuesday, March 20, 2018 9:58 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Russell King - ARM Linux <linux@armlinux.org.uk>; S.j. Wang
> <shengjiu.wang@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] ARM: dts: imx7d-pinfunc: update sai select input value
> 
> Hi Anson,
> 
> On Mon, Mar 19, 2018 at 12:14 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Update SAI select input daisy chain value according to Reference
> > Manual.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> Could you please clarify the authorship of this patch? Is this yours or from
> Shengjiu Wang?
> 
> If it is from Shengjiu Wang then his name should appear in the From field and his
> Signed-off-by tag should appear first and yours should go after it.
 
The original patch is from Shengjiu wang in our internal tree, I modify the commit
message, yes, I miss changing the from field, resent the V2 patch. Thanks.

Anson. 
