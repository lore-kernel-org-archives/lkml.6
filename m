Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeBZPqW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:46:22 -0500
Received: from mail-by2nam03on0050.outbound.protection.outlook.com ([104.47.42.50]:26688
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751570AbeBZPqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:46:20 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH 0/8] Decode IA32/X64 CPER
Thread-Topic: [PATCH 0/8] Decode IA32/X64 CPER
Thread-Index: AQHTrOG2/N2xHUFIGkOCqihNXWrl/qOzxFIAgAMTrBA=
Date: Mon, 26 Feb 2018 15:46:18 +0000
Message-ID: <DM5PR12MB1916D75D9526C2DB22D16CABF8C10@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
 <CAKv+Gu82+nPRhKSzAvTvwWqVPhi0zhjN4uC8_ZzA7HvBLEuuig@mail.gmail.com>
In-Reply-To: <CAKv+Gu82+nPRhKSzAvTvwWqVPhi0zhjN4uC8_ZzA7HvBLEuuig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [71.199.237.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1915;7:4ZXtyNpVToGETFGh8apqzXXj64/Het7bGe+OgfZGdXXWD+CJz9YcZxnaQE07nHnT3LYpboGBqauftbv76beS03JVnaRyawCBdpZouHml6Oam30BEGmbB13QBTefdTpNftU3ntHA3iYnPmpG2kzVNYDNvq03qN0k4q0Lpqr7z2ldbsr/AFYtDZghzN1vIQF3z/cwuGnBL7Iyy2bjINM+0jD09RUaLyk5LPxcNBtkTuyCgfBtNcKgWgnLyYHEpzBvA;20:+3iaVVGAS+jnwVoc0PKv7NbZ08U+FTEiscsOtSqHv7br3S9use/cRPvqTSBSJ0jf67IPQ/A8AQye62gIiCmEQRZG0aygzSi3oxQUogRCmVOgIzChyrX1KGCXrOTJglz2ImJvHXzHq91Uy3r5XlR2MMeJ/WG8M2Aqdn+vJtsKrH+22c+Ub5+36cK/1FyDwr8xk9WFUp3Ze0o2In7dWPgMliy/9Tj0vJyXtRNM3GEo3NppYJ5RPdW/u8pDspWjLCXt
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c0e2af4-1428-4eae-3653-08d57d3013be
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1915;
x-ms-traffictypediagnostic: DM5PR12MB1915:
x-microsoft-antispam-prvs: <DM5PR12MB191581C4B55A30800088E623F8C10@DM5PR12MB1915.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501161)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1915;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1915;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(366004)(39860400002)(396003)(189003)(199004)(13464003)(68736007)(53936002)(14454004)(2906002)(478600001)(97736004)(6246003)(9686003)(72206003)(54906003)(3280700002)(33656002)(305945005)(2900100001)(3846002)(6116002)(5660300001)(81166006)(81156014)(316002)(8936002)(7736002)(8676002)(74316002)(3660700001)(2950100002)(186003)(76176011)(6916009)(105586002)(7696005)(102836004)(229853002)(5250100002)(66066001)(25786009)(55016002)(4326008)(106356001)(86362001)(6506007)(53546011)(26005)(6436002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1915;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: /kJPYnmG+dGsCvvumEAS8tZh9ENpspr6oxQDCB8dyBNTI6iBETfPzDee3bWjhkSYj8lIXS8V8w0UAhKjX1rI8vbAJALswRz55L6UG78QzqaO98mxeF8IgrEYM9v9VHEKSTWyXXuUL/vr5U7hpbeK4FPi/WOLijx7HOh/XsUzAjk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0e2af4-1428-4eae-3653-08d57d3013be
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 15:46:18.4365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1915
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QFkX4E024812

> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> Sent: Saturday, February 24, 2018 11:47 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Borislav Petkov <bp@suse.de>; the arch/x86
> maintainers <x86@kernel.org>
> Subject: Re: [PATCH 0/8] Decode IA32/X64 CPER
> 
> Hi Yazen,
> 
> On 23 February 2018 at 20:03, Yazen Ghannam
> <Yazen.Ghannam@amd.com> wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > This series adds decoding for the IA32/X64 Common Platform Error Record.
> >
> > Patch 1 fixes the IA32/X64 Processor Error Section definition to match
> > the UEFI spec.
> >
> > Patches 2-8 add the new decoding. The patches incrementally add the
> > decoding starting from the top-level "Error Section". Hopefully, this
> > will make reviewing a bit easier compared to one large patch.
> >
> > The formatting of the field names and options is taken from the UEFI
> > spec. I tried to keep everything the same to make searching easier.
> >
> > The patches were written to the UEFI 2.7 spec though the definition of
> > the IA32/X64 CPER seems to be the same as when it was introduced in
> > the UEFI 2.1 spec.
> >
> > Without basic decoding, users will be confused about what these
> > "Hardware Errors" mean. So I'm requesting this set to be applied to the
> > stable branches. This set applies to the v4.16. However, patch 2 will
> > have a conflict on older branches, so I'll send this set again with the
> > conflict fixed.
> >
> 
> These patches look mostly fine to me, with the exception of some minor nits.
> 
> I can queue this for v4.17 if you respin it, but I am not sending 400
> lines of brand new error record parsing code to Greg for inclusion in
> -stable, so please drop the cc stable tags
> 

Okay, will do.

Thanks,
Yazen
