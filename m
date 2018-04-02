Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeDBNxP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 09:53:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43450 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDBNxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 09:53:11 -0400
X-IronPort-AV: E=Sophos;i="5.48,395,1517846400";
   d="scan'208";a="74914818"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: hosts: remove redundant assingment of
 shost->use_blk_mq
Thread-Topic: [PATCH] scsi: hosts: remove redundant assingment of
 shost->use_blk_mq
Thread-Index: AQHTymZTdLHoX+rgeUuXMw00QyXwEqPtfw6A
Date: Mon, 2 Apr 2018 13:53:08 +0000
Message-ID: <4c62b8f8da1175ddcdcdf0a234dacbf620d73060.camel@wdc.com>
References: <20180402093749.6862-1-jthumshirn@suse.de>
In-Reply-To: <20180402093749.6862-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0334;7:IctdT7vic1YyrUkqAzYnkTudouF0sd5DzH2HXHfX66ERMa4ZLNfB3x/tpFbh1YG0aKaSf5SGzUFD6VFKCfkAKh1JKV6q/O6xcIK3ZS1KuYQ7CF71sTpV3WoaEE5m0GRJ/vU76rvdh4GLQDb3omElTLouJPaG24gLB7T55isS4Q6L6wkzKArpDFsJbPpJ/7eX07MZC4gJmg0C/eRmCJlEC/nirbo/HEET76v+RvONeyZy1VTW6m+xRsgLh5CoRuUA;20:sdWzqxJaISg5huiNfrVZVyUfSdH3xWTzi78Oxk4OumsdgAzwZzjzCi66RAZeRLdN115my8bjD+ox/O28vtsLflUt3+rKCBFcuhgzqs4cq6fUXFbXFFAq9Bdcr3AdYkuGsgPoWG06KM0oboh7mzGzihTZe6pe55wO+KioVCCdGJU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f61dacb6-abcd-4fbb-5cfa-08d598a110e7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0334;
x-ms-traffictypediagnostic: MWHPR04MB0334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0334B307EE5589E49669F30A98A60@MWHPR04MB0334.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR04MB0334;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0334;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(377424004)(305945005)(6246003)(7736002)(99286004)(5250100002)(36756003)(316002)(105586002)(102836004)(2501003)(110136005)(72206003)(54906003)(68736007)(25786009)(966005)(59450400001)(6506007)(14454004)(76176011)(478600001)(6436002)(5660300001)(3280700002)(6306002)(476003)(446003)(229853002)(486005)(2906002)(3846002)(6512007)(6116002)(3660700001)(6486002)(11346002)(53936002)(66066001)(8936002)(2616005)(118296001)(486005)(86362001)(186003)(106356001)(81156014)(8676002)(26005)(4326008)(81166006)(2900100001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0334;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jjJPtdr5UjxqA0ZqjSKt5eokIuPAIMjFaU/NthDpAQx7Em4ODDyAS5BIq523V8Okhx/JgkSFV5cvhfuauMtZZv5njotMEClOFx5Iy4qDuN0vQcCcjtgMJvbZQqbwlKiuIQ0wSxZRWykT+onxfs5Pv8nrAXeSaw+2u4zKenmnI/Nxe7xHSliH1Fy3SjhSq7Dulb/LrU1jQy+mF2qekgXOPvxR9BZm2uCIWOdO+93Nqwf+Y4U2U3uMq54/Q+Zb8JBudEGWsWyz9thtqojVRTZR7UDxBujE/L7HujhhZlnoJjr9UvO33CiqH3MRVzWisJNmsH0XYHqj7SsWZy1OE9uVR0c0SQTT8gPiso0iABUMvS88ZtriT5Hj7KODH1E/rYBAEOak6X8kkBxZAye3TXiJzhVo1rSlemmgR9NDPdcQyt4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D2C8ED04C72AA439465242D7ADE66DD@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61dacb6-abcd-4fbb-5cfa-08d598a110e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 13:53:08.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0334
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32DrJU3007364

On Mon, 2018-04-02 at 11:37 +0200, Johannes Thumshirn wrote:
> Coverity reports that we're assigning shost->use_blk_mq twice. This
> looks like the result of a bad merge of commit 2f31115e940c ("scsi:
> core: introduce force_blk_mq")
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/hosts.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index ef22b275d050..c36f2a44e5ed 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -473,7 +473,6 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>  	else
>  		shost->dma_boundary = 0xffffffff;
>  
> -	shost->use_blk_mq = scsi_use_blk_mq;
>  	shost->use_blk_mq = scsi_use_blk_mq || shost->hostt->force_blk_mq;
>  
>  	device_initialize(&shost->shost_gendev);

A similar patch has already been queued by Martin. See also
https://patchwork.kernel.org/patch/10313569/.

Bart.
