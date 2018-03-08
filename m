Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935849AbeCHQ3J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:29:09 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:17136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752093AbeCHQ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:29:07 -0500
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
CC: Roman Kagan <rkagan@virtuozzo.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to
 HV_X64_MSR_VP_ASSIST_PAGE
Thread-Topic: [PATCH v2 1/5] x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to
 HV_X64_MSR_VP_ASSIST_PAGE
Thread-Index: AQHTryTagN9LcIOP8EeO7eDWMLEx76PFAeoAgAAH9oCAABVfgIABD93agABh+wA=
Date: Thu, 8 Mar 2018 16:29:04 +0000
Message-ID: <DM5PR2101MB1030A704CDF4DF12E26141B9DCDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180226171121.18974-1-vkuznets@redhat.com>
        <20180226171121.18974-2-vkuznets@redhat.com>    <20180307161944.GE12290@flask>
 <20180307164812.GA2366@rkaganb.sw.ru>  <20180307180442.GA16795@flask>
 <87lgf2yipt.fsf@vitty.brq.redhat.com>
In-Reply-To: <87lgf2yipt.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-08T16:29:02.7274390Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:jyZ5Dd2fhnGla9Ni4IgDowzTz+WnOqtWjoKaabTrSMS6d6TTiCPr6BTShfUEzkxxhw/zjqFGjXyRv8MJ8NlFw60iNaNQDbFfFOkLON41uN3kwwjJPNoI1/3FhhvpzGEeUVR+G95Ew4zAWHG1GM6bElglSrAyf8YANsZs6LUCy5Nbnfpyf1YQqkZ6qPm07c7OUkTq3nH3+frgropGWlOdeojmEUBamPDYNltwQqR/wEznXsv5riT72hxUNlGntbT6;20:jT3UOKIL3dxFd9Zb38LwL4S87xtSDnZeegj17XAwwqlz6N/buM6pp1xcrX1VjA2bUDBnuSqgzeXF+xf0+nia2stOIL2ubVsFqBgGXzUZoCky6bQBHyI+CCs9opEp4G27556dPFF4IDdNpvk7MTdcoV3cOKmY6BAvTt/pKmf/+2E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41f4ee25-6c83-4758-15b7-08d58511b56a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101643A05876673160FA5DD7DCDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(376002)(396003)(199004)(189003)(76104003)(10290500003)(3846002)(2900100001)(68736007)(22452003)(305945005)(5660300001)(229853002)(478600001)(86612001)(6116002)(7416002)(74316002)(66066001)(106356001)(4326008)(5250100002)(97736004)(3660700001)(7736002)(8676002)(81166006)(81156014)(8936002)(6506007)(6246003)(105586002)(9686003)(8990500004)(6436002)(2950100002)(26005)(186003)(55016002)(25786009)(15760500003)(3280700002)(316002)(2906002)(99286004)(33656002)(14454004)(102836004)(7696005)(86362001)(10090500001)(93886005)(72206003)(54906003)(76176011)(53936002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: NyujxBIc4d3AD41HrHUSQjfnKs+n8pjzhDkkN/Jz+82wrD+k/BbxsMOab9IUJtDkgsYM5D7nmb/Dz2qKH/Z8uwfXRHOmAROfziuPLHvsssbSaIOdkS2EGstjeFKgb1BLUkM5KUfVaTCs5ehjbTG5DRY4nI+U14V0bihixulvqcPoHWiYGhpm/GQpupvelWu/CkfpgNCB3UcK6ZU/JxAMR7gS6I6qZkU3vqI0tXDKw5dWtWHm9JCgp9Ez+zrHXOEK0rcAePHmVPJFXPo38ZYrZHad6HoVLxZeve2pDswIfgBZAe+Zv1m9B6SrlVQyMG+aVStQjrm4JX7y2fnQPAz50g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f4ee25-6c83-4758-15b7-08d58511b56a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 16:29:04.5748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28GTEH6013332

> >> > Removing definitions from userspace api isn't a good idea.
> >> >
> >> > I have no idea why hyper.h is a userspace api, though -- Linux doesn't
> >> > define any of those, so we could copy the definitions to a private
> >> > header, rename, and never look at this file again.
> >>
> >> That was a thinko when it was moved to uapi, and it has already been
> >> identified as a problem, so now QEMU has its own header with the
> >> definitions it needs, and I'm unaware of any other userspace project
> >> that depends on this stuff.  So I've been planning to remove it from
> >> uapi but still haven't got around to posting the patch :(
> >
> > Great, let's be bold here.
> 
> asm/hyperv.h is not uapi.
> 
> I would include a patch renaming arch/x86/include/uapi/asm/hyperv.h to
> arch/x86/include/asm/hyperv.h but we already have 'mshyperv.h' there and
> I don't quite understand the difference. We can either merge them or
> come up with a rule distinguishing them.
> 
> K. Y., Michael, what do you think?

Good timing for this topic, as I'm now looking at cloning these two
files into the arch/arm64 tree for Hyper-V on ARM64.  It would be great
to get a plan agreed on so I can be consistent on the arm64 side.

I would suggest keeping two files:  one with just the data structures and
#defines that come from the Hyper-V Top-Level Functional Spec (TLFS),  
and the other with additional data structures, macros, function prototypes,
etc. that are specific to Linux guest code.   uapi/asm/hyperv.h is already
the first one, and asm/mshyperv.h is mostly the second one, though it has
some things that should probably move to the first one.   There are also a
few stray definitions from the Hyper-V TLFS in drivers/pci/host/pci-hyperv.c
(HVCALL_RETARGET_INTERRUPT and HV_PARTITION_ID_SELF, for example)
that really belong in the first file.

And since we're already changing the location of the first file, let's rename
it to hyperv-tlfs.h or something similar.

Michael

> 
> --
>   Vitaly
