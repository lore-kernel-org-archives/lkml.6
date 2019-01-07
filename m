Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E197C206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546853040;
	bh=wG7Neey9WycqUkz4svEbzM2SiErJgj3hh116f4KxKCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KmcR8/eCpAEUgZQyL0JqYsqsD57gVIXOyw6xMOOlyTLSUsEPwSY+dTcThXWbqhOgb
	 5TBnUQP4J+RGYrVANrXL7vfTMBcRbIEsHQvUJoq+8FhWL1I2rKlZYHUx1RCEq6kyO5
	 ltvekMElrsg1uXZoLGf5u0ngRymuK9bttGhBo4+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfAGJX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:23:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:53470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbfAGJX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:23:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40001AD07;
        Mon,  7 Jan 2019 09:23:57 +0000 (UTC)
Date:   Mon, 7 Jan 2019 10:23:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: mmotm 2018-12-21-15-28 uploaded
Message-ID: <20190107092356.GB31793@dhcp22.suse.cz>
References: <20181221232853.WLvEi%akpm@linux-foundation.org>
 <99ab6512-9fce-9cb9-76e7-7f83d87d5f86@arm.com>
 <20190107084338.GW31793@dhcp22.suse.cz>
 <451ec03f-d669-fcd0-11c7-f7fef9f85a56@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451ec03f-d669-fcd0-11c7-f7fef9f85a56@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-01-19 14:46:43, Anshuman Khandual wrote:
> 
> 
> On 01/07/2019 02:13 PM, Michal Hocko wrote:
> > Hi,
> > 
> > On Mon 07-01-19 13:02:31, Anshuman Khandual wrote:
> >> On 12/22/2018 04:58 AM, akpm@linux-foundation.org wrote:
> > [...]
> >>> A git tree which contains the memory management portion of this tree is
> >>> maintained at git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.gi
> >>
> >> Hello Michal,
> >>
> >> I dont see the newer tags on this tree. Tried fetching all the tags from the tree
> >> but only see these right now for 2018. This release should have an equivalent tag
> >> (mmotm-2018-12-21-15-28) right ? 
> > 
> > I have stopped tracking mmotm trees in this tree quite some time ago. I
> > would much rather turn mmotm into a proper git tree which I was
> > discussing with Andrew but we didn't land in anything so far. I hope to
> > use LSFMM this year to resurrect the idea. 
> >
> 
> Even this tree http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/ does not clone. So
> right now the only way to construct the latest mmotm tree is through applying all
> the patches mentioned here at http://www.ozlabs.org/~akpm/mmotm/ on linux-next ?

linux-next should contain all of them already.

-- 
Michal Hocko
SUSE Labs
