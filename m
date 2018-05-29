Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeE2D51 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:57:27 -0400
Received: from mail-ve1eur01on0073.outbound.protection.outlook.com ([104.47.1.73]:59904
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751674AbeE2D5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:57:21 -0400
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH 5/5] MAINTAINERS: add myself as maintainer for QorIQ PTP
 clock driver
Thread-Topic: [PATCH 5/5] MAINTAINERS: add myself as maintainer for QorIQ PTP
 clock driver
Thread-Index: AQHT8+LGBsUTAo6yFEmBHKhoaYxTQKRGDFCAgAANI+A=
Date: Tue, 29 May 2018 03:57:16 +0000
Message-ID: <DB6PR0401MB253603A4BCE81F08557F9C0CF86D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180525044038.37756-1-yangbo.lu@nxp.com>
        <20180525044038.37756-5-yangbo.lu@nxp.com>
 <20180528.230631.1400838711386498433.davem@davemloft.net>
In-Reply-To: <20180528.230631.1400838711386498433.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2310;7:aXdsZoylaQN/lfysRZipHGCBcXg9I9cm/kOUtMOcKmiKAC9tB8/CCpMRvqs3xYjonUSzmotdxx77dwpZe54q1bplSSXSA47MCvo4rQWkP+nxWksONEmmHKP0t7KRKOF6Jt58PkZjchPB75P1M6qsjgkKZ+BSFabc7MyNGVG0mbEJel4Ari0v9nKdkRLWFN9BF8TgcOPAbUrjPu9SF1q4+f/mVXEe2om2AoCV1eZrpOAunZYSEQgQPHx/A467D+K9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2310;
x-ms-traffictypediagnostic: DB6PR0401MB2310:
x-microsoft-antispam-prvs: <DB6PR0401MB23105B7113E979E20BA9BEBFF86D0@DB6PR0401MB2310.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2310;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2310;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(39860400002)(346002)(376002)(396003)(13464003)(199004)(189003)(102836004)(53546011)(6506007)(5250100002)(25786009)(7696005)(105586002)(11346002)(86362001)(39060400002)(106356001)(6246003)(26005)(9686003)(4326008)(68736007)(476003)(5660300001)(76176011)(486006)(53936002)(74316002)(229853002)(305945005)(6436002)(55016002)(316002)(81166006)(8936002)(478600001)(446003)(2906002)(3846002)(81156014)(7736002)(54906003)(6916009)(6116002)(66066001)(99286004)(14454004)(2900100001)(97736004)(186003)(8676002)(33656002)(3280700002)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2310;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kPzKxGYytdy00BIbly26RwKJob4DKf1QXycptKD/Mn6CrieqPm0lSTLzQ7iynmEBnlaIeUvQzl77a94OlCQMZIfOu2bkKRSaNxavtDQtNrtvaW0f0wGXd+c1zQvXUzwFG328KlzkMtMIHa9AQWDZaPkvsCgKEn+VaqfqgARbsHaagyxaVyhMkeFA9ZzNWUgg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b941fd1b-e04e-468d-99fe-08d5c51844fa
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b941fd1b-e04e-468d-99fe-08d5c51844fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 03:57:16.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2310
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4T3vjCl023285

Hi David,

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Tuesday, May 29, 2018 11:07 AM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; richardcochran@gmail.com; Claudiu Manoil
> <claudiu.manoil@nxp.com>; robh+dt@kernel.org
> Subject: Re: [PATCH 5/5] MAINTAINERS: add myself as maintainer for QorIQ
> PTP clock driver
> 
> From: Yangbo Lu <yangbo.lu@nxp.com>
> Date: Fri, 25 May 2018 12:40:38 +0800
> 
> > Added myself as maintainer for QorIQ PTP clock driver.
> > Since gianfar_ptp.c was renamed to ptp_qoriq.c, let's also maintain it
> > under QorIQ PTP clock driver.
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> 
> Because of the dependency on the staging tree changes, this doesn't apply
> cleanly to net-next.
> 
> You'll have to figure out how you want to sort this out.

[Y.b. Lu] I sent out a v2 MAINTAINERS patch. I think it also makes sense to drop dpaa2 rtc drivers in the entry.
Thanks a lot.
