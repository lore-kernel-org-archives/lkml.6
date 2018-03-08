Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeCHXlC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:41:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeCHXlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:41:00 -0500
Date: Thu, 8 Mar 2018 15:40:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: expose mem_cgroup_put API
Message-Id: <20180308154058.9158c9c1ff1e4e67990bcce7@linux-foundation.org>
In-Reply-To: <20180308024850.39737-1-shakeelb@google.com>
References: <20180308024850.39737-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Mar 2018 18:48:50 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> This patch exports mem_cgroup_put API to put the refcnt of the memory
> cgroup.

Not the best of changelogs :(

Why is this patch being added?

It's a prerequisite for <I-forget-which-patch> isn't it?
