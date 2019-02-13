Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC45C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E36921904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aonD9Zx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391975AbfBMQEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:04:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45478 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfBMQEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:04:12 -0500
Received: from zn.tnic (p200300EC2BCDE80030B889FF4AEDD03A.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e800:30b8:89ff:4aed:d03a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91B951EC01AF;
        Wed, 13 Feb 2019 17:04:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550073850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V34Ijg4Fc1k4UhDCp94BW1/OJzu2iSUgLYzKWutbDps=;
        b=aonD9Zx+oRc2Boo+DL1GIEaRddUZHZrFyRD96Up76/ZNdFonFNv5tFQWmr4LPjwfwivDrH
        R8pCTQdAU5MfNk8UH42SxoYz/7G0Dbwiv13rm3AExGw8A4Ecqgw9gbi0mJLJhJYkaXEZ+n
        bb+oUHD0WNahnNA+HbnvHw7rGqoM+Z0=
Date:   Wed, 13 Feb 2019 17:04:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, dvhart@infradead.org,
        andy@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 06/10] x86/cpu: Add Icelake to Intel family
Message-ID: <20190213160405.GC1883@zn.tnic>
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
 <20190213150810.32750-7-rajneesh.bhardwaj@linux.intel.com>
 <20190213152326.GA1883@zn.tnic>
 <308aa852-b2c3-3336-707f-d54de6ad77b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <308aa852-b2c3-3336-707f-d54de6ad77b7@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 09:13:01PM +0530, Bhardwaj, Rajneesh wrote:
> Icelake related information is  available here https://www.intel.in/content/www/in/en/design/products-and-solutions/processors-and-chipsets/ice-lake/overview.html
> but it may require a login either with Intel or a Partner ID.
> 
> The CPUID mentioned in this document is 0x706E0 which is same as per this
> coreboot link.

You did not read what I wrote.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
