Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeC1IAX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:00:23 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:18702 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751166AbeC1IAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:00:20 -0400
X-IronPort-AV: E=Sophos;i="5.48,370,1517842800";
   d="scan'208";a="275094908"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
CC: Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] arm: Base support for Renesas RZN1D-DB Board
Thread-Topic: [PATCH v2 0/8] arm: Base support for Renesas RZN1D-DB Board
Thread-Index: AQHTwdPffaiw594zH0iLrq77afpZeKPlTsjQ
Date: Wed, 28 Mar 2018 08:00:10 +0000
Message-ID: <OSBPR01MB2054B502FE0D0777386C636BD2A30@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
In-Reply-To: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1766;7:Nv7ivv6rRTEcww//LuprTPQHQpRAuN9xb2H6Q8o6y3x3wQ47Xez6RZsdVm18kwcvSe876dhoPdPyjnJcak8L/Ff/bPb+4pMk1hb5TqzRbtM7CJ6T2dbPeBVKqY0PT3fITiKHlrMSiY/3ldy0qXO0mAtm7D1CaNbqMl14d7t4malZMaEMtBNwOwK+ysCiCxyIawJAGBcVY6nFhIDnDkAGLD9z7B1PIAB/P/vLRvhhkU/lTa2uOsbRGW0dp8HJ1VsZ;20:i2TAtPpn02F9YqlFtqGRvNlnT2AF8yXZRtUKqgj+tECnrw1LkPyUIQt0Czpkt4mI2hTyAHKSIuvxAsRM10zJ2F/BmIcLN33gzR0Usq9ZRRWJieHEvKmLr5lgHVAIbuAkBfP3TZLvkESoitxtrzQbfiiqruuURt0UHljy+uD3sCM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79ae5cad-5f41-4ec2-1acd-08d59481edd2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1766;
x-ms-traffictypediagnostic: OSBPR01MB1766:
x-microsoft-antispam-prvs: <OSBPR01MB1766C679CFCD13FBE622EB46D2A30@OSBPR01MB1766.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:OSBPR01MB1766;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1766;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(51914003)(189003)(199004)(39060400002)(3280700002)(53546011)(305945005)(4326008)(8936002)(6506007)(14454004)(9686003)(81156014)(3846002)(81166006)(478600001)(6116002)(5250100002)(316002)(74316002)(575784001)(76176011)(86362001)(486005)(486005)(25786009)(5660300001)(3660700001)(7736002)(68736007)(59450400001)(6246003)(2900100001)(229853002)(53936002)(99286004)(7696005)(110136005)(55016002)(45080400002)(102836004)(446003)(54906003)(8676002)(2501003)(106356001)(105586002)(97736004)(26005)(66066001)(7416002)(33656002)(6436002)(476003)(11346002)(2906002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1766;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
x-microsoft-antispam-message-info: 9vmlnbA8G7Hw80QnDVUNgBn4x9CNPkXjpwzP1zmroOalclvVdr8XHpXykIv8p0S+TsH3BYrOztR0CrrmYmbBpkPOng8yMDjw86C/0Z2bwxy4ivjTY9EdU5KDJQViI6UfXC+WgZwt8XbPjWph1xom+t/co5Uh1tSJMXhd7J2TzSuDXaPtmLrW8+9pnVhm5dUhawUsmgXI8puf+CEXB2fHp+ongL97MrB9zm5gMhAT+4eONNMMowSH2/Ygweiti8/S9LJqebtX7CgxVFZhSziPgthDda4aCEySTioHZOY2sEXS6DtZ2bmb7ubFi1ib5PMbwETuKVT/4VSZA3tqJmwE6A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ae5cad-5f41-4ec2-1acd-08d59481edd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 08:00:10.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1766
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2S80Til031323

Replying to myself here, more or less to reflect further discussion on IRC related to where the
bindings goes. Also, to publicly acknowledge and thank Geert for tons of advice and comments
outside the email chain...

So, after further discussion on IRC, that's what I've been trying to do
[hope outlook doesn't mangle this]:
+---------------------------------+     +------------------------------------+     +--------------------------------+
|          r9a06g0xx.dtsi         |     |         r9a06g032.dtsi             |     |     r9a06g032-rzn1d-db.dts     |
|                                 |     |                                    |     |                                |
|   compatible=                   |     |  compatible=                       |     | compatible=                    |
|         "renesas,rzn1";         |     |        "renesas,r9a06g032",        |     |       "renesas,rzn1d-db",      |
|                                 +----->        "renesas,rzn1";             +----->       "renesas,r9a06g032",     |
|   ...                           |     |  ...                               |     |       "renesas,rzn1";          |
|   compatible=                   |     |  compatible=                       |     |                                |
|         "renesas,rzn1-reset";   |     |        "renesas,r9a06g032-reset",  |     |                                |
|                                 |     |        "renesas,rzn1-reset";       |     |                                |
|                                 |     |                                    |     |                                |
+---------------------------------+     +------------------------------------+     +--------------------------------+
      Family File, "rzn1" only                  Future, potential SoC                          Board File
                                                Specific override file

The idea is that the 1D and 1S share /everything/ apart from one extra QSPI, no DDR, one less CPU
and a few other bits and bobs. So the r9a06g0xx.dtsi will contain 98% of both SoC bindings. *Perhaps*
later I could add a r9a06g03[23].dtsi for SoC specific bindings, but currently that is not necessary, so we
Won't need that file.

If everyone happy with this? I've got a v3 simmering on the fire, but I'd really like everyone to be
happy with the proposed solution...

Cheers,
Michel

On 22 March 2018 11:45, I wrote:
> This series adds the plain basic support for booting a bare kernel on the
> RZ/N1D-DB Board. It's been trimmed to the strict minimum as a 'base',
> further patches that will add the rest of the support, pinctrl, clock
> architecture and quite a few others.
>
> Thanks for the comments on the previous version!
>
> v2:
>  + Fixes for suggestions by Simon Horman  + Fixes for suggestions by Rob
> Herring  + Fixes for suggestions by Geert Uytterhoeven  + Removed the
> mach file  + Added a MFD base for the sysctrl block  + Added a regmap based
> sub driver for the reboot handler  + Renamed the files to match shmobile
> conventions  + Adapted the compatible= strings to reflect 'family' vs 'part'
>    distinction.
>  + Removed the sysctrl.h file entirelly.
>  + Fixed every warnings from the DTC compiler on W=12 mode.
>  + Split the device-tree patches from the code.
>
> Michel Pollet (8):
>   DT: mfd: renesas,rzn1-sysctrl: document RZ/N1 sysctrl node
>   DT: reset: renesas,rzn1-reboot: document RZ/N1 reboot driver
>   DT: arm: renesas,r9a06g032: add the RZ/N1 bindings
>   reset: Renesas RZ/N1 reboot driver
>   arm: rzn1: Add the RZ/N1 arch to the shmobile Kconfig
>   DT: arm: Add Renesas RZ/N1 SoC base device tree file
>   DT: arm: Add Renesas RZN1D-DB Board base file
>   DT: arm: Add the RZN1D-DB Board to Renesas Makefile target
>
>  Documentation/devicetree/bindings/arm/shmobile.txt |   5 +-
>  .../bindings/mfd/renesas,rzn1-sysctrl.txt          |  22 +++++
>  .../bindings/power/renesas,rzn1-reboot.txt         |  22 +++++
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts        |  26 +++++
>  arch/arm/boot/dts/r9a06g0xx.dtsi                   |  96 ++++++++++++++++++
>  arch/arm/mach-shmobile/Kconfig                     |   5 +
>  drivers/power/reset/Kconfig                        |   7 ++
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/rzn1-reboot.c                  | 109
> +++++++++++++++++++++
>  10 files changed, 293 insertions(+), 1 deletion(-)  create mode 100644
> Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
>  create mode 100644
> Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
>  create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
>  create mode 100644 arch/arm/boot/dts/r9a06g0xx.dtsi  create mode 100644
> drivers/power/reset/rzn1-reboot.c
>
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
