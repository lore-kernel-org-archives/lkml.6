Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeCVXad (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:30:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:54504 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbeCVXac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:30:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,347,1517904000";
   d="scan'208";a="40425298"
Date: Thu, 22 Mar 2018 16:30:29 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Luck@alison-desk.jf.intel.com, Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180322233027.bh6dp5vdcb4rdvqe@agluck-desk>
References: <20180322204922.GA2337@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322204922.GA2337@alison-desk.jf.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 01:49:22PM -0700, Alison Schofield wrote:
> +	if (!topology_same_node(c, o) &&
> +	    (c->x86_vendor == X86_VENDOR_INTEL &&
> +	     c->x86_model == INTEL_FAM6_SKYLAKE_X)) {

Maybe make life easier in the future to add more models
to the list by using x86_match_cpu() here?

-Tony
