Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeB1PMP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:12:15 -0500
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:37667
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752722AbeB1PML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:12:11 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 0/8] Decode IA32/X64 CPER
Thread-Topic: [PATCH v2 0/8] Decode IA32/X64 CPER
Thread-Index: AQHTrzmGNIT5DEMr+0GLgvlHp3HCk6O5geyAgABgJNA=
Date: Wed, 28 Feb 2018 15:12:09 +0000
Message-ID: <DM5PR12MB1916B6CA08F0D423B3635EDDF8C70@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180228084321.GA2969@pd.tnic>
In-Reply-To: <20180228084321.GA2969@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [71.199.237.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1930;7:OcyAMvEIQhBLhyMPahuFRYYoG7n6Rboem1eRanqhaEN3cYASCDCuCaN+k9kNOOAVy62tRiKymv2uDN/ZbzF2XKRH2533j8V7lOKvVb2n03pXjX9Ac2ZHS9c+feFm9xSrIsf/OlfRWhpRnyYfXy/pNUB7dQyX66A/QLLnB1dbJYzNKPE8x+injeyd4d113Tahbz002+jdm4u06AHzWUPFEc1FL7SIlVjBuW+qNyoFQtozqY8OdiPdV6zbk/5XZjPp;20:Kh3kKNYZOrWukJ5RjUMvDVhSqfK6DoBMXRtghB5yPxP8GN14zbEtfNzlIvcqC5iqISUyt9/WquhH+sOfBCWykM+F++yFqaJIVRVVllP4PCpV8g4IC94LfMP1EY3QH0OC2FPb5qt6Lc9jC84zZUzEOQlS6IKCO2Xw9mjLwqVEG9J4HyzimQUPWfhxpB+fWu/CQo/XQr+S3aOsYjW8F6RM8QRFz7x8fCKwezMv4IUxR8SB/FAegSHGG6d0Z3TFhLe9
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66f500ad-ab62-40da-43b3-08d57ebda38c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1930;
x-ms-traffictypediagnostic: DM5PR12MB1930:
x-microsoft-antispam-prvs: <DM5PR12MB19300C155A7D019CC0264107F8C70@DM5PR12MB1930.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501217)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB1930;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1930;
x-forefront-prvs: 0597911EE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(13464003)(189003)(199004)(3846002)(97736004)(2950100002)(2906002)(6436002)(316002)(8936002)(6506007)(59450400001)(186003)(3660700001)(110136005)(3280700002)(8676002)(229853002)(2900100001)(26005)(106356001)(53546011)(6116002)(25786009)(66066001)(81156014)(102836004)(81166006)(5250100002)(5660300001)(55016002)(9686003)(105586002)(54906003)(33656002)(99286004)(7736002)(4326008)(53936002)(86362001)(7696005)(74316002)(72206003)(6246003)(305945005)(14454004)(76176011)(478600001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1930;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: DwgmjiYQqLRxKKg2uLCzN/xLY7Y+1ZYbMkefsHq0SOiAtOpHSdsX9BO1oJ7Ld0XBwRTa3l3ggrgdjySUGSJXPFz6K9RX8DT2pAnKKxnaJ8ygGoI4sT514oYByNTYzHxmaj/ikjA9t35EXMl4zXO7kIJ3BBLjvn3EF5JDICpCyug=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f500ad-ab62-40da-43b3-08d57ebda38c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2018 15:12:09.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1930
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1SFCM4G010433

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Wednesday, February 28, 2018 3:43 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>; Tony Luck
> <tony.luck@intel.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 0/8] Decode IA32/X64 CPER
> 
> On Mon, Feb 26, 2018 at 01:38:56PM -0600, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > This series adds decoding for the IA32/X64 Common Platform Error Record.
> 
> One much more important thing I forgot about yesterday: how is
> this thing playing into our RAS reporting, x86 decoding chain, etc
> infrastructure?
> 

It doesn't right now.

> Is CPER bypassing it completely and the firmware is doing everything
> now? I sure hope not.
> 

CPER is the format used for BERT, etc. We'll only ever see a CPER if the
firmware creates it. And it's up to firmware policy what is shared with
the OS.

This set adds decoding for the x86 CPER format which will mostly map to
core MCA errors. There's a memory CPER format that DRAM ECC, etc. will
use, so that's not covered here. In other words, common errors like
corrected DRAM ECC won't be reported with this patch set.

Most likely, we'll only see CPERs in BERT because BERT only uses CPERs.
HEST has MCA structures that can be used. Meaning we won't see MCA
errors reported through CPERs during runtime.

So the most common scenario will probably be that the system resets,
firmware found an MCA error during boot, and firmware populates BERT
with a CPER. The error gets printed during OS boot. By the time userspace
is up the error has already be printed. The error is printed as informational
since there isn't any action for the OS or user to take.

My main reason for printing all the info is that it may be too difficult or too
late to gather that info after the fact. I think this is especially true for boot
errors, though maybe there's another way that I don't know about
(re-reading BERT later?).

> If not, it needs to tie into our infrastructure and the errors need
> to go into the decoding chain where different things look at them and
> filter them.
> 

Right. I want to work on getting this more integrated with our existing
x86 infrastructure. But I don't want to wait until we figure all that out
before we have some sort of CPER decoding.

> Tony, what are your plans here?
> 
> Perhaps we can finally get MCE decoding on Intel too :-)
> 

Thanks,
Yazen
