Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeCRCZF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 22:25:05 -0400
Received: from mail-eopbgr40054.outbound.protection.outlook.com ([40.107.4.54]:38152
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751450AbeCRCZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 22:25:03 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
CC: Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>, Robin Gong <yibin.gong@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] regulator: pfuze100: update voltage setting for
 pfuze3000 sw1a
Thread-Topic: [PATCH 2/2] regulator: pfuze100: update voltage setting for
 pfuze3000 sw1a
Thread-Index: AQHTvecGVQ9Mbxs7xUSOotC5SjalUaPUXSEAgABiQICAAIT7sA==
Date: Sun, 18 Mar 2018 02:25:00 +0000
Message-ID: <AM3PR04MB1315FFAB52CBB2E5DECED17BF5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <1521269828-8874-2-git-send-email-Anson.Huang@nxp.com>
 <1937778373.476574.1521290144753@email.1und1.de>
 <CAOMZO5CUD373oZsnE69kEwj0oXLSQTMeb5k2YK6H5gPY7QyZPA@mail.gmail.com>
In-Reply-To: <CAOMZO5CUD373oZsnE69kEwj0oXLSQTMeb5k2YK6H5gPY7QyZPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1506;7:Wykpv5V014s+me7kRIiKgseXKqd9XP7ACJ0qPN6x+ZWS77wq0yDney2lN/Px8UNbUYgFa9bgV7FrwC3KzV8vhpVRGJItCezHcK1fk4fMFqRyf12ErBCpYmuG8Db/lB9BwOGFd6IwM842NnlHz9AeCI2j7nAsRePWRCnXxhEFAR+4J/8ULwRPU5GD4otEf/kbo/BQpoOg1kgPKHqt2aWvxpnnph26BA20R2bZR0sJXTHLPNjniv5TXXGj1TRwzF+u
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c036d26a-9743-493a-a61f-08d58c777308
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1506;
x-ms-traffictypediagnostic: AM3PR04MB1506:
x-microsoft-antispam-prvs: <AM3PR04MB1506313E94ACA4C2330C03EFF5D50@AM3PR04MB1506.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM3PR04MB1506;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1506;
x-forefront-prvs: 06157D541C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(13464003)(6436002)(9686003)(3846002)(33656002)(39060400002)(68736007)(2950100002)(102836004)(53936002)(478600001)(45080400002)(966005)(2900100001)(6246003)(97736004)(25786009)(5660300001)(6116002)(6306002)(81156014)(81166006)(8676002)(316002)(229853002)(15650500001)(345774005)(55016002)(59450400001)(8936002)(4326008)(7416002)(5250100002)(93886005)(186003)(14454004)(66066001)(2906002)(76176011)(86362001)(99286004)(106356001)(54906003)(74316002)(53546011)(7736002)(110136005)(105586002)(6506007)(26005)(3660700001)(7696005)(3280700002)(305945005)(32563001)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1506;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MocTUYqhFb4SZUZBnJ+gnY7RayXjbPB7ENIfmmvCkA/abXhHTMKWvPKJBoyhCzrjy8DOCuCbpoilKEZ8R1LQT+I6oMIs0+5Aw26XPNNNnipEQ80WhxJLZRIanEgeAWU145RgUPbTu/NsDacXYYtJNFrqTKmQ6lLQuwy3Y//Ot+g+LVhCK/4sJ+0OHgh0JVo+j67c4xRGXmZP/6eZ01yjsJ8FrxhqRqC2s39jA6mjoMUMZD+m8GR7QeS5kpPiQlYIoyOFUmk1AlydLM2sZIQYlHeGV0leWL8hZI1bqSQQ5lFwOYuYpxpf5nRPjXnWnoEKY22KWUAU4tvs/3P/apDL7w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c036d26a-9743-493a-a61f-08d58c777308
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2018 02:25:00.0799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1506
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2I2PC1T013664



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Sunday, March 18, 2018 2:27 AM
> To: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Mark Rutland <mark.rutland@arm.com>; Robin
> Gong <yibin.gong@nxp.com>; Russell King - ARM Linux
> <linux@armlinux.org.uk>; Anson Huang <anson.huang@nxp.com>; Liam
> Girdwood <lgirdwood@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <kernel@pengutronix.de>; Mark Brown <broonie@kernel.org>;
> open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 2/2] regulator: pfuze100: update voltage setting for
> pfuze3000 sw1a
> 
> Hi Stefan,
> 
> On Sat, Mar 17, 2018 at 9:35 AM, Stefan Wahren <stefan.wahren@i2se.com>
> wrote:
> > Hi Anson,
> >
> >> Anson Huang <Anson.Huang@nxp.com> hat am 17. März 2018 um 07:57
> geschrieben:
> >>
> >>
> >> Latest pfuze3000 datasheet from:
> >>
> >>
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcache.fr
> eescale.com%2Ffiles%2Fanalog%2Fdoc%2Fdata_sheet%2FPF3000.pdf%3Ffsrch
> %3D1%26sr%3D1%26pageNum%3D1&data=02%7C01%7CAnson.Huang%40nxp
> .com%7Cf6e1374a196741efe49b08d58c34bbab%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C1%7C636569080479216580&sdata=DZQFb2hHbYqXjduHC0
> 1z%2FiAT4xvztN4Gy85S89mULwo%3D&reserved=0
> >
> > this link goes to Rev. 7.0, 9/2016, which isn't the latest one.
> >
> > I guess Rev. 9.0, 8/2017 is the latest.
> 
> You are right. This is the link to the latest datasheet:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.n
> xp.com%2Fdocs%2Fen%2Fdata-sheet%2FPF3000.pdf&data=02%7C01%7CAnson
> .Huang%40nxp.com%7Cf6e1374a196741efe49b08d58c34bbab%7C686ea1d3bc
> 2b4c6fa92cd99c5c301635%7C0%7C1%7C636569080479216580&sdata=WIQYD
> 7WDn0%2FTl4BzM7oJdSuwK31Z64TfekeBAkou9XQ%3D&reserved=0

Yes, thank you for the reminder, I will update the commit message and the link in V2.
 
Anson.
