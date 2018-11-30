Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AEAC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F220660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88F220660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLAJAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:00:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:48201 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeLAJAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:00:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 13:50:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="118888371"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2018 13:50:03 -0800
Date:   Fri, 30 Nov 2018 13:50:03 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Joshua Kinard <kumba@gentoo.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 01/15] MIPS: replace **** with a hug
Message-ID: <20181130215003.GH23772@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-2-jarkko.sakkinen@linux.intel.com>
 <20181130195758.GA20328@linux.intel.com>
 <9ba4d08d-10d1-c233-476a-c73051b8c9f5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba4d08d-10d1-c233-476a-c73051b8c9f5@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:06:30PM +0200, Nikolay Borisov wrote:
> I find it quite ridiculous that grown up people are engaging at yet
> another coc-related conversation and are on the way to blowing it out of
> proportions. Let's focus on improving the ACTUAL code what's the point
> to bikeshed on the word?
> 
> I've seen people before me comment that some comments are plainly out of
> date and that warrants their removal but otherwise nitpicking things
> like that. It seems common sense is very scant these days...

I have absolutely nothing against CoC.

If you look up from LKML, there total zero posts from criticizing of
having such. OK, maybe I find it bit too high-level, and yeah, this
patch set has been useful to know where the line is. I can go through
the commits and think more appropriate alternatives (thus the RFC-tag).

Thanks.

/Jarkko
