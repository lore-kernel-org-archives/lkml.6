Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeDPVUq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:20:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40377 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeDPVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:20:44 -0400
X-IronPort-AV: E=Sophos;i="5.48,460,1517846400";
   d="scan'208";a="179162572"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "beanhuo@micron.com" <beanhuo@micron.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "rajatja@google.com" <rajatja@google.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Index: AdPVx2ZtjVpJ9kJAR4mgs6eLh3g9fQAAVgSA
Date: Mon, 16 Apr 2018 21:20:30 +0000
Message-ID: <796550a7b71c9675ee9a3d5cc05c968938080254.camel@wdc.com>
References: <97d36126b86443f680aacfac23b0a04e@SIWEX5A.sing.micron.com>
In-Reply-To: <97d36126b86443f680aacfac23b0a04e@SIWEX5A.sing.micron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1038;7:JdeQV4+lSZcVQP6sDlWFba64nmnRJaZJ8DWxQUn72KYeiDqeRiG5//Rl3T2w/is2jywwrZuJjK6PSTra0BaVU8k8iX2Y5giNR9IJCnVkhix8rjB5KheNmarqCHKw2AV/5n+65rsLlBjsEsYcnN1KFCFVeV9DIXPIpNUMW10hNVuSLdo7YPhrkkmaphpXJnsoDKwH9MEGCQPhDppdOv2/XE5jQIRkOHFF7fvPR6xcHXPJbNhTKVYXkKK1wv6DGENG;20:fzMAPx2iHdHyP6COmicGQ/uthLxyCb8ry5bQHpE80QPFDShWj43cO4j9aVu8li0Zpo9bPVkMxzwY7sBG5fCyTdg8TKverhBSYOpj4/6L+QcSZE8JTqcdE/vHa7h9VAfPQH3RrKZoz+KNm99NzkFYlBXm/DBb/GCi9O0pGkfFfB4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1038;
x-ms-traffictypediagnostic: MWHPR04MB1038:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB103838BCD17A2DBF2844BFAE98B00@MWHPR04MB1038.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB1038;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1038;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(377424004)(118296001)(25786009)(186003)(2900100001)(478600001)(8676002)(446003)(486006)(11346002)(2616005)(5250100002)(72206003)(81156014)(81166006)(14454004)(476003)(102836004)(53936002)(2201001)(229853002)(4326008)(6486002)(76176011)(99286004)(6436002)(6506007)(6246003)(8936002)(2501003)(59450400001)(6512007)(26005)(3846002)(6116002)(97736004)(86362001)(110136005)(54906003)(3280700002)(68736007)(36756003)(66066001)(106356001)(7416002)(2906002)(7736002)(105586002)(316002)(305945005)(3660700001)(5660300001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1038;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: L3a4BuwIp2HjrFAHjkiMn8Fy3RdXcwWUhkCVuVKFfSR5mHWgh0yLHDUenJeVFgqs11mx+TeHdRTeLpn4hpRD5JMXoiRGESaYMtiXJrp+ebaRRanM4GfQ8NKsAGud3o9t7rBJiwwlAIAhyOVcnyj1j0R1Me9ou/gvvh+iBrs4k4UqS1j4hpgwJFYsnwy5XyDL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA52DD459046F8438BC272ACAC3A1AC9@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d47cffdb-506a-4c06-9607-08d5a3dfe209
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47cffdb-506a-4c06-9607-08d5a3dfe209
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 21:20:30.7169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1038
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GLKquk013493

On Mon, 2018-04-16 at 21:10 +0000, Bean Huo (beanhuo) wrote:
> Hi, Bart
> 
> > mingo@redhad.com; linux-block@vger.kernel.org; rajatja@google.com
> > Subject: [EXT] Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI
> > trace events
> > 
> > On Mon, 2018-04-16 at 14:31 +0000, Bean Huo (beanhuo) wrote:
> > >  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u
> > 
> > prot_sgl=%u" \
> > > -		  " prot_op=%s cmnd=(%s %s raw=%s)",
> > > +		  " prot_op=%s tag=%d cmnd=(%s %s raw=%s)",
> > > 
> > > [ ... ]
> > >  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u
> > 
> > prot_sgl=%u" \
> > > -		  " prot_op=%s cmnd=(%s %s raw=%s) rtn=%d",
> > > +		  " prot_op=%s tag=%d cmnd=(%s %s raw=%s) rtn=%d",
> > > [ ... ]
> > >  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u " \
> > > -		  "prot_sgl=%u prot_op=%s cmnd=(%s %s raw=%s)
> > 
> > result=(driver=" \
> > > -		  "%s host=%s message=%s status=%s)",
> > > +		  "prot_sgl=%u prot_op=%s tag=%d cmnd=(%s %s raw=%s) " \
> > > +		  "result=(driver=%s host=%s message=%s status=%s)",
> > 
> > Which tools process these strings? Has it been verified whether or not the
> > tools that process these strings still work fine with this patch applied?
> > 
> 
> I don't use one certain special tool to analyze this string, I am using ftrace with event.
> With tag information, I can see how many tasks in storage device and easily to trace each request
> under multiple thread workload. 
> Event there is someone who using certain tool to analyze this string, after adding additional
> tag printout, in my opinion, they are happy to see it there. 

Since you want to change these strings it is your job to determine which
user space tools parse these strings and also whether or not this change
will break any of these tools.

Thanks,

Bart.
