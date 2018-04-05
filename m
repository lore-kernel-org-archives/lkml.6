Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDEJnA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:43:00 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:49368 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751195AbeDEJm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:42:57 -0400
X-IronPort-AV: E=Sophos;i="5.48,410,1517842800";
   d="scan'208";a="277312894"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michel Pollet" <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Topic: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Index: AQHTxqA8Q/Tp1OQLo0C0CX9dPZ3BD6PpTkCAgAigajA=
Date: Thu, 5 Apr 2018 09:42:46 +0000
Message-ID: <TY1PR01MB1769064C77AE3E5ABA4993DAF5BB0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
 <CAHp75VeOTjZ30ok1JOW0cefZfxqUM-f0-zpTnC5TonyeqQVUKg@mail.gmail.com>
In-Reply-To: <CAHp75VeOTjZ30ok1JOW0cefZfxqUM-f0-zpTnC5TonyeqQVUKg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0697;7:H92yXRoodEjWh91Q7O9Y9DelVjAHPJo4kDyUQ6AsH142UvBuD3qAR8riNElVwu5lMY3beFZrMgcw63LvMQCmFuD/mMNv3LcZzSDAXPgz4pkxYiJwGclS+yyuqQEloFK+XIc8pxzoEQWb/VkMOC0EJWiUf3wZSwbg2OkhJbcJNfH+tqyR83pvSxrpnpfDjzpCQjSFpLnPS1k69PZGQN9WFNo7ExMP7/76/hcdeyYdpiAYaFO+lbprkGlJe84oF41S;20:QECfHmDD8s/zs/pldVg2aXci2ef/fPxTmlKvlcuc56XiAazyPNehgQcM4kJQazq02wMpyKXOwRhnNICd4vE6/ggXWZ6tMD8QV/ZIzKOCaHhSLipck5ZfQ/AeY2OMIZiPzphvASf69igQHauaGiEXWqo2dmudS2u+ZyMo693ePv0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: c2d21190-2d4a-441f-188c-08d59ad99651
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0697;
x-ms-traffictypediagnostic: TY1PR01MB0697:
x-microsoft-antispam-prvs: <TY1PR01MB069782A8DAD3D6495360124BF5BB0@TY1PR01MB0697.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:TY1PR01MB0697;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0697;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39850400004)(376002)(396003)(189003)(199004)(102836004)(3280700002)(2906002)(3660700001)(6116002)(3846002)(105586002)(97736004)(6246003)(7696005)(106356001)(76176011)(99286004)(66066001)(26005)(9686003)(55016002)(39060400002)(53936002)(25786009)(4326008)(186003)(33656002)(14454004)(2900100001)(6436002)(478600001)(68736007)(8936002)(229853002)(486006)(74316002)(305945005)(8676002)(446003)(11346002)(6916009)(476003)(5660300001)(6506007)(316002)(5250100002)(86362001)(53546011)(81166006)(54906003)(81156014)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0697;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LDmZfuexRTCuq6XIcwfexY+CKSu8e/6pQaSYDzgyNVUF1GpFuxBiSvod/585rQV7FJGlA+C2cFEwog74m8jlzxsmmm6ZnLdduE/5jR2xo8I3b9EyW/uodhU8OTxgGWA/yGyFeiElavrNI4Fs+5qoeaf4ErfGON468+NQtawSaaDyOVqX94IMUCuwXBSXgARNcSG+twL82ttnwniHGSJ9eT9X9+qXMZW6JWFeEvwBn8QJBNnqSIhJ23PvfVLyR1HfzV42VrTcy412ugXaT+WXCgPc24zsG2/LCov95EHz6/cSfL9uIJLmX+emQHEBaUxa2Jbn9lhriEtU59qx/DhELycBKdN8wZe+iik+C4Lq6O8QrKfGEn+2kFO0LjyRQC/52eV+wKrVOYSY/VmZihiz9JoDhJA1Ncdx7ZcSCm/C5xI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d21190-2d4a-441f-188c-08d59ad99651
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 09:42:46.1396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0697
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w359h4tD008587

Hi Andy,

On 30 March 2018 22:26 Andy Shevchenko wrote:
> On Wed, Mar 28, 2018 at 5:22 PM, Phil Edworthy wrote:
> > The DesignWare GPIO IP can be configured for either 1 or 32
> > interrupts,
> 
> 1 to 32, or just a choice between two?
Just a choice of 1 or 32.
Note that by 'configured' I am talking about the hardware being configured in
RTL prior to manufacturing a device. Once made, you cannot change it.
This configuration affects the number of output interrupt signals from the GPIO
Controller block that are connected to an interrupt controller.

> > but the driver currently only supports 1 interrupt. See the DesignWare
> > DW_apb_gpio Databook description of the 'GPIO_INTR_IO' parameter.
> 
> Will see after holiday and perhaps make more comments. Here is just a brief
> review.
> 
> > +- interrupts : The interrupts to the parent controller raised when
> > +GPIOs
> > +  generate the interrupts. If the controller provides one combined
> > +interrupt
> > +  for all GPIOs, specify a single interrupt. If the controller
> > +provides one
> > +  interrupt for each GPIO, provide a list of interrupts that
> > +correspond to each
> > +  of the GPIO pins. When specifying multiple interrupts, if any of
> > +the GPIOs are
> > +  not connected to an interrupt, use the interrupt-mask property.
> > +- interrupt-mask : a 32-bit bit mask that specifies which interrupts
> > +in the list
> > +  of interrupts is valid, bit is 1 for a valid irq.
> 
> So, but why one will need that in practice? GPIO driver usually provides a pin
> based IRQ chip which maps each pin to the corresponding offset inside
> specific IRQ domain.
On an ARM device we have this GPIO block connected to the GIC interrupt
controller, i.e. the Synopsys GPIO controller interrupts can* have a 1 to 1
mapping to the GIC interrupts. At the moment, the GPIO driver only allows a
single irq signal to specified.
* this is not strictly accurate on the device I am working on, there is another
block of IP between the two, but that doesn't matter in this case.

> > +                       struct device_node *np = to_of_node(fwnode);
> > +                       u32 irq_mask = 0xFFFFFFFF;
> 
> Why? Shouldn't it be dependent to the amount of actual pins / ports?
> Intel Quark has only 8 AFAIR.
It's just a default which can be overridden via device tree.
For Quark, since you currently only use a single irq, I guess the HW was
configured that way. In which case, you wouldn't use any of this.

> > +                       int j;
> > +
> > +                       /* Optional irq mask */
> > +                       fwnode_property_read_u32(fwnode,
> > + "interrupt-mask", &irq_mask);
> > +
> > +                       /*
> > +                        * The IP has configuration options to allow a single
> > +                        * combined interrupt or one per gpio. If one per gpio,
> > +                        * some might not be used.
> > +                        */
> 
> > +                       for (j = 0; j < pp->ngpio; j++) {
> > +                               if (irq_mask & BIT(j)) {
> 
> for_each_set_bit() is in kernel for ages!
There's lot of stuff in the kernel for ages that I can't remember!
I'll fix this :)

> > +                                       pp->irq[j] = irq_of_parse_and_map(np, j);
> > +                                       if (pp->irq[j])
> > +                                               pp->has_irq = true;
> > +                               }
> > +                       }
> 
> 
> So, on the first glance the patch looks either superfluous or taking wrong
> approach. Please, elaborate more why it's done in this way and what the
> case for all this in practice.
Hopefully I have explained it a bit better above.

Thanks for your comments
Phil
