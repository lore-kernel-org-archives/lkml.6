Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeB0PGC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:06:02 -0500
Received: from mail-dm3nam03on0087.outbound.protection.outlook.com ([104.47.41.87]:8061
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753994AbeB0PF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:05:57 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 1/8] efi: Fix IA32/X64 Processor Error Record
 definition
Thread-Topic: [PATCH v2 1/8] efi: Fix IA32/X64 Processor Error Record
 definition
Thread-Index: AQHTrzm02NI0m2EE00a8rW3dY4nrB6O4Ei0AgABHc+A=
Date: Tue, 27 Feb 2018 15:05:54 +0000
Message-ID: <DM5PR12MB1916AC482BB3282CCDEA93ACF8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-2-Yazen.Ghannam@amd.com>
 <20180227104708.GC26382@pd.tnic>
In-Reply-To: <20180227104708.GC26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1786;7:ZyOqDy8t0J9UnmU8WhjRmaEokM+Q82Lt+pAjkzii+7s4+kZqHPM+jcZOKZE1sLKDSrDSrSCd1zTjXvNWBZkd2DwHu5uWZNd6l1BHbRfKIf8FeE9kSHfYXtHCvjrIXpz/l7L2SvalyKMsSNTKyHqMN+uruQjxdp/+PC9eQ+AqD/pYQahtMhmTOAC42b/TdcHGlLoCbfqQNyvuXpRuykG526Ml3NcDfjYKhAo4GHdNnfxhtEvygnVS5E691SUdqUIY;20:bXCBTc2i1UOZljcnpvCP0dFG4ClAN2Lb+GHJKIDj0hIyZnKg0pZI4e41OSmdIsi/l5o808SbEdJ9/MSIJ4pzi75VG68ywFIARJrVWOSUQ3gY+lbdb3qyVRszvq8mROuYOhvrBZrm0semZthXKh2unTBkvhivHQrb0zSmgN/t8P03sm4+Y/66Q5M81DHlgyv9QLoJzw8KvDwbxPVQabN/QHZ+iLFUCmKCBMLA+Ul2IlX0O7dU2Mj3n20JXMJk3AiG
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e212abe8-5c08-41d6-89d1-08d57df3994f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1786;
x-ms-traffictypediagnostic: DM5PR12MB1786:
x-microsoft-antispam-prvs: <DM5PR12MB17865BC569EA9BF1E439C10BF8C00@DM5PR12MB1786.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501198)(52105095)(3002001)(10201501046)(6055026)(6041288)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1786;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1786;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(39380400002)(199004)(189003)(13464003)(81156014)(33656002)(81166006)(8936002)(2950100002)(14454004)(3280700002)(68736007)(66066001)(5250100002)(3660700001)(4326008)(3846002)(966005)(6246003)(72206003)(105586002)(2906002)(97736004)(478600001)(6116002)(74316002)(229853002)(106356001)(7736002)(76176011)(6436002)(2900100001)(6306002)(86362001)(25786009)(59450400001)(53546011)(6506007)(54906003)(6916009)(7696005)(305945005)(186003)(102836004)(99286004)(5660300001)(26005)(9686003)(316002)(55016002)(8676002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1786;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: nR6vSwpe3psULXZixlMEtqhSt7EY2i3jvfv565TTLji/a+5xHIloxI9MgQIMhosyr0vbQWmUKDCWrr6g+nOF816gruwXegzmgWOzLxM9I6+a3LFIcIoB1mMNNPG76KCH7M0nIy6A/oDWP1hazgxjRUFMJ1uULR95N+eA7Gcx/hk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e212abe8-5c08-41d6-89d1-08d57df3994f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 15:05:54.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RF6Kqb006379

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 5:47 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 1/8] efi: Fix IA32/X64 Processor Error Record
> definition
> 
> On Mon, Feb 26, 2018 at 01:38:57PM -0600, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Based on UEFI 2.7 Table 255. Processor Error Record, the "Local APIC_ID"
> 
> My pdf says this is table 252.
> 

Right. I'm using the latest which is UEFI 2.7 Errata A. It turns out that the table
numbering is different between the base and the errata specs. I can change this.

> > field is 8 bytes but Linux defines this field as 1 byte.
> >
> > Fix this in the struct cper_sec_proc_ia definition.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > Link:
> > https://lkml.kernel.org/r/20180223200333.6410-2-
> Yazen.Ghannam@amd.com
> >
> > v1->v2:
> > * No changes.
> >
> >  include/linux/cper.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/cper.h b/include/linux/cper.h
> > index d14ef4e77c8a..4b5f8459b403 100644
> > --- a/include/linux/cper.h
> > +++ b/include/linux/cper.h
> > @@ -381,7 +381,7 @@ struct cper_sec_proc_generic {
> >  /* IA32/X64 Processor Error Section */
> >  struct cper_sec_proc_ia {
> >  	__u64	validation_bits;
> > -	__u8	lapic_id;
> > +	__u64	lapic_id;
> >  	__u8	cpuid[48];
> 
> Ok, that processor error record has a variable length structure at byte
> offset 64 and we don't have it in this struct.
> 
> I guess I'll see it in the following patches but right now it looks
> like that "Processor Error Info" thing is simply situated after that
> Processor Error Record so we are supposed to simply find the info at
> offset 64...
> 
> /me continues reading...

The error and context info tables are defined in other structs and we
access them by offsetting from the previous table.

Thanks,
Yazen
