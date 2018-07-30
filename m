Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F32F20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F32F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeG3SAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:00:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:34979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbeG3SAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:00:53 -0400
Received: from homer.simpson.net ([185.191.218.229]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCggg-1fsOBr0xXu-009Ths; Mon, 30
 Jul 2018 18:25:01 +0200
Message-ID: <1532967899.30205.62.camel@gmx.de>
Subject: Re: candidates for @devel-rt localversion-rt++
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Mon, 30 Jul 2018 18:24:59 +0200
In-Reply-To: <1532864867.1618.32.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
         <1532864867.1618.32.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cVoyywM8UKQlr4hhKxnRENdmXqAiqRI0yC3IFlRF6DCpogOqCLw
 4jt7WV2QksAyFDdHkntGwhVwuXm9IyZzcgENDRgHawYcfnssZlCuKxG8rbxytMlEcRjpfvf
 wFLhmwaOKCXYgrm4s+0Gj9xTma+cfkrhYJnMwYGrL2//DoeAj4DySHOAmYoHFVSdj1l2eWC
 9ulcELVLN8FZfe2A8q3sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ip6eQawrQjA=:LDg7rUcgiqm+h40iZJRLYU
 IjSxLzU7Pf6XFlzWrVv5taar8WxSb3/jDKripnwnHskXCGjFih30rOTJAsh1LYxt+3m5cgiwX
 XZ25Wt43fcBywGaPdmRbVrQtUjnWEPiiI2ToGeWd6nEj5e6Zk5jB6L7adb7xZc73DD+HL/eV7
 mzYwPxZaweclesm2lGgwW7idKAg2x6keVVaJ1AC2DS/hXkPy+MBagwOLmY8EInPFaH1A0resr
 BY2+aQGAuzZmuL1t6Iek+yNcg+BO5rKbmILVhQml36Bok5SZ2vjrXuEUgEq/b05wo86mrO8RV
 lcMw8dGL/zIK1ILcFrv1RpnEZx7/b5wRqoqcy2F7zEKCNR4UdVwcoU7Vtkz6yY5Bfbr2GESRw
 Tak7Q7TwwADBRdDpVUVE1qMwGICE3dh621HYHWStgLvHNa7HwOvUUs2Gc1W32ke/zZtQjsalr
 9Z8Yqn/sPskBkkeBNO8G86pAaMW12pSjDk1do4614MjAxentNYFVyaDv9c964hYS7XWD/t1qX
 KyULWjfrSbTsZwEJwBKyljpW5DdAVckAO0QSD9FTvcOT2LMMfBfzarqWC0UETfRN/iGfv8iW0
 O9hey370kXrP4TmDjv8GwgBVPqOfMHuN4DoXJE6/M7ejnvCTYz+CU+kVTTKnhRqFfw1RyFZKK
 NM/rf0wQC5n1paWaCtIB+qAKX+KIwI328IuayjYc1u0TFwNWFmh690mAP/0gjLc8nzM6Hbyak
 TqXJMv9JWwpXlWyS1WJlGyODFp9BY3+3NEAmcBuV/vNjFHJEemC5K9jgURuGFZC5hUv8IvLQ6
 +VG1uaq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-29 at 13:47 +0200, Mike Galbraith wrote:
> FYI, per kvm unit tests, 4.16-rt definitely has more kvm issues.
> 
> huawei5:/abuild/mike/kvm-unit-tests # uname -r
> 4.16.18-rt11-rt
> huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
> PASS selftest-setup (2 tests)
> FAIL selftest-vectors-kernel 
> FAIL selftest-vectors-user 
> PASS selftest-smp (65 tests)
> PASS pci-test (1 tests)
> PASS pmu (3 tests)
> FAIL gicv2-ipi 
> FAIL gicv3-ipi 
> FAIL gicv2-active 
> FAIL gicv3-active 
> PASS psci (4 tests)
> FAIL timer 
> huawei5:/abuild/mike/kvm-unit-tests #
> 
> 4.14-rt passes all tests.  The above is with the kvm raw_spinlock_t
> conversion patch applied, but the 4.12 based SLERT tree I cloned to
> explore arm-land in the first place shows only one timer failure, and
> has/needs it applied as well, which would seem to vindicate it.
> 
> huawei5:/abuild/mike/kvm-unit-tests # uname -r
> 4.12.14-0.gec0b559-rt
> huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
> PASS selftest-setup (2 tests)
> PASS selftest-vectors-kernel (2 tests)
> PASS selftest-vectors-user (2 tests)
> PASS selftest-smp (65 tests)
> PASS pci-test (1 tests)
> PASS pmu (3 tests)
> PASS gicv2-ipi (3 tests)
> PASS gicv3-ipi (3 tests)
> PASS gicv2-active (1 tests)
> PASS gicv3-active (1 tests)
> PASS psci (4 tests)
> FAIL timer (8 tests, 1 unexpected failures)

FWIW, this single timer failure wass inspired by something in the 4-15
merge window.  A 4.14-rt based 4.15-rt updated to include recent fixes 
reproduces the exact same (ie my colleagues imported it into SLE).  The
rest landed in 4.16.. staring at which is not proving the least bit
enlightening.

	-Mike
