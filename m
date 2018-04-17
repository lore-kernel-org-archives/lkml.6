Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeDQH4u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:56:50 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:42984 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750967AbeDQH4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:56:47 -0400
X-IronPort-AV: E=Sophos;i="5.48,462,1517842800";
   d="scan'208";a="277021300"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "buserror+upstream@gmail.com" <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "Sebastian Reichel" <sre@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v4 3/8] dt-bindings: mfd: renesas,rzn1-sysctrl: document
 RZ/N1 sysctrl node
Thread-Topic: [PATCH v4 3/8] dt-bindings: mfd: renesas,rzn1-sysctrl: document
 RZ/N1 sysctrl node
Thread-Index: AQHT0Kb43gWmL//VvUuE1bdBET3duKP/AsyAgAWdP6A=
Date: Tue, 17 Apr 2018 07:56:40 +0000
Message-ID: <OSBPR01MB20548CE7A728549EFA2B9ADBD2B70@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523349015-37985-4-git-send-email-michel.pollet@bp.renesas.com>
 <20180413180549.yjzkl2yf7osz7myt@rob-hp-laptop>
In-Reply-To: <20180413180549.yjzkl2yf7osz7myt@rob-hp-laptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2230;7:S00+sh3D74opkYrAAyfQFEbFXXaTm5qumgI/jIi1gt4HRQxLnC+I6nXAm2Xcw5F5bZx2pdwovtWc2AW1xygOkB6FvPSkLXjouTM2tt9Ys48r97NhVAoTt/3+oJoo85D6J8K/S5Q/iUtTx8/cBhbZfIG+4dwFaoc7FsYQ/2/DoQEhJaSUZ/qFlTLD9LZtz0H8w2r6XN0LbySDEBBuosGQlVihwZzZfpCOeMsvjLbvqbNe0Hr36OSyb9wmB8FSci2i;20:bC3dobANPmJqVEuDwlO0O2OtPTxjUYR3wce3Rr9cuSwms3/iXhSN7bS9GhsK5CpARunOPpSsG1VCqiRmjZhgGA9gPgm7sCnwwWC/86F47ARxqQCjuYrd9/dTn5S+UroWCqC3s2VWsTLzbUEKpprxj5MRkCMhSEI76Ckj9YEoSaY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2230;
x-ms-traffictypediagnostic: OSBPR01MB2230:
x-microsoft-antispam-prvs: <OSBPR01MB223006435870854222ABA205D2B70@OSBPR01MB2230.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:OSBPR01MB2230;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2230;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(366004)(39380400002)(376002)(199004)(189003)(99286004)(25786009)(106356001)(76176011)(105586002)(2900100001)(186003)(6506007)(4326008)(9686003)(39060400002)(68736007)(316002)(53936002)(66066001)(110136005)(55016002)(5660300001)(229853002)(6246003)(6436002)(14454004)(44832011)(5250100002)(81156014)(8936002)(2906002)(8676002)(81166006)(7416002)(26005)(7736002)(7696005)(3660700001)(3846002)(6116002)(305945005)(97736004)(486006)(86362001)(11346002)(3280700002)(33656002)(476003)(54906003)(74316002)(478600001)(575784001)(446003)(102836004)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2230;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-microsoft-antispam-message-info: l0UjbdpdwR/xBWwPDWni3l9fhQ/9ePa9HgM17vOZ/N+02OzaU7h8cGDSssRIPX9PoP0zYaaCN+ar65ku1ucfDRIIsKpfmMKczA0zzSQOYdKXYrVoC8oGgdyQE5T5/eLrzzRU8QY9S7nW22wEY/YzKK9E1tPgslka4Tpb60HKeohYnSOFjgTLRQM5AAO/rq3r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c6af94bb-3d46-426c-6b24-08d5a438c11b
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6af94bb-3d46-426c-6b24-08d5a438c11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 07:56:40.5529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2230
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3H7usdL029088

Hi Rob,

On 13 April 2018 19:06, Rob Herring:
> On Tue, Apr 10, 2018 at 09:30:03AM +0100, Michel Pollet wrote:
> > The Renesas RZ/N1 Family (Part #R9A06G0xx) has a multi-function system
> > controller. This documents the node used to encapsulate it's sub
> > drivers.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > ---
> >  .../bindings/mfd/renesas,rzn1-sysctrl.txt          | 23
> ++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> > b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> > new file mode 100644
> > index 0000000..9897f8f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> > @@ -0,0 +1,23 @@
> > +DT bindings for the Renesas RZ/N1 System Controller
> > +
> > +== System Controller Node ==
> > +
> > +The system controller node currently only hosts a single sub-node to
> > +handle the rebooting of the CPU. Eventually it will host the clock
> > +driver, SMP start handler, watchdog etc.
>
> Please submit a complete binding for the h/w block.
>
> Again, if the only reason you have sub nodes is to define compatible strings
> and in turn enumerate drivers, then you don't need the nodes in DT. DT is
> not the only way to instantiate drivers.

I can't document it before I have the code. There is 0.000% chance of my clock
driver for example to be upstreamed the way I would imagine making it -- in
fact pretty much any other driver will have to be reworked to fit, so documenting
bindings first is impossible.

So, if I understand correctly, you are telling me to make a 'sysctrl' driver and use
platform_device to instantiate my sub-drivers? Isn't that what machine files used
to do? And they are now banned?

Geert, any guidance here?

>
> Rob

Thanks!
Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
