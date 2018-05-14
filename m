Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755195AbeENQfL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:35:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:41255 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752691AbeENQfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:35:09 -0400
Date: Mon, 14 May 2018 09:19:10 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, aarcange@redhat.com,
        joe.lawrence@redhat.com, gareth.evans@contextis.co.uk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@kernel.org,
        ltp@lists.linux.it
Subject: Re: [PATCH -next 0/2] ipc/shm: shmat() fixes around nil-page
Message-ID: <20180514161910.gbt32tfsocpddaav@linux-n805>
Mail-Followup-To: Vlastimil Babka <vbabka@suse.cz>,
        akpm@linux-foundation.org, aarcange@redhat.com,
        joe.lawrence@redhat.com, gareth.evans@contextis.co.uk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@kernel.org,
        ltp@lists.linux.it
References: <20180503203243.15045-1-dave@stgolabs.net>
 <8addf0c1-26cd-add9-fb9c-292cc3567014@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8addf0c1-26cd-add9-fb9c-292cc3567014@suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018, Vlastimil Babka wrote:

>Can you add appropriate Fixes: tags if possible? I guess patch 1 is
>clear, dunno about patch 2...

Right, patch 1 would still benefit from Fixes tag. As to patch 2, the bug
as been there since forever (pre-dates git history). But yeah, as both come
together and are related to a certain extent, the same Fixes could serve both
patches.

Thanks,
Davidlohr
