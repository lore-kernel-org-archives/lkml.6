Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A29020883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A29020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbeGKPfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:35:15 -0400
Received: from foss.arm.com ([217.140.101.70]:38738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387455AbeGKPfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:35:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B874415AD;
        Wed, 11 Jul 2018 08:30:23 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEEA73F5B1;
        Wed, 11 Jul 2018 08:30:21 -0700 (PDT)
Date:   Wed, 11 Jul 2018 16:30:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
Message-ID: <20180711153015.GA10578@e107155-lin>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
 <20180710213557.GC27827@roeck-us.net>
 <CABe79T4+S2vxx8RoNkEtY7ncaKGvXVf0n_yqN81gmtHnhgqg9A@mail.gmail.com>
 <3868f0c7-e45e-d3b4-5365-12a6a0646f6f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3868f0c7-e45e-d3b4-5365-12a6a0646f6f@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 06:47:49AM -0700, Guenter Roeck wrote:
> On 07/11/2018 06:22 AM, Srinath Mannam wrote:
> >Hi Guenter,
> >
> >Thank you very much for all the help with your feedback and review
> >comments to complete the changes very fast.
> >
> >About the documentation..
> >I have gone through few similar patches available in the kernel are
> >listed in the mail of previous version.
> >No documentation available in Linux for the properties used in those
> >patches also.
>
> " No documentation available _in Linux_"
>
> Emphasis mine. Yes, I noticed this as well. I was asking for a reference
> to documentation _outside_ Linux. Sorry for not being more specific.

Typically new properties needs to registered or discussed in dsd@acpica.org
Though there's almost no activity on that list for more than a year now.
IIRC, the thread[1] gives kind of agreement that was reached after
elaborate discussion on _DSD properties.

--
Regards,
Sudeep

[1] https://lists.acpica.org/pipermail/dsd/2015-December/000027.html
