Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754790AbeD3O5h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:57:37 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:54519
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754363AbeD3O5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:57:32 -0400
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
Subject: RE: [PATCH v2 2/3] Documentation: bluefield-dw-mshc: add DT
 description
Thread-Topic: [PATCH v2 2/3] Documentation: bluefield-dw-mshc: add DT
 description
Thread-Index: AQHT2xjSFVeQYZReFU+KFPzqHmwju6QVC+KAgARkzfA=
Date: Mon, 30 Apr 2018 14:57:28 +0000
Message-ID: <AM2PR05MB075369C92FE1416271895F51A1820@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <7505274f8d82642fd08e874160acd45be2418673.1524497286.git.lsun@mellanox.com>
 <20180427195049.ycjmhes4qj4n3myq@rob-hp-laptop>
In-Reply-To: <20180427195049.ycjmhes4qj4n3myq@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com;
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM2PR05MB0724;7:aFddnHzUCPoIt4nP76Xh0gKMGFWLmDxST3CV91pnZeVH9lqg+YfLzG6MyM+rohrViMkh/s5HyQfkKS8ldupyWPNynOPs98joJFrSyvzC1d4ej2lnTkphgFlHqNFAND4IvvI6I6XCg1nFIP2atd+1GgHGnuR6eJv8pjY3dAPWvQgK5vt6r7CXjyQ06BBzLthBwAFjmv0Xmh/IR1Ucl0J6fG3bXCxLx0wwMr855M3p6hN0SzuGf6/x+ZazFjducYp/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM2PR05MB0724;
x-ms-traffictypediagnostic: AM2PR05MB0724:
x-microsoft-antispam-prvs: <AM2PR05MB072472D0C36DEC76F188C074A1820@AM2PR05MB0724.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM2PR05MB0724;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB0724;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39380400002)(376002)(396003)(39860400002)(13464003)(189003)(199004)(6246003)(33656002)(4326008)(305945005)(68736007)(74316002)(8936002)(7736002)(66066001)(55016002)(105586002)(25786009)(106356001)(9686003)(6116002)(97736004)(3846002)(8676002)(81166006)(81156014)(53936002)(478600001)(5250100002)(2900100001)(7696005)(99286004)(486006)(76176011)(6916009)(86362001)(575784001)(3280700002)(3660700001)(6506007)(446003)(476003)(102836004)(59450400001)(316002)(26005)(14454004)(54906003)(6436002)(186003)(2906002)(229853002)(5660300001)(53546011)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB0724;H:AM2PR05MB0753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: AXsmc1efBj7KxyMv1h03Ssx1icL7aJ1ryN+24iXsyAu9FuySHOPtLPZPf9zbcKNXmesaHNv/TCN/kR6D+3eE2fEjbBkWpCqBNXqdI2wVHPehpFVJ4scscDjyRYpNM5rIJ+kKtAPRU6bHb0ZXbCFsnOL5k9vZRSfiOgipmuXDSeSukNEc1yx82W8FzhKiKyjg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 94082dd0-9160-4f0a-66a0-08d5aeaab13d
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94082dd0-9160-4f0a-66a0-08d5aeaab13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 14:57:28.3432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB0724
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3UEvkdj030491

Thanks. Updated in v3 2/3.

- Liming

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, April 27, 2018 3:51 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/3] Documentation: bluefield-dw-mshc: add DT
> description
> 
> On Mon, Apr 23, 2018 at 11:32:21AM -0400, Liming Sun wrote:
> > This commit adds "mellanox,bluefield-dw-mshc" for dwmmc driver
> > extension on Mellanox BlueField SoC platform.
> 
> "dt-bindings: mmc: " is preferred subject prefix.
> 
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
> mmc@...
> 
> Doesn't look like a correct unit-address either.
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
