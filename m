Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67EF1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C932089C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C932089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbeFKWgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:36:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeFKWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:36:23 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.103])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8D169151C;
        Mon, 11 Jun 2018 22:36:22 +0000 (UTC)
Date:   Mon, 11 Jun 2018 15:36:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] memory.min fixes/refinements
Message-Id: <20180611153621.aefcf17a4d4d0b939eb35f28@linux-foundation.org>
In-Reply-To: <20180611175418.7007-1-guro@fb.com>
References: <20180611175418.7007-1-guro@fb.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 10:54:15 -0700 Roman Gushchin <guro@fb.com> wrote:

> Hi, Andrew!
> 
> Please, find an updated version of memory.min refinements/fixes
> in this patchset. It's against linus tree.
> Please, merge these patches into 4.18.
> 
> ...
>
>   mm: fix null pointer dereference in mem_cgroup_protected
>   mm, memcg: propagate memory effective protection on setting
>     memory.min/low
>   mm, memcg: don't skip memory guarantee calculations

Has nobody reviewed or acked #2 and #3?
