Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeEVODv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:03:51 -0400
Received: from mail-db5eur01on0129.outbound.protection.outlook.com ([104.47.2.129]:57688
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751713AbeEVODh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:03:37 -0400
From: "Ofer Levi(SW)" <oferle@mellanox.com>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Meir Lichtinger" <meirl@mellanox.com>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: RE: ARC compact700 NPS platform - EZ_MachineCheck exception handler
Thread-Topic: ARC compact700 NPS platform - EZ_MachineCheck exception handler
Thread-Index: AdPxAFKCVPWfnmkrQ+CoZqjBzcAhqAADIrHAAAYMHIAAJuwMwA==
Date: Tue, 22 May 2018 14:03:35 +0000
Message-ID: <DB6PR05MB4597EC445D1CA5E1737C095AB2940@DB6PR05MB4597.eurprd05.prod.outlook.com>
References: <DB6PR05MB4597A3B8BC5BE80BD039B0AAB2950@DB6PR05MB4597.eurprd05.prod.outlook.com>
 <0c84cd14-19dc-a22c-271c-11cbd18ded3a@synopsys.com>
In-Reply-To: <0c84cd14-19dc-a22c-271c-11cbd18ded3a@synopsys.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oferle@mellanox.com;
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB3238;7:eiAGoSeL168WZpSPxTO/jNoHJM1OSM8T2VpCQwlQPwXojzKtX3jtMz0FvfBdhgeiFXYYCkicBYzuWuu4zxijlSvlIdFviDYzW6w7HxlzEGGzIfWD2oDISbYpnebxOwKnqMWxbHClf9kap5fYlYMEk05kiyuO/7o/cdDF+IC2+8/TuuervRBVPjnjUuudUzQq9pUIxaAhce1AETCj5aV58dSASZVesnsC6iqNACDxhXJyfwdh+Plurq+WaTNqg7Vj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3238;
x-ms-traffictypediagnostic: DB6PR05MB3238:
x-microsoft-antispam-prvs: <DB6PR05MB32386B25EEE126D247007C4CB2940@DB6PR05MB3238.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB3238;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3238;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(377454003)(479174003)(76104003)(51704005)(24454002)(52544003)(13464003)(199002)(189002)(20776003)(69226001)(63696002)(74876001)(74706001)(54606006)(33656001)(77096001)(76786001)(76796001)(81542001)(54356001)(93136001)(92566001)(46102001)(64706001)(76576001)(81342001)(92726001)(77982001)(59766001)(56816005)(80022001)(66066001)(76482001)(74316001)(90146001)(65816001)(87936001)(56776001)(54316002)(74366001)(44376005)(87266001)(54206007)(2656002)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR05MB3238;H:DB6PR05MB4597.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iXAlaEzRxV6f1P7AXTdXYfg7cIz3vpRyiz12AyTkyzP3U/78Vg5SUUy4VgtrjNwFBtrCTL4h/luqALbhW3UnX6v2cKwRLrGAZ7dxnQLaG759p+nCfaWViGE5P5psTZgJ9/3HcQDEpgLDo1TxOxrhz93snTADQ6C7MAsdfYAFvNrAreBXhQ9/hq9FMfZCEbj2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fe561dda-da34-4858-ef76-08d5bfeccf50
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe561dda-da34-4858-ef76-08d5bfeccf50
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 14:03:35.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4ME3seS007669


There are two cases to consider for this exception:

> but others can't so continuing despite it is recipe for disaster. Perhaps your chip
> has some spurious Machine check exceptions ?

1. Except for core 0, which is running the linux os, all other cores are running 
packet processing code in ZOL isolation mode. If any of these cores hit the compact 700
0x20 exception it is logical to assume all other cores will hit it too.
It seems that eventually in any case, will have to reset HW and reboot the system.
It might be beneficial for user to try collect more info for debugging the issue even if it’s 
a disaster for the system.

> Hmm, but you have to explain why those machine checks are fine !

2. The ARC compact700 instruction set was extended to support fast DMA 
operations to various added HW accelerators and new asm ops to support network 
packet Processing.
In case of an error,  some of these instructions are wired to the 0x20 exception.
There is an HW mechanism to partition the DDR between linux os and the various accelerators
This mechanism unaware of the mmu or virtual memory handling. 
In a cases where an accelerator access out of its memory bounds this exception is hit 
but there is no risk to system stability. User signal handler can catch it allowing easier 
debugging.
This is one example.



> >   1:
> >   	FAKE_RET_FROM_EXCPN
> 
> You don't need this.

When removing FAKE_RET_FROM_EXCPN, first EV_MachineCheck exception 
Is causing the core running that thread to stall.
If not removed multiple exceptions are handled and system seems healthy.

Please note that exception is generated by accessing one of the NPS accelerators
address which is out its memory space, so no harm is expected to system 


> Next time please send a real patch so I know right away what was changed.
My apologies, here is the patch based on linux-4.16.10

diff -uprN linux-4.16.10/arch/arc/kernel/entry.S linux/arch/arc/kernel/entry.S
--- linux-4.16.10/arch/arc/kernel/entry.S	2018-05-19 11:19:37.000000000 +0300
+++ linux/arch/arc/kernel/entry.S	2018-05-22 14:12:18.065103918 +0300
@@ -106,13 +106,9 @@ ENTRY(EV_MachineCheck)
 	b       ret_from_exception
 
 1:
-	; DEAD END: can't do much, display Regs and HALT
-	SAVE_CALLEE_SAVED_USER
-
-	GET_CURR_TASK_FIELD_PTR   TASK_THREAD, r10
-	st  sp, [r10, THREAD_CALLEE_REG]
-
-	j  do_machine_check_fault
+	FAKE_RET_FROM_EXCPN
+	bl		do_machine_check
+	b       ret_from_exception
 
 END(EV_MachineCheck)
 
diff -uprN linux-4.16.10/arch/arc/kernel/traps.c linux/arch/arc/kernel/traps.c
--- linux-4.16.10/arch/arc/kernel/traps.c	2018-05-19 11:19:37.000000000 +0300
+++ linux/arch/arc/kernel/traps.c	2018-05-22 14:13:25.162748373 +0300
@@ -86,6 +86,7 @@ DO_ERROR_INFO(SIGBUS, "Invalid Mem Acces
 DO_ERROR_INFO(SIGTRAP, "Breakpoint Set", trap_is_brkpt, TRAP_BRKPT)
 DO_ERROR_INFO(SIGBUS, "Misaligned Access", do_misaligned_error, BUS_ADRALN)
 DO_ERROR_INFO(SIGSEGV, "gcc generated __builtin_trap", do_trap5_error, 0)
+DO_ERROR_INFO(SIGBUS, "Machine Check", do_machine_check, BUS_MCEERR_AR )
 
 /*
  * Entry Point for Misaligned Data access Exception, for emulating in software






> -----Original Message-----
> From: Vineet Gupta [mailto:Vineet.Gupta1@synopsys.com]
> Sent: Monday, May 21, 2018 19:59
> To: Ofer Levi(SW) <oferle@mellanox.com>
> Cc: linux-kernel@vger.kernel.org; Meir Lichtinger <meirl@mellanox.com>;
> arcml <linux-snps-arc@lists.infradead.org>
> Subject: Re: ARC compact700 NPS platform - EZ_MachineCheck exception
> handler
> 
> On 05/21/2018 07:14 AM, Ofer Levi(SW) wrote:
> > Resending, due to typo in LKML mail  address.
> 
> Also please CC linux-snps-arc@lists.infradead.org for any ARC Linux related
> posts.
> 
> >
> >   The EV_MachineCheck exception handler is halting the core for
> exceptions
> >   which are not tlb_overlap_fault.
> >   Since for the NPS platform each core is running a single thread in ZOL (Zero
> >   Overhead Linux) isolation mode, we feel that most of the time it is safe to
> >   resume execution instead of halting the core.
> 
> Most of the time is not good enough when dealing with OS code :-( A
> Machine check excepting implies something went terribly wrong. Some of
> those cases can be handled gracefully (such as duplicate TLB entry), but
> others can't so continuing despite it is recipe for disaster. Perhaps your chip
> has some spurious Machine check exceptions ?
> 
> >   I would appreciate it if you could review the change  below
> 
> Next time please send a real patch so I know right away what was changed.
> 
> > and let me know
> >   what you think, if this change is valid or if we missed or overlooked
> >   something.
> >   We are not looking to push this change upstream, but will be used on
> some
> >   systems.
> 
> Hmm, but you have to explain why those machine checks are fine !
> 
> >
> >   Please see below our implementation after label 1.
> >
> >   Thanks
> >   Ofer
> >
> >   ENTRY(EV_MachineCheck)
> >
> >   	EXCEPTION_PROLOGUE
> >
> > ...
> >   	brne    r3, ECR_C_MCHK_DUP_TLB, 1f
> >
> >   	bl      do_tlb_overlap_fault
> >   	b       ret_from_exception
> >
> >   1:
> >   	FAKE_RET_FROM_EXCPN
> 
> You don't need this.
> 
> >   	bl		do_machine_check  ; using DO_ERROR_INFO macro
> 
> We don't have above function in code. There's do_machine_check_fault()
> which calls
> die() -> flag 1 - so it would halt the kernel and would never return here.
> So your patch is broken in implementation as well.
> 
> >   	b       ret_from_exception
> >
> >   END(EV_MachineCheck)
> >
> >
