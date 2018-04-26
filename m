Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756165AbeDZVfi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:35:38 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41566 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbeDZVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:35:36 -0400
X-Google-Smtp-Source: AIpwx49XEZQWS5OEmtD1iyWEANPi2/SnN8D5Aml/OqVgnFc9I11nLFfKkeIzPNUS4FjMo9yB/PqPxA==
Date: Thu, 26 Apr 2018 14:35:33 -0700
From: Tejun Heo <tj@kernel.org>
To: lizefan@huawei.com, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, guro@fb.com,
        kernel-team@fb.com
Subject: Re: [PATCHSET] cgroup/for-4.17: Make cgroup_rstat available to
 controllers
Message-ID: <20180426213533.GW1911913@devbig577.frc2.facebook.com>
References: <20180323231313.1254142-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323231313.1254142-1-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 04:13:05PM -0700, Tejun Heo wrote:
> Hello,
> 
> cgroup has scalable recursive stat mechanism implemented in
> kernel/stat.c.  It's currently only used to track cpu consumptions and
> difficult to use outside of cgroup core.  This patchset generalizes
> the mechanism and exposes it as cgroup_rstat so that controllers can
> use it.
> 
> This patchset contains the following eight patches.  A follow-up
> patchset will add usages.
> 
>  0001-cgroup-Rename-kernel-cgroup-stat.c-to-kernel-cgroup-.patch
>  0002-cgroup-Rename-stat-to-rstat.patch
>  0003-cgroup-Distinguish-base-resource-stat-implementation.patch
>  0004-cgroup-Reorganize-kernel-cgroup-rstat.c.patch
>  0005-cgroup-Factor-out-and-expose-cgroup_rstat_-interface.patch
>  0006-cgroup-Replace-cgroup_rstat_mutex-with-a-spinlock.patch
>  0007-cgroup-Add-cgroup_subsys-css_rstat_flush.patch
>  0008-cgroup-Add-memory-barriers-to-plug-cgroup_rstat_upda.patch

Applied 1-8 to cgroup/for-4.18.

Thanks.

-- 
tejun
