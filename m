Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AD1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA86C2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA86C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbeGRDcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:32:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:1919 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731304AbeGRDcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:32:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 19:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,368,1526367600"; 
   d="scan'208";a="73246076"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2018 19:56:53 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Shaohua Li" <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 0/7] swap: THP optimizing refactoring
References: <20180717005556.29758-1-ying.huang@intel.com>
        <20180717151715.rbxvofb6yf5toy47@ca-dmjordan1.us.oracle.com>
Date:   Wed, 18 Jul 2018 10:56:52 +0800
In-Reply-To: <20180717151715.rbxvofb6yf5toy47@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Tue, 17 Jul 2018 08:17:16 -0700")
Message-ID: <87fu0hgsjv.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Tue, Jul 17, 2018 at 08:55:49AM +0800, Huang, Ying wrote:
>> This patchset is based on 2018-07-13 head of mmotm tree.
>
> Looks good.
>
> Still think patch 7 would be easier to review if split into two logical
> changes.  Either way, though.
>
> For the series,
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Thanks a lot for your review!

Best Regards,
Huang, Ying
