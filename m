Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeC1HoO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:44:14 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:63647 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752848AbeC1HoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:44:10 -0400
X-IronPort-AV: E=Sophos;i="5.48,370,1517842800";
   d="scan'208";a="276484717"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2 3/8] DT: arm: renesas,r9a06g032: add the RZ/N1 bindings
Thread-Topic: [PATCH v2 3/8] DT: arm: renesas,r9a06g032: add the RZ/N1
 bindings
Thread-Index: AQHTwdPuTX4YR6F4f0q+f7Er2m2uwKPcMVKAgAkbFvA=
Date: Wed, 28 Mar 2018 07:44:03 +0000
Message-ID: <OSBPR01MB2054832DF4C7ACB15F49C129D2A30@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
 <1521719091-25157-4-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdXaRarxors3E-Jv7TLjka-p9XGYCTKyF7jM3p+UemgO+w@mail.gmail.com>
In-Reply-To: <CAMuHMdXaRarxors3E-Jv7TLjka-p9XGYCTKyF7jM3p+UemgO+w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2134;7:VU1cULhaHucVDQtxwzdVTcM158QXzWB8NwHjaBR7RgfyD/ww4VHcSSQiH46KzBRo0i5Ob+lIu2pBzGcJULZHIXyCvD5SlpK22muIXN/2/QrzWegqM6M1exuEACaJC3WIr6hu4G2btwrl90pA8NbIZwWberRNUIXSOy0qupbRboiN2ju58C6dVMhinwQXeSvKeCoop1jfocsgyyflF4Mc9iuBtzHROgQXz8fIJ/pai3oZR4NxYEz/9t/DpqVNIJoT;20:OWKZyoEeFWwtwnt2ca022GR7bwSTzCE71jbTFYYulhzIGp0aBbVMDhR46ccyp1uwrRO/Yp6TWumIYwryY4Jy62nNfCerYoRGkDxTzm1uG6ph1vwa1/snxshydCMcbnmmXWb2GVXa6/DSg1dciUOc8xS9w3n3PqC1DaA+5r7H1ms=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04ec0bc6-9d5e-45ba-9239-08d5947fadb5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2134;
x-ms-traffictypediagnostic: OSBPR01MB2134:
x-microsoft-antispam-prvs: <OSBPR01MB213410219D5AF42FA452D7A1D2A30@OSBPR01MB2134.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:OSBPR01MB2134;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2134;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(39380400002)(346002)(366004)(189003)(199004)(76176011)(229853002)(486005)(316002)(99286004)(54906003)(26005)(86362001)(575784001)(7696005)(102836004)(53936002)(3660700001)(6436002)(186003)(6246003)(2906002)(53546011)(6506007)(3280700002)(81166006)(66066001)(486005)(3846002)(6116002)(106356001)(8676002)(11346002)(81156014)(446003)(476003)(39060400002)(4326008)(6916009)(105586002)(7736002)(25786009)(97736004)(14454004)(5660300001)(2900100001)(74316002)(8936002)(305945005)(7416002)(478600001)(68736007)(33656002)(5250100002)(9686003)(55016002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2134;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
x-microsoft-antispam-message-info: 1c2BvybgyfX8xHsgQqp5LFKwj2XrgJd8IcPCM/8QjlCvXgN3wZJrxRtJWqof8Am5zxCJyn/0drM5Qxw5qdlpq0t5dKzPFBxowxZu/BUau/IqsEquuM8sFQl7KUsA6SOIdR8GqOMoiM/knqVAVz2hXrXF/UOFWfWsFNcg9rZB8dDZ8VG+MTZdGKP6d8IwGF8ASf4XS4O+0n2XLQtOZBubTXnO0FvdQVcUfr4dfUUB8BHmq2dOxenLNyjIRQRiQ+gzYUUaTc5CTNgAOoaj08u0U5q3zOsmiiGXZdpeuTMZuOV8zbcvi6PZpDGuIr2A7tJ5vlgKztw36yLmKaGpf+ENBA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ec0bc6-9d5e-45ba-9239-08d5947fadb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 07:44:03.6877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2S7iLCO027897

Hi Geert,

Thanks for your review!

On  22 March 2018 12:37, Geert said:
> Hi Michel,
>
> On Thu, Mar 22, 2018 at 12:44 PM, Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > This documents the RZ/N1 bindings for both the RZ/N1 and the
> > RZN1D400-DB board.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> > +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> > @@ -47,7 +47,8 @@ SoCs:
> >      compatible = "renesas,r8a77980"
> >    - R-Car D3 (R8A77995)
> >      compatible = "renesas,r8a77995"
> > -
> > +  - RZ/N1D (R9A06G032)
> > +    compatible = "renesas,r9a06g032"
> >
> >  Boards:
> >
> > @@ -104,6 +105,8 @@ Boards:
> >      compatible = "renesas,porter", "renesas,r8a7791"
> >    - RSKRZA1 (YR0K77210C000BE)
> >      compatible = "renesas,rskrza1", "renesas,r7s72100"
> > +  - RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
>
> The official board part number (between parentheses) should be
> YCONNECT-IT-RZN1D?

I've checked this, and the YCONNECT is the /base board/ for this 'module', the module
is called RZN1D-DB.

>
> > +    compatible = "renesas,rzn1d400-db", "renesas,r9a06g032"
> >    - Salvator-X (RTP0RC7795SIPB0010S)
> >      compatible = "renesas,salvator-x", "renesas,r8a7795"
> >    - Salvator-X (RTP0RC7796SIPB0011S)
>
> Gr{oetje,eeting}s,
>
>                         Geert

Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
