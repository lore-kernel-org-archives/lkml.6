Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeCUA64 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 20:58:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35567 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeCUA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 20:58:53 -0400
X-Google-Smtp-Source: AG47ELuVmiUvhFiCzwmdJqM+63q4HVtV/Csm6x4HPDqtmH05BQZwJ92YIk1KMJpwDHe6qy9rq/mTdQ==
Date: Tue, 20 Mar 2018 17:58:41 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>, psodagud@codeaurora.org,
        Network Development <netdev@vger.kernel.org>,
        Chenbo Feng <fengc@google.com>,
        Richard Smith <richard-llvm@metafoo.co.uk>,
        Chandler Carruth <chandlerc@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: disable clang's default use of
 -fmerge-all-constants
Message-ID: <20180321005839.3s2ftjp5pgwzy26p@ast-mbp>
References: <20180321001824.8395-1-daniel@iogearbox.net>
 <CA+55aFw94wSeOvs1JO2iPHXgpwWQ-EF6v0XYwjFrQN1wr5tY-A@mail.gmail.com>
 <bd7b0d23-519e-ca8b-a768-1440a4bc90d3@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7b0d23-519e-ca8b-a768-1440a4bc90d3@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 01:38:45AM +0100, Daniel Borkmann wrote:
> On 03/21/2018 01:36 AM, Linus Torvalds wrote:
> > On Tue, Mar 20, 2018 at 5:18 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> Prasad reported that he has seen crashes in BPF subsystem with netd
> >> on Android with arm64 in the form of (note, the taint is unrelated):
> > 
> > Ack. This looks good to me. And thanks for noticing the behavior wrt
> > the correct gcc merging.
> > 
> >>  [ Hi Linus, feel free to take this fix directly if you want.
> >>    Alternatively, we could route it via bpf tree. Thanks a
> >>    lot for your feedback! ]
> > 
> > So since it's your patch and the only known issue comes from the bpf
> > side, I think it should just go through the bpf tree, and I expect it
> > to get to me through all the usual channels.
> 
> Yeah, that's fine, thanks for letting us know!

Applied to bpf tree, thanks everyone.
