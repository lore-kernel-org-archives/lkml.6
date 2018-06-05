Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeFEOKA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:10:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56474 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbeFEOJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:09:58 -0400
Date: Tue, 5 Jun 2018 15:09:54 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180605140954.GF12193@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
 <20180605105721.GA12193@e108498-lin.cambridge.arm.com>
 <CAKfTPtBduambCpfeNHuaqnayUoB8J224LDHcdG9EjH8kpJApnQ@mail.gmail.com>
 <20180605131224.GC12193@e108498-lin.cambridge.arm.com>
 <CAKfTPtCMzZK2QdOqWzFQZTPav1Gk99ujWGbWJYkKKPAMxijmiQ@mail.gmail.com>
 <20180605135215.GD12193@e108498-lin.cambridge.arm.com>
 <CAKfTPtBW2um0o4cdS-j_9FZ_OK9hL1F=fBuQ9a9Bsdc40LiHTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBW2um0o4cdS-j_9FZ_OK9hL1F=fBuQ9a9Bsdc40LiHTA@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 Jun 2018 at 15:55:43 (+0200), Vincent Guittot wrote:
> On 5 June 2018 at 15:52, Quentin Perret <quentin.perret@arm.com> wrote:
> > On Tuesday 05 Jun 2018 at 15:18:38 (+0200), Vincent Guittot wrote:
> >> On 5 June 2018 at 15:12, Quentin Perret <quentin.perret@arm.com> wrote:
> >> I would say no because when one will decrease the other one will not
> >> increase at the same pace and we will have some wrong behavior or
> >> decision
> >
> > I think I get your point. Yes, sometimes, the slow-moving rt_avg can be
> > off a little bit (which can be good or bad, depending in the case) if your
> > RT task runs a lot with very changing behaviour. And again, I'm not
> > fundamentally against the idea of having extra complexity for RT/IRQ PELT
> > signals _if_ we have a use-case. But is there a real use-case where we
> > really need all of that ? That's a true question, I honestly don't have
> > the answer :-)
> 
> The iperf test result is another example of the benefit

The iperf test result ? The sysbench test you mean ?
