Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934811AbeB1U6U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:58:20 -0500
Received: from mail-cys01nam02on0077.outbound.protection.outlook.com ([104.47.37.77]:14659
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934698AbeB1U6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:58:18 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: Tony Luck <tony.luck@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 0/8] Decode IA32/X64 CPER
Thread-Topic: [PATCH v2 0/8] Decode IA32/X64 CPER
Thread-Index: AQHTrzmGNIT5DEMr+0GLgvlHp3HCk6O5geyAgABgJNCAACPSgIAARNAQ
Date: Wed, 28 Feb 2018 20:58:15 +0000
Message-ID: <DM5PR12MB19169CD3BC3BAE3230C1DCA3F8C70@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180228084321.GA2969@pd.tnic>
 <DM5PR12MB1916B6CA08F0D423B3635EDDF8C70@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180228163539.GC2969@pd.tnic>
In-Reply-To: <20180228163539.GC2969@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [71.199.237.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1721;7:ufuGlUHn2XrKvsh/NVlaOo9z9mUzgCKcW1ILZ8C7EM5SdcmNJY20BmCpteupVwXXgntiCsr1KD6B0MNVC3nlYpZO2TSmZ9fkQwUH0ZbDjR1+OFMfMhy+10OZ+Dsou8xDSHDeNBrBYiNPje/XsC8aIf4NUs0Puti36cvAZ0wD0yctuIk1jVuKWr03VrRsHVPJ/tEpsdaqZ7h2bs147uS9ICOpFyphOJBUw3eoC57f2yIL3N0YqXoE+JG2Z/bMzSxu;20:UAz0hal/pRHMP4UN+XOW/KNRWr1JQi6n/wna6l9BN2YR7kNN4Wir6RuLXNHSv7W8QT70O15+5601FVeCthMU/kzM1+zhmQIjxOONo+buh8b6yFho0kG+1DihXz1EdmlD0/aN0/R7laexNVUZhdAvNJixR7rM+jxPSI/+rvNrP7CIitMAmFVLBcIsFrj7WWctjEd8YTSkpT9xYlVKZDKW73iOPQlfnm8eicQXIRtj5xjgKPpBoZct6LaEZMc69jEr
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 016acee0-46e7-42d4-e935-08d57eedfcc1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1721;
x-ms-traffictypediagnostic: DM5PR12MB1721:
x-microsoft-antispam-prvs: <DM5PR12MB1721EA28F4939920DB687FF9F8C70@DM5PR12MB1721.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1721;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1721;
x-forefront-prvs: 0597911EE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(396003)(346002)(366004)(39860400002)(13464003)(189003)(199004)(6246003)(68736007)(99286004)(81156014)(2906002)(14454004)(106356001)(3280700002)(3660700001)(3846002)(6116002)(81166006)(8676002)(76176011)(8936002)(6916009)(66066001)(7696005)(186003)(105586002)(5250100002)(5660300001)(26005)(72206003)(305945005)(7736002)(316002)(54906003)(74316002)(2950100002)(97736004)(229853002)(86362001)(102836004)(6436002)(9686003)(33656002)(53936002)(25786009)(93886005)(55016002)(478600001)(2900100001)(53546011)(6506007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1721;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 0eYDvoaZxOQq1R74vJ/lxKz/6NI7z5gKlCNV6mFjmWZHV7j2q0a3boYGhb+KX99gGKKtRSWe43W2gWER2tammnPqhVT/2RqIqNjflBD9SuEi6xJ0EGzyaFbU1YpAdoi+rId/6NKeA/ihtSFz5MSTjAmY/pNKz7ouBngcIFVLObo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016acee0-46e7-42d4-e935-08d57eedfcc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2018 20:58:15.5083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1SKwSPD017748

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Wednesday, February 28, 2018 11:36 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: Tony Luck <tony.luck@intel.com>; linux-efi@vger.kernel.org; linux-
> kernel@vger.kernel.org; ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 0/8] Decode IA32/X64 CPER
> 
> On Wed, Feb 28, 2018 at 03:12:09PM +0000, Ghannam, Yazen wrote:
> > CPER is the format used for BERT, etc. We'll only ever see a CPER if the
> > firmware creates it. And it's up to firmware policy what is shared with
> > the OS.
> 
> Yap, but we should still tie it into our infra.
> 

Okay, so how about this?

1) We keep this set mostly as-is. This would be our fallback if we don't have
anything better.

2) I add the MCA decoding to this set. I was thinking to do this in a separate
set but maybe it's better to do it all together.

Number 2 would mean we do a quick check on the CPER to see if it contains
MCA info. There's no spec-defined way to do this, but we can make a good
guess by seeing if we have an "MSR register" context and that context has
an "MSR address" that is an MCA register.

If we think we have MCA info, then we pull as much out of the CPER as we
can and put it in a struct mce which we then pass to the notifier chain.

If we don't think we have MCA info, then we fallback to number 1.

At the moment, it seems we'll be using x86 CPER to represent MCA errors
in BERT since there's no other option in BERT. So I think having number 2
would catch most, if not all, errors reported with x86 CPER.

Thanks,
Yazen
