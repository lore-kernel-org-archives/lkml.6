Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeEaKE0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:04:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15130 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbeEaKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:04:22 -0400
X-IronPort-AV: E=Sophos;i="5.49,463,1520870400";
   d="scan'208";a="176178364"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC: Gwendal Grignou <gwendal@chromium.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>, Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Topic: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Index: AQHT93lpGmTFqrK/4k6nSxRetFdr1aRJmw1A
Date: Thu, 31 May 2018 10:04:18 +0000
Message-ID: <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
In-Reply-To: <20180529181740.195362-1-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0416;7:qJMDl6dcMXHZpmi9WPx9D9hSMcApEnUTw4sn6Xoz8luNEW7S1nknG3JHbNl79iyq/0nyEtDZ0P3MIIbtfPf1cw5ygVeeMpKHR7+pRDx4HDZc9WaCofj+3chuEB5Am0X2QK46MMTxQbRGgAdjpAPv1BSj/9ZJag6sI9ygv79hrW/v3W+v7UXrNXKzYUwDpaqTkuKgCvHu+G+R+QBqJODXZcAsvITmxSrQoAHM+wMC4MGMEfQbf3jPHfj8JD+rpFfu;20:T3bD4ROqEdwv87XFwxK9ypy+BnroMhi0dTcfSF5Wn05cVsKgKrR+zJ4SjRINBBZzFD61FIQP42lHCqo45PHExUKHNJuATbvyhyE/LKmlX1Mnt71AgEOter7asydIerFmsFxYB3RY4CN3vhNOZ1u1UBVFvlmtFoVonucq1uJt//U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0416;
x-ms-traffictypediagnostic: MWHPR04MB0416:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0416ACDA00C67E2C53BC1B809A630@MWHPR04MB0416.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0416;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0416;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(346002)(396003)(376002)(199004)(189003)(13464003)(110136005)(8936002)(316002)(2906002)(54906003)(81156014)(97736004)(486006)(6116002)(3846002)(74316002)(11346002)(476003)(81166006)(446003)(86362001)(25786009)(3280700002)(8676002)(305945005)(5660300001)(3660700001)(6436002)(5250100002)(53546011)(59450400001)(26005)(6246003)(55016002)(53936002)(186003)(33656002)(2201001)(2900100001)(76176011)(2501003)(72206003)(7736002)(4326008)(66066001)(102836004)(68736007)(478600001)(106356001)(6506007)(7696005)(39060400002)(9686003)(229853002)(105586002)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0416;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MnDl/S8BUms9grVrOQ3x9EPgQmcnbpDYgKrCcAjxNPzgMW9nq68Wu//sEgrJIuwQ3rc6iHPmsrEC9vWCOWH0ii0klhbZ/sGlt3rBBxPUoVzt1AnlyrDDzTjw5ZgLi2sf12BPV/PgfuUlbEvH1NLfhSAzeX43XNYBjmlEDrvHCTM0V/U+7QVb3AT2nv0o4dO0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c9aad1c2-5870-41dd-bac9-08d5c6dddfb2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9aad1c2-5870-41dd-bac9-08d5c6dddfb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 10:04:18.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0416
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VA4WOO000713

Hi Evan,
I have some generic notes:
- Why to create new sysfs entries for the configuration descriptor fields if they are just duplication of fields in the device and unit descriptors? And the sysfs representation of the device and unit descriptors is existing already.
- It would be nice to have some "packet" mode allowing to gather configuration changes and apply them at once, not one by one.
- Why to put documentation update in the separate patches?

Regards
Stanislav

> -----Original Message-----
> From: Evan Green <evgreen@chromium.org>
> Sent: Tuesday, May 29, 2018 9:18 PM
> To: Vinayak Holikatti <vinholikatti@gmail.com>; James E.J. Bottomley <jejb@linux.vnet.ibm.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>; linux-kernel@vger.kernel.org; linux-
> scsi@vger.kernel.org
> Cc: Gwendal Grignou <gwendal@chromium.org>; Evan Green <evgreen@chromium.org>
> Subject: [PATCH 0/7] Enable UFS provisioning via Linux
> 
> This series enables provisioning UFS devices using the existing sysfs
> interface. This functionality is primarily useful along the assembly
> line, but might also be useful for end users that receive devices that
> aren't locked down.
> 
> Evan Green (7):
>   scsi: ufs: Add Configuration Descriptor to sysfs
>   scsi: ufs: Add config descriptor documentation
>   scsi: ufs: Make sysfs attributes writable
>   scsi: ufs: sysfs: Document attribute writability
>   scsi: ufs: Refactor descriptor read for write
>   scsi: ufs: Enable writing config descriptor
>   scsi: ufs: Update config descriptor documentation
> 
>  Documentation/ABI/testing/sysfs-driver-ufs | 174 ++++++++++++++++++++---
>  drivers/scsi/ufs/ufs-sysfs.c               | 217 ++++++++++++++++++++++++++---
>  drivers/scsi/ufs/ufs.h                     |  29 ++++
>  drivers/scsi/ufs/ufshcd.c                  |  89 ++++++++----
>  drivers/scsi/ufs/ufshcd.h                  |  16 ++-
>  5 files changed, 458 insertions(+), 67 deletions(-)
> 
> --
> 2.13.5
