Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1033C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C62B20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C62B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeHATzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:55:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34646 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731995AbeHATzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:55:16 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkvXQ-0006w1-0u; Wed, 01 Aug 2018 20:07:56 +0200
Date:   Wed, 1 Aug 2018 20:07:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Shier <pshier@google.com>
cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de,
        konrad.wilk@oracle.com, dwmw@amazon.co.uk,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH] proc: added ept_ad flag to /proc/cpuinfo
In-Reply-To: <CACwOFJQqqh6m2x+JXBnmeCzS7Zb-3e+5iPzp_vAZPGCqW+i_8w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808011954410.1835@nanos.tec.linutronix.de>
References: <20180730211254.173686-1-pshier@google.com> <alpine.DEB.2.21.1807302342570.1725@nanos.tec.linutronix.de> <CACwOFJQqqh6m2x+JXBnmeCzS7Zb-3e+5iPzp_vAZPGCqW+i_8w@mail.gmail.com>
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


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Wed, 1 Aug 2018, Peter Shier wrote:

> Thank you Thomas. Wording issues understood and will post a new patch
> with updated subject.
> 
> Re goals: purpose is to expose feature bit with side effect of
> "ept_ad" in /proc/cpuinfo and is not necessarily related to VMX code.
> 
> We are upstreaming some internal patches that we think would be
> generally useful and I will be careful from now on to remove any
> wording that is not publicly relevant.

Well, it does not matter what your goals are. If you add new functionality
and there is an indication that it might be useful in other places, then
looking into that is not really optional. Kernel development works because
people work together and look over the brim of their own tea cup, otherwise
we would end up with a unmaintainable steaming pile of s....

'Not my goal' surely does not qualify as a proper answer to a sensible
technical question.

Thanks,

	tglx




