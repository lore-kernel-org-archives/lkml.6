Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeDRPKb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:10:31 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:43819 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDRPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:10:30 -0400
X-Google-Smtp-Source: AB8JxZpCTc0hoDfFYWrwdyOqTiVg/odeoB8O234ivJe+U0ii8S5Pm/Rf47bX65RXxmfqJFFHUrb29w==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 18 Apr 2018 11:10:20 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Jiri Olsa <jolsa@redhat.com>
cc: Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [RFC] perf/core: what is exclude_idle supposed to do
In-Reply-To: <20180417062010.GA2052@krava>
Message-ID: <alpine.DEB.2.21.1804181109100.1587@macbook-air>
References: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com> <20180417062010.GA2052@krava>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018, Jiri Olsa wrote:

> On Mon, Apr 16, 2018 at 10:04:53PM +0000, Stephane Eranian wrote:
> > Hi,
> > 
> > I am trying to understand what the exclude_idle event attribute is supposed
> > to accomplish.
> > As per the definition in the header file:
> > 
> >     exclude_idle   :  1, /* don't count when idle */
> 
> AFAICS it's not implemented

so just to be completely clear hear, we're saying that the "exclude_idle" 
modifier has never done anything useful and still doesn't?

If so I should update the perf_event_open manpage to spell this out.

Vince
