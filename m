Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0BEC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D41020873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D41020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeG1OuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 10:50:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:46119 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbeG1OuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 10:50:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jul 2018 06:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,414,1526367600"; 
   d="scan'208";a="57878521"
Received: from valeriof-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.48.151])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jul 2018 06:23:24 -0700
Date:   Sat, 28 Jul 2018 16:23:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 11/13] platform/x86: Intel SGX driver
Message-ID: <20180728132323.GC7697@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-12-jarkko.sakkinen@linux.intel.com>
 <2cd5def0-61f0-3d57-efa4-7d835d7bdb86@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd5def0-61f0-3d57-efa4-7d835d7bdb86@fortanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:52:27AM -0700, Jethro Beekman wrote:
> On 2018-07-03 11:19, Jarkko Sakkinen wrote:
> > +/* IOCTL return values */
> > +#define SGX_POWER_LOST_ENCLAVE		0x40000000
> > +#define SGX_LE_ROLLBACK			0x40000001
> 
> I don't think SGX_LE_ROLLBACK is used anymore.
> 
> Jethro Beekman | Fortanix

Correct. Thaks for spotting that out.

I've on a leave for soon past three weeks and one week is remaining but
have been slowly preparing v13 like one day a week so after next week it
shouldn't take much time to get it out.

/Jarkko
