Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeEUPgJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:36:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47010 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbeEUPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:36:06 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520870400";
   d="scan'208";a="78831440"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deller@gmx.de" <deller@gmx.de>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "hch@lst.de" <hch@lst.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "paulus@samba.org" <paulus@samba.org>
Subject: Re: [PATCH v11 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Thread-Topic: [PATCH v11 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Thread-Index: AQHT7tIUryVouySXukyEt1Om04LvUaQ1z6SAgASFiQA=
Date: Mon, 21 May 2018 15:35:58 +0000
Message-ID: <8f1ababa064eae4969162bb868f874ce90c586d2.camel@wdc.com>
References: <20180518180006.24389-1-bart.vanassche@wdc.com>
         <20180518180006.24389-2-bart.vanassche@wdc.com>
         <C2876D88-F59B-48D7-85D9-49EB79B1FBE3@zytor.com>
In-Reply-To: <C2876D88-F59B-48D7-85D9-49EB79B1FBE3@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0543;7:PtOVmoMczoH12XTZWykj3yG4z9PjWs52ITLyJk7EqqaNG0ZNdY12wZUdCHVeMpzjcvtV1CGZ5Mi4gn/mBnBGyzX4KBvO6OIZ6pd88z8PReULbzUm4LrPV+8NPUd4q3A0xNW2WGQxq6m5CbtbBuUjrUoxCmkS1Okz4Ja8TOmQuA/K+159Ys1rz3vW2uJ6TlrRGcWhhQYKon+2JXqvnEgE2MZZWSlKr77Y2jpOzdfgoitmDiZEqx4nsC8Pkl851VzP;20:4imepB8PxgKo/ugMfDAPH05TAsoFwcel8CoOr4o8xdPgaXypKbg2c4qcPLHL3LoxnISN/Htpj7yoYLKCiIS/+S5k2ln66/Ulv6UFHtm3qBET668+gdlaF69Upm/jkLeoutcPFJOStG4TNdL3Pc0QQhrHwhiC/8gBTr+Fc4L89uo=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0543;
x-ms-traffictypediagnostic: MWHPR04MB0543:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB05432E7110A79BC2AB1B978498950@MWHPR04MB0543.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(26323138287068)(85827821059158)(190383065149520)(104084551191319)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0543;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0543;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39380400002)(39860400002)(189003)(199004)(377424004)(72206003)(305945005)(6512007)(6436002)(36756003)(102836004)(76176011)(99286004)(54906003)(186003)(6116002)(476003)(110136005)(486006)(2616005)(3846002)(26005)(8666007)(316002)(11346002)(478600001)(7736002)(86362001)(575784001)(105586002)(446003)(229853002)(68736007)(106356001)(6506007)(53546011)(15760500003)(59450400001)(5250100002)(7416002)(2906002)(66066001)(39060400002)(2900100001)(97736004)(2501003)(14454004)(25786009)(3280700002)(53936002)(3660700001)(8936002)(6486002)(81166006)(8676002)(4326008)(118296001)(5660300001)(6246003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0543;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
x-microsoft-antispam-message-info: roS0oqgRVZ1EprUHJzwrkmEUEvVAd1PDEw1g2fpSHTfII4uCMT62alHPAUU1uq46s9lVDHXRhk36Pos7IEkg1g1V+p7XyYj55f6xqlm4bv8YRPOR36vHyKfyFTIHCdERq9Dda+oeyQZ+rbU7iPaY3xuHzUVWvMhklpdGCOrrfp288l2uPvdTORL6UJEFvQTk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2133A085353F2443A2F663E8DE0368CE@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6e7b8c07-a3a2-4bc5-5f39-08d5bf308d41
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7b8c07-a3a2-4bc5-5f39-08d5bf308d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 15:35:59.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0543
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4LFaHm8015947

On Fri, 2018-05-18 at 11:32 -0700, hpa@zytor.com wrote:
> On May 18, 2018 11:00:05 AM PDT, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> > The next patch in this series introduces a call to cmpxchg64()
> > in the block layer core for those architectures on which this
> > functionality is available. Make it possible to test whether
> > cmpxchg64() is available by introducing CONFIG_ARCH_HAVE_CMPXCHG64.
> > 
> > Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > ---
> > .../features/locking/cmpxchg64/arch-support.txt    | 33
> > ++++++++++++++++++++++
> > arch/Kconfig                                       |  4 +++
> > arch/arm/Kconfig                                   |  1 +
> > arch/ia64/Kconfig                                  |  1 +
> > arch/m68k/Kconfig                                  |  1 +
> > arch/mips/Kconfig                                  |  1 +
> > arch/parisc/Kconfig                                |  1 +
> > arch/riscv/Kconfig                                 |  1 +
> > arch/sparc/Kconfig                                 |  1 +
> > arch/x86/Kconfig                                   |  1 +
> > arch/xtensa/Kconfig                                |  1 +
> > 11 files changed, 46 insertions(+)
> > create mode 100644
> > Documentation/features/locking/cmpxchg64/arch-support.txt
> > 
> > diff --git a/Documentation/features/locking/cmpxchg64/arch-support.txt
> > b/Documentation/features/locking/cmpxchg64/arch-support.txt
> > new file mode 100644
> > index 000000000000..84bfef7242b2
> > --- /dev/null
> > +++ b/Documentation/features/locking/cmpxchg64/arch-support.txt
> > @@ -0,0 +1,33 @@
> > +#
> > +# Feature name:          cmpxchg64
> > +#         Kconfig:       ARCH_HAVE_CMPXCHG64
> > +#         description:   arch supports the cmpxchg64() API
> > +#
> > +    -----------------------
> > +    |         arch |status|
> > +    -----------------------
> > +    |       alpha: |  ok  |
> > +    |         arc: |  ..  |
> > +    |         arm: |  ok  |
> > +    |       arm64: |  ok  |
> > +    |         c6x: |  ..  |
> > +    |       h8300: |  ..  |
> > +    |     hexagon: |  ..  |
> > +    |        ia64: |  ok  |
> > +    |        m68k: |  ok  |
> > +    |  microblaze: |  ..  |
> > +    |        mips: |  ok  |
> > +    |       nds32: |  ..  |
> > +    |       nios2: |  ..  |
> > +    |    openrisc: |  ..  |
> > +    |      parisc: |  ok  |
> > +    |     powerpc: |  ok  |
> > +    |       riscv: |  ok  |
> > +    |        s390: |  ok  |
> > +    |          sh: |  ..  |
> > +    |       sparc: |  ok  |
> > +    |          um: |  ..  |
> > +    |   unicore32: |  ..  |
> > +    |         x86: |  ok  |
> > +    |      xtensa: |  ok  |
> > +    -----------------------
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 8e0d665c8d53..9840b2577af1 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -358,6 +358,10 @@ config HAVE_ALIGNED_STRUCT_PAGE
> > 	  on a struct page for better performance. However selecting this
> > 	  might increase the size of a struct page by a word.
> > 
> > +config ARCH_HAVE_CMPXCHG64
> > +	bool
> > +	default y if 64BIT
> > +
> > config HAVE_CMPXCHG_LOCAL
> > 	bool
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index a7f8e7f4b88f..02c75697176e 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -13,6 +13,7 @@ config ARM
> > 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> > 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
> > 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> > +	select ARCH_HAVE_CMPXCHG64 if !THUMB2_KERNEL
> > 	select ARCH_HAVE_CUSTOM_GPIO_H
> > 	select ARCH_HAS_GCOV_PROFILE_ALL
> > 	select ARCH_MIGHT_HAVE_PC_PARPORT
> > diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> > index bbe12a038d21..31c49e1482e2 100644
> > --- a/arch/ia64/Kconfig
> > +++ b/arch/ia64/Kconfig
> > @@ -41,6 +41,7 @@ config IA64
> > 	select GENERIC_PENDING_IRQ if SMP
> > 	select GENERIC_IRQ_SHOW
> > 	select GENERIC_IRQ_LEGACY
> > +	select ARCH_HAVE_CMPXCHG64
> > 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> > 	select GENERIC_IOMAP
> > 	select GENERIC_SMP_IDLE_THREAD
> > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > index 785612b576f7..7b87cda3bbed 100644
> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -11,6 +11,7 @@ config M68K
> > 	select GENERIC_ATOMIC64
> > 	select HAVE_UID16
> > 	select VIRT_TO_BUS
> > +	select ARCH_HAVE_CMPXCHG64
> > 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
> > 	select GENERIC_CPU_DEVICES
> > 	select GENERIC_IOMAP
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 225c95da23ce..088bca0fd9f2 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -7,6 +7,7 @@ config MIPS
> > 	select ARCH_DISCARD_MEMBLOCK
> > 	select ARCH_HAS_ELF_RANDOMIZE
> > 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> > +	select ARCH_HAVE_CMPXCHG64 if 64BIT
> > 	select ARCH_SUPPORTS_UPROBES
> > 	select ARCH_USE_BUILTIN_BSWAP
> > 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
> > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > index fc5a574c3482..166c30865255 100644
> > --- a/arch/parisc/Kconfig
> > +++ b/arch/parisc/Kconfig
> > @@ -30,6 +30,7 @@ config PARISC
> > 	select GENERIC_ATOMIC64 if !64BIT
> > 	select GENERIC_IRQ_PROBE
> > 	select GENERIC_PCI_IOMAP
> > +	select ARCH_HAVE_CMPXCHG64
> > 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> > 	select GENERIC_SMP_IDLE_THREAD
> > 	select GENERIC_CPU_DEVICES
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index cd4fd85fde84..4f886a055ff6 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -8,6 +8,7 @@ config RISCV
> > 	select OF
> > 	select OF_EARLY_FLATTREE
> > 	select OF_IRQ
> > +	select ARCH_HAVE_CMPXCHG64
> > 	select ARCH_WANT_FRAME_POINTERS
> > 	select CLONE_BACKWARDS
> > 	select COMMON_CLK
> > diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> > index 8767e45f1b2b..e3429b78c491 100644
> > --- a/arch/sparc/Kconfig
> > +++ b/arch/sparc/Kconfig
> > @@ -75,6 +75,7 @@ config SPARC64
> > 	select HAVE_PERF_EVENTS
> > 	select PERF_USE_VMALLOC
> > 	select IRQ_PREFLOW_FASTEOI
> > +	select ARCH_HAVE_CMPXCHG64
> > 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> > 	select HAVE_C_RECORDMCOUNT
> > 	select NO_BOOTMEM
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index c07f492b871a..52331f395bf4 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -67,6 +67,7 @@ config X86
> > 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> > 	select ARCH_HAS_UBSAN_SANITIZE_ALL
> > 	select ARCH_HAS_ZONE_DEVICE		if X86_64
> > +	select ARCH_HAVE_CMPXCHG64		if X86_CMPXCHG64
> > 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> > 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
> > 	select ARCH_MIGHT_HAVE_PC_PARPORT
> > diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> > index c921e8bccdc8..0e5c77958fa3 100644
> > --- a/arch/xtensa/Kconfig
> > +++ b/arch/xtensa/Kconfig
> > @@ -4,6 +4,7 @@ config ZONE_DMA
> > 
> > config XTENSA
> > 	def_bool y
> > +	select ARCH_HAVE_CMPXCHG64
> > 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
> > 	select ARCH_WANT_FRAME_POINTERS
> > 	select ARCH_WANT_IPC_PARSE_VERSION
> 
> Perhaps it would be better to define cmpxchg64 as a macro (which can be
> #define cmpxchg64 cmpxchg64) rather putting this in Kconfig? Putting it
> in Kconfig makes sense if it affects config options.

That's an interesting suggestion. The following seems to be sufficient to
allow the block layer to check with if defined(cmpxchg64) for cmpxchg64()
support:

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 8b701f8e175c..41ab99bc04ca 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -141,7 +141,9 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 					        sizeof(*(ptr)));	\
 })
 
+#ifndef CONFIG_THUMB2_KERNEL
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#endif /* CONFIG_THUMB2_KERNEL */
 
 #include <asm-generic/cmpxchg.h>
 
@@ -241,6 +243,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 				        sizeof(*(ptr)));		\
 })
 
+#ifndef CONFIG_THUMB2_KERNEL
 static inline unsigned long long __cmpxchg64(unsigned long long *ptr,
 					     unsigned long long old,
 					     unsigned long long new)
@@ -273,6 +276,7 @@ static inline unsigned long long __cmpxchg64(unsigned long long *ptr,
 })
 
 #define cmpxchg64_local(ptr, o, n) cmpxchg64_relaxed((ptr), (o), (n))
+#endif /* CONFIG_THUMB2_KERNEL */
 
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
