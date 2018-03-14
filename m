Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCNNDR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:03:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeCNNDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:03:15 -0400
Date: Wed, 14 Mar 2018 14:03:13 +0100
From: Michal Hocko <mhocko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: broonie@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mm-commits@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: mmotm 2018-03-13-15-15 uploaded
Message-ID: <20180314130313.GB23100@dhcp22.suse.cz>
References: <20180313221617.IBhUuE5FL%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313221617.IBhUuE5FL%akpm@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-03-18 15:16:17, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2018-03-13-15-15 has been uploaded to
[...]
> To develop on top of mmotm git:
> 
>   $ git remote add mmotm git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
>   $ git remote update mmotm
>   $ git checkout -b topic mmotm/master
>   <make changes, commit>
>   $ git send-email mmotm/master.. [...]

JFYI. After few missed mmotm updates while I was offline the tree is
back up-to-date.
-- 
Michal Hocko
SUSE Labs
