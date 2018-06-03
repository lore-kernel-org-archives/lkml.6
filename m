Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbeFCKVY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 06:21:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54326 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 06:21:21 -0400
X-IronPort-AV: E=Sophos;i="5.49,472,1520870400";
   d="scan'208";a="182820593"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Evan Green <evgreen@chromium.org>
CC: Vinayak Holikatti <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>, Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Topic: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Index: AQHT93lpGmTFqrK/4k6nSxRetFdr1aRJmw1AgAHj/gCAAtT7sA==
Date: Sun, 3 Jun 2018 10:21:17 +0000
Message-ID: <MWHPR04MB11370AED823FB608218CB9AD9A600@MWHPR04MB1137.namprd04.prod.outlook.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
 <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
In-Reply-To: <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1217;7:GeF39K6Uu6ohHEUDuNDb4+nXAmLEcj7TXMpLw1cTQ4OdDozmEfgTBDpUwGS1Z2OBsvfPV4sCgdcoGLwEsZUB4Q+XICb5loF1Uakzd3LzDREKzVhmuywVA80XYLW4xHc+I8z5dU0nR1l2dLTwv5vAH84ADKm8QndRFVa/pnHKxpMsx3DKAYHUPWPljvLSa7kMoElf/t+socT2jqTGvuAtPLqoZRoSblw/tZkRSMG/IUxwNdJEJcI4YXRKdbJ+2Jxl;20:8VeWIhY4XAEhCYH/TkO/XZbxqR3+WQZR+GH3t9CN6rdhP9DY87a6iZbSok7GRl6+cKR6GnA7lkB+D4lTiSkTsgDvonX1Hm0qQuUYJtSdWC72UHWQ65bnSmibY3hKMoe1qiwMLf10ioKktgjajtHuyTboFdzvD4VfxhKqZn2lOOs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1217;
x-ms-traffictypediagnostic: MWHPR04MB1217:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB121740CD2FE819331F03730E9A600@MWHPR04MB1217.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1217;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1217;
x-forefront-prvs: 069255B8B8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(13464003)(189003)(199004)(9686003)(25786009)(476003)(6506007)(72206003)(53546011)(59450400001)(54906003)(11346002)(14454004)(478600001)(446003)(4326008)(68736007)(105586002)(106356001)(316002)(486006)(3660700001)(2906002)(8676002)(81166006)(102836004)(8936002)(305945005)(186003)(74316002)(26005)(33656002)(7736002)(81156014)(97736004)(5890100001)(5250100002)(39060400002)(2900100001)(229853002)(6436002)(66066001)(99286004)(6116002)(3846002)(5660300001)(3280700002)(53936002)(55016002)(76176011)(6916009)(6246003)(7696005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1217;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ck9ibONnL7MIblRFi/Xp7kSaztl1BPyIKiRpKrBOxIZShlJ9nhtBQQJf6ND9BJvaHWqGSLtlxwnbeRUUtb/jKZolH7IGMCfiKNb45bV+Cgj2DBn81hEQej7rsB9odv4wfB/WbQgPU3INNToqla03tlqiZiiMpC+vOfOgDSpqZ56G11yFXztQi+mMTqEZd2do
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cafef3ed-dd44-416f-6c05-08d5c93bbe16
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafef3ed-dd44-416f-6c05-08d5c93bbe16
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2018 10:21:17.1405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1217
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w53ALWn7011024



> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org> On Behalf Of Evan Green
> Sent: Friday, June 1, 2018 5:44 PM
> To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> Cc: Vinayak Holikatti <vinholikatti@gmail.com>; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; linux-
> kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Gwendal Grignou <gwendal@chromium.org>; Alex Lemberg
> <Alex.Lemberg@wdc.com>; Avri Altman <Avri.Altman@wdc.com>
> Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
> 
> Hi Stanislav. Thanks for taking a look. Responses below.
> 
> On Thu, May 31, 2018 at 3:04 AM Stanislav Nijnikov
> <Stanislav.Nijnikov@wdc.com> wrote:
> >
> > Hi Evan,
> > I have some generic notes:
> > - Why to create new sysfs entries for the configuration descriptor fields if they are just duplication of fields in the device and unit
> descriptors? And the sysfs representation of the device and unit descriptors is existing already.
> 
> Well, UFS describes them as different descriptors. I worry that if I
> add a bunch of clever logic to hide the config descriptor behind other
> descriptors, there might be trouble later if 1) there is a quirky
> device that doesn't reflect the values between descriptors quite the
> same way or at the same time, or 2) if a later UFS spec adds more
> configuration descriptor fields that don't exactly reflect into other
> non-config descriptors, the cleverness will look awkward.
 
No additional logic will be required to attach write functionality to the
existing entries instead of new defined ones. It will reduce the patch 
size significantly. And there will be no need for the unit selector 
mechanism which I'm not sure will be accepted by the SCSI community.

> 
> > - It would be nice to have some "packet" mode allowing to gather configuration changes and apply them at once, not one by one.
> 
> That's definitely doable. Do you think it's needed? I suppose if there
> were a device that truly allowed you to do only a single write to the
> config descriptor, then the commit style would be needed. The two
> devices I've tested (Toshiba and Samsung) allow multiple writes to the
> config descriptor, which makes me lean towards not needing the
> batch-and-commit style, since if you get interrupted you can simply
> try again. I'm happy to do either, though.

Agree. It doesn't have to be part of this patch set. It's just thoughts  
about "quirky devices and future changes" :) that might require to 
change several parameters simultaneously.

> 
> > - Why to put documentation update in the separate patches?
> Well, in case some piece of this turned out to be controversial, I
> wanted to allow for the option of taking these changes independently,
> without the concern of missing the documentation. I'm happy to squash
> all the documentation changes into one if that's preferred.
> 
> -Evan

Regards
Stanislav
