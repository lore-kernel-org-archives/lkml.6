Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeEOQ0W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:26:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:24245 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753125AbeEOQ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:26:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="199573855"
Message-ID: <1526401576.5391.2.camel@linux.intel.com>
Subject: Re: [PATCH 0/15] x86/split_lock: Enable #AC exception for split
 locked accesses
From: Alan Cox <alan@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>
Cc: x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 15 May 2018 17:26:16 +0100
In-Reply-To: <ef39e053-ad81-2058-f66c-037f90b53516@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
         <ef39e053-ad81-2058-f66c-037f90b53516@intel.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you describe the performance degradation?  Why is this not a
> "doctor it hurts when I do that" situation?

They already know it hurts - the question is why and where.

Alan
