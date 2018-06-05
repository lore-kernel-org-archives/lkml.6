Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeFEJd3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:33:29 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41134 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeFEJd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:33:27 -0400
X-Google-Smtp-Source: ADUXVKKQ+kPlAbd8uuDlAnGVc2pXo5UtBXKy2Dz+3aFdJxu/uq8F+FAQsckoRxKwZGo8RPb1aH/CwW2GVxPydi8ioWo=
MIME-Version: 1.0
In-Reply-To: <1528136669.83760.11.camel@linux.intel.com>
References: <20180531225143.34270-1-srinivas.pandruvada@linux.intel.com>
 <20180604180156.4uvb6t4xqxmuwayq@linux-h043> <1528136669.83760.11.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Jun 2018 11:33:26 +0200
X-Google-Sender-Auth: ddr0ySaBfw1CJmqU_7HVOmUB3bU
Message-ID: <CAJZ5v0hiY41e3-CMxmsRA1z02vY7gYpEmDE8KMB-imA-X2Bu7Q@mail.gmail.com>
Subject: Re: [RFC/RFT] [PATCH v3 0/4] Intel_pstate: HWP Dynamic performance boost
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 8:24 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Mon, 2018-06-04 at 20:01 +0200, Giovanni Gherdovich wrote:
>> On Thu, May 31, 2018 at 03:51:39PM -0700, Srinivas Pandruvada wrote:
>> > v3
>> > - Removed atomic bit operation as suggested.
>> > - Added description of contention with user space.
>> > - Removed hwp cache, boost utililty function patch and merged with
>> > util callback
>> >   patch. This way any value set is used somewhere.
>> >
>> > Waiting for test results from Mel Gorman, who is the original
>> > reporter.
>> > [SNIP]
>>
>> Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>>
>> This series has an overall positive performance impact on IO both on
>> xfs and
>> ext4, and I'd be vary happy if it lands in v4.18. You dropped the
>> migration
>> optimization from v1 to v2 after the reviewers' suggestion; I'm
>> looking
>> forward to test that part too, so please add me to CC when you'll
>> resend it.
> Thanks Giovanni. Since 4.17 is already released and 4.18 pulls already
> started, we have to wait for 4.19.

Not necessarily. :-)

It has been in the works for quite a while and we have another week of
the merge window ahead of us.

Please resubmit the series with the minor issues in the first patch
addressed and with the RFC/RFT tag removed.

Cheers,
Rafael
