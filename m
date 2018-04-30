Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754107AbeD3N5p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:57:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34452 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeD3N5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:57:44 -0400
Date: Mon, 30 Apr 2018 15:57:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: Re: [PATCH v6 01/11] perf/x86/intel/pt: Move Intel-PT MSR bit
 definitions to a public header
Message-ID: <20180430135727.GA12258@hirez.programming.kicks-ass.net>
References: <1521544918-31084-1-git-send-email-luwei.kang@intel.com>
 <1521544918-31084-2-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521544918-31084-2-git-send-email-luwei.kang@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 07:21:48PM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Intel Processor Trace virtualization enabling in guest need
> to use these MSR bits, so move them to public header msr-index.h.
> Introduce RTIT_CTL_FABRIC_EN and sync the definitions to
> latest spec.

You forgot to Cc the maintainers.

Also, this patch does 2 things, I think we have a rule that says that's
a bad thing.
