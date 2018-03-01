Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967880AbeCAL7m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:59:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37184 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967837AbeCAL7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:59:41 -0500
Subject: Re: [PATCH 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
To: Gaku Inami <gaku.inami.xh@renesas.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <PS1PR06MB1755EB9FD0AFD1D2E0C85C7DA2C70@PS1PR06MB1755.apcprd06.prod.outlook.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <de99deff-b7ca-e7ea-2763-d2cd24c586c8@arm.com>
Date: Thu, 1 Mar 2018 11:59:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <PS1PR06MB1755EB9FD0AFD1D2E0C85C7DA2C70@PS1PR06MB1755.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/28/2018 07:46 AM, Gaku Inami wrote:
> Hi
> 
[...]
> 
> Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>
> 
> I tested as same in other SoC. It looks fine.
> 

Thanks for testing on your side !
