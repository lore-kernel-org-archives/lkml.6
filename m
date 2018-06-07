Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FdTjCy1UGVvWLAAAmS7hNA
	; Thu, 07 Jun 2018 15:51:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 466F46074D; Thu,  7 Jun 2018 15:51:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D842260290;
	Thu,  7 Jun 2018 15:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D842260290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934514AbeFGPvH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:51:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:60249 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933702AbeFGPvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:51:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 08:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="61249294"
Received: from 2b52.sc.intel.com (HELO [143.183.136.51]) ([143.183.136.51])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2018 08:51:03 -0700
Message-ID: <1528386472.4636.1.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 2/5] x86/fpu/xstate: Change some names to separate
 XSAVES system and user states
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Date: Thu, 07 Jun 2018 08:47:52 -0700
In-Reply-To: <CALCETrXAx4vBUxf3VaePNm3HHLZkdTFAR9TV0T+A-jb2QL7Uag@mail.gmail.com>
References: <20180607143544.3477-1-yu-cheng.yu@intel.com>
         <20180607143544.3477-3-yu-cheng.yu@intel.com>
         <CALCETrXAx4vBUxf3VaePNm3HHLZkdTFAR9TV0T+A-jb2QL7Uag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 08:38 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > To support XSAVES system states, change some names to distinguish
> > user and system states.
> >
> > Change:
> >   supervisor to system
> >   copy_init_fpstate_to_fpregs() to copy_init_fpstate_user_settings_to_fpregs()
> >   xfeatures_mask to xfeatures_mask_user
> >   XCNTXT_MASK to SUPPORTED_XFEATURES_MASK (states supported)
> 
> How about copy_init_user_fpstate_to_fpregs()?  It's shorter and more
> to the point.
> 
> --Andy

I will change that.

Yu-cheng
