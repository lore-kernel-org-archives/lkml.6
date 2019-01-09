Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F8B206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547035336;
	bh=XTBZhDsJc4Ynp78V2jlVO07TKDLhJocNSllKYI2qRtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fEV0APbhRLItC4oSvVFe82S2QzPKwSfwAllTZhsKDSm7mqFYFVa/6IZ7JelFbjcMK
	 4NsOTWpSJNQkzYcr2UI4jmawN5qyzrMPQ+D4Yr+DF5CMmBsmv5+oT+ZYQapyzs4zSB
	 Qj10OyzUHAML7I0zwNjli6OurGMD0ofEsMacdlm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfAIMCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:02:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:35714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbfAIMCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:02:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A2DBAF71;
        Wed,  9 Jan 2019 12:02:14 +0000 (UTC)
Date:   Wed, 9 Jan 2019 13:02:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
Message-ID: <20190109120212.GT31793@dhcp22.suse.cz>
References: <20190107143802.16847-1-mhocko@kernel.org>
 <20190109110328.GS31793@dhcp22.suse.cz>
 <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-01-19 20:34:46, Tetsuo Handa wrote:
> On 2019/01/09 20:03, Michal Hocko wrote:
> > Tetsuo,
> > can you confirm that these two patches are fixing the issue you have
> > reported please?
> > 
> 
> My patch fixes the issue better than your "[PATCH 2/2] memcg: do not
> report racy no-eligible OOM tasks" does.

OK, so we are stuck again. Hooray!
-- 
Michal Hocko
SUSE Labs
