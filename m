Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeEBCjM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 22:39:12 -0400
Received: from mail-by2nam03on0040.outbound.protection.outlook.com ([104.47.42.40]:34848
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750785AbeEBCjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 22:39:10 -0400
From: "Qu, Jim" <Jim.Qu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        Mathieu Malaterre <malat@debian.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: David Airlie <airlied@linux.ie>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBUcmFja2luZzogcmFkZW9uIDAwMDA6MDA6MTAuMDogcmluZyAw?=
 =?utf-8?Q?_stalled_for_more_than_10240msec?=
Thread-Topic: Tracking: radeon 0000:00:10.0: ring 0 stalled for more than
 10240msec
Thread-Index: AQHT2zRELZR/kX0ppEyj9HMFUWJ4a6QYBSUAgAO/QMM=
Date: Wed, 2 May 2018 02:39:07 +0000
Message-ID: <DM3PR12MB0873246BA4A3462050AC10E299800@DM3PR12MB0873.namprd12.prod.outlook.com>
References: <CA+7wUszgY3uFVfMe4T-_5x9KuzWNSgKHXcRKgfcmpE+Keo73Vg@mail.gmail.com>,<fefee930-1eca-4819-4e02-7ba4a7487dee@amd.com>
In-Reply-To: <fefee930-1eca-4819-4e02-7ba4a7487dee@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM3PR12MB0810;7:OoWIbjr83DIIC7M8FHelEsHG+fMIMiMcx1loPvTs7c8JACMY+lL+BRRyiKwKlFQ+jrsFZ76D4og9AC8b6+wf30LUbefr91BnJ1LUUGUPi/1RKIqFyDy6XBKYzglOGvaLuJ5xWHZzN7ghuS/68MAGPjGHc/fkLR/X9p9CvXQYfyY1NjlYr7TT5q1jwumz440vrb/qxBmIe4CRzeNu+z7T8FScS7HhqB0E/wkt19y+vfLhAo5JWNSavI2kgNo3NX/q;20:bY7QLvU0w9EVMsuXkrS/s8DSspgoi+vMKmaffBpjbVlwvWeoCTLHhf8abdbI4q3BdcrwVKEe/jbUOhTMtxbjrqH2mgmhwmhR0+TFWM4NGIaVUW4zFbwZdc0RjpFDbpp2IHaoogQhBKqzH7IV2GKCsz4GaMg+Zyny829sUvzk/9FEURlaPmC+ENJWtplAm21QDEUflD1we8e8xccVBmHtFr2ttlkREGZEyPpGhtX5U4pObw5QPD/6RK+7Bhn7OdVs
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(39380400002)(189003)(199004)(224303003)(11346002)(3846002)(106356001)(105586002)(2900100001)(478600001)(5660300001)(25786009)(81166006)(97736004)(7696005)(33656002)(6116002)(76176011)(72206003)(66066001)(8936002)(966005)(99286004)(6436002)(486006)(476003)(6306002)(74316002)(68736007)(81156014)(59450400001)(53936002)(55016002)(446003)(26005)(9686003)(5250100002)(7736002)(4326008)(316002)(6506007)(54906003)(3280700002)(2906002)(102836004)(6346003)(3660700001)(110136005)(305945005)(86362001)(6636002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0810;H:DM3PR12MB0873.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM3PR12MB0810;
x-ms-traffictypediagnostic: DM3PR12MB0810:
x-microsoft-antispam-prvs: <DM3PR12MB08105A625C02E1D41693036199800@DM3PR12MB0810.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(788757137089)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM3PR12MB0810;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0810;
x-forefront-prvs: 06607E485E
authentication-results: spf=none (sender IP is ) smtp.mailfrom=Jim.Qu@amd.com; 
x-microsoft-antispam-message-info: Oa7SMBCEr3d/ReLk5yCGw8mTJSltQ7DVN8atIZunRPA4NbVTYM8iDuMrNQHd4wACQu1U6Dm+yt19EhWx0Ry9d/139QDEA+zrd1/NBfUjbH+Ni3zTDAiSkOk5D9eZxi6KBlIAiodyQF1VPqsdJYPD2rFzvkN0LyPV/pUQbsQgX998/Uc1yEZ6PNm1wTgQk0ed
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 106dd12e-e6cd-4ddd-7ee5-08d5afd5e09c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106dd12e-e6cd-4ddd-7ee5-08d5afd5e09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 02:39:07.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0810
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w422dI8D022623

Hi ,

If you are sure that the HW worked fine before. I think you should:

1. Be sure that HW works fine now.
2. recall the driver to the point at where it works well, and then replace them one by one to confirm component which causes the issue.
3. try to update the last VBIOS to adapt new driver.

Thanks
JimQu

________________________________________
发件人: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> 代表 Christian König <christian.koenig@amd.com>
发送时间: 2018年4月30日 1:16:14
收件人: Mathieu Malaterre; Deucher, Alexander
抄送: David Airlie; Zhou, David(ChunMing); dri-devel; amd-gfx@lists.freedesktop.org; LKML
主题: Re: Tracking: radeon 0000:00:10.0: ring 0 stalled for more than 10240msec

Am 23.04.2018 um 20:50 schrieb Mathieu Malaterre:
> Hi there,
>
> I am pretty sure I was able to run kodi on an old Mac Mini G4 (big
> endian) with AMD RV280. Today it is failing to start with:

Well, that is rather old hardware. I suggest to make sure first that the
hw isn't broken in some way.

> How should I go and debug this (other than plain git-bisect) ?

You first need to figure out what's the failing component. Either Mesa,
DDX or the Kernel are possible candidates.

Another possibility is that you updated kodi and kodi is now doing
something the hw doesn't like.

Regards,
Christian.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
