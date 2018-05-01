Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756492AbeEATKb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:10:31 -0400
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:1248
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756272AbeEATK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:10:27 -0400
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
Subject: RE: [PATCH v4 2/3] dt-bindings: mmc: Add binding for BlueField SoC
Thread-Topic: [PATCH v4 2/3] dt-bindings: mmc: Add binding for BlueField SoC
Thread-Index: AQHT4VmwAT7MpJ9v9EOsZgmgeF92vKQbDyIAgAAuBGA=
Date: Tue, 1 May 2018 19:10:22 +0000
Message-ID: <AM2PR05MB0753E1D0ADA97E687EDD59C6A1810@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525185155-24469-2-git-send-email-lsun@mellanox.com>
 <20180501162446.GA10012@rob-hp-laptop>
In-Reply-To: <20180501162446.GA10012@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com;
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM2PR05MB0724;7:8tq34+BhlZXg3XkO0tIdMesvEGDAaLi/h1ay8OIaXcJMQ4UNPgiOd3nNs36+kVaAo4fiF2+V9xy6ir6gPzSKJuLSKfV3ENzZYo6HofMCcx86PFphFxq70TQTulCOiyDEBcQc3TLTv8UlzMHZVIloX2kYionSfVkPP2j0I4fmBR8tiKgDLeCeSypCKJwVueh1vfCN5Meb6krzf1fdYtxeqmSb3XwdGSsow6BGC9BsqOAmqi+ucwpDorcW4lBxne0I
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM2PR05MB0724;
x-ms-traffictypediagnostic: AM2PR05MB0724:
x-microsoft-antispam-prvs: <AM2PR05MB0724D7A2098D690429585336A1810@AM2PR05MB0724.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM2PR05MB0724;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB0724;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(366004)(13464003)(199004)(189003)(8936002)(86362001)(59450400001)(3280700002)(446003)(6506007)(5250100002)(54906003)(3660700001)(186003)(476003)(7696005)(76176011)(99286004)(2900100001)(486006)(6916009)(53546011)(2906002)(316002)(11346002)(5660300001)(102836004)(14454004)(229853002)(26005)(6436002)(33656002)(74316002)(66066001)(7736002)(55016002)(8676002)(6246003)(68736007)(305945005)(4326008)(3846002)(97736004)(6116002)(81166006)(25786009)(53936002)(81156014)(105586002)(9686003)(478600001)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB0724;H:AM2PR05MB0753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Cb91YleI0coYMk9yTFC7jipHLC7gKNTeYlAXH6kk8f+pxOYSFH/GU3MvVll6KAHGiARSk9z5AGPh2QZRyh0TVuDOwCwWK7bk4Zi6Sgf3Rxo14o9KaSJwjArjGK7fZSJxpTzoxOEEsS8ldy1MaIvfITjnRAJcJ7heI4BIHNeQO3pzi7zSEiALzsYaqTJ99okE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6abe7cec-66f1-4aff-a95a-08d5af973018
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abe7cec-66f1-4aff-a95a-08d5af973018
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 19:10:22.3075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB0724
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41JAZsu023630

Thanks! Updated in v5 2/3.

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, May 1, 2018 12:25 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 2/3] dt-bindings: mmc: Add binding for BlueField SoC
> 
> On Tue, May 01, 2018 at 10:32:34AM -0400, Liming Sun wrote:
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
> > index 0000000..75bd844d
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
> > +	mmc@0x6008000 {
> 
> Drop the '0x'.
> 
> Building your dtb with 'W=1' will warn on this.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> > +		compatible = "mellanox,bluefield-dw-mshc";
> > +		reg = <0x6008000 0x400>;
> > +		interrupts = <32>;
> > +		fifo-depth = <0x100>;
> > +		clock-frequency = <24000000>;
> > +		bus-width = <8>;
> > +		cap-mmc-highspeed;
> > +	};
> > --
> > 1.8.3.1
> >
