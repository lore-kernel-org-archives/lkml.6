Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932138AbeB0P2l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:28:41 -0500
Received: from mail-sn1nam02on0054.outbound.protection.outlook.com ([104.47.36.54]:60384
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752930AbeB0P2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:28:38 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure
 GUIDs
Thread-Topic: [PATCH v2 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure
 GUIDs
Thread-Index: AQHTrzmKOzlbKWzCnUq8dgNCnwiGJqO4UIoAgAAQFsA=
Date: Tue, 27 Feb 2018 15:28:37 +0000
Message-ID: <DM5PR12MB191643165F74F3BDB469C5BCF8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-5-Yazen.Ghannam@amd.com>
 <20180227143020.GG26382@pd.tnic>
In-Reply-To: <20180227143020.GG26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1675;7:I8ezhAStswt6+kgbDq/ttjo5iGHaXsU8Ee6LthP77wS8mtjCn5oan+5GTm8SA0viy5onNVCD+Z9cF9MgMsDLNZBO0ZBHusvHQYD7yP9BF23wsQLYI0iHLl4fy3X0W7+s2sd/QnkRZcY7d/4JhZtoeMh3ptvYEXc1w6cM8/Z1wm0+atK0nLmHmETMwpmdc10eekkmTtChcx+5SgAJZL+NPQCx5/JtFL0ubAK4Yu2v7x/kpKqtqMhrjsEilHFu0MLJ;20:mB/tGEufAQeUDzCQHc1X+XZxj2N/ce92ncyBkHVajlKL/OSbgeqC43azt0gtoa7Rp/yfFT+h/pDrZ8VORlbnKa+8ovyU9KXu1304gJJBMsccKPiOuY5JgkFj+BtqtmDtXcEDNsw8IW4RWu9zVgDbP7lrs++3a0mws7tngVznyTPUoA8Zs6IVqdiyQCIDAe1q725EHxWjHYQvhS7uWTDRoEEHcnHUeq3+DeIdUgqQEwjvOszLMlckmo4w/C1+NMS4
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb2741df-3876-4a89-f119-08d57df6c599
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1675;
x-ms-traffictypediagnostic: DM5PR12MB1675:
x-microsoft-antispam-prvs: <DM5PR12MB1675E5B03142E901B82520B3F8C00@DM5PR12MB1675.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1675;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1675;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(199004)(189003)(13464003)(5660300001)(76176011)(2900100001)(26005)(2950100002)(8936002)(186003)(53936002)(3846002)(6116002)(305945005)(7736002)(3280700002)(6246003)(99286004)(54906003)(53546011)(6916009)(4326008)(7696005)(9686003)(81166006)(81156014)(2906002)(8676002)(316002)(229853002)(14454004)(55016002)(25786009)(6436002)(6506007)(72206003)(86362001)(68736007)(478600001)(102836004)(66066001)(106356001)(33656002)(74316002)(3660700001)(5250100002)(97736004)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1675;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rSGy1JhR9UmMWL9TsNsDr2JxA8HcQXaHLfGGSEOU0+uZkyYS6WupUDOh1AUjp1JuRy7+QntOIugB5Ph0YQzCMqpswMUDLSpjlFB8bIBVhwK8YbvcxKYiJHFE3G+dc4MM+OQFq+kvq08V4qmPyXqaDr5BBLUxu+u1aEUwPTQxgiE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2741df-3876-4a89-f119-08d57df6c599
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 15:28:37.1857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RFSm9d013433

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 9:30 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 4/8] efi: Decode UEFI-defined IA32/X64 Error
> Structure GUIDs
> 
> On Mon, Feb 26, 2018 at 01:39:00PM -0600, Yazen Ghannam wrote:
> > @@ -45,6 +81,11 @@ void cper_print_proc_ia(const char *pfx, const struct
> cper_sec_proc_ia *proc)
> >  		printk("%sError Structure Type: %pUl\n", newpfx,
> >  		       &err_info->err_type);
> >
> > +		err_type = cper_get_err_type(&err_info->err_type);
> > +		printk("%sError Structure Type: %s\n", newpfx,
> > +		       err_type < ARRAY_SIZE(cper_proc_error_type_strs) ?
> > +		       cper_proc_error_type_strs[err_type] : "unknown");
> 
> Ah, there it is, much better. Now this tells us what component it is.
> 
> So cper-arm.c does the same thing and there's a similar thing in cper.c -
> cper_print_proc_generic().
> 
> Let's not tri-plicate that code pls and have a generic function instead.
> 

Sure, I can do that.

Ard, is this okay?

Thanks,
Yazen
