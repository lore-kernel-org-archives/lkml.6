Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeCTUGu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:06:50 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:39361 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:06:47 -0400
X-Google-Smtp-Source: AG47ELuSupgtnU++WZ36wZJnKnyT3TmH6sRv6enRE3+007MgzjfiLLbt7EMBDFGHK1EZS/0wU07juw==
Date: Tue, 20 Mar 2018 13:06:43 -0700
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix the comments of nr_idle
Message-ID: <20180320200643.GM519464@devbig577.frc2.facebook.com>
References: <20180320092406.13078-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320092406.13078-1-jiangshanlai@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 05:24:05PM +0800, Lai Jiangshan wrote:
> Since the worker rebinding behavior was refactored, there is
> no idle worker off the idle_list now. The comment is outdated
> and can be just removed.
> 
> It also groups nr_workers and nr_idle together.
> 
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>

Applied to wq/for-4.17.

Thanks.

-- 
tejun
