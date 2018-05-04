Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeEDKOy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:14:54 -0400
Received: from mail-eopbgr40138.outbound.protection.outlook.com ([40.107.4.138]:56397
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750707AbeEDKOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:14:52 -0400
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
Thread-Index: AQHT4vCk47h5qV3BckuAqk8fndyFEaQfTBMAgAAMYQCAAAMdgA==
Date: Fri, 4 May 2018 10:14:47 +0000
Message-ID: <1525428885.6296.18.camel@toradex.com>
References: <1525360112-9893-1-git-send-email-krzk@kernel.org>
         <c47c07b2c112219093b668c0b4d46ac8@agner.ch>
         <CAJKOXPeb+DmKVQ1uXkBOjaGMpxtPVFp54SBWm6h=+o30z9K3aQ@mail.gmail.com>
In-Reply-To: <CAJKOXPeb+DmKVQ1uXkBOjaGMpxtPVFp54SBWm6h=+o30z9K3aQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com;
x-originating-ip: [84.227.20.26]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0501MB2236;7:xjpedbWpXDP+YFAGNvfdF6l69wXaZ0xqX33MmTNM+x9lAXt98CgF4lvDrCOD/p5/hzHFqi49uY46Hizj8LDgyEnrINLFJuHg2iLchE3TzcSMsNE4yGNtvB+yxEp2ruqhYH4XyKW32ap5QBAgOKEzT2Pn4ZHgHejytX2gKLUuHTOlLTLaGskmFDJt6fjcC9eoFWuCKHJnfraUNf6b8Be9yqzhnlZYt4+Uee2j8Q2V1Slld4jm6QZeTVv7mX+P+5y2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0501MB2236;
x-ms-traffictypediagnostic: HE1PR0501MB2236:
x-microsoft-antispam-prvs: <HE1PR0501MB2236B8E1EF000CF827E95EADFB860@HE1PR0501MB2236.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0501MB2236;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2236;
x-forefront-prvs: 06628F7CA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39840400004)(366004)(376002)(346002)(396003)(377424004)(189003)(199004)(97736004)(3280700002)(99286004)(8676002)(81166006)(81156014)(6512007)(6506007)(76176011)(2900100001)(53546011)(86362001)(3660700001)(14454004)(106356001)(2906002)(7736002)(103116003)(68736007)(229853002)(305945005)(39060400002)(316002)(478600001)(105586002)(6246003)(25786009)(6436002)(6486002)(36756003)(4326008)(44832011)(6116002)(3846002)(5660300001)(2616005)(476003)(446003)(11346002)(7416002)(486006)(110136005)(5250100002)(8936002)(102836004)(2501003)(26005)(66066001)(53936002)(54906003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0501MB2236;H:HE1PR0501MB2330.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rv/uZCs3Rv9prHAJ3xh0n13CJAYJY3vfczl7Ck8pdhhHwOlHgfzz4ftpSdQ1e22VKW4bJQlg2WOh2MhOnb3h6g8BFpvXZ5XylWj2lPSeX1aYU7Sf+g2rLBDvqzaElr3fgrry1+gLeZHb8/6WfFmPPnuQ1f9iJVdCyb5lo/WcdzqWZmsupZWgKX8s5sq+oiTQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <927B0483E71C84488A18CDFD34B32129@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 63ef9652-3067-40fd-8fb1-08d5b1a7dda2
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ef9652-3067-40fd-8fb1-08d5b1a7dda2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 10:14:47.7616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2236
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w44AEwPX019699

Hi Krzysztof

On Fri, 2018-05-04 at 12:03 +0200, Krzysztof Kozlowski wrote:
> On Fri, May 4, 2018 at 11:19 AM, Stefan Agner <stefan@agner.ch>
> wrote:
> > On 03.05.2018 17:08, Krzysztof Kozlowski wrote:
> > > Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB
> > > RAM
> > > (with 1024 MB NAND) flavors.  Add support for the 256 MB version
> > > on Iris
> > > evaluation board.
> > 
> > To we really need to specify memory size these days? I think all
> > common
> > boot loaders fill the memory node anyway.
> > 
> > arch/arm/boot/dts/imx6qdl-apalis.dtsi:
> >         /* Will be filled by the bootloader */
> >         memory@10000000 {
> >                 reg = <0x10000000 0>;
> >         };
> > 
> > 
> > I think we should just rename tegra20-colibri-512.dtsi =>
> > tegra20-colibri.dtsi and tegra20-iris-512.dts => tegra20-iris.dts
> > to
> > avoid confusion and add such an empty node.
> 
> Having memory node is requirement of DeviceTree specification (at
> least one cpu and memory node). Of course if bootloader fills it,
> then
> we could assume that specification is satisfied... but what if some
> bootloader skips it? This creates quite specific dependency between
> kernel's DTS and bootloader.

Yes, no system boots without any boot loader e.g. initialising the
memory and what not. So there are obviously quite specific
dependencies.

> One safe solution would be to specify 256 MB memory node for both
> boards and assume that bootloader will bump it to 512 MB for specific
> module.

Like I mentioned this actually used to be how it was done however
lately it has been agreed that any boot loader anyway needs to do the
device tree dance (e.g. even just loading and passing it).

> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > 
> > > ---
> > > 
> > > Changes since v1:
> > > 1. Fix memory size in tegra20-colibri-256.dtsi (was working fine
> > > because
> > >    my bootloader uses mem= argument).
> > 
> > What boot loader are you using? You even can omit mem= if your boot
> > loader fills the memory node properly.
> 
> I use the one provided by vendor - Toradex. By default it passes both
> mem= and few other mem-like arguments (for FB and video processor) to
> command line. I believe it does not adjust the DTB itself because
> Toradex prepared this bootloader for... 3.1 kernel without DTB. 7
> years old kernel. :)

Remember our regular BSP is still based on NVIDIA's downstream Linux
for Tegra aka L4T R16.5 based on Linux kernel 3.1.10 which does not
even use any device tree yet.

> Best regards,
> Krzysztof

Cheers

Marcel
