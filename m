Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4ACC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A23B2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfAVLOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:14:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:59183 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfAVLOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:14:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 03:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,506,1539673200"; 
   d="scan'208";a="108801491"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.124])
  by orsmga007.jf.intel.com with ESMTP; 22 Jan 2019 03:14:02 -0800
Date:   Tue, 22 Jan 2019 19:13:59 +0800
From:   Philip Li <philip.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kbuild test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kbuild-all@01.org
Subject: Re: [kbuild-all] arch/x86/include/asm/cmpxchg.h:245:2: error: 'asm'
 operand has impossible constraints
Message-ID: <20190122111359.GA9888@intel.com>
References: <201901221204.ZqZgxRnA%fengguang.wu@intel.com>
 <20190122100815.GA26587@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122100815.GA26587@zn.tnic>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:08:34AM +0100, Borislav Petkov wrote:
> On Tue, Jan 22, 2019 at 12:53:11PM +0800, kbuild test robot wrote:
> > Hi Ingo,
> > 
> > FYI, the error/warning still remains.
> 
> Guys,
> 
> we already discussed this:
> 
> https://lists.01.org/pipermail/kbuild-all/2018-December/056206.html
> 
> but you keep reporting it.
> 
> You need to fix your reported issues tracking or otherwise no one will
> bother anymore.
thanks for the feedback, we will blacklist this. So may i understand based on
the thread at https://lists.01.org/pipermail/kbuild-all/2018-December/056225.html,
this is gcc-4.9 problem?

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
