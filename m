Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B42C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CD920881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CD920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbeGXMNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:13:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:42421 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388585AbeGXMNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:13:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 04:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,397,1526367600"; 
   d="scan'208";a="74024090"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2018 04:07:13 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id E9C6C203B0; Tue, 24 Jul 2018 14:07:12 +0300 (EEST)
Date:   Tue, 24 Jul 2018 14:07:12 +0300
From:   "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
To:     "Chiang, AlanX" <alanx.chiang@intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Rob Herring <robh@kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Yeh, Andy" <andy.yeh@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "jcliang@chromium.org" <jcliang@chromium.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
 property
Message-ID: <20180724110712.2f26evp3kdbnhyhd@paasikivi.fi.intel.com>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
 <1530522740-2798-2-git-send-email-alanx.chiang@intel.com>
 <20180705212204.GA10449@rob-hp-laptop>
 <alpine.LFD.2.21.1807051623400.12206@localhost.localdomain>
 <0772C36F3434E145A062D024A4869A09010B1E4D@PGSMSX101.gar.corp.intel.com>
 <CAMRc=Mc4s6tJw6dAHYCPQdsPox9V8sBTqY3LHi5XMWALwOZdyA@mail.gmail.com>
 <CAMRc=MfNa0OwMbJ6ibbCJJD0pV9tKtyTZ3cQi34ra5oc_-5jYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfNa0OwMbJ6ibbCJJD0pV9tKtyTZ3cQi34ra5oc_-5jYw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:01:17AM +0200, Bartosz Golaszewski wrote:
> I will soon be sending my pull request to Wolfram, so if you still
> want that applied for 4.19 - please resend with the commit message
> fixed.

Alan?

Not sure whether it's too late for 4.19 now though.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
