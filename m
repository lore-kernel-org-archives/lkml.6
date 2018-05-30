Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeE3Nw7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:52:59 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:44894 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbeE3Nwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:52:55 -0400
X-Google-Smtp-Source: ADUXVKLkhqB77iQa7qXR/eXgEx/9pVG34S9zGi4WlfkvwGN30JeUZjZLLymDNKUheyop925JMFuruQ==
Date: Wed, 30 May 2018 15:52:51 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v9 0/7] Enable cpuset controller in default hierarchy
Message-ID: <20180530135251.GE3320@localhost.localdomain>
References: <1527601294-3444-1-git-send-email-longman@redhat.com>
 <20180530101317.GB3320@localhost.localdomain>
 <d74c67ea-43c9-cabb-4303-ecff008412df@redhat.com>
 <20180530130555.GD3320@localhost.localdomain>
 <e42f910a-83b7-0fd2-2c77-05d069441c2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42f910a-83b7-0fd2-2c77-05d069441c2f@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/18 09:47, Waiman Long wrote:

[...]

> Yes, it is a bug in the existing code. I have sent out a patch to fix that.

Cool, thanks. I'll have a look.
