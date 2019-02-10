Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107F6C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE20E213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfBJW3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 17:29:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:13727 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfBJW3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 17:29:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2019 14:29:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,356,1544515200"; 
   d="scan'208";a="125412173"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2019 14:29:15 -0800
Date:   Sun, 10 Feb 2019 14:29:03 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/gup.c: Remove unused write variable
Message-ID: <20190210222902.GA13720@iweiny-DESK2.sc.intel.com>
References: <20190209173109.9361-1-ira.weiny@intel.com>
 <alpine.DEB.2.21.1902102029560.8784@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902102029560.8784@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 08:39:44PM +0100, Thomas Gleixner wrote:
> Ira,
> 
> On Sat, 9 Feb 2019, ira.weiny@intel.com wrote:
> 
> nice patch. Just a few nitpicks vs. the subject and the change log.
> 
> > Subject: [PATCH] mm/gup.c: Remove unused write variable
> 
> We usually avoid filenames in the subsystem prefix. mm/gup: is sufficient.

Thanks.

> 
> But what's a bit more confusing is 'write variable'. You are not removing a
> variable, you are removing a unused function argument. That's two different
> things.

Indeed my mistake.

> 
> > write is unused in gup_fast_permitted so remove it.
> 
> When referencing functions please use brackets so it's clear that you talk
> about a function, i.e. gup_fast_permitted().
> 
> So the correct subject line would be:
> 
>   Subject: [PATCH] mm/gup: Remove write argument from gup_fast_permitted()

NP, V2 on its way,
Ira

> 
> Thanks,
> 
> 	tglx
