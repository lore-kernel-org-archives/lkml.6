Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeCEFSw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:18:52 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:60342 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751543AbeCEFSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:18:44 -0500
X-IronPort-AV: E=Sophos;i="5.47,426,1515423600";
   d="scan'208";a="272850879"
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] phy: rcar-gen3-usb2: Add support for r8a77965
Thread-Topic: [PATCH 1/2] phy: rcar-gen3-usb2: Add support for r8a77965
Thread-Index: AQHTr4/Yi/M9yjZcXUulM9Qqv7QkdKO8nh8AgASFYwA=
Date: Mon, 5 Mar 2018 05:18:39 +0000
Message-ID: <TY1PR06MB0992C3B78E86E32B60B36735D8DA0@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <1519710747-26435-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1519710747-26435-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <046ceb88-56a1-56d3-5945-026597822aa0@ti.com>
In-Reply-To: <046ceb88-56a1-56d3-5945-026597822aa0@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com;
x-originating-ip: [211.11.155.139]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR06MB0765;7:mokWUuz/8G3koqu0K2u7zbfviltSgjF0IZYpFPqYxl10BsknqcVLERdijkp0pWeOIbVrN5UNO24xKPgk6nG2qF1oo07Te49JgmYrV6g+YkgLqVYXjok+qHQ7qaILZDitS0SFNqAME3LBXsvdUQpCrYYcKPpcpgHLECA58lW7C9ccSBxPWeVJtJ5iltve9ZWGJZck2lYfyHgZRNUjFe95R2satIFaYLJs6KOgme4r+9yLNxZXExMFmyL+G7nX0x1Q;20:6eW5Lt6sK96aVewnryPxAIWkhhZW4zvaLZKx9tjso72zyz+QBfxWoP9Kq8Ukk1aWJFmtURP69OqA/skBa+W1yKu0yv/TBKWHhhkQ68yvu5j3banvFz9xjf14kI8yMpifHGdqoYDJzyfjhBUneKn03TgTIlhNUmmElEJz9atn+5M=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cf7b7cc-8632-4a4f-a0b4-08d582588e43
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:TY1PR06MB0765;
x-ms-traffictypediagnostic: TY1PR06MB0765:
x-microsoft-antispam-prvs: <TY1PR06MB0765D227C4FFD9E8AA71E0FED8DA0@TY1PR06MB0765.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:TY1PR06MB0765;BCL:0;PCL:0;RULEID:;SRVR:TY1PR06MB0765;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(2906002)(2900100001)(9686003)(102836004)(2950100002)(26005)(5660300001)(305945005)(7736002)(77096007)(3846002)(6116002)(74316002)(229853002)(7696005)(66066001)(76176011)(99286004)(33656002)(2501003)(6506007)(14454004)(478600001)(3280700002)(105586002)(110136005)(54906003)(55016002)(6436002)(6246003)(53936002)(8936002)(81166006)(8676002)(81156014)(316002)(106356001)(186003)(68736007)(97736004)(86362001)(3660700001)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR06MB0765;H:TY1PR06MB0992.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: x1dKo8Jiht/4Pod09ARqUw9ucVjKSuXn3agXU7CBW3+TaDNrwDBtgCKAONCBRZK1vd6pA0ljf80HX6NkrYp/CWWy/GaM+w31gAfuW9BbG1ChIfFJa+hYZybWMiGHXVubrugo8u8F4WftaqTY+hZ+1/CdfZoQziD7ImI5WP9vB8Ilv9imj9q9zSVXB1x2LK4dLbzslGDU9/NjQBYOf8/+ZR1/TVLs/TAGTq63L3AXd0sH8hWpHrWG/4682xvho9pL0j7pRDc0PzWiJQcQ+m74uTfyzE9UaJgaNCPGaG7KA8je1QiUosGyl9idbnqhKFMv4FQwTFEeiIDISx0LSDxxMg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf7b7cc-8632-4a4f-a0b4-08d582588e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 05:18:39.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR06MB0765
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w255ItpD009812

Hi,

> From: Kishon Vijay Abraham I, Sent: Friday, March 2, 2018 5:15 PM
> 
> On Tuesday 27 February 2018 11:22 AM, Yoshihiro Shimoda wrote:
> > This patch adds support for r8a77965 (R-Car M3-N). This SoC has
> > dedicated pins.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
> >  drivers/phy/renesas/phy-rcar-gen3-usb2.c                     | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > index 99b651b..dbd137c 100644
> > --- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > @@ -8,6 +8,8 @@ Required properties:
> >  	      SoC.
> >  	      "renesas,usb2-phy-r8a7796" if the device is a part of an R8A7796
> >  	      SoC.
> > +	      "renesas,usb2-phy-r8a77965" if the device is a part of an
> > +	      R8A77965 SoC.
> 
> have dt-binding Documentation as a separate patch.

I will fix this in v2.

Best regards,
Yoshihiro Shimoda

> Thanks
> Kishon
