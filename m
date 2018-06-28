Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05097C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5022744A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5022744A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966118AbeF1Na6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:30:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:57528 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965788AbeF1Na4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:30:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 06:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,283,1526367600"; 
   d="scan'208";a="241054031"
Received: from shivamur-mobl.gar.corp.intel.com ([10.249.254.20])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2018 06:30:50 -0700
Message-ID: <722fe86b2651d2616fa9bf43d9f8b1322f4c868b.camel@linux.intel.com>
Subject: Re: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alan Cox <alan@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Date:   Thu, 28 Jun 2018 16:30:49 +0300
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D956753@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
         <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
         <cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
         <5c50d7fa2bf495f26443bd2da2e15df34c3d23f7.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D956753@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 21:13 +0000, Winkler, Tomas wrote:
> Very well, I will remove the NESTED flag.  though I have feeling you are
> shooting from the hip you didn't really read the code. 
> Please there anyone who can review the code?

Asking to change a minor thing in a patch does not really fit into that
profile. I've even tried the patch a few times in it seems to work just
fine. You are making a big deal out of nothing.

/Jarkko
