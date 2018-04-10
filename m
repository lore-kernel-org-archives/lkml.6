Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeDJHIy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:08:54 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:44354 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751812AbeDJHIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:08:51 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517842800";
   d="scan'208";a="277744025"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Rob Herring <robh@kernel.org>
CC: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "Sebastian Reichel" <sre@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1
 reboot driver
Thread-Topic: [PATCH v3 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1
 reboot driver
Thread-Index: AQHTxzLJTLeNtSYpW02PKtQLtrUFtKP47zSAgAC2BEA=
Date: Tue, 10 Apr 2018 07:08:45 +0000
Message-ID: <OSBPR01MB2054DA948D0301F20AB9F1EDD2BE0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-3-git-send-email-michel.pollet@bp.renesas.com>
 <20180409201027.ydlvyx72mrt5fphh@rob-hp-laptop>
In-Reply-To: <20180409201027.ydlvyx72mrt5fphh@rob-hp-laptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1575;7:oy8/8h6F6UG6uJm4AY6y5rahk4+Ro4LXTHkmFL6kZ4Bx08CkZgwh+ELmURyiMqG95I7o7BnIAqkR3a1yWgIYfv4pweX6H1qOhw4Ba/+ukypIUMi+QBwGSvyLS0YCi+sD4NLJQvNip7uGkVq/E6XO6en7DGaVNHziVEz1Cs9hM6FJGqvUWYl59RpsgVsc74Z8tIkbMLJd0I/bWWycvqD+zEQN4a75xN0Zx49qNEVP3gNRvq09PdwA8i96/rnEXpz9;20:n4VDDz4MUb1xE4jSj9G9Xio6AJt6lPEHhLOpCjoTHp2i40AWye5ejBZ2VpXRPXFYkkEs/nJcWEQZs4gu6+Xg9niJRbC25sPFYfibkXUccRnIHtBy3WIzoGWksLzc+Ng8An3//enluoT3rAXhdao3CSQPbdA0kWZhhrmIT0aQ2eM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 999cddd4-068a-48c5-558a-08d59eb1e6fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1575;
x-ms-traffictypediagnostic: OSBPR01MB1575:
x-microsoft-antispam-prvs: <OSBPR01MB1575E8F94897F9AAD491A1ECD2BE0@OSBPR01MB1575.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:OSBPR01MB1575;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1575;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(76176011)(486006)(9686003)(186003)(55016002)(316002)(7736002)(39060400002)(3660700001)(305945005)(33656002)(229853002)(7696005)(476003)(8676002)(6436002)(6506007)(14454004)(7416002)(26005)(105586002)(74316002)(102836004)(25786009)(5660300001)(6116002)(3846002)(8936002)(86362001)(5250100002)(2900100001)(6246003)(11346002)(446003)(54906003)(53546011)(68736007)(575784001)(478600001)(4326008)(106356001)(2906002)(97736004)(66066001)(81156014)(6916009)(3280700002)(99286004)(81166006)(53936002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1575;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-microsoft-antispam-message-info: 711O2lS88AMQR6jUtUJzIrLfROva2/5Lbuutn1a0zHR8NXYWhVF48ZjXZnbpdWkLBJWMaIrcIIXO8BhR/r7BaVLqGiY2lg5QeXnRbgryHtV77k9lbb9XrZDNkYCbPbWDzlIUkcWZXQRt3KZuyVcFmoI0T3lLqTN60mZ4RoZAwqmkAct9dlpix1oCAV6GEFJsPKSQdpz/iZHc59FBtr0h5qkeV0G60fCS6oSmjCTJWwPNn0axoWgBf6P6arkc2U/FUZQlLOqTR2YXdEKrt5GnRxM9VeCY6mE7XoldWd8c/HlA5AmxELPEVN/djy8blA9c3R2F2Pv6sM7vKBRFESsqkhwDuHmrZgwIuig/+WJ65b/7KP1/kZxd9IEpUhIN6z5rrWybJJvCVmzJZdel6dclwAyEnKLY3Efq89I2zperWZg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999cddd4-068a-48c5-558a-08d59eb1e6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 07:08:45.8083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1575
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3A7B2Aj000863

Hi Rob,

On 09 April 2018 21:10,  Rob Herring wrote:
> On Thu, Mar 29, 2018 at 08:46:58AM +0100, Michel Pollet wrote:
> > The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver as part
> > of the sysctrl MFD to handle rebooting the CA7 cores.
> > This documents the driver bindings.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > ---
> >  .../bindings/power/renesas,rzn1-reboot.txt           | 20
> ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> > b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> > new file mode 100644
> > index 0000000..f592769
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/renesas,rzn1-
> reboot.txt
> > @@ -0,0 +1,20 @@
> > +DT bindings for the Renesas RZ/N1 Reboot Driver
> > +
> > +== Reboot Driver Node ==
> > +
> > +The reboot driver is always a subnode of the system controller node,
> > +see renesas,rzn1-sysctrl.txt for details.
> > +
> > +Bindings:
> > ++ Required:
> > +compatible = "renesas,rzn1-reboot";
> > +
> > +Example:
> > +sysctrl: sysctrl@4000c000 {
> > +compatible = "renesas,rzn1-sysctrl", "syscon", "simple-mfd";
>
> Are there other functions for this block? If so, please define a complete
> binding for the block.

There are indeed multiple functions for this particular IP block. It's pretty much a
kitchen sink of clocks, pinmux, reboot, watchdog, SMP and probably a couple
more I forgot about!

We've discussed this MFD structure with Geert, we picked that because if I
were to add all these callbacks/drivers to a 'sysctrl' driver, it'd end up looking
like ... a mach-xx.c file in the end!
So the current version is just a placeholder for a single driver for now, but it
won't last, there's already a SMP core enable driver lined up next...

>
> > +reg = <0x4000c000 0x1000>;
> > +
> > +reboot {
> > +compatible = "renesas,rzn1-reboot";
>
> Why is this node needed? The driver for "renesas,rzn1-sysctrl" should be
> able to register as a reboot handler/driver/provider.

Please see above...

>
> Rob

Thanks for your input!
Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
