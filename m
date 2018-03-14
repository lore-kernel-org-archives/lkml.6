Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCNUze (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:55:34 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:42428 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCNUzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:55:32 -0400
Subject: Re: arc_usr_cmpxchg and preemption
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
References: <1521045375.11552.27.camel@synopsys.com>
 <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
 <20180314175352.GP4064@hirez.programming.kicks-ass.net>
 <1521059931.11552.51.camel@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <148bd98f-52df-0270-a6f1-be1ad37720ab@synopsys.com>
Date: Wed, 14 Mar 2018 13:55:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521059931.11552.51.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/2018 01:38 PM, Alexey Brodkin wrote:
> @Vineet, are you OK with proposed implementation?

I couldn't agree any more !

-Vineet
