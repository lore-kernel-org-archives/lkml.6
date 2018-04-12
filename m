Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDLWGQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:06:16 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34459 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeDLWGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:06:14 -0400
X-Google-Smtp-Source: AIpwx48YSZ7W67kyeRNIj0FO6SUURIjbAIGKXYIjwE9/Qasr5x8NGNS6shXJA/CnlQECyI54qGMo3A==
Date: Fri, 13 Apr 2018 00:06:11 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
Message-ID: <20180412220611.GI12256@bigcity.dyn.berto.se>
References: <20180412091822.GG12256@bigcity.dyn.berto.se>
 <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 2018-04-12 12:33:27 +0200, Vincent Guittot wrote:
[snip[

> 
> Can you send me your config ?
> 
> I'm going to prepare a debug patch to spy what's happening when entering idle

I'm sorry i missed this request when first reading your reply, I'm using
arch/arm/configs/shmobile_defconfig for my tests.

-- 
Regards,
Niklas Söderlund
