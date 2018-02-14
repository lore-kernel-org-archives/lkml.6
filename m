Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032528AbeBNQ2c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:28:32 -0500
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com ([104.47.38.70]:20841
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032204AbeBNQ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:28:30 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 2/3] x86/MCE/AMD, EDAC/mce_amd: Enumerate Reserved SMCA
 bank type
Thread-Topic: [PATCH 2/3] x86/MCE/AMD, EDAC/mce_amd: Enumerate Reserved SMCA
 bank type
Thread-Index: AQHTm41/Xv4E/KNhJUiK25p9Z3IfLaOaqBmAgAmCRUA=
Date: Wed, 14 Feb 2018 16:28:28 +0000
Message-ID: <DM5PR12MB1916FC8D126DD2926F44A80BF8F50@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-2-Yazen.Ghannam@amd.com>
 <20180208151507.GE7964@pd.tnic>
In-Reply-To: <20180208151507.GE7964@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [71.199.237.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2344;20:98JBSyDMnnYbwVQxTqTA6ty5d03g86Kc9fp+oJpcsIoFp83SODy8STL67u7RDtob8c2xG+kArYKhtfwldxGHVyUw4HJrgDhGnp65vAArEvWPAZrxUkt9G0vg/efeuMwhksim50Bz13jeUa+WSXg3wWYy1bQ9QDWLLQhFQIrrMI+AbdlmgEbylEO8OWRtYzT7hwffKwCKYDVq5aqJbL063fVwj+qZurdIAAV6Krt1R/s7rvQEh68W/JCYQRlFXZDv
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64d1c4a9-6608-46b0-c548-08d573c7faf5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB2344;
x-ms-traffictypediagnostic: DM5PR12MB2344:
x-microsoft-antispam-prvs: <DM5PR12MB2344FEBC0A4B0FD454169826F8F50@DM5PR12MB2344.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2344;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2344;
x-forefront-prvs: 0583A86C08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39380400002)(39860400002)(376002)(13464003)(189003)(199004)(186003)(7736002)(2906002)(2950100002)(33656002)(6506007)(478600001)(72206003)(2900100001)(25786009)(14454004)(86362001)(7696005)(3846002)(5660300001)(6916009)(97736004)(229853002)(6116002)(9686003)(106356001)(4326008)(6436002)(105586002)(55016002)(6246003)(76176011)(99286004)(26005)(15650500001)(68736007)(77096007)(53936002)(74316002)(81156014)(8676002)(8936002)(3280700002)(305945005)(3660700001)(59450400001)(53546011)(66066001)(81166006)(54906003)(316002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2344;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: aaO8DrbbmtjjT9B7NttwimA0QWAg3rZluh4aFYy7ejmqhwf+5wsXiKDp44HLDOM2duwAlosvecEN9pi0Ms2KqA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d1c4a9-6608-46b0-c548-08d573c7faf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2018 16:28:28.7796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2344
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1EGScD3032463

> -----Original Message-----
> From: linux-edac-owner@vger.kernel.org [mailto:linux-edac-
> owner@vger.kernel.org] On Behalf Of Borislav Petkov
> Sent: Thursday, February 8, 2018 10:15 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; bp@suse.de;
> tony.luck@intel.com; x86@kernel.org
> Subject: Re: [PATCH 2/3] x86/MCE/AMD, EDAC/mce_amd: Enumerate Reserved
> SMCA bank type
> 
> On Thu, Feb 01, 2018 at 12:48:12PM -0600, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Currently, bank 4 is reserved on Fam17h, so we chose not to initialize
> > bank 4 in the smca_banks array. This means that when we check if a bank
> > is initialized, like during boot or resume, we will see that bank 4 is
> > not initialized and try to initialize it. This may cause a call trace,
> > when resuming from suspend, due to *on_cpu() calls in the init path.
> 
> Please be more specific: the rdmsr_*_on_cpu() calls issue an IPI but we're
> running with interrupts disabled, which triggers:
> 
>  WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291
> smp_call_function_single+0xdc/0xe0
> 

Okay.

...
> > @@ -433,6 +437,9 @@ static u32 get_block_address(unsigned int cpu, u32
> current_addr, u32 low, u32 hi
> >  	u32 addr = 0, offset = 0;
> >
> >  	if (mce_flags.smca) {
> 
> As a last patch in the series: please carve the code in this
> if-statement into a smca_get_block_address() helper. And it doesn't need
> the stable tag as it is only a cleanup.
> 

Will do.

Thanks,
Yazen 
