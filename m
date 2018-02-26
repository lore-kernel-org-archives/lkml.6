Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbeBZFIL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 00:08:11 -0500
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:63488
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750748AbeBZFII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 00:08:08 -0500
From: Ran Wang <ran.wang_1@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andy Tang <andy.tang@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/3] arm64: dts: ls1012a: add cpu idle support
Thread-Topic: [PATCH 1/3] arm64: dts: ls1012a: add cpu idle support
Thread-Index: AQHToLTgsxEkvv7hDUKwvjthljXWqqOzLw4AgAANPgCAAwGNwA==
Date: Mon, 26 Feb 2018 05:08:04 +0000
Message-ID: <AM3PR04MB14893117A4351047456D5D5BF1C10@AM3PR04MB1489.eurprd04.prod.outlook.com>
References: <20180208075436.38443-1-ran.wang_1@nxp.com>
 <20180224062514.GB3217@dragon> <20180224071239.GC3217@dragon>
In-Reply-To: <20180224071239.GC3217@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com;
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1252;7:CYFhbvIygnpy1my5LIXwBJW53vsix8DKIkL4oVZzzSTVFTxZLkG1KucCjoEngSaFreQNXQKiWwUH+KP9+srG16qcNqGBnALeAYS7HO7PN7rgo6Gjz1vonNVexl45mpACfJEsFIOhPvpxr8sTzWPCaMlls1NzRaDG3rvzkLD+vu6+tSCLFcB5ALSAAfsCxZGxfL0ndOjnncr94f7hO+DU7TDN96004epDFk0UsNwY+Cqm8Wx/AYK/UI1x6is/zsDw
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(39380400002)(396003)(189003)(199004)(13464003)(6916009)(2950100002)(55016002)(186003)(9686003)(8936002)(81156014)(8676002)(81166006)(33656002)(26005)(97736004)(2900100001)(66066001)(6436002)(53546011)(3280700002)(74316002)(2906002)(316002)(305945005)(3846002)(6116002)(7736002)(99286004)(3660700001)(105586002)(5250100002)(7696005)(68736007)(54906003)(5660300001)(14454004)(478600001)(6246003)(102836004)(76176011)(53936002)(25786009)(106356001)(6506007)(4326008)(86362001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1252;H:AM3PR04MB1489.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a76c7c06-1df3-4edd-504a-08d57cd6ea91
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB1252;
x-ms-traffictypediagnostic: AM3PR04MB1252:
x-microsoft-antispam-prvs: <AM3PR04MB125276AD178D737EE24FB922F1C10@AM3PR04MB1252.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501161)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1252;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1252;
x-forefront-prvs: 05954A7C45
x-microsoft-antispam-message-info: PZnBhmvsn4jZFldZW+c3pejZVZdViBA2yu5OSZ6Gi45LHhCATvF5uGGB4UF6FumzGvRZ11Mql1QMamlmZ+ftIiAaQ5sn0BbJpHn+gZ4Shs+bhNx0nPrB3SAkGCHmQsCqPIkqP+8Dmczg89kBK9bIm867uUV/oyhgtbVP2Iai6UE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76c7c06-1df3-4edd-504a-08d57cd6ea91
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 05:08:04.2093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1Q58Ivc007989

Hi Shawn,

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Saturday, February 24, 2018 3:13 PM
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Mark Rutland <mark.rutland@arm.com>; devicetree@vger.kernel.org; Andy
> Tang <andy.tang@nxp.com>; Catalin Marinas <catalin.marinas@arm.com>; Will
> Deacon <will.deacon@arm.com>; linux-kernel@vger.kernel.org; Leo Li
> <leoyang.li@nxp.com>; Rob Herring <robh+dt@kernel.org>; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 1/3] arm64: dts: ls1012a: add cpu idle support
> 
> On Sat, Feb 24, 2018 at 02:25:16PM +0800, Shawn Guo wrote:
> > On Thu, Feb 08, 2018 at 03:54:34PM +0800, Ran Wang wrote:
> > > From: Yuantian Tang <andy.tang@nxp.com>
> > >
> > > Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   18 ++++++++++++++++++
> > >  1 files changed, 18 insertions(+), 0 deletions(-)
> >
> > Applied all, thanks.
> 
> Ran,
> 
> Just noticed that these patches are authored by Yuantian.  When you send
> patches authored by someone else, you should have your SoB added to it.
> 
> I just append your SoB below to all 3 patches.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Got it, thanks!

Ran
