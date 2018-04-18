Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeDRVwg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 17:52:36 -0400
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:34203
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751407AbeDRVwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 17:52:34 -0400
From: Long Li <longli@microsoft.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: RE: linux-next: build warning after merge of the scsi tree
Thread-Topic: linux-next: build warning after merge of the scsi tree
Thread-Index: AQHT1fOOBLalvKqH7Umf2deWJ/NHdKQHEY2Q
Date: Wed, 18 Apr 2018 21:52:32 +0000
Message-ID: <MWHPR2101MB072925FF18BBA2F84B2EE470CEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180417122540.1c0a3fee@canb.auug.org.au>
In-Reply-To: <20180417122540.1c0a3fee@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0809;7:o4jD5QXu40nBUKhHYIzE69vCupygD1T96NAcz9y6BRw7stkWnQLoXxkf08duya9O2/kau9tfu7ahZ5DWYpK4AVuA+fBszqnGGp8QY/26MGtstEHoU7SRERgJ89YqBzzLPU2KI3U575/QWstQSBuqmNHgHnJqWMlkl3JE9PifY3eFLkG1N9jHGeaFx7WRx5t8hIX4GPda0T/sjbjkng1yKQHdj6xRImBCRkeelEwYoWBGQAtj48s0qjx06oGP2dr7;20:JIxHtz5sIovBrrHrdCpc+MWvscHbKGXeIBtZ+Q6r3mqytSG5L8sW5NyhNw6/EjQRGpcfRw0cEH8RAXT12J2tyTuzbP22yjsNY7DNh0akgGy5EvZeV0Nn+RRa26jTvEX1Wt1t4MDlZ29Hq72DunznLyz+L036EwcBH7WW3YYwcAc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MWHPR2101MB0809;
x-ms-traffictypediagnostic: MWHPR2101MB0809:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB08097AEBC9B2996E0204E430CEB60@MWHPR2101MB0809.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501368)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR2101MB0809;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0809;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(39860400002)(366004)(7736002)(6116002)(53936002)(5250100002)(186003)(5660300001)(102836004)(2906002)(99286004)(478600001)(7696005)(11346002)(76176011)(305945005)(10290500003)(446003)(9686003)(6506007)(476003)(59450400001)(6246003)(74316002)(14454004)(33656002)(25786009)(86362001)(8990500004)(6436002)(2900100001)(229853002)(8936002)(81166006)(46003)(22452003)(8676002)(4326008)(10090500001)(54906003)(86612001)(316002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0809;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: EYvn7ZIaIzdYMLsVxmBdUacc9tFqLZw4NcH32jWchZecW9YMC47EDbJ5qveH0kqxZd9Rgf2ck5RLCUh9JvTQ/e425KicJJCql3OB78ZDXUYtsZiDJwft458kJIzzCqpI0sJXUZoI8kwAV/MDBzSCoGwmUaEB+PEnHP1oOv+vfdKvndB9fEdOpojyQN+EZGjw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 594e1cf4-1d71-46cb-a7af-08d5a576b045
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594e1cf4-1d71-46cb-a7af-08d5a576b045
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 21:52:32.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0809
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3ILqiug004104

> Subject: linux-next: build warning after merge of the scsi tree
> 
> Hi James,
> 
> After merging the scsi tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/scsi/storvsc_drv.c: In function 'storvsc_do_io':
> drivers/scsi/storvsc_drv.c:1402:1: warning: the frame size of 2216 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]  }  ^
> 
> Introduced by commit
> 
>   0b9bc24b8304 ("csi: storvsc: Select channel based on available percentage of
> ring buffer to write")

Thanks for catching this. This is due to the size of struct cpumask is too big, when CONFIG_NR_CPUS=8192 is used in most kernel config.

I will fix this by moving those data structure to kmalloc pre-allocated when channel is first created.

> 
> --
> Cheers,
> Stephen Rothwell
