Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeDTIYF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:24:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:52515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753905AbeDTIYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:24:01 -0400
Message-ID: <1524212601.11030.2.camel@gmx.de>
Subject: Re: [PATCH v7 0/5] cpuset: Enable cpuset controller in default
 hierarchy
From: Mike Galbraith <efault@gmx.de>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>, Juri Lelli <juri.lelli@redhat.com>
Date: Fri, 20 Apr 2018 10:23:21 +0200
In-Reply-To: <1524145624-23655-1-git-send-email-longman@redhat.com>
References: <1524145624-23655-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cKR187XmS0/JnqrhOqzg3IW+TcZA5IsAhQlNfqyD/+LCqd2BOoy
 Sqq4hBGLVwY/LTKfIfecoEb3UZoS04WBnl9AAu4OWSctDjua231s0b0Ii0ya+I/6W8KVEoc
 DauQuOkdXZgYex8Wklpa6Mwgej0kd142uTQBcuZwXaUxjkdw0rwE7Vj2DICI+W19sBVsn0h
 9vI5xvCpOtXOMGvKQYduA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w/7ET0+DbCs=:O3q/4+PDoOOo5CsLOuZVvF
 QhBQirLdw4g0dB02ZIabHCb4s+QYwp6Mq8xxML+K+SNeMLyvDUtCtJ5sI+7d1r9u1MD+qJqJY
 g6vqJ4NOwi7QLEiJu0ouShKnQfE4IFN9sF36EvhER8tu1GR8eFBcN4TkEN0Ai/wraBC1xD6li
 R/2bRvgDIZtaCfmLx/k3aRhJiFjK21iArEiFaIjgrMHcLAIH69rErMq02xS6LVEmD0DbztZe4
 LUwmgaR5AlnJcSxohZ/zPZWzggpf345sVLa1mcwLcOqiyGG8c2ukdtFC3g4GKAZwcA6F0DCDg
 ih/8nk29k+5qm8N5TrwRkUWB5DGp5tWe7fOWFF/BfMfus3PBzDzCZbWaAUryeYU/A3eP+l9ph
 KDcu7bUQH7G+nB3ZcpsE9TFcR1Qg7yijXpyLpx5ebguWLMLGJWP6HAhBdp5R3P0LYlFo0DOsP
 eOmntAQ84tFyxz/hdbTlu9SCDCn+ukHj/mv1DTvrjY6Olg7zkVdaECALkqZOjJV5lW0UNLIOQ
 FI+uUmQQR6zxvpVKu+XEPjAuJ686hBWZqIn42oqruIuA9VmiIbJgRbsOvegUeUj8BoWOZu6MW
 sNNYn125bVorwxmuIlGaoF+KyP6725+LiFIW3xgePXyDaAMp85qyuiQxM+V1y3VVncDqX0dod
 woNrjrC/w5AiVSpewxzKahVdSpvSveCGiqnsQlfQVjIDCcjGSEC72Kq8Es5iZuv0CBA0Xq4Kb
 YgvSloKVM1StWcx+XSk9eskwwDbkX6HiBFowGbuGwmnUCaKfOxfE5xWB1QgE1g9UndIbJbDCf
 vrXIltmownUQ1ASsu9+3lFUjjjxnb8IYC4Hyt8r+jN5pArBFkU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-19 at 09:46 -0400, Waiman Long wrote:
> v7:
>  - Add a root-only cpuset.cpus.isolated control file for CPU isolation.
>  - Enforce that load_balancing can only be turned off on cpusets with
>    CPUs from the isolated list.
>  - Update sched domain generation to allow cpusets with CPUs only
>    from the isolated CPU list to be in separate root domains.

I haven't done much, but was able to do a q/d manual build, populate
and teardown of system/critical sets on my desktop box, and it looked
ok.  Thanks for getting this aboard the v2 boat.

	-Mike
