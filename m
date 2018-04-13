Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx4+2OH2s7U+8kTFS/jJHGb4bYiMzr7atebAQ9V3W2+Y9xToXWMeUjm2+LBJ8DY0biKnu5wFc
ARC-Seal: i=1; a=rsa-sha256; t=1523608659; cv=none;
        d=google.com; s=arc-20160816;
        b=KSgchr503qINpmv1Q7jBUATGyOn8KvwP6RAT6uZrXff3VvacMvmxBGi/kZYKkBBdKg
         P/flFah8TaByz5NM9EQf2/yQawQ9dx+SVvasTwbUHHsxiI98tPLw2RAi8kJcroGo3a7p
         TYfSIyBKu9vhruQmGKmj2EX+wskJe60JpSkTntCrFr56NNcwUsEa8WP91q4DUfLtHZ2E
         Jx1nh/tIZxdl1U4xHYjLbFNK9Cqi7iIx+zYRPBjYSf3oQ4kToTOYsUkVlQjULAdL0ykk
         6m6NajK7LP9UDEvuh03DV+tdR9R03U/anHg+olcAcYZE3s8YKxsOg8bGPza/I+I0ugQ1
         r1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=crzbxph9yFJ2P28ZproEy44EOmqGvThLCFE0Pm9hjao=;
        b=HDJYGUmT9HeW8X9KnWvvX1uFJ76xPiX0B0QHxMfU64I/WENs9Xkv6qHznGfVBMJjfJ
         DzEaxcMGsIRDEGNCl9fKTWQMOgxcNZ+sj8WQFMF++GRlKZqmy73fJyyL7fGrElNQ3YN0
         YYEiNtfSaRYT1npGIfH1L4KwwUIaUpwAgPwi3CtVJQU9+kOSRQubEdjBVRnW0tLsKhmF
         OMPiUwqCNM5LWjp+DsyNT2wO1eSWiVsE+Dlhkm05xAYZrjMbfQdNG4LS2dVBiLTbq5Rm
         7VWt3RC9IZsBOrLAYdbSpQyCU7d+YQk6XsY+G9itBA/S4Yj211txB9dDsdRs6gVstnKR
         DDsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Fri, 13 Apr 2018 09:37:31 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 2/6] sched: Introduce energy models of CPUs
Message-ID: <20180413083730.GA3470@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-3-dietmar.eggemann@arm.com>
 <20180413040253.GW7671@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413040253.GW7671@vireshk-i7>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011681114649781?=
X-GMAIL-MSGID: =?utf-8?q?1597619473899057809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday 13 Apr 2018 at 09:32:53 (+0530), Viresh Kumar wrote:
[...]
> And for the whole OPP discussion, perhaps we should have another
> architecture specific callback which the scheduler can call to get a
> ready-made energy model with all the structures filled in. That way
> the OPP specific stuff will move to the architecture specific
> callback.

Yes, that's another possible solution indeed. Actually, it's already on
the list of ideas to be dicussed in OSPM ;-)

Thanks,
Quentin
