Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /JzrNWmTGVthTQAAmS7hNA
	; Thu, 07 Jun 2018 20:21:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C738F6089E; Thu,  7 Jun 2018 20:21:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F20960290;
	Thu,  7 Jun 2018 20:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F20960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeFGUV3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:21:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:54680 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753028AbeFGUV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:21:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 13:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="235321084"
Received: from 2b52.sc.intel.com (HELO [143.183.136.51]) ([143.183.136.51])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2018 13:21:26 -0700
Message-ID: <1528402695.5265.24.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 08/10] mm: Prevent mremap of shadow stack
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
Date: Thu, 07 Jun 2018 13:18:15 -0700
In-Reply-To: <CALCETrVX8nE6oFnJH7yZCydxtnC-VAhhnYs=ekJELc07a2UKiQ@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-9-yu-cheng.yu@intel.com>
         <CALCETrVX8nE6oFnJH7yZCydxtnC-VAhhnYs=ekJELc07a2UKiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Please justify.  This seems actively harmful to me.

I will remove this patch.
