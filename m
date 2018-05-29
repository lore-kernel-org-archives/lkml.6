Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934409AbeE2Ndg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:33:36 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:61758 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933721AbeE2Ndb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:33:31 -0400
X-IronPort-AV: E=Sophos;i="5.49,456,1520866800";
   d="scan'208";a="282417758"
From: Biju Das <biju.das@bp.renesas.com>
To: Simon Horman <horms@verge.net.au>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: "arm@kernel.org" <arm@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "ionela.voinescu@arm.com" <ionela.voinescu@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 13/15] arm: dts: r8a7743: Add missing OPP properties for
 CPUs
Thread-Topic: [PATCH 13/15] arm: dts: r8a7743: Add missing OPP properties for
 CPUs
Thread-Index: AQHT9BPTpWyazdkMskeAodPjaLQVjKRE4u8AgAAaioCAABDMAIABnWzA
Date: Tue, 29 May 2018 13:33:25 +0000
Message-ID: <OSBPR01MB2103A3411D0C3C5DB76F715EB86D0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <5821a6dbe413b5a217ca1e24ddf8ebfa63ba6ef0.1527244201.git.viresh.kumar@linaro.org>
 <20180528092331.3jon45nsqfdzs5ds@verge.net.au>
 <20180528105831.vesrswazlagynemq@vireshk-i7>
 <20180528115832.b2wovvanypxkgalj@verge.net.au>
In-Reply-To: <20180528115832.b2wovvanypxkgalj@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2181;7:OUNNx3WtSn8GoLlTYgXDxlTTQJWqVUHlWixiY/aOTAeMJXqmio9LuIWpEGlx6kxvLbFgcdOpUp4S30jdUpt50Bgd5xHjEiMBNWxoUlx3zASLsVJKCzgdsI1XHCR3ea2z5DA+maf3t6KTcY10SqwutUEYmYnqX3e04By/b+Kp+Ub192lXVczvspOIqYk810utHYyyDQpyANCHDsU35Gf7laWX2iQO/nDJ5aHVAUvWtLDGp4F1qJdFLaKqxLiizsvu;20:/x+XAqt/npMcO2/A0XJ2o+zG8ZDWm+a9IAXZK7Ms4O6Y2EUvHf6LpyLZgd4CMx2uvEvz+pDw7etD6SygPnNWCC75cJ2b4sspXvKn+7le5L62jI8mYApiynCiGv6JLfaBCxTEpVfsqUP4uvmmlQncrMQo8K0OmL+xYw/c0LUtVgQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2181;
x-ms-traffictypediagnostic: OSBPR01MB2181:
x-microsoft-antispam-prvs: <OSBPR01MB21815DF582616506EDEA9C9DB86D0@OSBPR01MB2181.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(209352067349851)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB2181;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2181;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(39380400002)(396003)(13464003)(377424004)(199004)(53754006)(189003)(5250100002)(478600001)(305945005)(59450400001)(8936002)(9686003)(97736004)(229853002)(93886005)(53936002)(53546011)(486006)(5660300001)(6506007)(14454004)(81156014)(66066001)(4326008)(81166006)(8676002)(6246003)(102836004)(3280700002)(186003)(74316002)(26005)(2906002)(25786009)(7736002)(3660700001)(7696005)(110136005)(316002)(44832011)(476003)(39060400002)(105586002)(76176011)(68736007)(54906003)(33656002)(7416002)(6436002)(55016002)(106356001)(99286004)(446003)(2900100001)(86362001)(6116002)(3846002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2181;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-microsoft-antispam-message-info: xuJ3sHAvDIkhplQhv8WWlWW6AgAJS/rw6moZf+lsSuar5HCMOHP5lgs+LO6RxGnKW0LzK+NADCeFiWzN3K1ws+KC2bO5CMe57ymHrpup+9itmrbQRo1WCm8GFtih8u9jkJLfQnnhJBUvsFg5dmqBapP4JxTEbj/gxBawk9B6FdKRZJLdNVl8mWkOhB00TaZN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f95394f3-3d00-4179-be82-08d5c568c17a
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95394f3-3d00-4179-be82-08d5c568c17a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 13:33:25.4235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TDXcAa024989

Hi All,

I have tested this patch on RZ/G1M and I didn't find any issues. r8a7743 is similar to r8a7791. So I assume you will apply the same patch for other R-SoC devices as well.

Apart from this, maybe we need to update the OPP binding documentation. i.e., extend the  operating- point usage to other cores in the cluster (Binding 1: operating-points).

Regards,
Biju

> -----Original Message-----
> From: Simon Horman [mailto:horms@verge.net.au]
> Sent: 28 May 2018 12:59
> To: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: arm@kernel.org; Magnus Damm <magnus.damm@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Vincent Guittot <vincent.guittot@linaro.org>; ionela.voinescu@arm.com;
> Daniel Lezcano <daniel.lezcano@linaro.org>; chris.redpath@arm.com; linux-
> renesas-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [PATCH 13/15] arm: dts: r8a7743: Add missing OPP properties for
> CPUs
>
> On Mon, May 28, 2018 at 04:28:31PM +0530, Viresh Kumar wrote:
> > On 28-05-18, 11:23, Simon Horman wrote:
> > > [Cc Biju Das]
> > >
> > > On Fri, May 25, 2018 at 04:01:59PM +0530, Viresh Kumar wrote:
> > > > The OPP properties, like "operating-points", should either be
> > > > present for all the CPUs of a cluster or none. If these are
> > > > present only for a subset of CPUs of a cluster then things will
> > > > start falling apart as soon as the CPUs are brought online in a
> > > > different order. For example, this will happen because the
> > > > operating system looks for such properties in the CPU node it is
> > > > trying to bring up, so that it can create an OPP table.
> > > >
> > > > Add such missing properties.
> > > >
> > > > Fix other missing property (clock latency) as well to make it all
> > > > work.
> > > >
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > > Thanks, this looks good to me and it looks like it should have:
> > >
> > > Fixes: 0417814ea140 ("ARM: dts: r8a7743: Add OPP table for frequency
> > > scaling")
> >
> > Sure.
> >
> > Will you be picking this patch directly and send it part of your pull
> > request ? Maybe add Fixes tag then only ?
>
> Yes, that is my plan. I can handle adding the Fixes tag.
> But I'll wait to see if Bjiu has an feedback first.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
