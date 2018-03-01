Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163096AbeCAX1k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:27:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162904AbeCAX1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:27:38 -0500
Date: Thu, 1 Mar 2018 15:27:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Rientjes <rientjes@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, compaction: drain pcps for zone when kcompactd
 fails
Message-Id: <20180301152737.62b78dcb129339a3261a9820@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.20.1803010340100.88270@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803010340100.88270@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 03:42:04 -0800 (PST) David Rientjes <rientjes@google.com> wrote:

> It's possible for buddy pages to become stranded on pcps that, if drained,
> could be merged with other buddy pages on the zone's free area to form
> large order pages, including up to MAX_ORDER.

I grabbed this as-is.  Perhaps you could send along a new changelog so
that others won't be asking the same questions as Vlastimil?

The patch has no reviews or acks at this time...
