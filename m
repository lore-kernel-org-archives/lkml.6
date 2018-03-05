Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCEQrf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:47:35 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:46145 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751275AbeCEQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:47:30 -0500
X-IronPort-AV: E=Sophos;i="5.47,427,1515423600";
   d="scan'208";a="272905942"
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
Thread-Index: AQHTr9Kltqdm2PoG7E68/YC+voS9LqO4TqAAgAAAiOCAAAN1gIAABH5ggAC3FQCACNF7AA==
Date: Mon, 5 Mar 2018 16:47:25 +0000
Message-ID: <HK2PR0601MB139301F701386BB74CF369E2F5DA0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
 <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
 <HK2PR0601MB1393B39958A128DCB8CA0E44F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
 <b725dcf5-2f53-dab7-1e0c-85ea138f54a9@rock-chips.com>
 <HK2PR0601MB139380F295EF5CE849288F91F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
 <52191012-300a-e13d-fa54-8717eb97c2e1@rock-chips.com>
In-Reply-To: <52191012-300a-e13d-fa54-8717eb97c2e1@rock-chips.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR0601MB1443;7:3cJmQxpM6yjjVLyas/VfAQj3BAaJeM96kZwzBNKWLwkaXKPGr3HUw0EhzqZhITHFtOeRS7t1V4WszAlLDciGN+4cs0FNuflQo4onF+7WSTZwKTuBz+IBv1d+omIti7HRvCHdRJAJKCnCxASgQo5F3amIAIfg/mCjdmW+SN9EMoHmNMlAJlU8IvSTEkCGlp7O59BADq3wVlRk1BoNSdLds1KDp1fzTVvR78p7QFUSwpRcbdya0Kg4edXh+vyJYDFf;20:IxszdUYIxNJrRYhN+a9BNzrz8cc81uzNxgW8ZP1GP9FRpgnm4orYtTtq57KGVpIjFeXk02LAYuCbVFTvi+it0yAqjW0b0Wg73w+8cfRELwKaV0k2X8fQRt+P5cVnZLNcCcDbX3+FTBIzp5sg/qxQEprOxBpbrNI5+BYEGzpBw84=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 687d8bae-ec69-4830-004e-08d582b8c623
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:HK2PR0601MB1443;
x-ms-traffictypediagnostic: HK2PR0601MB1443:
x-microsoft-antispam-prvs: <HK2PR0601MB14437369E35D43183AF893B7F5DA0@HK2PR0601MB1443.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HK2PR0601MB1443;BCL:0;PCL:0;RULEID:;SRVR:HK2PR0601MB1443;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39380400002)(39860400002)(376002)(396003)(199004)(189003)(186003)(8666007)(97736004)(102836004)(93886005)(6436002)(9686003)(81156014)(81166006)(8676002)(6306002)(26005)(55016002)(2906002)(4326008)(74316002)(66066001)(305945005)(25786009)(5660300001)(7736002)(2950100002)(3280700002)(6916009)(105586002)(229853002)(59450400001)(106356001)(33656002)(53546011)(6506007)(5250100002)(8936002)(54906003)(478600001)(68736007)(99286004)(8656006)(6246003)(6116002)(3846002)(86362001)(53936002)(2900100001)(316002)(14454004)(76176011)(7696005)(966005)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR0601MB1443;H:HK2PR0601MB1393.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zjQbnezFPPe5vxb5UZsCjFj2nNZXTgROFNNXesvwjwdFAyjUMs8YIKRNZfqjTi3oItjA74nZdmJhilguQMrEnvnbHk2AStkpUfUECiEM9/hWfQsPeQ0cnZ5bWHjmhwuSJljcZMmBFKUG2159WWmaQ190UHThXrPF4hzK1J6p7gqKf5VFqIgM0CgoruMdhYRXOma+lNzv94SJIrDplodFKaN2dN5C8rcWEPT711NA82s5vLiGGIk9GlP0ZCgyD1GT4icXmFZUG2mvgjf7TpN6LBQiZyI+Xmc5pI9UCIfimiqm/owmxTgAyaRkv1Ks6+hUp2esay6z0CRgjQ5YWOqasw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687d8bae-ec69-4830-004e-08d582b8c623
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 16:47:25.1348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1443
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w25GlegN007432

