Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A864EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A933214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A933214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbeHBN6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:58:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:34686 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732074AbeHBN6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:58:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 05:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,435,1526367600"; 
   d="scan'208";a="251116159"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2018 05:07:49 -0700
Message-ID: <54b34c40dbe7a16ef4964813ad5aa73027a917f1.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/5] bitmap: Introduce alloc/free helpers
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Date:   Thu, 02 Aug 2018 15:07:48 +0300
In-Reply-To: <20180802010325.GB184797@dtor-ws>
References: <20180630201750.2588-1-andriy.shevchenko@linux.intel.com>
         <CAHp75Vd9RSxVsYrbiAFJKLPL4wNzAtS9qAPjCNJJ4E=QbeTP8A@mail.gmail.com>
         <2310fa540b9e5db3b94f4917ecae76dce2a2ca65.camel@linux.intel.com>
         <20180802010325.GB184797@dtor-ws>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 18:03 -0700, Dmitry Torokhov wrote:

> I put the first 3 patches into an immutable branch off 4.17:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/4.17-
> bitmap

Thank you!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
