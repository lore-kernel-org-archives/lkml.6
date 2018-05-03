Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeECCbr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 22:31:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbeECCbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 22:31:46 -0400
Date: Wed, 2 May 2018 19:31:43 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 RESEND 2/2] mm: ignore memory.min of abandoned memory
 cgroups
Message-ID: <20180503023142.GA4938@bombadil.infradead.org>
References: <20180502154710.18737-1-guro@fb.com>
 <20180502154710.18737-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502154710.18737-2-guro@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 04:47:10PM +0100, Roman Gushchin wrote:
> +				 * Abandoned cgroups are loosing protection,

"losing".
