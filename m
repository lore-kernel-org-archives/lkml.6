Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeD3OBV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:01:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34534 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeD3OBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:01:20 -0400
Date: Mon, 30 Apr 2018 16:01:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org
Subject: Re: [PATCH v6 03/11] perf/x86/intel/pt: Introduce a new function to
 get the capability of Intel PT
Message-ID: <20180430140113.GC12258@hirez.programming.kicks-ass.net>
References: <1521544918-31084-1-git-send-email-luwei.kang@intel.com>
 <1521544918-31084-4-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521544918-31084-4-git-send-email-luwei.kang@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 07:21:50PM +0800, Luwei Kang wrote:
> Because of the guest CPUID information may different with
> host(some bits may mask off in guest) so introduce a new
> function to get the capability of Intel PT.

That's not English, also you need whitespace before a parenthesis.

Also, what?
