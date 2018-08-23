Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8104FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4482320661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4482320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeHWXgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:36:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726459AbeHWXgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:36:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A95C2AE10;
        Thu, 23 Aug 2018 20:05:21 +0000 (UTC)
Date:   Thu, 23 Aug 2018 22:05:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation/l1tf: suggest what to do on systems with
 too much RAM
Message-ID: <20180823200520.GW29735@dhcp22.suse.cz>
References: <20180823134418.17008-1-vbabka@suse.cz>
 <20180823142812.7363-1-vbabka@suse.cz>
 <20180823154648.GD12066@tassilo.jf.intel.com>
 <20180823192547.GS29735@dhcp22.suse.cz>
 <20180823193833.GE12066@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823193833.GE12066@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-08-18 12:38:33, Andi Kleen wrote:
> > There are people who care about L1TF mitigations. I am not going to
> > question their motivation. In any case a hint how to make the mitigation
> > active again sounds more useful than something that sounds as scary as
> > "you are vulnerable".
> 
> FWIW an early version of these patches automatically limited the available
> memory, but Linus pointed out that people likely prefer their memory.

Nobody is questioning that. The point is to give them a hint on how to
make the mitigation active again without going to call for help. The
message does tell them how to _enable_ it and point them to the
documentation on how to _decide_.
-- 
Michal Hocko
SUSE Labs
