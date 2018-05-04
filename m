Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeEDJh5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:37:57 -0400
Received: from mail-he1eur01on0110.outbound.protection.outlook.com ([104.47.0.110]:47008
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751269AbeEDJhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:37:53 -0400
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "stefan@agner.ch" <stefan@agner.ch>,
        "krzk@kernel.org" <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: tegra: Add support for 256 MB Colibri-T20
 (plus such board on Iris)
Thread-Topic: [PATCH v2] ARM: dts: tegra: Add support for 256 MB Colibri-T20
 (plus such board on Iris)
Thread-Index: AQHT4vCk47h5qV3BckuAqk8fndyFEaQfTBMAgAAFKIA=
Date: Fri, 4 May 2018 09:37:47 +0000
Message-ID: <1525426665.6296.7.camel@toradex.com>
References: <1525360112-9893-1-git-send-email-krzk@kernel.org>
         <c47c07b2c112219093b668c0b4d46ac8@agner.ch>
In-Reply-To: <c47c07b2c112219093b668c0b4d46ac8@agner.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com;
x-originating-ip: [84.227.20.26]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0501MB2459;7:uMYhtzEHWzBzTzwnlkkh0l0xKyxa1jRmK1u5tYTY8/VYt5Y69uUWHUjIa8UufpxDZxph9pDgNpx6fqSe0cofq5TMVcbG7OfW3GYjCI2nNcImnXqotwOLFWEGDywwtUZFqRiQUFheELD+REs7KBtLDUE4mp5rGaG4AGre3u4+Xv+h+udmFopBlsnBTotvtkQ8lpzFKL/l0Ccw6pqVJiCR3VeQe3pCxUj+wm0HeFMWuoYNDBsW5dnd094ng0+8iYyD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0501MB2459;
x-ms-traffictypediagnostic: HE1PR0501MB2459:
x-microsoft-antispam-prvs: <HE1PR0501MB2459B86AFB1E864750EE6526FB860@HE1PR0501MB2459.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0501MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2459;
x-forefront-prvs: 06628F7CA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(39380400002)(376002)(346002)(366004)(377424004)(189003)(199004)(316002)(6512007)(478600001)(3846002)(2906002)(6116002)(86362001)(105586002)(106356001)(3660700001)(97736004)(3280700002)(476003)(66066001)(14454004)(102836004)(2616005)(966005)(446003)(7736002)(7416002)(11346002)(26005)(2501003)(2900100001)(186003)(5660300001)(5250100002)(110136005)(4326008)(103116003)(54906003)(6436002)(486006)(36756003)(53936002)(6306002)(305945005)(25786009)(6506007)(81156014)(6246003)(53546011)(8676002)(44832011)(68736007)(8936002)(99286004)(81166006)(76176011)(229853002)(6486002)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0501MB2459;H:HE1PR0501MB2330.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: cg2HL1mL/AdcK7ZpNuu6ODEZikovDVW13gB6a2aekcz3WCvAgaHJM+5+OmdY9T9Vr8jNYP6rg9MEpiaLKh8LMScxwyV0JUiei2AM0qa3dxG3Or5msESCrHaDsFSy7qVpxPWiVKXSQHFI4xKI/ERHYUlvCBKt8vCnD++K5+rs5hsLAbUTLfc5DyN/M4sXXFGW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7F450C509846E428FFA0046778F25F7@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0f1559ce-7d44-4d29-5d85-08d5b1a2b250
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1559ce-7d44-4d29-5d85-08d5b1a2b250
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 09:37:47.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2459
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w449c1C1016139

Hi Krzysztof

On Fri, 2018-05-04 at 11:19 +0200, Stefan Agner wrote:
> On 03.05.2018 17:08, Krzysztof Kozlowski wrote:
> > Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
> > (with 1024 MB NAND) flavors.  Add support for the 256 MB version on
> > Iris
> > evaluation board.
> 
> To we really need to specify memory size these days? I think all
> common
> boot loaders fill the memory node anyway.
> 
> arch/arm/boot/dts/imx6qdl-apalis.dtsi:
> 	/* Will be filled by the bootloader */
> 	memory@10000000 {
> 		reg = <0x10000000 0>;
> 	};

Yes, both mainline as well as our downstream U-Boot do actually set the
memory node.

In the past some people used to set it to the smallest SKU's memory
size just to be on the safe side.

However lately it is agreed that the memory node should no longer even
be present as can be seen from e.g. arch/arm/boot/dts/tegra30-
apalis.dtsi resp. tegra30-apalis-eval.dts.

> I think we should just rename tegra20-colibri-512.dtsi =>
> tegra20-colibri.dtsi and tegra20-iris-512.dts => tegra20-iris.dts
> avoid confusion and add such an empty node.

I would rather suggest going to the regular SoC, module, carrier naming
convention making it tegra20-colibri-iris.dts instead.

> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Fix memory size in tegra20-colibri-256.dtsi (was working fine
> > because
> >    my bootloader uses mem= argument).
> 
> What boot loader are you using? You even can omit mem= if your boot
> loader fills the memory node properly.

Yes, using mem= should only be used to force memory size for test
purpose [1].

> --
> Stefan

[1] https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters
.html

Cheers

Marcel
