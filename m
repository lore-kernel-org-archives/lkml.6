Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348E1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62BD2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62BD2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeI0EhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:37:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeI0EhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:37:09 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B48EB1087;
        Wed, 26 Sep 2018 22:22:02 +0000 (UTC)
Date:   Wed, 26 Sep 2018 15:22:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-mm@ archive on lore.kernel.org (Was: [PATCH 0/2] thp
 nodereclaim fixes)
Message-Id: <20180926152200.8a3bfb1845de21937914feeb@linux-foundation.org>
In-Reply-To: <20180926131445.GW6278@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
        <20180926130850.vk6y6zxppn7bkovk@kshutemo-mobl1>
        <20180926131445.GW6278@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 15:14:45 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > Does anybody have good enough archive of the list to get started?
> 
> Maybe Andrew has. Mine is incomplete for sure.

fwiw, I have everything going back to 2001.   For some reason.
