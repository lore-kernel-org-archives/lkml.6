Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D36C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9AD2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9AD2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbeHIL6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:58:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:18527 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeHIL6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:58:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 02:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,214,1531810800"; 
   d="scan'208";a="63793663"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2018 02:34:02 -0700
Message-ID: <17a90b003bcc2f1dda2b92b65f16c212ffddc571.camel@linux.intel.com>
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        rashmica <rashmicy@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Aug 2018 12:34:01 +0300
In-Reply-To: <87ftzo9i77.fsf@concordia.ellerman.id.au>
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
         <87mutxb9qy.fsf@concordia.ellerman.id.au>
         <7857c69a-a209-541b-b2e1-9fe2e288ca65@gmail.com>
         <87ftzo9i77.fsf@concordia.ellerman.id.au>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 16:18 +1000, Michael Ellerman wrote:
> rashmica <rashmicy@gmail.com> writes:
> > On 08/08/18 17:25, Michael Ellerman wrote:
> > > Christophe Leroy <christophe.leroy@c-s.fr> writes:
> > > > 
> > mpe I sent a patch doing that awhile ago and you obviously didn't
> > like
> > it because you never merged it :P

Hmm... I (as an author of the test case) never saw that patch.

> Sorry, I wasn't sure who should merge it, and never followed up.

lib/* most of the time under Andrew's responsibility, though since it's
orphaned in MAINTAINERS, anyone can push, though, I think, it's good to
notify Andrew.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

