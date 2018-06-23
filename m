Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECCAC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 20:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2D724CE7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 20:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2D724CE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeFWUNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 16:13:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43902 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeFWUM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 16:12:59 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWosj-0007yF-3g; Sat, 23 Jun 2018 22:11:37 +0200
Date:   Sat, 23 Jun 2018 22:11:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018, Thomas Gleixner wrote:

> On Thu, 21 Jun 2018, Pavel Tatashin wrote:
> > We will change sched_clock() to be called early.
> 
> Why is this relevant? Does the issue only appear with that change?

So you forgot to answer this question. I did not find a system yet, which
actually exposes this behaviour on mainline.

Is this an artifact of your early sched clock thing?

Thanks,

	tglx
