Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753571AbeB0OOW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:14:22 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:62588 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753240AbeB0OOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:14:20 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515423600";
   d="scan'208";a="273635717"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
Thread-Topic: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
Thread-Index: AQHTr9Kltqdm2PoG7E68/YC+voS9LqO4STcAgAABB5A=
Date: Tue, 27 Feb 2018 14:14:15 +0000
Message-ID: <HK2PR0601MB13939B7510C1A4726197797CF5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
 <6abab0b5-72c5-0578-91aa-5d0c3867e53b@intel.com>
In-Reply-To: <6abab0b5-72c5-0578-91aa-5d0c3867e53b@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR0601MB1332;7:/EHcZGQP5F4cia0qiiJOVgallvmSeWsStUl798NX+d1PIJ1D/kDTumhGkfNXMObqHgBDSlmAjggaK+0YD4aP74OFuZQIqJSyhg5Q76wU47VS9bJAY3XXrHwTsOwBSI5LGDnsrYb9gA1yi/xFzabrJF9EOLmK6Otm/7vaFaularTZwwSQI9yuXhjRGqhzLyELHCRbzccArR1RfEjF2Fh6fgvdtVRL2CluSk9t9wmT7cXVdQTkJCde0qc5tVq4YTdG;20:xCQfB8dKMibprCFDyxDHehRIUZNW20jfJvJSbESZzmz/Vcc4AquUxHCqEXuEGIBVq56v7N2kpL+1ucWgpcnbF4EjuHvYx/9nEE8q4YUyWblQjf4XTILa3ZE5GfjKb55AQQJEptm7yWe0OZiD08KU2n/UqB97vWg/iIKyXPeif+A=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8b181bc-b260-435e-3c6a-08d57dec6285
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:HK2PR0601MB1332;
x-ms-traffictypediagnostic: HK2PR0601MB1332:
x-microsoft-antispam-prvs: <HK2PR0601MB13326D326E74DFF617A42D58F5C00@HK2PR0601MB1332.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501161)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HK2PR0601MB1332;BCL:0;PCL:0;RULEID:;SRVR:HK2PR0601MB1332;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(366004)(39860400002)(376002)(396003)(199004)(189003)(186003)(25786009)(8666007)(2906002)(54906003)(26005)(86362001)(76176011)(99286004)(74316002)(9686003)(5660300001)(7696005)(6306002)(5250100002)(55016002)(3846002)(8656006)(6436002)(6116002)(4326008)(3280700002)(478600001)(66066001)(316002)(7736002)(33656002)(97736004)(81156014)(8676002)(14454004)(81166006)(3660700001)(6246003)(229853002)(8936002)(59450400001)(106356001)(2950100002)(53936002)(2900100001)(6916009)(53546011)(102836004)(305945005)(105586002)(6506007)(966005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR0601MB1332;H:HK2PR0601MB1393.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Kkktjh58h7FG/tVDT/YVCUdBYJ+rUqEtxRBTz6CpLmP0gMS0RElHsnug+dIISOtV1CBOnDE6b4QsfunQ/rXs3TSIZpL5Iaz2jpKrnjUS8nMPyo7K0sReFFMuIWPguZeSpfEzbTsUMUzOQQch2qoyzv5YKgXq2t4GVGOrNQz/aO8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b181bc-b260-435e-3c6a-08d57dec6285
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 14:14:15.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1REETu6017186

Hi Adrian,

On 27 February 2018 14:08, Adrian Hunter wrote:
> On 27/02/18 15:55, Phil Edworthy wrote:
> > Since the controller does not support the end-of-busy IRQ, don't use it.
> > Otherwise, on older SD cards you will get lots of these messages:
> > "mmc0: Got data interrupt 0x00000002 even though no data operation was
> in progress"
> 
> SDHCI_QUIRK2_STOP_WITH_TC may be the quirk you want but it doesn't
> match your description.  SDHCI_QUIRK2_STOP_WITH_TC is when we always
> get a TC
> (end-of-busy) IRQ with the STOP command even when we didn't ask for
> one.
> Hence the TC interrupt (0x00000002) comes when we think we are already
> finished.
Right, thanks for clarifying, I'll fixup the message.

> >
> > This has been reported on Xilinx devices that also use the Arasan IP.
> > See https://patchwork.kernel.org/patch/8062871/
> >
> > This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> > b/drivers/mmc/host/sdhci-of-arasan.c
> > index c33a5f7..ab66e32 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data
> sdhci_arasan_pdata = {
> >  	.ops = &sdhci_arasan_ops,
> >  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> >  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> > -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> > +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> > +			SDHCI_QUIRK2_STOP_WITH_TC,
> >  };
> >
> >  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32
> > intmask)
> >
