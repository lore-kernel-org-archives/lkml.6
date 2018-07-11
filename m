Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87973C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E04920875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E04920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeGKH4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:56:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:50468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbeGKH4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:56:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF4C3ACA5;
        Wed, 11 Jul 2018 07:53:48 +0000 (UTC)
Date:   Wed, 11 Jul 2018 09:53:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v13 2/2] Add oom victim's memcg to the oom context
 information
Message-ID: <20180711074933.GA20050@dhcp22.suse.cz>
References: <1531217988-33940-1-git-send-email-ufo19890607@gmail.com>
 <1531217988-33940-2-git-send-email-ufo19890607@gmail.com>
 <20180710120816.GJ14284@dhcp22.suse.cz>
 <CAHCio2jQO58+npS269Ufyg17unHUeKDRpVjS4-ggBEV8xFMMqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2jQO58+npS269Ufyg17unHUeKDRpVjS4-ggBEV8xFMMqQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 11:39:29, 禹舟键 wrote:
> Hi Michal
> Sorry , I l forget to update the changlog for the second patch, but
> the cpuset information is not missing.

The cpuset information is missing in the changelog.

> Do I still need to make the
> v14  or just update the changelog for v13?

Wait for more feedback for few days. If there are no other concerns just
repost this patch 2. Btw. I still think that it would be more logical
to print cpuset before memcg info. But I will not insist.
-- 
Michal Hocko
SUSE Labs
