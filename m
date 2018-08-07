Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEF6C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D29821774
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D29821774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbeHGMR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:17:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:35394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbeHGMR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:17:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70EAFADC8;
        Tue,  7 Aug 2018 10:04:20 +0000 (UTC)
Message-ID: <1533636259.7912.2.camel@suse.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
From:   Oliver Neukum <oneukum@suse.com>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Theodore Ts o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date:   Tue, 07 Aug 2018 12:04:19 +0200
In-Reply-To: <20180807073840.GA17894@chenyu-desktop>
References: <20180718202235.GA4132@amd>
         <20180718235851.GA22170@sandybridge-desktop> <20180719110149.GA4679@amd>
         <20180719132003.GA30981@sandybridge-desktop> <20180720102532.GA20284@amd>
         <1532346156.3057.11.camel@suse.com>
         <20180723162302.GA4503@sandybridge-desktop>
         <1532590246.7411.3.camel@suse.com> <20180806075754.GA12124@chenyu-desktop>
         <1533550820.15815.14.camel@suse.com>
         <20180807073840.GA17894@chenyu-desktop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2018-08-07 at 15:38 +0800, Yu Chen wrote:
> > As STD affects the whole machine it must require root rights.
> > So I cannot see how you can talk about a session belonging
> > to a user. Please explain.
> > 
> 
> The case is for physical access, not the 'user' in OS.

Well, yes, but Secure Boot does not guard against anybody
booting or halting the machine. It limits what you can
boot by a chain of trust.

I think you are trying to add a feature to Secure Boot.

	Regards
		Oliver

