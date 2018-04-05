Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeDETwj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:52:39 -0400
Received: from mail-by2nam01on0134.outbound.protection.outlook.com ([104.47.34.134]:60144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752962AbeDETwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:52:37 -0400
From: KY Srinivasan <kys@microsoft.com>
To: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Long Li <longli@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matt Kurjanowicz <mattkur@microsoft.com>
CC: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector
 blacklist
Thread-Topic: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector
 blacklist
Thread-Index: AQHTxt68JEyeXr1i+UiGAnV0HuKvJKPmO7yAgAw1F4CAAC+awA==
Date: Thu, 5 Apr 2018 19:52:32 +0000
Message-ID: <MW2PR2101MB1113040CF411696D9674B6D6A0BB0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180326135651.8193-1-ross.lagerwall@citrix.com>
 <yq17epvj2f1.fsf@oracle.com>
 <MWHPR2101MB0729E7680EDB0EE4886AAED1CEA30@MWHPR2101MB0729.namprd21.prod.outlook.com>
 <2b7a3146-e2e4-699f-5633-13d8b568786d@citrix.com>
In-Reply-To: <2b7a3146-e2e4-699f-5633-13d8b568786d@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:f::4f8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1116;7:WP298TkXQBwC2ETNSdOXxuhacH2kiLa+V+VNy4HtclJ1QdBOJ6blGkPp+U28OuJjBKZurSw6EuE9nAk40K2vBn+PmRQLeKHOkuSfkkXl8AC30oYlw75w0Ktkv2bqyyl7/HGxkf3571HyYw4MUq0+KWHmayEnKnGXQdYkB7+2iNJqayk4qah9UcFx4Yl4d/qw71sYuRICqZ5yfSKkgXe666ldFX4lGhwr2frVH6u5vrOU0SYcCWiiR/YMoN+WVGa4;20:/+bgYdSxOt7DL9MlUaqTo8hzSyIQqd+i5skg3X/TCHffPf1AAiYhabQxa++k9OtXZqnRHD4W+MetuzMvfJ+NZSOYLz0lFufeDGltgFA2OUB6RaAOKghhlOzWcS0lAgoH6ce2rRGVe7qM07BemeLgTtACxZyiJyPeTuGT0Pv5CzI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 296d54bd-30dd-424a-61bd-08d59b2ec551
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1116;
x-ms-traffictypediagnostic: MW2PR2101MB1116:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB111660C311B6235DF771BD00A0BB0@MW2PR2101MB1116.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(9452136761055)(70601490899591)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1116;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1116;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(47530400004)(13464003)(199004)(189003)(110136005)(229853002)(53546011)(2900100001)(446003)(476003)(10290500003)(105586002)(7696005)(68736007)(97736004)(86362001)(76176011)(5660300001)(6506007)(6436002)(22452003)(25786009)(53936002)(14454004)(478600001)(59450400001)(6636002)(54906003)(99286004)(33656002)(1511001)(486006)(6116002)(5250100002)(86612001)(9686003)(3280700002)(8666007)(106356001)(8990500004)(186003)(316002)(46003)(3660700001)(8936002)(6246003)(305945005)(93886005)(10090500001)(11346002)(102836004)(8676002)(74316002)(81156014)(81166006)(4326008)(55016002)(7736002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1116;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: awC7JZKzgrKvcEVSS8FmIsNLo58glbfXM1Y3YysnVqkuCWsJlZGLnGzi/Rv9WFBDIIhXwJnB3loGUb3g+mYEsxx+96cp37VuPAGk6JXj63soUiK6nRnPkEcu/C6lRP62ggB/SP13a5X78dui4z4BxeioW+5k1LrfBmTQA+1gOrAFCtfwimvdY4Ph2LirrjP11ULfemAkCZdn30IdfVa5zzLLOP1ut0ZXVJPvFqrlFfRXPnOTbdKUkUshmIv0WjEOvnXocCLR4dnTgl882JZviCk6+IqtmXPFp4u3nww7jzdtJeV7ksXSytvU8uqwRLp6Z4YMVD0GFz1PLk0dkatKT/4wyWx11iM2Dr/w8f3slZMslY+oLQSQsURkVhTzglSn/ZcCPiY9pLbCBzH/FDiYMf4THl9gzJbZKJXoph/dzi8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296d54bd-30dd-424a-61bd-08d59b2ec551
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 19:52:32.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w35JqjxP022899

+Matt

> -----Original Message-----
> From: Ross Lagerwall <ross.lagerwall@citrix.com>
> Sent: Thursday, April 5, 2018 9:58 AM
> To: Long Li <longli@microsoft.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; KY Srinivasan <kys@microsoft.com>
> Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector
> blacklist
> 
> On 03/28/2018 11:33 PM, Long Li wrote:
> >> Subject: Re: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024
> sector
> >> blacklist
> >>
> >>
> >> Long, KY: Please confirm.
> >>
> >>> The Windows Server 2016 iSCSI target doesn't work with the Linux
> >>> kernel initiator since the kernel started sending larger requests by
> >>> default, nor does it implement the block limits VPD page. Apply the
> >>> sector limit workaround for these targets.
> >>>
> >>> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> >>> ---
> >>>   drivers/scsi/scsi_devinfo.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> >>> index f3b1172..5cb748a 100644
> >>> --- a/drivers/scsi/scsi_devinfo.c
> >>> +++ b/drivers/scsi/scsi_devinfo.c
> >>> @@ -213,7 +213,7 @@ static struct {
> >>>   	{"Medion", "Flash XL  MMC/SD", "2.6D", BLIST_FORCELUN},
> >>>   	{"MegaRAID", "LD", NULL, BLIST_FORCELUN},
> >>>   	{"MICROP", "4110", NULL, BLIST_NOTQ},
> >>> -	{"MSFT", "Virtual HD", NULL, BLIST_NO_RSOC},
> >>> +	{"MSFT", "Virtual HD", NULL, BLIST_MAX_1024 | BLIST_NO_RSOC},
> >
> > Ross,
> >
> > What about storage_channel_properties.max_transfer_bytes returned
> from VSTOR_OPERATION_QUERY_PROPERTIES (in storvsc_channel_init())
> >
> > Does it return correctly the maximum transfer size for iSCSI?
> >
> 
> I presume you're referring to the Hyper-V virtual storage driver? This
> has nothing to do with that module -- I don't even have it compiled in.
> It's just simply the Linux kernel initiator connecting over plain
> software iSCSI to a Windows Server 2016 iSCSI target.
> 
> This is easy enough to reproduce. Just set up a Windows Server 2016
> target and try and use it from Linux. You get I/O errors as soon as you
> try and format the disk.

Adding Matt for visibility. Ross, we are fine with blacklisting for now.

K. Y 
> 
> Cheers,
> --
> Ross Lagerwall
