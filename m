Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCNS5S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeCNS5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:57:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331052077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 14 Mar 2018 15:57:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/2] perf record: Synthesize features before events in
 pipe mode
Message-ID: <20180314185715.GE27335@kernel.org>
References: <20180314092205.23291-1-jolsa@kernel.org>
 <CABPqkBS5u6Qkbw3qoq4ocgsMZSoVF2m_5pBQ5YTRnx3=mZG6LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBS5u6Qkbw3qoq4ocgsMZSoVF2m_5pBQ5YTRnx3=mZG6LQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 14, 2018 at 11:45:14AM -0700, Stephane Eranian escreveu:
> On Wed, Mar 14, 2018 at 2:22 AM, Jiri Olsa <jolsa@kernel.org> wrote:
> > We need to synthesize events first, because some
> > features works on top of them (on report side).
> >
> > Link: http://lkml.kernel.org/n/tip-vz436m6fobfz8ykmuxo8phyy@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Works for me.
> Tested-by: Stephane Eranian <eranian@google.com>

Thanks for testing, will apply.

- Arnaldo
