Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7012C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B83D20660
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547031812;
	bh=aGFVvWoyCOqH/x1EhKDSFUmLKwvPsZEKGVADlivRO5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=om4oayDkbQbxg6avPYCvVGTvXuDAw5Yj8mgRnFMYwYoQ7WY04fhmkRfk1EHsmmFFb
	 wzIcvzaXVCGrKsa8S+8DDjohuCA3HNh8n1lsY+fsQ+nvcfC8iqQlK9ynUoSbn0mVXG
	 0tc5Tp+TsoT0HKvep8bgbgCZiDSu5dHp6sslrJFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfAILDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:03:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:52022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730350AbfAILDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:03:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A3ADAEA3;
        Wed,  9 Jan 2019 11:03:30 +0000 (UTC)
Date:   Wed, 9 Jan 2019 12:03:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-mm@kvack.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
Message-ID: <20190109110328.GS31793@dhcp22.suse.cz>
References: <20190107143802.16847-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107143802.16847-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo,
can you confirm that these two patches are fixing the issue you have
reported please?
-- 
Michal Hocko
SUSE Labs
