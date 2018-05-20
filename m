Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbeETR4C (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:56:02 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:17733
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750932AbeETRz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:55:59 -0400
From: KY Srinivasan <kys@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>, "lkp@intel.com" <lkp@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-tip-commits@vger.kernel.org"
        <linux-tip-commits@vger.kernel.org>
Subject: RE: [tip:x86/hyperv] x86/Hyper-V/hv_apic: Build the Hyper-V APIC
 conditionally
Thread-Topic: [tip:x86/hyperv] x86/Hyper-V/hv_apic: Build the Hyper-V APIC
 conditionally
Thread-Index: AQHT76kvK3PsjFNWZUaw1ZR1fw/EKaQ46CvQ
Date: Sun, 20 May 2018 17:55:56 +0000
Message-ID: <BL0PR2101MB11079C3E32EBF8904AA9C397A0960@BL0PR2101MB1107.namprd21.prod.outlook.com>
References: <tip-2d2ccf24939cf369f7473c7e4ea309891be91848@git.kernel.org>
In-Reply-To: <tip-2d2ccf24939cf369f7473c7e4ea309891be91848@git.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:b076:3b2a:409c:285e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1027;7:DywvSpkFzMmUZXkoSlW2aJ7xTEkvMtAutZAXGjBzfu8TxgONkojORTjpkf8y0wUhlUQy+e3kNKvPVmYrbS7CsFmGQ13AsjxjbSMXZdGi7lvrUZG3TdIFHfFiTBmvk2BXQTE04SfARIiBhbwO5UfAR57L52IynmB3zBvoWpTHiIN+LM4sJCFvBcgnDU8YmOVHF1kcg2I8RZO5r306tfaDDWC7ATDdNKyraO0mZCf/q0kUgc4/yPBuNszL+I5VmL71;20:Zt4wHAzA3XTgLswi0PWozom2upGLLHhID8acuvlSiO5eHtjKaDOJD5l7fKZ+RDQR+UMw887wssgaZJKEYq6XtitIUDn+dOx2gpF97SlDIuqBVws7XDrDx1HYs4d7gnqiScZ/isxRZwbKnKFc2ZcBye2tDR8yY37RtfyOJa1TqHk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB1027D45CEA4A219C88000680A0960@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(219752817060721)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1027;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1027;
x-forefront-prvs: 06780E24F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(39860400002)(346002)(396003)(199004)(189003)(13464003)(2900100001)(86362001)(575784001)(7696005)(68736007)(14454004)(10090500001)(7736002)(8990500004)(2906002)(1511001)(966005)(22452003)(229853002)(110136005)(74316002)(25786009)(6246003)(2201001)(53936002)(316002)(9686003)(6306002)(86612001)(76176011)(486006)(3280700002)(446003)(2501003)(8936002)(105586002)(33656002)(53546011)(8676002)(476003)(478600001)(6436002)(6506007)(55016002)(102836004)(3660700001)(10290500003)(99286004)(305945005)(59450400001)(81166006)(97736004)(5660300001)(106356001)(5250100002)(46003)(11346002)(81156014)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1027;H:BL0PR2101MB1107.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7Q508IFDOxAj5Hay+0XYoVJEOYo0u/E/VBGccXOQf3qgwwzsbLKYNXCCqYRsGja03Z7s3guaGYG7Ri2gYxVEpmDzU+0t9PWyNNhV3Xv23n0dDg1JvBD7wfPLjCzWrEvBLFkvyxQ3SsfS8E0d6Ma1+gu7ETUAVhialpDT+s/yajVtZj8TT7mPydiIbuzAn7kU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aab5958f-f2a7-4b32-738f-08d5be7aefee
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab5958f-f2a7-4b32-738f-08d5be7aefee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2018 17:55:56.2525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4KHu8Cu002311



> -----Original Message-----
> From: tip tree robot <tipbot@zytor.com>
> Sent: Saturday, May 19, 2018 12:40 PM
> To: linux-tip-commits@vger.kernel.org
> Cc: lkp@intel.com; hpa@zytor.com; mingo@kernel.org; Michael Kelley
> (EOSG) <Michael.H.Kelley@microsoft.com>; tglx@linutronix.de; KY
> Srinivasan <kys@microsoft.com>
> Subject: [tip:x86/hyperv] x86/Hyper-V/hv_apic: Build the Hyper-V APIC
> conditionally
> 
> Commit-ID:  2d2ccf24939cf369f7473c7e4ea309891be91848
> Gitweb:
> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ker
> nel.org%2Ftip%2F2d2ccf24939cf369f7473c7e4ea309891be91848&data=02%7C
> 01%7Ckys%40microsoft.com%7C4ca32d3abd084c7a96b608d5bdc04fd9%7C72
> f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636623556042008674&sdata
> =F04rsVvpkPMwuzsQF6odQX2jER84S4AYcVQr4CB0yc0%3D&reserved=0
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Sat, 19 May 2018 21:22:48 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Sat, 19 May 2018 21:34:11 +0200
> 
> x86/Hyper-V/hv_apic: Build the Hyper-V APIC conditionally
> 
> The Hyper-V APIC code is built when CONFIG_HYPERV is enabled but the
> actual
> code in that file is guarded with CONFIG_X86_64. There is no point in doing
> this. Neither is there a point in having the CONFIG_HYPERV guard in there
> because the containing directory is not built when CONFIG_HYPERV=n.
> 
> Further for the hv_init_apic() function a stub is provided only for
> CONFIG_HYPERV=n, which is pointless as the callsite is not compiled at
> all. But for X86_32 the stub is missing and the build fails.
> 
> Clean that up:
> 
>   - Compile hv_apic.c only when CONFIG_X86_64=y
>   - Make the stub for hv_init_apic() available when CONFG_X86_64=n

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
>  arch/x86/hyperv/Makefile        | 3 ++-
>  arch/x86/hyperv/hv_apic.c       | 6 ------
>  arch/x86/include/asm/mshyperv.h | 7 ++++++-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 00ce4df01a09..b173d404e3df 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1 +1,2 @@
> -obj-y		:= hv_init.o mmu.o hv_apic.o
> +obj-y			:= hv_init.o mmu.o
> +obj-$(CONFIG_X86_64)	+= hv_apic.o
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index d3ff6e255924..f68855499391 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -31,9 +31,6 @@
>  #include <asm/mshyperv.h>
>  #include <asm/apic.h>
> 
> -#ifdef CONFIG_X86_64
> -#if IS_ENABLED(CONFIG_HYPERV)
> -
>  static struct apic orig_apic;
> 
>  static u64 hv_apic_icr_read(void)
> @@ -257,6 +254,3 @@ void __init hv_apic_init(void)
>  		apic->icr_read  = hv_apic_icr_read;
>  	}
>  }
> -
> -#endif /* CONFIG_HYPERV */
> -#endif /* CONFIG_X86_64 */
> diff --git a/arch/x86/include/asm/mshyperv.h
> b/arch/x86/include/asm/mshyperv.h
> index 9aaa493f5756..997192131b7b 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -302,7 +302,13 @@ void hyperv_reenlightenment_intr(struct pt_regs
> *regs);
>  void set_hv_tscchange_cb(void (*cb)(void));
>  void clear_hv_tscchange_cb(void);
>  void hyperv_stop_tsc_emulation(void);
> +
> +#ifdef CONFIG_X86_64
>  void hv_apic_init(void);
> +#else
> +static inline void hv_apic_init(void) {}
> +#endif
> +
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
> @@ -311,7 +317,6 @@ static inline void hyperv_setup_mmu_ops(void) {}
>  static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
>  static inline void clear_hv_tscchange_cb(void) {}
>  static inline void hyperv_stop_tsc_emulation(void) {};
> -static inline void hv_apic_init(void) {}
>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int
> cpu)
>  {
>  	return NULL;
