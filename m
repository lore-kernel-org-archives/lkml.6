Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeB0Obt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:31:49 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:50130 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753357AbeB0Obm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:31:42 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515423600";
   d="scan'208";a="273636983"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
Thread-Topic: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
Thread-Index: AQHTr9Kltqdm2PoG7E68/YC+voS9LqO4TqAAgAAAiOA=
Date: Tue, 27 Feb 2018 14:31:36 +0000
Message-ID: <HK2PR0601MB1393B39958A128DCB8CA0E44F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
 <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
In-Reply-To: <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2SPR00MB03;7:hMGOCZ8HQy0liWB+W82EEs6kXFkfKxHkRx51G0ppZg9isMxqjF4WhRBFgMTr4btEr8vRNnM+7ezTwxecVCkxWHVIUGeUM0Duh2hhPZCryuocyH0JmwEZ4bya+AR0D5VFWGINzgQczRR2hRdjIFOkjJQ1iKS9rR8Lrx0Ah5aDmlGpYQqncs96bJyib91OxK/aez1MzXZ2dOpxYBbxHgh6tUIOqHr9DiGOQmnDPJ2Fv3A9r3cCjCDXkwAirw9pVzMK;20:xZVDJ2lNT3+oviQk7I2UaQW0j68d2TqC/XM0sKWvcR2GN3CsyQkLQU10PMyyARbwMnSMNP4x8MsNLlLS2hPWzBE4EYnN3rKAv83hvKmn6JNXChs87B0/jiRcRb9cnGySMcV9R7pP96FXo49JzqcyJUEgH8DADVDQaz55JttwrK4=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b6cdd8d-9fc2-4463-c86a-08d57deeced7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HK2SPR00MB03;
x-ms-traffictypediagnostic: HK2SPR00MB03:
x-microsoft-antispam-prvs: <HK2SPR00MB0340A0F34C6CEB60C7E2A7F5C00@HK2SPR00MB03.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(52105095)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HK2SPR00MB03;BCL:0;PCL:0;RULEID:;SRVR:HK2SPR00MB03;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(346002)(396003)(39380400002)(376002)(189003)(199004)(4326008)(6436002)(8666007)(14454004)(305945005)(53936002)(9686003)(2900100001)(33656002)(6246003)(7736002)(966005)(478600001)(25786009)(66066001)(81166006)(105586002)(6306002)(2906002)(76176011)(3660700001)(229853002)(186003)(6916009)(2950100002)(26005)(59450400001)(55016002)(6506007)(102836004)(53546011)(86362001)(74316002)(8676002)(97736004)(68736007)(54906003)(3280700002)(5660300001)(316002)(99286004)(8936002)(81156014)(6116002)(3846002)(106356001)(5250100002)(8656006)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2SPR00MB03;H:HK2PR0601MB1393.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: /uW5pXiUw5nKkbfUFteI+lfjAIo3YmP4LyNtlqcEw2V7rgXxaW1rEBv8PBZLgQ+c1Au02UqK6WL2GIIrEd7xNFUKEbc2bVfowYxR5YoMosnc2iG6ZCjWx1eCJKHxWh8ZibDJaILjSl1va2XNcNd+LMyjckSg8XUlWpqedHMiPqw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6cdd8d-9fc2-4463-c86a-08d57deeced7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 14:31:36.7208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2SPR00MB03
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1REWBKq022934

Hi Shawn,

On 27 February 2018 14:28, Shawn Lin wrote:
> 在 2018/2/27 21:55, Phil Edworthy 写道:
> > Since the controller does not support the end-of-busy IRQ, don't use it.
> > Otherwise, on older SD cards you will get lots of these messages:
> > "mmc0: Got data interrupt 0x00000002 even though no data operation was
> in progress"
> >
> 
> I'm afraid you have to explain which version of arasan's IP suffer from this
> and what does the "older SD cards" mean?
Ok, I'll try to find out the IP version...
For "older SD cards", I can provide a list of a few cards that exhibit this problem
and others that don't, is that enough info?

Thanks
Phil

> > This has been reported on Xilinx devices that also use the Arasan IP.
> > See https://patchwork.kernel.org/patch/8062871/
> >
> > This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >   drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> > b/drivers/mmc/host/sdhci-of-arasan.c
> > index c33a5f7..ab66e32 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data
> sdhci_arasan_pdata = {
> >   	.ops = &sdhci_arasan_ops,
> >   	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> >   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> > -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> > +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> > +			SDHCI_QUIRK2_STOP_WITH_TC,
> >   };
> >
> >   static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32
> > intmask)
> >
> 
> 
> --
> Best Regards
> Shawn Lin
