Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6822C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A06208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A06208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936361AbeFORQJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:16:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:44451 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936136AbeFORQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:16:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00169AED0;
        Fri, 15 Jun 2018 17:16:05 +0000 (UTC)
Date:   Fri, 15 Jun 2018 19:16:00 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/mce: Check for alternate indication of machine
 check recovery on Skylake
Message-ID: <20180615171600.GA15584@zn.tnic>
References: <cover.1527283897.git.tony.luck@intel.com>
 <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com>
 <20180607174337.GA22594@agluck-desk>
 <CAPcyv4hNjnm+CawtRzU=ROUo02+XsBxjUmMGMcpjHKnL5M42Jw@mail.gmail.com>
 <20180607202445.GC20936@zn.tnic>
 <20180614215754.GA26090@agluck-desk>
 <20180615114517.GB24132@zn.tnic>
 <20180615163406.GA8775@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180615163406.GA8775@agluck-desk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 09:34:06AM -0700, Luck, Tony wrote:
> I was just worried that Thomas is holding off asking Linus to pull
> because he's waiting for part 2/3, while you might be planning to
> hold onto part 2/3 for the next merge (and add the other cleanups
> you RFC'd).
> 
> I'm OK either way on part 2/3 (it just makes for better error messages,
> it doesn't fix any bugs).

Yes, and this is my understanding too - 2/3 is not urgent material so no
need to hurry that particular one.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
