Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeB0O4c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:56:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23506 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753897AbeB0O4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:56:30 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515427200";
   d="scan'208";a="72922503"
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
Thread-Index: AQHTr77gTAsg8icfe0GBsxZvuBdg+qO4eGEA
Date: Tue, 27 Feb 2018 14:56:26 +0000
Message-ID: <CB89C150-B842-475C-A53A-C6FE7E8A710A@wdc.com>
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
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1638;7:uTUWpbe8O2nI4umF3WzMi9s1hOec0dBSLxsyvgbCW1E2xWPzgENcA+WF67m2N0xNE//lIZg5C5wkB9ujFKjU1Thk0tC/l7kzTr633ukUGY94gVk5hhdD6iBI9l+iKNIbfoZxrfVaT81Upb2gW6opiz7chriCluLa2Y1qeBnYfOBCH9rvakyJccXkHtj7yb54WjJvV4O/DemTPmgay4QjscG7xIS2tKRMUOrUlqmFl7l3zGjbmqJdadE8NQD+DQF5;20:5o2Mfr0u7BYJISRuk02yduxmXM5bOyQYD6yveSEJBE3xM7g5UA7+ytMsNRyFDTLDNzLMOGCt1wriBDpeabuh0tr4uI3stK+6AXqzBP+aMUVI02iaATJiPn+jV2rJsdvRqtm+N/LldVP6oJ9y6pFjqXKmGhTzocVwmt8E6XRyVNY=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d7f1e6d-fcd5-4685-0e42-08d57df246cf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BN3PR0401MB1638;
x-ms-traffictypediagnostic: BN3PR0401MB1638:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB16381B89A2F9A0CC80587DCB8DC00@BN3PR0401MB1638.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501198)(3002001)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN3PR0401MB1638;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1638;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(39380400002)(366004)(189003)(199004)(53936002)(68736007)(2950100002)(66066001)(14454004)(3846002)(97736004)(6116002)(36756003)(82746002)(8676002)(5660300001)(106356001)(81166006)(81156014)(8936002)(26005)(86362001)(2906002)(102836004)(966005)(7736002)(59450400001)(110136005)(2501003)(105586002)(54906003)(5250100002)(229853002)(6246003)(316002)(6506007)(305945005)(2900100001)(58126008)(6436002)(4326008)(2201001)(3280700002)(6486002)(83716003)(76176011)(6306002)(99286004)(478600001)(25786009)(33656002)(3660700001)(72206003)(6512007)(186003)(422495003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1638;H:BN3PR0401MB1235.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MboWVAAw35py7PGYyI0bw+8fwFQujzFwHD1eSJ3uvgdBlKRLfWbkenMeXsw5Z1676msJHIeGsJucK7dXH0Fzae1wIBT4SfMtFGbaf5VBkj3nAaW7h7uVGoXS9jiGfKCO9K25aj7YEO71DNH4JVEI2R+mFsdTrqfn5gdSWSqeSmo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EABF50BC22CD074793560B5B7445C1DD@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7f1e6d-fcd5-4685-0e42-08d57df246cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 14:56:26.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1638
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1REufOP002863

While RPMB partition requires special IOCTL

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
    
