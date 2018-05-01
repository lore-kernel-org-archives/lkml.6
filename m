Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756079AbeEAOgO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:36:14 -0400
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:20512
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755663AbeEAOgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:36:11 -0400
From: Liming Sun <lsun@mellanox.com>
To: Rob Herring <robh@kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] dt-bindings: mmc: Add binding for BlueField SoC
Thread-Topic: [PATCH v3 2/3] dt-bindings: mmc: Add binding for BlueField SoC
Thread-Index: AQHT4JMapdyzhLo67kSp+fT/4CBfX6Qa1B8AgAAdUiA=
Date: Tue, 1 May 2018 14:36:06 +0000
Message-ID: <AM2PR05MB07537F51DC0670BF67E79AD2A1810@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525099868-45094-2-git-send-email-lsun@mellanox.com>
 <20180501124800.GA6206@rob-hp-laptop>
In-Reply-To: <20180501124800.GA6206@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM2PR05MB1169;7:JPhemFNfG5I19ntVTHcMV48XsMBGTajZn71neFEg4usxAaFs4Fbq1/NUKbHdrR594hKNDUVHFqSSooL1fyk4+We/KU7ic1q+kfKTsjJw3ZjsbWJK2B3IIV0np4T54eN7NPM61u6jhDoMDBt1JR9s4/AsU56AD/bq9rbL7z2nwvGi4dANuUldjPhisuO1rT/SS+NWY1ktLaRkgwQYd48dgkMPK3mHx5TMAK9x5AI/jSMmKmFFYSQv/pHjXQE32NLS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM2PR05MB1169;
x-ms-traffictypediagnostic: AM2PR05MB1169:
x-microsoft-antispam-prvs: <AM2PR05MB1169352AE383F643FB8F68ADA1810@AM2PR05MB1169.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM2PR05MB1169;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB1169;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(39380400002)(366004)(199004)(189003)(13464003)(55016002)(74316002)(7736002)(105586002)(106356001)(8936002)(6246003)(6916009)(53936002)(14454004)(305945005)(33656002)(5660300001)(9686003)(229853002)(5250100002)(2906002)(6436002)(6346003)(26005)(3660700001)(186003)(66066001)(446003)(486006)(7696005)(81166006)(11346002)(54906003)(76176011)(575784001)(86362001)(102836004)(25786009)(6116002)(476003)(3846002)(2900100001)(3280700002)(81156014)(478600001)(316002)(97736004)(68736007)(59450400001)(4326008)(8676002)(99286004)(6506007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB1169;H:AM2PR05MB0753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com;
x-microsoft-antispam-message-info: ed3iOAqEUjGdUXjQAB1+1DI7HN8D0GO55wOqFrZYuYT/NlVGbH0U7QackPM3EdoJnRNtsffshI2D8heXTRyHuEng5xw8i0CmNHCiYvfJubKuNV+ka4t7aKjbAnHQZSUttAigcgYbMvJMiCHIjHd/FO6o48nivYHrPXMuptSaTj4mkBV7HPqwy/IB+kko6KnT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fcd8c41a-96a7-4afe-fad1-08d5af70dfe9
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd8c41a-96a7-4afe-fad1-08d5af70dfe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 14:36:06.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB1169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41EaKan018633

Sorry, my mistake. I missed the last one in the v3 comments.
Fixed it in v4 2/3.

Thanks,
Liming

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, May 1, 2018 8:48 AM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: Add binding for BlueField SoC
> 
> On Mon, Apr 30, 2018 at 10:51:07AM -0400, Liming Sun wrote:
> > This commit adds "mellanox,bluefield-dw-mshc" for dwmmc driver
> > extension on Mellanox BlueField SoC platform.
> >
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > ---
> >  .../devicetree/bindings/mmc/bluefield-dw-mshc.txt  | 29
> ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/bluefield-
> dw-mshc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/bluefield-dw-
> mshc.txt b/Documentation/devicetree/bindings/mmc/bluefield-dw-
> mshc.txt
> > new file mode 100644
> > index 0000000..ee0dd61
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
> > @@ -0,0 +1,29 @@
> > +* Mellanox Bluefield SoC specific extensions to the Synopsys Designware
> > +  Mobile Storage Host Controller
> > +
> > +Read synopsys-dw-mshc.txt for more details
> > +
> > +The Synopsys designware mobile storage host controller is used to
> interface
> > +a SoC with storage medium such as eMMC or SD/MMC cards. This file
> documents
> > +differences between the core Synopsys dw mshc controller properties
> described
> > +by synopsys-dw-mshc.txt and the properties used by the Mellanox
> Bluefield SoC
> > +specific extensions to the Synopsys Designware Mobile Storage Host
> Controller.
> > +
> > +Required Properties:
> > +
> > +* compatible: should be one of the following.
> > +  - "mellanox,bluefield-dw-mshc": for controllers with Mellanox Bluefield
> SoC
> > +    specific extensions.
> > +
> > +Example:
> > +
> > +	/* Mellanox Bluefield SoC MMC */
> > +	dwmmc0@4,0 {
> 
> Still the same issues.
> 
> mmc@...
> 
> And the unit-address looks wrong.
> 
> > +		compatible = "mellanox,bluefield-dw-mshc";
> > +		reg = <4 0x8000 0x400>;
> > +		interrupts = <32>;
> > +		fifo-depth = <0x100>;
> > +		clock-frequency = <24000000>;
> > +		bus-width = <8>;
> > +		cap-mmc-highspeed;
> > +	};
> > --
> > 1.8.3.1
> >
