Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF2BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F0121545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F0121545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbeHOUqR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:46:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:50725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbeHOUqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:46:16 -0400
Received: from localhost.localdomain ([79.203.83.237]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MYOkT-1fLOGI3h7h-00VCJR; Wed, 15 Aug 2018 19:52:44 +0200
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 6120380087; Wed, 15 Aug 2018 19:52:41 +0200 (CEST)
From:   Sven Joachim <svenjoac@gmx.de>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
References: <20180814171520.883143803@linuxfoundation.org>
        <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
Date:   Wed, 15 Aug 2018 19:52:41 +0200
In-Reply-To: <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com> (Sebastian
        Gottschall's message of "Wed, 15 Aug 2018 19:01:38 +0200")
Message-ID: <87k1orms9i.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:2h+QkHPjg+zcc9iSXNZl4KT74BbXxVHezPbnEjrY6LtIbAnyca4
 zQMTSCNb0+q4QMGBXbWEAiyZ6qccP9hnG9gRfOwRFOXNkYlSrYaWlgl3enUVrKa5PcbrKjJ
 MrR0ACIyFluYQpLBM+NxtpzG/sU5M9t+Jy27m2xkv8EupkBuTV6lccjqWx5y5S4nR1+Z1wT
 87ay3IdNizpJFRA6WQhwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T8K5zkEuy2E=:pP60ulYTB5kTJTAcWZCjIW
 YiVMrmPUAoB870S5ST23Z1Ub56pMK7H02mks6PBRTw/kFgpdrvPZpqLKNDUO95IsRqZk9A4FG
 klFFhwOCXG5tB7fQ6p3uTMOkbcxjiISl6PDI8uAbmQYr0G3Kg5wjJUZU7eL2tscBjuuCruReD
 urUuiMZb+zUdkZ22nFO13KCZjEkmVsNyuCdjxudhvflOa0fykeFRGXAtdCfGp7gYY2PL+HP2/
 ECcl5bIxOBFAPrTC1LXT3VsxXpwk9me7WW0y2aExfO3t3dB0U3I6YuEE4ttE6vRMkGk5XXYyK
 +E+hfrL7e1aQX338Wkii9oQwVxWxH8aH/M3ZFcBLJJdnAdAq8/pfVdi8G7a7d7+yY/I/wTY+d
 oFsDhE3cU7l4ne13s6oyDP9Hpx8sw0WIvvnxNm+CxXujk5LmlZwgq4xu/I3QsduNDXJuVa30e
 WeWrgLRpsqOBjh/meHe23WaXAK3T+wCJJhGq1goMuW7J8ObzdG5dc7ruPD+bYsRzyzryilR3r
 tlvak9wVuw0wRpqrX+RBNBdV2W0wc8XrZ+KSDJx7SGBcm8nPjPKrZovWyihzh7wrJRDqPhG/c
 FaFuu912YkrljYblaSRMiTzbqNvbI2B5e0sBZ3we4PrzYAv2+XuKnamv/3Bz3zGcPR04tKask
 o4VbfmdjSsKFnsfR3J0yCKUzMOe0MjLyW7YuEoLEVR/jQVOGC7jjGDOfgQWG/wqWyTbFppX5L
 L70tISgiGY9e2hFL5BEBsesjNGtj01Ep5VX2G5/ojRul3mdS0t4UdPlCyKmMqKXTvENGRbmaJ
 SVOA2GY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-15 19:01 +0200, Sebastian Gottschall wrote:

> nother issue seen on xscale and as it affects all non SMP configured kernels
>
>
> kernel/cpu.c: In function 'boot_cpu_hotplug_init':
> kernel/cpu.c:2204:28: error: 'struct cpuhp_cpu_state' has no member
> named 'booted_once'
>   this_cpu_write(cpuhp_state.booted_once, true);

I got a different error in 4.9.120 with CONFIG_SMP unset:

,----
| CC      drivers/rtc/rtc-cmos.o
| In file included from drivers/rtc/rtc-cmos.c:45:0:
| ./arch/x86/include/asm/i8259.h: In function 'inb_pic':
| ./arch/x86/include/asm/i8259.h:32:24: error: implicit declaration of function 'inb' [-Werror=implicit-function-declaration]
|   unsigned char value = inb(port);
|                         ^~~
| ./arch/x86/include/asm/i8259.h: In function 'outb_pic':
| ./arch/x86/include/asm/i8259.h:45:2: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]
|   outb(value, port);
|   ^~~~
| In file included from ./include/linux/mc146818rtc.h:14:0,
|                  from drivers/rtc/rtc-cmos.c:49:
| ./arch/x86/include/asm/io.h: At top level:
| ./arch/x86/include/asm/io.h:277:20: warning: conflicting types for 'outb'
|  static inline void out##bwl(unsigned type value, int port)  \
|                     ^
| ./arch/x86/include/asm/io.h:316:1: note: in expansion of macro 'BUILDIO'
|  BUILDIO(b, b, char)
|  ^~~~~~~
| ./arch/x86/include/asm/io.h:277:20: error: static declaration of 'outb' follows non-static declaration
|  static inline void out##bwl(unsigned type value, int port)  \
|                     ^
| ./arch/x86/include/asm/io.h:316:1: note: in expansion of macro 'BUILDIO'
|  BUILDIO(b, b, char)
|  ^~~~~~~
| In file included from drivers/rtc/rtc-cmos.c:45:0:
| ./arch/x86/include/asm/i8259.h:45:2: note: previous implicit declaration of 'outb' was here
|   outb(value, port);
|   ^~~~
| In file included from ./include/linux/mc146818rtc.h:14:0,
|                  from drivers/rtc/rtc-cmos.c:49:
| ./arch/x86/include/asm/io.h:283:29: error: conflicting types for 'inb'
|  static inline unsigned type in##bwl(int port)    \
|                              ^
| ./arch/x86/include/asm/io.h:316:1: note: in expansion of macro 'BUILDIO'
|  BUILDIO(b, b, char)
|  ^~~~~~~
| In file included from drivers/rtc/rtc-cmos.c:45:0:
| ./arch/x86/include/asm/i8259.h:32:24: note: previous implicit declaration of 'inb' was here
|   unsigned char value = inb(port);
`----

Cheers,
       Sven
