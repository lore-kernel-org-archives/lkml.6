Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5478ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C41420652
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C41420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeGQJJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:09:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:4744 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeGQJJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:09:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 01:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="65269579"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2018 01:37:36 -0700
Message-ID: <b85806d5a6085f67fb430ca0808b286d0d4d737e.camel@linux.intel.com>
Subject: Re: [PATCH 0/4] add crc64 calculation as kernel library
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Date:   Tue, 17 Jul 2018 11:37:34 +0300
In-Reply-To: <608100d7-6e98-13ec-57ab-5c672131e332@suse.de>
References: <20180716165507.23100-1-colyli@suse.de>
         <8538b45b-bf30-926a-50fb-700b4bf1c636@suse.de>
         <608100d7-6e98-13ec-57ab-5c672131e332@suse.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 14:19 +0800, Coly Li wrote:
> On 2018/7/17 1:46 PM, Hannes Reinecke wrote:

> > Actually, I would merge patch 1 & 2 together (pointless to introduce
> > an
> > option for which no code exists).
> 

I was just about to say the same.

> The patch 1 was originally from Andy Shevchenko, and I want to keep
> his
> contribute. If it seems not a good idea from me, I will merge them
> into
> 1 patch in v2 series.

We have Co-developed-by tag, for example, which you may use here (if you
choose this way, leave my SoB as well).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
