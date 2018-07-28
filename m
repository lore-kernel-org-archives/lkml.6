Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1340FC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9BD20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9BD20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeG1KdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:33:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:50999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbeG1KdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:33:08 -0400
Received: from homer.simpson.net ([185.221.150.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LikQP-1gFfLB1y2f-00cvCa; Sat, 28
 Jul 2018 11:07:12 +0200
Message-ID: <1532768831.9882.71.camel@gmx.de>
Subject: candidates for @devel-rt localversion-rt++
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sat, 28 Jul 2018 11:07:11 +0200
In-Reply-To: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LZRsZjy0RS9zmA65TPb+7gA40YULbQ5OMvaV3wQgYAORCwUHNxz
 xwYdnn2azOGDWUeiZ9BQFSyizHEDtBymBVVspLNFRN4b7NeHdSLrlGAloAeKdyVKP1j0ePi
 7gTrcqkvTYL7MS3MM+IBrnKvd980xlQMNvQ+WVy54vemPA/oCTQmTpuXTwfXxqdvGyLoGLL
 FwSxtaDqjJthFhrDeNefw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vi0gNqvl4io=:kBY/KueJEnV1KMuMOlxDz+
 XsYT/uip8Wd9FfArHTN0r8kYTS6r1bZngtrJrredezmhdih5c2aV8NlqIH5aVN4Y1VFVoOVMG
 NxlXWFfxAOwKKWRcTD3B374WyZ6yexeL5KAQunvPZnBMNPTQApvdwhunquc9QeuiNtN5yugdt
 MIaDmO+6txN1WCKCyod8k3UuN00jDAqn9ZpeRniLNRbntTF1cteFnXsUQTzLVQJdHejWeVCF7
 +N/PothBd9ejXVKrX5cli42xP8m+6Eez/ZwufBonwgtD2wxhKZ9BrT+ltPatOhp1bMs4C3MX0
 wrYmYV9kRXu15hLC55m5rfBBQuuyKh8nkmZXgzeyKfVWmVvSQQSbzlhfS4f8ChV/NkSSPxpVF
 zdl9Coo1oqdiS+AoQq/0Ij2cya0/JER5gCaGmgcNqLH2nALkB2lW+HfDgO9GxgTLLa9Dgl94y
 IArPeOHlx6EqM0HPuGwSCCHbgIhEVXOiFWHY01rsPKp8tz/gPCfoSKYPKnxO5FyaOmyUplmqu
 wFIZKSFYvl9Wrrge+TJaR9Vx2Ws+daQD25zo8/vxArAMW8c6Gf5+vitEi7b0vlOhIj0LQ9hPj
 ioF6BD376cihtLnnZSBTQjIZVbcW5fq1OHEjl0eXGtei12CIaBINxpdE14IgsZ+uxM7L7BYj7
 P8zqsZugauzboEr/r2YqkX1CFnlykUQYpOmteJck8i0RYikww6TMoKqgRHHf+OO3CMhC1Ov/6
 ammaYhbhn1U5iQ88qWcMmgVytRwdeTY+sr2mRt0qez/yf+xX2UnxiuPs/LtpkMadlTu7YvmP/
 ljTwCSz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. arm64/acpi/perf: move pmu allocation to an early CPU up hook
2. sched: Introduce raw_cond_resched_lock()
3. arm, KVM: convert vgic_irq.irq_lock to raw_spinlock_t

With these applied, 4 socket TaiShan 2280 box boots shiny new -rt11
gripe free, and has been tossed into SUSE's kvm build-bot slave pit,
where it is presumably performing acceptably, given its boss keeps
giving it more work to do.  (I see only lack of smoke/flame)

1 should fly, 2 and 3 may well die.. as box does without them.

	-Mike
