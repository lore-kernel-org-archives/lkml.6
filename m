Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeBZQBj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:01:39 -0500
Received: from mail-sn1nam02on0083.outbound.protection.outlook.com ([104.47.36.83]:60965
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751947AbeBZQBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:01:37 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure
 GUIDs
Thread-Topic: [PATCH 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure
 GUIDs
Thread-Index: AQHTrOGVL5hT+aL1S0SLQTAsr7jVxqOzwtcAgAMZU7A=
Date: Mon, 26 Feb 2018 16:01:35 +0000
Message-ID: <DM5PR12MB1916D6F66B70E73013D1DA60F8C10@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
 <20180223200333.6410-5-Yazen.Ghannam@amd.com>
 <CAKv+Gu_xQseJg3ABoD74hJt6ZbMZF7zE75Gc9ZNN4SsftnNN4g@mail.gmail.com>
In-Reply-To: <CAKv+Gu_xQseJg3ABoD74hJt6ZbMZF7zE75Gc9ZNN4SsftnNN4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.199.237.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1385;7:mgv/u3rE0/e8AXptezpBfJAN+2VWy+a3v0z49prCoZytsYXE/yHUxPvFH8jQhIE+iTwWkrYWyF2ZETAaPMId1OndD6ZgFhdMgbb1xfmb/WmijSuiV6FpdCNvDXqiv1Q2j+oBEO60G2/ZqeiD08NyTyA2VCW4lItdxX3vGtO8UR9G4bOvlAnNJXfgolPZLOaoaha4chqMok1odHaDxayM5P4tzJvdXeiFSyAyiWSqMaXqEkTAySRRNX+oIt6aXMgU;20:SDpgWujQOwV0fXcAvwdxgb9uryFOAY/8zNcf/c7JZWawa2/jK0gQQivqMUQ7F6dC0r65+/8gHAolsV7xVvwfYpx8Q++hY8h1MoRK9V1H4IV6NiBnei+neYH2V3jLaxO9AkwFzLU2ZF9ign69nwsotbU1Ce6CP2oFz/bkR+3mw2YtZ/OfskQPAbvLORxx1aTk1mKkhPl6a31O2revONLQLVNkp9mWrqSjEbZlfNWhqtZLd6yd9/5fZ7bqF9XOrpLr
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14c4d3c4-8a03-4a15-14bf-08d57d32363b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1385;
x-ms-traffictypediagnostic: DM5PR12MB1385:
x-microsoft-antispam-prvs: <DM5PR12MB138505710D0CCE8B621F3ECBF8C10@DM5PR12MB1385.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501187)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1385;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1385;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(366004)(39380400002)(13464003)(199004)(189003)(2950100002)(6916009)(53936002)(5660300001)(14454004)(74316002)(316002)(26005)(55016002)(229853002)(6346003)(2906002)(186003)(76176011)(54906003)(68736007)(6116002)(3846002)(66066001)(6506007)(53546011)(6246003)(4326008)(97736004)(106356001)(105586002)(102836004)(5250100002)(25786009)(2900100001)(9686003)(8936002)(81166006)(305945005)(478600001)(81156014)(99286004)(33656002)(72206003)(6436002)(3280700002)(3660700001)(8676002)(86362001)(7736002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1385;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-microsoft-antispam-message-info: L6bNiYNuxsmsisCcG1viXnefr4F2bwhXl/tC8LB3ZeGa6myzyb/4oglnCfdpiLMF2zUcTtrrfkgIxlALCircyic/CyBTdSNfaaHFv3OCpJwQ93b+I1bGBEsN8j9AN66u9vKulW88766qGYlHE4OiG4vI/78CvDoAUe0ppo+4NXI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c4d3c4-8a03-4a15-14bf-08d57d32363b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 16:01:35.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QG1mIH001204

> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> Sent: Saturday, February 24, 2018 11:41 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Borislav Petkov <bp@suse.de>; the arch/x86
> maintainers <x86@kernel.org>
> Subject: Re: [PATCH 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure
> GUIDs
> 
> On 23 February 2018 at 20:03, Yazen Ghannam
> <Yazen.Ghannam@amd.com> wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > For easier handling, match the known IA32/X64 error structure GUIDs to
> > enums.
> >
> > Also, print out the name of the matching Error Structure Type.
> >
> > GUIDs taken from UEFI 2.7 section N.2.4.2.1 IA32/X64 Processor Error
> > Information Structure.
> >
> > Cc: <stable@vger.kernel.org> # 4.16.x
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  drivers/firmware/efi/cper-x86.c | 41
> +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
> x86.c
> > index 9d608f742c98..3b86223bdb67 100644
> > --- a/drivers/firmware/efi/cper-x86.c
> > +++ b/drivers/firmware/efi/cper-x86.c
> > @@ -14,17 +14,53 @@
...
> >  void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia
> *proc)
> >  {
> >         int i;
> >         struct cper_ia_err_info *err_info;
> >         char newpfx[64];
> > +       enum err_types err_type;
> >
> 
> Can you make this an u8 please? The signedness of an enum is not well
> defined, and you only check the upper bound below.
> 

Yes, will do.

Thanks,
Yazen
