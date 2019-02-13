Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B48C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658502070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="otYWVDVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392878AbfBMRTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:19:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56978 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfBMRTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:19:02 -0500
Received: from zn.tnic (p200300EC2BCDE80030B889FF4AEDD03A.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e800:30b8:89ff:4aed:d03a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 617A91EC02FF;
        Wed, 13 Feb 2019 18:19:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550078340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3E+h3mS+llB4qSFi5ZYOh5xcECH6qEtOL9ROupGQjZE=;
        b=otYWVDVY4RmQJ27czpfPo7KzaFPxlLDusnjVTO0yzcUM3hPUdi7mshOdMMRGOvLa45mjQO
        hmdZpQs+qJu82tetl6Iav0Owb31N2I2HReyvN/KE9M+vKhngaBi/nH4E7m4kO0nF6oGwPs
        40vngVTvaOTSqXoME2a86i2H3y9FNoU=
Date:   Wed, 13 Feb 2019 18:18:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        platform-driver-x86@vger.kernel.org, dvhart@infradead.org,
        andy@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 06/10] x86/cpu: Add Icelake to Intel family
Message-ID: <20190213171855.GD1883@zn.tnic>
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
 <20190213150810.32750-7-rajneesh.bhardwaj@linux.intel.com>
 <20190213152326.GA1883@zn.tnic>
 <308aa852-b2c3-3336-707f-d54de6ad77b7@linux.intel.com>
 <20190213160405.GC1883@zn.tnic>
 <d1d8a2fb-f8f9-7712-d53f-fac4bb2065a8@linux.intel.com>
 <46ad3b08-b96b-6ef2-a5e4-fb0865865916@intel.com>
 <1836a770-86ce-fc34-f7fd-6d1692fa184a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1836a770-86ce-fc34-f7fd-6d1692fa184a@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:43:30PM +0530, Bhardwaj, Rajneesh wrote:
> Hi Borislav, I realize that the link i mentioned is not public. Apologies
> for creating confusion around that and for the previous top posting.  I will
> drop references to the coreboot link too in the next version.

As we talked on IRC with Dave, those patches don't need to point to an
official document.

If the model number is wrong, we'll learn very soon about it. :-)

If it is a patchset enabling a feature or an erratum, then this becomes
a whole different story.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
