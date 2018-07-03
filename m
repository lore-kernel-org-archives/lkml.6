Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D15C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F86217AE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F86217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934592AbeGCStS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:49:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45171 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934465AbeGCStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:49:16 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faQMA-0000zp-KQ; Tue, 03 Jul 2018 20:48:54 +0200
Date:   Tue, 3 Jul 2018 20:48:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Kai Huang <kai.huang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 02/13] x86/sgx: add SGX definitions to cpufeature
In-Reply-To: <20180703182118.15024-3-jarkko.sakkinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1807032041310.1816@nanos.tec.linutronix.de>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com> <20180703182118.15024-3-jarkko.sakkinen@linux.intel.com>
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

On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:

Subject: x86/sgx: add SGX definitions to cpufeature

The prefix is bogus. Not everything you touch is SGX just because.

The proper prefix is 'x86/cpufeatures:' 
The following sentence starts with an uppercase letter.

And with the proper prefix the subject wants to be something like:

  x86/cpufeatures: Add SGX and SGX_LC CPU features

> From: Kai Huang <kai.huang@linux.intel.com>
> 
> Added X86_FEATURE_SGX and X86_FEATURE_SGX_LC definitions that define the

Add the ...

->						definitions that define

That's redundant.

> bits CPUID level 7 bits for determining whether the CPU supports SGX and

bits ... bits ?? 

> launch configuration other than the Intel proprietary key. If this the
> case, IA32_SGXLEPUBKEYHASHn MSRs (0 < n < 4) are available for defining the
> root key for enclaves.
> 
> Signed-off-by: Kai Huang <kai.huang@linux.intel.com>

Lacks your SOB

Thanks,

	tglx
