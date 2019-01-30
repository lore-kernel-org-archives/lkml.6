Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B61C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC242184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Cjqr1+GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfA3LPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:15:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55314 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfA3LPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:15:22 -0500
Received: from zn.tnic (p200300EC2BCAED00302FA729E39312A6.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:ed00:302f:a729:e393:12a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E4151EC0338;
        Wed, 30 Jan 2019 12:15:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548846921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lXR50jr7SoOIYrt32VNGNsmo5d4z7EnSBIc4Vllw+S8=;
        b=Cjqr1+GOTNcxsfVZgtkgMHDw24Ilhc/GOzjdWpIvnQ9Ou2sX4Age8QDtJRcdKkd3gJLKi+
        Ek++WDX19PCPt6vzJTdNZsyFzyrLlfx/uMcCNzpgtWgI5VKszwWeDZjQWaZwZjNnaY6WAf
        iKxOryX9FWpIyVv1veCEhI1+14Jbqlk=
Date:   Wed, 30 Jan 2019 12:15:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Philip Li <philip.li@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] arch/x86/include/asm/cmpxchg.h:245:2: error: 'asm'
 operand has impossible constraints
Message-ID: <20190130111517.GA18383@zn.tnic>
References: <201901221204.ZqZgxRnA%fengguang.wu@intel.com>
 <20190122100815.GA26587@zn.tnic>
 <20190122111359.GA9888@intel.com>
 <20190122115544.GC26587@zn.tnic>
 <84021d10-0711-d94e-c2d3-92cc670d8a2f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84021d10-0711-d94e-c2d3-92cc670d8a2f@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:28:40AM +0800, Rong Chen wrote:
> we have added it to the blacklist, and there's no other configuration found
> in the past reports.

Thanks.

We'll dig it out again if it becomes more prominent.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
