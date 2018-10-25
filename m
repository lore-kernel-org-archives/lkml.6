Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE118C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAEB20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAEB20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJZAvj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:51:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJZAvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:51:38 -0400
Received: from [192.168.86.34] (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F5B81E2B;
        Thu, 25 Oct 2018 16:18:10 +0000 (UTC)
Date:   Thu, 25 Oct 2018 09:18:05 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20181025161410.GT18839@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org> <20180925120326.24392-3-mhocko@kernel.org> <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1> <20180926141708.GX6278@dhcp22.suse.cz> <20180926142227.GZ6278@dhcp22.suse.cz> <20181018191147.33e8d5e1ebd785c06aab7b30@linux-foundation.org> <20181019080657.GJ18839@dhcp22.suse.cz> <583b20e5-4925-e175-1533-5c2d2bab9192@suse.cz> <20181024161754.0d174e7c22113f4f8aad1940@linux-foundation.org> <983e0c59-99ef-796c-bfc4-00e67782d1f1@suse.cz> <20181025161410.GT18839@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask
To:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mel Gorman <mgorman@suse.de>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
From:   Andrew Morton <akpm@linux-foundation.org>
Message-ID: <E0A009A6-FF31-459E-B223-6743C395F659@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 25, 2018 9:14:10 AM PDT, Michal Hocko <mhocko@kernel.org> wrote:

>Andrew. Do you want me to repost the patch or you plan to update the
>changelog yourself?

Please send a replacement changelog and I'll paste it in? 
