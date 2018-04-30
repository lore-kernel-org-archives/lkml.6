Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeD3N7L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:59:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34474 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeD3N7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:59:09 -0400
Date: Mon, 30 Apr 2018 15:59:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: Re: [PATCH v6 02/11] perf/x86/intel/pt: Change pt_cap_get() to a
 public function
Message-ID: <20180430135904.GB12258@hirez.programming.kicks-ass.net>
References: <1521544918-31084-1-git-send-email-luwei.kang@intel.com>
 <1521544918-31084-3-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521544918-31084-3-git-send-email-luwei.kang@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 07:21:49PM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Change pt_cap_get() to a public function so that KVM can access it.
> Introduce new capablility PT_CAP_output_subsys to support
> of output to Trace Transport subsystem.

That is again, more than a single change.

Also, the Changelog is far too terse, why do you need a new capability?
