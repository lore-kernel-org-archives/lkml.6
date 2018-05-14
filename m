Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeENUh7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:37:59 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:39099 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENUh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:37:58 -0400
X-Google-Smtp-Source: AB8JxZo4FpJSs3QSUcATjRLI3BjMaPmpAwDFVpdnLfZgRokMWp+Wi0MAy9tm54G5g5IjXRn2GkPECoiQeciBGmwspJ0=
MIME-Version: 1.0
In-Reply-To: <20180514202910.GI26088@linux.vnet.ibm.com>
References: <cover.1525964381.git.joe@perches.com> <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
 <20180514202910.GI26088@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 23:37:56 +0300
Message-ID: <CAHp75Vf2O4xryPu9qFxCW7HP58Uz9c860xfNSUHKyvCqJyA8Ew@mail.gmail.com>
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging output
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:29 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Thu, May 10, 2018 at 08:45:44AM -0700, Joe Perches wrote:

> And I took this (but kept the period), plus used "%s" to make it fit in
> 80 characters:
>
>         pr_info("\tRCU restricting CPUs from %s=%d to %s=%u.\n",
>                 "NR_CPUS", NR_CPUS, "nr_cpu_ids", nr_cpu_ids);

Why do care about 80 characters for string literals? (Checkpatch
dropped this limit long time ago after some discussions)
I think it's better to find line if more context given (this my
objection agains %s for string literals).

-- 
With Best Regards,
Andy Shevchenko
