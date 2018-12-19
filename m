Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A17C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D74720869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545251561;
	bh=JMh+L05rD6JGnwQtNaFLU9DL06cfoKZlRxlsQmP4fGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BoEvCjtEIekyk2tLge8qSTFMOiLpB2xGX1FS1ROIh+kyMoB2SjrAcSuTRhN8A+6u+
	 vM3RCF1HrGGt6+8+NMzzFZ/KIzPBFK0KCCyTYmlCVGsfXk4Kvk68TaPrMqbmWNumKe
	 ASshwvdFY1EGcASFtLnhb5wXjHi3fHcPal7a9gHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbeLSUck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:32:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:51774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727818AbeLSUck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:32:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 761C7B674;
        Wed, 19 Dec 2018 20:32:38 +0000 (UTC)
Date:   Wed, 19 Dec 2018 21:32:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@suse.de
Subject: Re: [PATCH v6 0/6] mm: Randomize free memory
Message-ID: <20181219203236.GA5689@dhcp22.suse.cz>
References: <154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-12-18 20:23:23, Dan Williams wrote:
> Andrew, this needs at least an ack from Michal, or Mel before it moves
> forward. It would be a nice surprise / present to see it move forward
> before the holidays, but I suspect it may need to simmer until the new
> year. This series is against v4.20-rc6.

I am sorry but I am unlikely to look into this before the end of the
year and I do not want to promise early days in new year either because
who knows how much stuff piles up by then. But this is definitely on my
radar.
-- 
Michal Hocko
SUSE Labs
