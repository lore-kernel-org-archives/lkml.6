Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEUEiO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:38:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36579 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeEUEiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:38:06 -0400
X-Google-Smtp-Source: AB8JxZoAypTh/dAg+mN7i+LBx0ItB6rQgHZdXNpgYTWOeQYKw0qaSn9ZZm8DrILSFCDzakEWajzzjw==
Date: Sun, 20 May 2018 21:38:04 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/4] fixes, cleanups for rcu/dev
Message-ID: <20180521043804.GA72491@joelaf.mtv.corp.google.com>
References: <20180521043251.120953-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521043251.120953-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 09:32:47PM -0700, Joel Fernandes wrote:
> Hi Paul,
> 
> Here are some patches reworked with a few comments on few of the patches
> from previous series: https://lkml.org/lkml/2018/5/13/296
> 
> 4/4 is a new addition which fixes a potential issue.
> 
> Let me know what you think, thanks!
> 
> Joel Fernandes (4):
>   rcu: Add comment documenting how rcu_seq_snap works
>   rcu: Cleanup the variables used to request a new grace period
>   rcu: Use better variable names in funnel locking loop
>   rcu: Unlock non-start node only after accessing its gp_seq_needed

Please disregard the v2, my infant daughter distracted me when I was
preparing the 'git format-patch' :-) I was not supposed to send the 'Speed
up..' patch since I already sent that separately. And patch 4/4 which I
believe fixes a potential issue is also missing. So lets drop/ignore all of
this v2 and I'll just send a v3.

thanks!
 
