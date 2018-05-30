Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeE3Oti (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:49:38 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39060 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeE3Otf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:49:35 -0400
X-Google-Smtp-Source: ADUXVKKSTubaVRa9sPmSV9WHe/dfvnk8JU/3gzx/MJL3x8Wt9gnq2icN/x96jNZyeagW8ixtw/XphA==
Date: Wed, 30 May 2018 22:49:22 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robert Walker <Robert.Walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kim Phillips <kim.phillips@arm.com>, Tor Jeremiassen <tor@ti.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org
Subject: Re: [RFT v3 1/4] perf cs-etm: Generate branch sample for missed
 packets
Message-ID: <20180530144922.GB12368@leoy-ThinkPad-X240s>
References: <1527497103-3593-1-git-send-email-leo.yan@linaro.org>
 <1527497103-3593-2-git-send-email-leo.yan@linaro.org>
 <20180528221347.GA4109@xps15>
 <20180529002538.GA11317@leoy-ThinkPad-X240s>
 <CANLsYkzEU90aVtPMRqf=YHzee8DHq8JZttRuxjLKGz-gRYiBuw@mail.gmail.com>
 <20180530002837.GB11923@leoy-ThinkPad-X240s>
 <CANLsYkzPShMj1cbXZPb7Lzio+gKcmvhD2+KTYr7vP9ec1d6bmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzPShMj1cbXZPb7Lzio+gKcmvhD2+KTYr7vP9ec1d6bmg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 08:45:46AM -0600, Mathieu Poirier wrote:
> On 29 May 2018 at 18:28, Leo Yan <leo.yan@linaro.org> wrote:
> > Hi Mathieu,
> >
> > On Tue, May 29, 2018 at 10:04:49AM -0600, Mathieu Poirier wrote:
> >
> > [...]
> >
> >> > As now this patch is big with more complex logic, so I consider to
> >> > split it into small patches:
> >> >
> >> > - Define CS_ETM_INVAL_ADDR;
> >> > - Fix for CS_ETM_TRACE_ON packet;
> >> > - Fix for exception packet;
> >> >
> >> > Does this make sense for you?  I have concern that this patch is a
> >> > fixing patch, so not sure after spliting patches will introduce
> >> > trouble for applying them for other stable kernels ...
> >>
> >> Reverse the order:
> >>
> >> - Fix for CS_ETM_TRACE_ON packet;
> >> - Fix for exception packet;
> >> - Define CS_ETM_INVAL_ADDR;
> >>
> >> But you may not need to - see next comment.
> >
> > From the discussion context, I think here 'you may not need to' is
> > referring to my concern for applying patches on stable kernel, so I
> > should take this patch series as an enhancement and don't need to
> > consider much for stable kernel.
> 
> Yes, that is what I meant.

Thanks for confirmation, will send new patch series according to the
discussion.

[...]

Thanks,
Leo Yan
