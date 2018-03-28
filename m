Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeC1WdK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:33:10 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:61216
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753223AbeC1WdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:33:08 -0400
From: Long Li <longli@microsoft.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
        KY Srinivasan <kys@microsoft.com>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector
 blacklist
Thread-Topic: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector
 blacklist
Thread-Index: AQHTxQu1h8SEKWk9fUyQHsWpjrY0l6PmM2DggAAKPSA=
Date: Wed, 28 Mar 2018 22:33:05 +0000
Message-ID: <MWHPR2101MB0729E7680EDB0EE4886AAED1CEA30@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180326135651.8193-1-ross.lagerwall@citrix.com>
 <yq17epvj2f1.fsf@oracle.com>
In-Reply-To: <yq17epvj2f1.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0875;7:kH03E2Em0JbwS23TMb8o5sPWr8WEqw54G1hxERT2f9LEb1bY/HtVGjdXDpn3cloFD8vdGUsoVdSlwnmRsgfaeCqIMWZR+MrjjBonggBqR8adD2Bbq2tEGxxcCe8LQ/SxqvvzsGn4502PdgysoPazslRguUOJ6NVYkOHy7ZPY3QV5sOWDQoLs5rJF+bfg6yVpMjJmzzoaJcrfGGZXJbztkfLYBzuNnFZ89EmCy5ohZgKhrU3NFIiotsCtMB2ljHMS;20:Chy2zgN5HL12/dZHHlfZyWYZEpy89mn9L0qblFGsEvx6aHmDBLQDsSNPqeUyCMqWh4ItnIOyVjf5FMqILdcM+BoQy+f9c1hncMlDWbgZiI3aIfbG9PfZtWjYEditxgmYo+UUgi2f0tAGMFqa3Bqr4pgZL6yBHkVGRBsiMvhGcGk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa9f9f0b-ecbe-4ef8-9b3c-08d594fbdfaa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MWHPR2101MB0875;
x-ms-traffictypediagnostic: MWHPR2101MB0875:
x-microsoft-antispam-prvs: <MWHPR2101MB08751CEA8E53390ABD215964CEA30@MWHPR2101MB0875.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(70601490899591);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR2101MB0875;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0875;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(346002)(376002)(47530400004)(199004)(189003)(7736002)(22452003)(6636002)(5250100002)(46003)(10090500001)(305945005)(33656002)(9686003)(74316002)(14454004)(10290500003)(53936002)(3280700002)(76176011)(478600001)(446003)(68736007)(3660700001)(2906002)(476003)(8936002)(81166006)(81156014)(11346002)(6436002)(486005)(486005)(106356001)(8676002)(55016002)(5660300001)(8990500004)(8666007)(4326008)(316002)(6246003)(97736004)(6116002)(99286004)(102836004)(86362001)(2900100001)(6346003)(25786009)(86612001)(229853002)(6506007)(7696005)(110136005)(105586002)(186003)(59450400001)(54906003)(1511001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0875;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-message-info: MOJ3YczLy89JcsOE+MJkixtNprAv5Xlll+2UczEV5OTvYANjxqhVw8eOJKi6dMJ5k7F0LKkWy7M6E+cPwhi/WKmHvxilmtatn/bSh2E+IbX2eCUxOS67fuiWjUR9oPodXiDgV1nMNltvcKZME1hvfpm7OtZH7pcu8v8d1iwykdZ3K8CBVdY62CYCWchGAiTzm9ZpySZzxEczWGCcjeGimB8kfbj1gS3RBOd5YwdG9OahRLQ94yHLLuDoVSeRvyigyrvv1+pMB3gB3LnHl0hl/s/UzMUHLI9Y6F+XuO+NsGc9Mlk8cQle8Mo0c0DNhMRLfxBhykimR6jCFvxq/aFQTw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9f9f0b-ecbe-4ef8-9b3c-08d594fbdfaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 22:33:05.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0875
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SMXGoD013476

> Subject: Re: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector
> blacklist
> 
> 
> Long, KY: Please confirm.
> 
> > The Windows Server 2016 iSCSI target doesn't work with the Linux
> > kernel initiator since the kernel started sending larger requests by
> > default, nor does it implement the block limits VPD page. Apply the
> > sector limit workaround for these targets.
> >
> > Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> > ---
> >  drivers/scsi/scsi_devinfo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> > index f3b1172..5cb748a 100644
> > --- a/drivers/scsi/scsi_devinfo.c
> > +++ b/drivers/scsi/scsi_devinfo.c
> > @@ -213,7 +213,7 @@ static struct {
> >  	{"Medion", "Flash XL  MMC/SD", "2.6D", BLIST_FORCELUN},
> >  	{"MegaRAID", "LD", NULL, BLIST_FORCELUN},
> >  	{"MICROP", "4110", NULL, BLIST_NOTQ},
> > -	{"MSFT", "Virtual HD", NULL, BLIST_NO_RSOC},
> > +	{"MSFT", "Virtual HD", NULL, BLIST_MAX_1024 | BLIST_NO_RSOC},

Ross,

What about storage_channel_properties.max_transfer_bytes returned from VSTOR_OPERATION_QUERY_PROPERTIES (in storvsc_channel_init())

Does it return correctly the maximum transfer size for iSCSI?

Long 

> >  	{"MYLEX", "DACARMRB", "*", BLIST_REPORTLUN2},
> >  	{"nCipher", "Fastness Crypto", NULL, BLIST_FORCELUN},
> >  	{"NAKAMICH", "MJ-4.8S", NULL, BLIST_FORCELUN |
> BLIST_SINGLELUN},
> 
> --
> Martin K. Petersen	Oracle Linux Engineering
