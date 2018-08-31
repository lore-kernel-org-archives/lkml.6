Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D501C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DD920842
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DD920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeIAATQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:19:16 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:47714 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeIAATQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:16 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id F104A9003F;
        Fri, 31 Aug 2018 23:10:11 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id DE707220A65; Fri, 31 Aug 2018 23:10:09 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id D416E2204BB;
        Fri, 31 Aug 2018 23:10:09 +0300 (EEST)
Date:   Fri, 31 Aug 2018 23:10:09 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: =?ISO-8859-7?Q?Re=3A_cmpxchg=2Eh=3A245=3A2=3A_error=3A_=A1asm=A2_?=
 =?ISO-8859-7?Q?operand_has_impossible_constraints?=
In-Reply-To: <alpine.DEB.2.21.1808312122300.1349@nanos.tec.linutronix.de>
Message-ID: <alpine.LRH.2.21.1808312308280.6505@math.ut.ee>
References: <alpine.LRH.2.21.1808262340040.22219@math.ut.ee> <alpine.DEB.2.21.1808312122300.1349@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > While trying to compile v4.18-13105-gaba16dc5cf93 with gcc 5.3.1 on a 
> > 32-bit x86 configured for AMD K6:
> 
> I tried to get hold of that debian gcc 5.3.1 compiler, but no luck so far.

5.3.1-14, seems to be available in 
http://snapshot.debian.org/package/gcc-5/5.3.1-14/#gcc-5_5.3.1-14 - the 
whole system is a snapshot of debian unstable when they stoooed 
supporting pre-686 CPUs.

-- 
Meelis Roos (mroos@linux.ee)
