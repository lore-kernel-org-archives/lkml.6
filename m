Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbeCGSsx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:48:53 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:39316 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753901AbeCGSsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:48:51 -0500
X-Google-Smtp-Source: AG47ELu9yqR7hj/tLsAWqYwXnr1uQn1AjHxTkK/WEDgagHozlUVulZ7NVnAzTRtdD94to2HOMCtIz2e+mr3q8NYAVSA=
MIME-Version: 1.0
In-Reply-To: <20180307155444.GA10367@linux.vnet.ibm.com>
References: <CAOS58YPzLeiZnwEeN31wWMZhki0t9+3ozdRNv9DgxWKY7OKmGA@mail.gmail.com>
 <CA+55aFx48U4W5tUgqW9ioZOHibPhQoDCUDWF_d-7yNCbqFQ7zg@mail.gmail.com>
 <20180305001600.GO3918@linux.vnet.ibm.com> <CA+55aFyOi1XnSqHtg=VfcUiBL+egNL==NRX1Zaeihe8W5OJVgw@mail.gmail.com>
 <20180305030949.GP3918@linux.vnet.ibm.com> <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com> <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com> <20180306203906.GA3918@linux.vnet.ibm.com>
 <20180307155444.GA10367@linux.vnet.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Mar 2018 10:48:50 -0800
X-Google-Sender-Auth: kL6NgXUsx59tOx7U_MQMkOITHMM
Message-ID: <CA+55aFzyycJWD2xuo7wSptJ=D045yiZnmO+7iY6CapDvge_uCw@mail.gmail.com>
Subject: Re: Simplifying our RCU models
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>,
        Jann Horn <jannh@google.com>, Benjamin LaHaise <bcrl@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 7:54 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> Ah, and any thoughts on how best to get feedback from the various people
> who would need to reprogram their fingers?  Or is everyone already on
> board with changing these various names?

I really would prefer to not see massive re-naming unless there is a
really good reason for it.

I'm all for simplifying RCU from a million different versions down to
just a few thousand, but I'm definitely not convinced we want to do
any search-and-replace.

                 Linus
