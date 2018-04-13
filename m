Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbeDMIYq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:24:46 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:48052 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754076AbeDMIYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:24:40 -0400
X-IronPort-AV: E=Sophos;i="5.48,444,1517842800";
   d="scan'208";a="278097022"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Michel Pollet" <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: Update Synopsys GPIO
 interrupts
Thread-Topic: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: Update Synopsys GPIO
 interrupts
Thread-Index: AQHT0v60qgJ58lwXlEapH/3DuTSWuaP+WoeAgAAAr8A=
Date: Fri, 13 Apr 2018 08:24:30 +0000
Message-ID: <TY1PR01MB176970ECD9C66DCF865E5C17F5B30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1523606900-2332-1-git-send-email-phil.edworthy@renesas.com>
 <1523606900-2332-3-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdVKi=dDvn29U-S26PtAc_Um_+1Oy=PzKAgYUSU9qvcF-Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVKi=dDvn29U-S26PtAc_Um_+1Oy=PzKAgYUSU9qvcF-Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0636;7:H8S/niOMPYRe6ZDu2EIcgP0aj2UlpTq+nvk+cgqU5vt+12AtyqAdKH1e+2ovyxgiHCn3TLTpdf6lb9qNJv2P88jsLT5JidjHEcSb30CJpfOqxlLlFM+7f54XzNtBIlF5q/A21yCcsOoSvPQhaaXz0GcqZ4zQhenfiLvuCFogDjlUF4H2SWoihM6gRomrza5+qm5apnwGGM23pTQEOUVCXOMBZMStm2n8jAE0ARnPpYZbcjS5BiGLdbiz3HFva7ph;20:Vjb7SZ3CZTa6no34H8sAFoX3rxDU7Bu+2DlYBPVIpNdPk/yI2WouVe/43IzkadHHvMEe1QVpmICaDvoJRCUJin9sqL+MGVrvlXBK+fSgwydhAekLck1ptRVgfxtPdPc3fZ6dnWCgoMDcrhf/8lXPmSSnEGKt/s4X+VAEgUxqeN4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0636;
x-ms-traffictypediagnostic: TY1PR01MB0636:
x-microsoft-antispam-prvs: <TY1PR01MB0636A82FA7BF5C0394822D95F5B30@TY1PR01MB0636.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR01MB0636;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0636;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(199004)(189003)(2906002)(3280700002)(2900100001)(8936002)(39060400002)(81156014)(81166006)(53936002)(54906003)(3660700001)(102836004)(8676002)(15760500003)(5660300001)(86362001)(9686003)(55016002)(99286004)(6916009)(186003)(5250100002)(7696005)(229853002)(6506007)(59450400001)(6436002)(53546011)(7416002)(316002)(76176011)(26005)(106356001)(14454004)(68736007)(305945005)(105586002)(11346002)(25786009)(4326008)(446003)(15650500001)(7736002)(6246003)(66066001)(486006)(33656002)(44832011)(97736004)(74316002)(6116002)(3846002)(478600001)(476003)(70780200001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0636;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +5yKOHsmWwel/+iQdtBPqSr+Y3JREhGvUlY41cBs57mK0+mTgmRTPNS/paQhAtX0eXtskzpBNFNm88uaDo6YYX88eKJl0mRvyqufP7cMtjRjuKQYokLiFz3vAvNUqw0Z2TO2WkgbyjqbRSu6s322i0MC6eoFpVuqN3I+mxidyWeix1Q2w3tWrcn6eId0e9+A
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 61a75e2e-2e1c-4a84-8bf8-08d5a117fab5
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a75e2e-2e1c-4a84-8bf8-08d5a117fab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 08:24:30.3596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0636
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3D8OqDG015786

Hi Geert,

On 13 April 2018 09:20 Geert Uytterhoeven wrote:
> On Fri, Apr 13, 2018 at 10:08 AM, Phil Edworthy wrote:
> > Since the way the Synopsys GPIO interrupts are stored has changed,
> > this driver needs to be updated in line with the changes.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v2:
> >  - New patch in v2 to fix the only other user of struct
> dwapb_port_property.
> 
> Thanks for your patch!
> 
> To avoid bisection compile failures due to the changed type of
> dwapb_port_property.irq, I think this should be folded into the first patch,
Right, thanks for pointing this out!
Phil

> > ---
> >  drivers/mfd/intel_quark_i2c_gpio.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/intel_quark_i2c_gpio.c
> > b/drivers/mfd/intel_quark_i2c_gpio.c
> > index 90e35de..5bddb84 100644
> > --- a/drivers/mfd/intel_quark_i2c_gpio.c
> > +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> > @@ -233,7 +233,8 @@ static int intel_quark_gpio_setup(struct pci_dev
> *pdev, struct mfd_cell *cell)
> >         pdata->properties->idx          = 0;
> >         pdata->properties->ngpio        = INTEL_QUARK_MFD_NGPIO;
> >         pdata->properties->gpio_base    = INTEL_QUARK_MFD_GPIO_BASE;
> > -       pdata->properties->irq          = pdev->irq;
> > +       pdata->properties->irq[0]       = pdev->irq;
> > +       pdata->properties->has_irq      = true;
> >         pdata->properties->irq_shared   = true;
> >
> >         cell->platform_data = pdata;
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-
> m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
