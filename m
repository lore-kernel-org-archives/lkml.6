Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeCMWqN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:46:13 -0400
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:60538
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932197AbeCMWqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:46:12 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/7] x86/hyper-v: move hyperv.h out of uapi
Thread-Topic: [PATCH v3 1/7] x86/hyper-v: move hyperv.h out of uapi
Thread-Index: AQHTt69VlYYyB8vEwU60xjCapRMb0aPOxdWg
Date: Tue, 13 Mar 2018 22:46:10 +0000
Message-ID: <DM5PR2101MB103059A90CD91DE8FA69920BDCD20@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-2-vkuznets@redhat.com>
In-Reply-To: <20180309140249.2840-2-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-13T22:46:08.3560149Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:q1qKv0Tc9G6hpBOgMZ0hCVlCeURfvYbTLtYqIIQTqU3k1tuAR8tmwWWHiZ5XqZpz3OLVNEEmQmlsPzC1dDavq/mIILmokcAAXtFKO1C505D56cXUd/0l0oKPC2/g95m/gOxjdVM7Pi1+Tsn4Q5cq5awpYQJ2rKe7/YGXnYkIGw0WYbxcALYaI9QXfj4lszIiaa9LZYGzrassgcAO5VnFue6HNyTBuxh1VGP9u9FHBSir9VKDuKAW1V8L76uOXZde;20:EelAdwuRwZdw813R6Cvhusbn03whAOCfIbyV3UsNK4xN3HPyHTPyV7P+baOoKbCrA/vhMHrBS+W/N4Q0Mwz46gorRb5sAhe6HEOqRkEhi7MXvHIKj4tHVq0lgkyMyK70Pst7XAkhzZhvIyvjZ0VVP32+aNZ+Upo6YsmsmGMmmDg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63428d77-01b7-4491-a83f-08d58934375c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
x-microsoft-antispam-prvs: <DM5PR2101MB1047BEC9D0E2A524E42861A1DCD20@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501255)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(346002)(39380400002)(13464003)(199004)(189003)(2900100001)(2906002)(110136005)(3846002)(8990500004)(229853002)(22452003)(6116002)(106356001)(54906003)(6246003)(305945005)(97736004)(10290500003)(33656002)(14454004)(76176011)(3280700002)(72206003)(478600001)(7696005)(55016002)(10090500001)(53546011)(6506007)(7736002)(8676002)(8936002)(2501003)(25786009)(9686003)(4326008)(81166006)(81156014)(5250100002)(86362001)(105586002)(53936002)(66066001)(2950100002)(26005)(6436002)(316002)(3660700001)(186003)(86612001)(5660300001)(99286004)(102836004)(74316002)(6346003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: AdfZrpDISc8jk4N2/R0Ax7FFabJqgA40IALVbA/9ZZkwY0JAqg3XCkSkzDkz1I9qy2fs+ldoA/MUM17WeneWwIgJ459p8tpztNYTk3dFvby2ExeW7mRZFzc5wYqKwsYUn4u7D/gk41XD8FKtiPfGfV4wMli1xi3nXvBK/3933PAqh831fn8ScDpeEOq9Kt8sUilnIFTATjZ+aCZ3LREGtpvxrPUPWW4UP9H31g1/AcRY3Cie2tRVMbRyP6IFnuy9/t5mgZC6M3IQQoaLNLUptIYScUiP5jPhuAJpxRWQ2T/o9oTpycMaLXq8iaBydAgP2wJR360LXgXzVAB+nRTMzg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63428d77-01b7-4491-a83f-08d58934375c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 22:46:10.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2DMkKSN002377

> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Friday, March 9, 2018 6:03 AM
> To: kvm@vger.kernel.org
> Cc: x86@kernel.org; Paolo Bonzini <pbonzini@redhat.com>; Radim Krèmáø
> <rkrcmar@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; Bandan Das <bsd@redhat.com>;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v3 1/7] x86/hyper-v: move hyperv.h out of uapi
> 
> hyperv.h is not part of uapi, there are no (known) users outside of kernel.
> We are making changes to this file to match current Hyper-V TLFS and we
> don't want to maintain backwards compatibility.
> 
> Move the file renaming to hyperv-tlfs.h to avoid confusing it with
> mshyperv.h. In future, all definitions from TLFS should go to it and
> all kernel objects should go to mshyperv.h or include/linux/hyperv.h.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

[snip]

> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 447371f4de56..72855182b191 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -31,7 +31,6 @@
>  #include <linux/vmalloc.h>
>  #include <linux/hyperv.h>
>  #include <linux/export.h>
> -#include <asm/hyperv.h>

This #include should remain and be changed to asm/hyperv-tlfs.h.  This
file uses the hypercall status values HV_STATUS_*.

>  #include <asm/mshyperv.h>
> 
>  #include "hyperv_vmbus.h"
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index fe96aab9e794..45f3694bbb76 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -29,7 +29,6 @@
>  #include <linux/version.h>
>  #include <linux/interrupt.h>
>  #include <linux/clockchips.h>
> -#include <asm/hyperv.h>

This #include should remain and be changed to asm/hyperv-tlfs.h.  This
file uses HV_MESSAGE_* values.

>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> 
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 22300ec7b556..500f805a6ef2 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -27,6 +27,7 @@
> 
>  #include <linux/list.h>
>  #include <asm/sync_bitops.h>
> +#include <asm/hyperv-tlfs.h>
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bc65c4d79c1f..b10fe26c4891 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -36,7 +36,6 @@
>  #include <linux/cpu.h>
>  #include <linux/sched/task_stack.h>
> 
> -#include <asm/hyperv.h>

This #include should remain and be changed to asm/hyperv-tlfs.h.  This
file uses HVMSG_* values.

>  #include <asm/mshyperv.h>
>  #include <linux/notifier.h>
>  #include <linux/ptrace.h>

Michael
