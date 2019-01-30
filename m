Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D1AC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FD720855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbfA3RTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:19:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:40642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfA3RTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:19:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF25BB018;
        Wed, 30 Jan 2019 17:19:41 +0000 (UTC)
Date:   Wed, 30 Jan 2019 18:19:33 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86: avoid confusion over the new RESCTRL config prompt
Message-ID: <20190130171933.GC21221@zn.tnic>
References: <20190129225218.15441-1-hannes@cmpxchg.org>
 <20190129230845.GG28773@zn.tnic>
 <20190130164626.GA17841@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130164626.GA17841@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:46:26AM -0500, Johannes Weiner wrote:
> This is still awefully close to the cgroup CPU resource
> controller. Since it's more hardware-specific, and the config symbol
> also has the x86 in it, how about "x86 CPU resource control support"?

Fine by me.

What about

s/X86_RESCTRL/X86_CPU_RESCTRL/g

?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
