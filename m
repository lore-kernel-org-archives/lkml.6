Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8436AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE4B21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE4B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeJIPSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:18:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeJIPSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:18:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DEFAB03E;
        Tue,  9 Oct 2018 08:02:54 +0000 (UTC)
Date:   Tue, 9 Oct 2018 10:02:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yong-Taek Lee <ytk.lee@samsung.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] mm, oom_adj: avoid meaningless loop to find
 processes sharing mm
Message-ID: <20181009080253.GD8528@dhcp22.suse.cz>
References: <67eedc4c-7afa-e845-6c88-9716fd820de6@i-love.sakura.ne.jp>
 <af7ae9c4-d7f1-69af-58fa-ec6949161f5b@I-love.SAKURA.ne.jp>
 <20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p8>
 <20181008061407epcms1p519703ae6373a770160c8f912c7aa9521@epcms1p5>
 <CGME20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p2>
 <20181008083855epcms1p20e691e5a001f3b94b267997c24e91128@epcms1p2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008083855epcms1p20e691e5a001f3b94b267997c24e91128@epcms1p2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-10-18 17:38:55, Yong-Taek Lee wrote:
> Do you have any other idea to avoid meaningless loop ? 

I have already asked in the earlier posting but let's follow up here.
Could you please expand on why this actually matters and what are the
consequences please?
-- 
Michal Hocko
SUSE Labs
