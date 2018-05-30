Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeE3P6i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:58:38 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41686 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753813AbeE3P61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:58:27 -0400
X-Google-Smtp-Source: ADUXVKI1OQiNZFqT3v41ozUbA4cfQWRCDt+PiSEkWCojMW9pKXrpbbULQ+SvXs3TqMbqZ9mn0tCgDQ==
Date: Wed, 30 May 2018 08:58:24 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 04/13] blk: introduce REQ_SWAP
Message-ID: <20180530155824.GL1351649@devbig577.frc2.facebook.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-5-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529211724.4531-5-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 05:17:15PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Just like REQ_META, it's important to know the IO coming down is swap
> in order to guard against potential IO priority inversion issues with
> cgroups.  Add REQ_SWAP and use it for all swap IO, and add it to our
> bio_issue_as_root_blkg helper.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
