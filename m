Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeB0O6j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:58:39 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24311 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753996AbeB0O6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:58:36 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515427200";
   d="scan'208";a="72922738"
From: Alex Lemberg <Alex.Lemberg@wdc.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
Thread-Topic: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
Thread-Index: AQHTr77gTAsg8icfe0GBsxZvuBdg+qO4ePmA
Date: Tue, 27 Feb 2018 14:58:33 +0000
Message-ID: <14AC9066-4BA9-478D-9F67-2A29D69E6011@wdc.com>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
In-Reply-To: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.9.0.180116
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Lemberg@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1364;7:12xSMdQuLt2RPZQoDhC0BLldOVZbEIJPjanlMM2qTkXI2ByJsKMQxp/CWtRfXaFB4Hjgw9pHjPO3ferGbecfpNP5dpwzqLMGC3FU9jFJtonnVK0A5HKRNi1z/2lCWss0TyUSEhDYNXgtObl5NY3uCyUUnP+K6ALsyehHHvYH8pOsAS73neGLalGSliV+c+SxuQPFRlWjMPjVBU2chuq03qakpiMgQydj7wadj1uxqdSOCQB42RlrqsyecdSFOSbM;20:I71cWtkKl10XcdWJ8/2mNsz93Ivc0ydHi9/+WOisOYWrWEIefAjone8tElWawUhrW5AzyFtvZ1xjtEe1ZY5biDoBCO3ONum/5PZWPI6fh6tRQBjKc6/jjw7kWtUsn1URcrLbuI6HVutzQrVaUZKIdVjUSrVxcwe3SILQdGGZ0J8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 713909c9-878c-4f5b-80c5-08d57df29273
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BN3PR0401MB1364;
x-ms-traffictypediagnostic: BN3PR0401MB1364:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB13645E80231AFECE47B556CF8DC00@BN3PR0401MB1364.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501161)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN3PR0401MB1364;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1364;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(966005)(76176011)(305945005)(229853002)(2950100002)(110136005)(316002)(58126008)(7736002)(68736007)(97736004)(4326008)(54906003)(14454004)(72206003)(2906002)(3280700002)(105586002)(99286004)(478600001)(3660700001)(33656002)(66066001)(86362001)(26005)(2501003)(53936002)(186003)(6512007)(82746002)(6246003)(8936002)(102836004)(8676002)(81156014)(83716003)(3846002)(81166006)(5250100002)(6116002)(2201001)(25786009)(59450400001)(36756003)(6436002)(2900100001)(106356001)(6486002)(6506007)(6306002)(5660300001)(422495003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1364;H:BN3PR0401MB1235.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: RSRknXd/7Y5E03suL05Vd531WqG5Y9Y2du8UZzp/E9J204yNRNwAYiOq45WSBs5IE0pPXXuZqD5cAmkkwvBxCOB8UnFe19JIxyvbR5CpTA1c+3g9cIQdNwjEHnxqllX/dioCdEb1Uc11K3rwRc6jPAqRVvbq7k2fXbHLdohhvgM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CB7AAEC713896469897D11F2DB1481E@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713909c9-878c-4f5b-80c5-08d57df29273
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 14:58:33.3519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1364
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RExDLV003767

Hi Andrew,

While RPMB partition requires special IOCTL, the boot partition is only requires "switch partition", which is not unusual operation in eMMC.
Why to prevent users access boot partition?

Thanks,
Alex 

﻿On 2/27/18, 1:34 PM, "linux-mmc-owner@vger.kernel.org on behalf of Harish Jenny K N" <linux-mmc-owner@vger.kernel.org on behalf of harish_kandiga@mentor.com> wrote:

    From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
    
    Since RPMB area is accessible via special ioctl only and boot areas
    are unlikely to contain any partitions, exclude them all from listing
    in /proc/partitions. This will hide them from various user-level
    software (e.g. fdisk), thus avoiding unnecessary access attempts.
    
    Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
    Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
    ---
     drivers/mmc/core/block.c | 3 ++-
     1 file changed, 2 insertions(+), 1 deletion(-)
    
    diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
    index 20135a5..376e47e 100644
    --- a/drivers/mmc/core/block.c
    +++ b/drivers/mmc/core/block.c
    @@ -2341,7 +2341,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
     	set_disk_ro(md->disk, md->read_only || default_ro);
     	md->disk->flags = GENHD_FL_EXT_DEVT;
     	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
    -		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
    +		md->disk->flags |= GENHD_FL_NO_PART_SCAN
    +				   | GENHD_FL_SUPPRESS_PARTITION_INFO;
     
     	/*
     	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
    -- 
    1.9.1
    
    --
    To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html
    
