Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeFETlO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:41:14 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39452 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeFETlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:41:12 -0400
X-Google-Smtp-Source: ADUXVKIquohSnDuo/X3MYjyk54Hn4niOdo8xSoyE2fe8bryZKe30Abe7zLqsJ7JOsh+L+g4fcTUJWQ==
Date: Tue, 5 Jun 2018 12:41:09 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] swap,blkcg: issue swap io with the appropriate
 context
Message-ID: <20180605194109.GI1351649@devbig577.frc2.facebook.com>
References: <20180605132948.1664-1-josef@toxicpanda.com>
 <20180605132948.1664-6-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605132948.1664-6-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:29:40AM -0400, Josef Bacik wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> For backcharging we need to know who the page belongs to when swapping
> it out.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

I still think it might be worthwhile to mention that we're skipping
over the rw_page cases.

Thanks.

-- 
tejun
