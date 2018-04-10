Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeDJUsj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:48:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJUsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:48:38 -0400
Date: Tue, 10 Apr 2018 13:48:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Greg Thelen <gthelen@google.com>, Wang Long <wanglong19@meituan.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        npiggin@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] writeback: safer lock nesting
Message-Id: <20180410134837.d2b0f2d1cd940bb08c2bad0a@linux-foundation.org>
In-Reply-To: <20180410063357.GS21835@dhcp22.suse.cz>
References: <201804080259.VS5U0mKT%fengguang.wu@intel.com>
        <20180410005908.167976-1-gthelen@google.com>
        <20180410063357.GS21835@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 08:33:57 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > Reported-by: Wang Long <wanglong19@meituan.com>
> > Signed-off-by: Greg Thelen <gthelen@google.com>
> > Change-Id: Ibb773e8045852978f6207074491d262f1b3fb613
> 
> Not a stable material IMHO

Why's that?  Wang Long said he's observed the deadlock three times?
