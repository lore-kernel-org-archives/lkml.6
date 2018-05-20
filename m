Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeETRz1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:55:27 -0400
Received: from mail-by2nam01on0139.outbound.protection.outlook.com ([104.47.34.139]:5056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751685AbeETRzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:55:24 -0400
From: KY Srinivasan <kys@microsoft.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        "mingo@kernel.org" <mingo@kernel.org>, "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-tip-commits@vger.kernel.org"
        <linux-tip-commits@vger.kernel.org>
Subject: RE: [tip:x86/hyperv] x86/Hyper-V/hv_apic: Include asm/apic.h
Thread-Topic: [tip:x86/hyperv] x86/Hyper-V/hv_apic: Include asm/apic.h
Thread-Index: AQHT74AckHFXr9qFTkSs9mrWwAJdZqQ46Ceg
Date: Sun, 20 May 2018 17:55:21 +0000
Message-ID: <BL0PR2101MB110754B858C4DDF3DA0FCFEEA0960@BL0PR2101MB1107.namprd21.prod.outlook.com>
References: <tip-61eeb1f6d1f2648a218855d7c8d44f16df242ef3@git.kernel.org>
In-Reply-To: <tip-61eeb1f6d1f2648a218855d7c8d44f16df242ef3@git.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:b076:3b2a:409c:285e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1027;7:nGlXAQ9AkRj6RfbxAt30rFDYF+AtlDw9kZs9msJZZNHNwxX+sGrdsYCgG48aZiHVHiiMsYbRBMny09HZxie/W8aYc0CLNDcjIxfuqmpA9MJCUGtnzRne7UfKvYOtncm9BWSpJMwk0H8PgumBGorKK7XWHdWtCyRKJuBJ/7Y9Icf9z8utv9Umgg92L92epW2mPZ48f5lIdCPXO0hjcQCtLkJmyppVRzbD9kf3DwWaP9HuZ8RT6e+FM2HeyEiEVjNY;20:r6GKVMDI24e/PXaLCGojMeMRHAUuPEe+8BQeMgve2w26BO1uZQdjQ0Qy/4JY+aZ3i8fhUHw0meCvFzOvfdc/oWvStArdZh4DNcisnzF5/s2GVotTLXaML/WicyEsGAoVCQ8Xn6N6NLLLPWSqD2k49hdnvIeXuxzT5N46m1EPXR4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB10272BC1240940BBC9F25334A0960@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(219752817060721)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1027;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1027;
x-forefront-prvs: 06780E24F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(39860400002)(346002)(396003)(199004)(189003)(13464003)(2900100001)(86362001)(7696005)(68736007)(14454004)(10090500001)(7736002)(8990500004)(2906002)(1511001)(966005)(22452003)(229853002)(110136005)(74316002)(25786009)(6246003)(2201001)(53936002)(316002)(9686003)(6306002)(86612001)(76176011)(486006)(3280700002)(446003)(186003)(2501003)(8936002)(105586002)(33656002)(53546011)(8676002)(476003)(478600001)(6436002)(6506007)(55016002)(102836004)(3660700001)(10290500003)(99286004)(305945005)(59450400001)(81166006)(97736004)(5660300001)(106356001)(5250100002)(46003)(11346002)(81156014)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1027;H:BL0PR2101MB1107.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qBbeyyU4xq4XZUsrqXOrnw2ckf+dOve/XHyUgEpnPaa8G3PGGxvWelBlCDEgOXJUeX4FKdFDCKpHrDs9k2imGdJeIpKWgATe5iS/ax2NcC4LwufoxDcn3uAd+GD95xAcxzFoJX9ehdHBvCzLmJ4dsw8kH/eY96xw9p4Ik4jDhvGSBWVn7IMzlgiiRz0ws68j
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f6d6f78a-287f-4975-6b85-08d5be7adafc
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d6f78a-287f-4975-6b85-08d5be7adafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2018 17:55:21.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4KHtdcI002303



> -----Original Message-----
> From: tip tree robot <tipbot@zytor.com>
> Sent: Saturday, May 19, 2018 7:46 AM
> To: linux-tip-commits@vger.kernel.org
> Cc: hpa@zytor.com; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> tglx@linutronix.de; mingo@kernel.org; lkp@intel.com
> Subject: [tip:x86/hyperv] x86/Hyper-V/hv_apic: Include asm/apic.h
> 
> Commit-ID:  61eeb1f6d1f2648a218855d7c8d44f16df242ef3
> Gitweb:
> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ker
> nel.org%2Ftip%2F61eeb1f6d1f2648a218855d7c8d44f16df242ef3&data=02%7
> C01%7Ckys%40microsoft.com%7C9469b1fea91344d65b9f08d5bd973c7c%7C7
> 2f988bf86f141af91ab2d7cd011db47%7C1%7C1%7C636623379628726325&sdat
> a=mbprYiPRtCsbYHGm%2BMsmUUt4MGGMFloyTN5Y40JrnKg%3D&reserved
> =0
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Sat, 19 May 2018 16:38:59 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Sat, 19 May 2018 16:41:59 +0200
> 
> x86/Hyper-V/hv_apic: Include asm/apic.h
> 
> Not all configurations magically include asm/apic.h, but the Hyper-V code
> requires it. Include it explicitely.

Thanks Thomas. I was planning to send this patch today after I saw the kbuild robot mail.

Regards,

K. Y
> 
> Fixes: 6b48cb5f8347 ("X86/Hyper-V: Enlighten APIC access")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 192b6ad6a361..d3ff6e255924 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -29,6 +29,7 @@
>  #include <linux/cpuhotplug.h>
>  #include <asm/hypervisor.h>
>  #include <asm/mshyperv.h>
> +#include <asm/apic.h>
> 
>  #ifdef CONFIG_X86_64
>  #if IS_ENABLED(CONFIG_HYPERV)