Hi Shawn,

On 28 February 2018 01:53, Shawn Lin wrote:
> On 2018/2/27 23:05, Phil Edworthy wrote:
> > On 27 February 2018 14:42, Shawn Lin wrote:
> >> On 2018/2/27 22:31, Phil Edworthy wrote:
> >>> On 27 February 2018 14:28, Shawn Lin wrote:
> >>>> 在 2018/2/27 21:55, Phil Edworthy 写道:
> >>>>> Since the controller does not support the end-of-busy IRQ, don't use
> it.
> >>>>> Otherwise, on older SD cards you will get lots of these messages:
> >>>>> "mmc0: Got data interrupt 0x00000002 even though no data operation
> >>>>> was
> >>>> in progress"
> >>>>>
> >>>>
> >>>> I'm afraid you have to explain which version of arasan's IP suffer
> >>>> from this and what does the "older SD cards" mean?
> >>> Ok, I'll try to find out the IP version...
> >>> For "older SD cards", I can provide a list of a few cards that
> >>> exhibit this problem and others that don't, is that enough info?
> >>
> >> What I meant is could you elaborate more about what kind of cards,
> >> e.g, are them the  legacy SDSC cards or SDHC cards, or maybe they are
> >> only running with defaut speed? or whatever, but not just with a
> >> vague "older" cards. :)
> > Unfortunately, I have one SDHC card that works, one that doesn't. Both
> > cards are running with a 50MHz SD clock. All I know is this:
> 
> Thanks for sharing these, though it looks wired as I never remember I saw
> this problem when extensively tested SD cards on one of arasan controllers
> in 2014.
Not sure what you mean by 'wired'?

Note that this is on a relatively slow device, a dual core Cortex A7 @500MHz.
Maybe that has some effect.

It's also interesting that someone posted the same fix for Xilinx a while
back, I linked to it in the commit msg.

Thanks
Phil


> > SD cards that report unexpected interrupts:
> > 2GB Sandisk Extreme III                     (e624 SD02G 1.89 GiB)
> > 8GB Sandisk (SDHC class 4)              (aaaa SU08G 7.40 GiB)
> > 8GB Sandisk Extreme III (SDHC class 6)    (bb4e SD08G 7.61 GiB)
> >
> > SD cards that work ok:
> > 16GB Samsung (microSDHC U1 class 10)          (0001 00000 14.6 GiB)
> > 16GB Sandisk Ultra (microSDHC U1 class 10)    (aaaa SL16G 14.8 GiB)
> > 32GB Sandisk Ultra (microSDHC U1 class 10)    (aaaa SL32G 29.7 GiB)
> >
> > Thanks
> > Phil
> >
> >>>>> This has been reported on Xilinx devices that also use the Arasan IP.
> >>>>> See https://patchwork.kernel.org/patch/8062871/
> >>>>>
> >>>>> This has been tested on the Renesas RZ/ND-DB board with the RZ/N1
> >> SoC.
> >>>>>
> >>>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >>>>> ---
> >>>>>     drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
> >>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> >>>>> b/drivers/mmc/host/sdhci-of-arasan.c
> >>>>> index c33a5f7..ab66e32 100644
> >>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
> >>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> >>>>> @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data
> >>>> sdhci_arasan_pdata = {
> >>>>>     	.ops = &sdhci_arasan_ops,
> >>>>>     	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> >>>>>     	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> >>>>> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> >>>>> +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
> |
> >>>>> +			SDHCI_QUIRK2_STOP_WITH_TC,
> >>>>>     };
> >>>>>
> >>>>>     static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32
> >>>>> intmask)
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Best Regards
> >>>> Shawn Lin
> >>>
> >>>
> >>>
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
