Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932473AbeEWKGW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:06:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35905 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932258AbeEWKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:06:18 -0400
X-Google-Smtp-Source: AB8JxZqCVFwSIH9i9fYOf/yWqNgVnoGbWIVijBMIxz/Waik4/qiZYWl/8UtsyyFUdkL0SFC6zaH9kw==
Date: Wed, 23 May 2018 15:36:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180523100615.gxd35efqn3h6b55u@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180522103415.cuutobi5kbhj4gcw@vireshk-i7>
 <20180522220953.GB40506@joelaf.mtv.corp.google.com>
 <20180523090101.6xifikvjpirqafox@vireshk-i7>
 <6A76301E-E383-439D-AD1E-6DC2B2CAC3CE@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A76301E-E383-439D-AD1E-6DC2B2CAC3CE@joelfernandes.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 02:42, Joel Fernandes wrote:
> Probably. But then Rafael is changing single policy to use the lock
> so then barrier wouldn't be needed at all. In that case, both mine
> and Rafael new patch can go into stable which handles your race (
> optimization == fix in this case :P )

Yeah, we discussed that offline.

Go get some sleep. There are no barriers in this world :)

-- 
viresh
