Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8858AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342A120844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342A120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbeGXSOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:14:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:59870 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388333AbeGXSOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:14:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 10:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,398,1526367600"; 
   d="scan'208";a="75539825"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 24 Jul 2018 10:06:37 -0700
Message-ID: <399c1cc851f983370a0308c76c68a97ff41a5d4f.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/3] lib: add crc64 calculation routines
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Coly Li <colyli@suse.de>, Eric Biggers <ebiggers3@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Tue, 24 Jul 2018 20:06:36 +0300
In-Reply-To: <dd95ab25-562e-1318-19e9-c8163969252f@suse.de>
References: <20180718165545.1622-1-colyli@suse.de>
         <20180718165545.1622-2-colyli@suse.de>
         <20180724042637.GA1944@sol.localdomain>
         <dd95ab25-562e-1318-19e9-c8163969252f@suse.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 00:29 +0800, Coly Li wrote:
> On 2018/7/24 12:26 PM, Eric Biggers wrote:
> > On Thu, Jul 19, 2018 at 12:55:43AM +0800, Coly Li wrote:
> > > This patch adds the re-write crc64 calculation routines for Linux
> > > kernel.
> > > The CRC64 polynomical arithmetic follows ECMA-182 specification,
> > > inspired
> > 
> > "polynomical" => "polynomial".  Same everywhere else in the patches.
> > 
> 
> Hi Eric,
> 
> Thanks for your careful review. I will post a fixing patch to fix all
> these issues.

IIUC this series in Andrew's quilt. So, it's still possible to replace
it with better one, I suppose. Ask Andrew (at least I remember recent
case where he just replaced series by fixed one).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
