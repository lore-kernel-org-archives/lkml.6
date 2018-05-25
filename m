Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966480AbeEYLwp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:52:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45610 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966158AbeEYLwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:52:44 -0400
X-Google-Smtp-Source: AB8JxZrMxVlp0EAMkt1nDZvpn+AUqCfquxF6axfCSQIV4cF0rjTCPI87rJ6PdgbbPNiOiQ9JUCYtNA==
Date: Fri, 25 May 2018 13:52:40 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched/topology: Clarify root domain(s) debug
 string
Message-ID: <20180525115240.GA678@localhost.localdomain>
References: <20180524152936.17611-1-juri.lelli@redhat.com>
 <ba17ff9c-d687-2099-eec5-211fd195efd0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba17ff9c-d687-2099-eec5-211fd195efd0@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/18 13:35, Dietmar Eggemann wrote:

[...]

> 
> Looks good to me. Probably especially helpful when setting up exclusive
> cpusets.
> 
> Juno with big and little exclusive cpuset:
> 
> ...
> [  124.231333] CPU1 attaching sched-domain(s):
> [  124.235482]  domain-0: span=1-2 level=MC
> [  124.239382]   groups: 1:{ span=1 }, 2:{ span=2 }
> [  124.243969] CPU2 attaching sched-domain(s):
> [  124.248112]  domain-0: span=1-2 level=MC
> [  124.251998]   groups: 2:{ span=2 }, 1:{ span=1 }
> [  124.256585] root domain span: 1-2 (max cpu_capacity = 1024)
> [  124.262150] CPU0 attaching sched-domain(s):
> [  124.266307]  domain-0: span=0,3-5 level=MC
> [  124.270366]   groups: 0:{ span=0 cap=446 }, 3:{ span=3 cap=446 }, 4:{
> span=4 cap=446 }, 5:{ span=5 cap=446 }
> [  124.280131] CPU3 attaching sched-domain(s):
> [  124.284273]  domain-0: span=0,3-5 level=MC
> [  124.288334]   groups: 3:{ span=3 cap=446 }, 4:{ span=4 cap=446 }, 5:{
> span=5 cap=446 }, 0:{ span=0 cap=446 }
> [  124.298096] CPU4 attaching sched-domain(s):
> [  124.302239]  domain-0: span=0,3-5 level=MC
> [  124.306298]   groups: 4:{ span=4 cap=446 }, 5:{ span=5 cap=446 }, 0:{
> span=0 cap=446 }, 3:{ span=3 cap=446 }
> [  124.316063] CPU5 attaching sched-domain(s):
> [  124.320205]  domain-0: span=0,3-5 level=MC
> [  124.324265]   groups: 5:{ span=5 cap=446 }, 0:{ span=0 cap=446 }, 3:{
> span=3 cap=446 }, 4:{ span=4 cap=446 }
> [  124.334031] root domain span: 0,3-5 (max cpu_capacity = 446)

Yep, that's similar to how I noticed.

Thanks for testing.

Best,

- Juri
