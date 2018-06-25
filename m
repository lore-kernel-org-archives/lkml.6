Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7EFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137E72552E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137E72552E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeFYHjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:39:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:43884 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbeFYHjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:39:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 00:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="51997656"
Received: from jsakkine-mobl1.tm.intel.com (HELO jsakkine-mobl1) ([10.237.50.42])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2018 00:39:29 -0700
Message-ID: <cb6c99eb2c29ab52146e92ba08075a1b6be7c2ce.camel@linux.intel.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 07/13] x86, sgx: detect Intel
 SGX
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        npmccallum@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Mon, 25 Jun 2018 10:39:28 +0300
In-Reply-To: <CALCETrU+s97soHtiC3p3hkdwqZhEMdjPyJByskb99a+Z8PZjpA@mail.gmail.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-8-jarkko.sakkinen@linux.intel.com>
         <4fc3b6b0-6e4b-3d5f-4d54-2bf7539c7a17@intel.com>
         <CALCETrU+s97soHtiC3p3hkdwqZhEMdjPyJByskb99a+Z8PZjpA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 14:36 -0700, Andy Lutomirski wrote:
> SGX: disabled by firmware
> SGX: disabled because CPU does not support flexible launch control
> SGX: disabled because firmware does not support flexible launch control
> SGX: disabled because the phase of the moon is wrong
> SGX: enabled; using SGX1
> SGX: enabled, using SGX2

Makes sense for trouble-shooting (and in that case the check for
SGX_ENABLE flag is more appropriate).

/Jarkko
