Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753977AbeB0PFx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:05:53 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:14417 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752573AbeB0PFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:05:50 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515423600";
   d="scan'208";a="272291789"
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
Thread-Index: AQHTr9Kltqdm2PoG7E68/YC+voS9LqO4TqAAgAAAiOCAAAN1gIAABH5g
Date: Tue, 27 Feb 2018 15:05:46 +0000
Message-ID: <HK2PR0601MB139380F295EF5CE849288F91F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
 <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
 <HK2PR0601MB1393B39958A128DCB8CA0E44F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
 <b725dcf5-2f53-dab7-1e0c-85ea138f54a9@rock-chips.com>
In-Reply-To: <b725dcf5-2f53-dab7-1e0c-85ea138f54a9@rock-chips.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR0601MB1873;7:D93x1FM9couwjHXpIy0dWdQaMHCjQW8vfHm7UazxfCVsD882wTrJue5fA/V7SRwHweRz5vwxgAvxXAmr4XbZ8Lxw5z0KPUxM8YcI+4sJnFuSnoMVyFj5A33BqY8SDZ9iie4W521KHdUUNf55hz9+t4+PtCM20QrCThIS7r9VgzYCz4S9TkHABJrtH/9R27+HUe7Xh9MFPaW5sOhejXZ87V7KptH3+wKyQhZcj/OtzhiUlMn0+nv5aHstShN/YgbD;20:n9ve5Az0tyzugHrryKZ/GQlITWuVYgDWI9IWyBFIqoT4kPMYZbHavBFwZF0qwUKRTvjNEXc8LJkrpCOgMagA+mL4zh9KUQm+KlsPNsGEIJd1i7lBJ4jZVsFEbxv/VXhcR21elPY+GPbIGsjOuF4MHKt5lxlHJ42WPltSPsN7f2c=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfe82109-fb01-4542-e059-08d57df394d4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:HK2PR0601MB1873;
x-ms-traffictypediagnostic: HK2PR0601MB1873:
x-microsoft-antispam-prvs: <HK2PR0601MB187374CF028D12F22107624AF5C00@HK2PR0601MB1873.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501198)(52105095)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HK2PR0601MB1873;BCL:0;PCL:0;RULEID:;SRVR:HK2PR0601MB1873;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39380400002)(366004)(39860400002)(189003)(199004)(68736007)(86362001)(25786009)(5250100002)(4326008)(2900100001)(33656002)(66066001)(229853002)(5660300001)(74316002)(3660700001)(305945005)(7736002)(6916009)(2950100002)(8666007)(9686003)(55016002)(6306002)(8936002)(8676002)(93886005)(478600001)(8656006)(54906003)(6436002)(2906002)(106356001)(97736004)(53546011)(6246003)(76176011)(6506007)(3846002)(53936002)(14454004)(3280700002)(186003)(6116002)(99286004)(7696005)(316002)(102836004)(59450400001)(966005)(105586002)(26005)(6346003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR0601MB1873;H:HK2PR0601MB1393.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-microsoft-antispam-message-info: vI45IffnMlkJh3v4yGTcwreIs9DKuYzuJWWhwV3W3I8GNduV10sJ9iSG4Cl09yF3GegkJ4qrAcdYqga/punfnPqRaFUxxXi19saO7kAxixCz1Fio/Hl29xzF195LF0o+qEIeIdYM9Qab7HNO+e8zJSmbR/sjwH5j2VJyOOvZuAw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe82109-fb01-4542-e059-08d57df394d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 15:05:46.9136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1873
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1RF6J83006366

Hi Shawn,

On 27 February 2018 14:42, Shawn Lin wrote:
> On 2018/2/27 22:31, Phil Edworthy wrote:
> > Hi Shawn,
> >
> > On 27 February 2018 14:28, Shawn Lin wrote:
> >> 在 2018/2/27 21:55, Phil Edworthy 写道:
> >>> Since the controller does not support the end-of-busy IRQ, don't use it.
> >>> Otherwise, on older SD cards you will get lots of these messages:
> >>> "mmc0: Got data interrupt 0x00000002 even though no data operation
> >>> was
> >> in progress"
> >>>
> >>
> >> I'm afraid you have to explain which version of arasan's IP suffer
> >> from this and what does the "older SD cards" mean?
> > Ok, I'll try to find out the IP version...
> > For "older SD cards", I can provide a list of a few cards that exhibit
> > this problem and others that don't, is that enough info?
> 
> What I meant is could you elaborate more about what kind of cards, e.g, are
> them the  legacy SDSC cards or SDHC cards, or maybe they are only running
> with defaut speed? or whatever, but not just with a vague "older" cards. :)
Unfortunately, I have one SDHC card that works, one that doesn't. Both cards
are running with a 50MHz SD clock. All I know is this:

SD cards that report unexpected interrupts:
2GB Sandisk Extreme III                     (e624 SD02G 1.89 GiB)
8GB Sandisk (SDHC class 4)              (aaaa SU08G 7.40 GiB)
8GB Sandisk Extreme III (SDHC class 6)    (bb4e SD08G 7.61 GiB)

SD cards that work ok:
16GB Samsung (microSDHC U1 class 10)          (0001 00000 14.6 GiB)
16GB Sandisk Ultra (microSDHC U1 class 10)    (aaaa SL16G 14.8 GiB)
32GB Sandisk Ultra (microSDHC U1 class 10)    (aaaa SL32G 29.7 GiB)

Thanks
Phil

> >>> This has been reported on Xilinx devices that also use the Arasan IP.
> >>> See https://patchwork.kernel.org/patch/8062871/
> >>>
> >>> This has been tested on the Renesas RZ/ND-DB board with the RZ/N1
> SoC.
> >>>
> >>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >>> ---
> >>>    drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> >>> b/drivers/mmc/host/sdhci-of-arasan.c
> >>> index c33a5f7..ab66e32 100644
> >>> --- a/drivers/mmc/host/sdhci-of-arasan.c
> >>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> >>> @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data
> >> sdhci_arasan_pdata = {
> >>>    	.ops = &sdhci_arasan_ops,
> >>>    	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> >>>    	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> >>> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> >>> +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> >>> +			SDHCI_QUIRK2_STOP_WITH_TC,
> >>>    };
> >>>
> >>>    static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32
> >>> intmask)
> >>>
> >>
> >>
> >> --
> >> Best Regards
> >> Shawn Lin
> >
> >
> >
> >
> 
> 
> --
> Best Regards
> Shawn Lin
