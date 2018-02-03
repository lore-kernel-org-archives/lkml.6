Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeBCCBx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 21:01:53 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:45445 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeBCCBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 21:01:43 -0500
X-Google-Smtp-Source: AH8x2241A5HlUoam+CxKUDIGfMojQa25HB1Tsl488OK3bbtHh1ZnUzLHAOEqRvfZLpUl1Ijec2E1wQ==
Date: Fri, 2 Feb 2018 18:01:40 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Leblond <eric@regit.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 0/5] libbpf: add XDP binding support
Message-ID: <20180203020138.qpbpxlsggfylmqsc@ast-mbp>
References: <a26f90e9-5028-f8a9-a1e6-83a6c46b4e0b@iogearbox.net>
 <20180130205042.19647-1-eric@regit.org>
 <ab472a93-49c4-fd35-0e61-1b7691b81c39@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab472a93-49c4-fd35-0e61-1b7691b81c39@iogearbox.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 05:53:13PM +0100, Daniel Borkmann wrote:
> On 01/30/2018 09:50 PM, Eric Leblond wrote:
> > Hello Daniel,
> > 
> > No problem with the delay in the answer. I'm doing far worse.
> > 
> > Here is an updated version:
> > - add if_link.h in uapi and remove the definition
> > - fix a commit message
> > - remove uapi from a include
> 
> Fyi, this still needs to wait for a bit in the queue due to current
> merge window where bpf-next is closed during that time [0]. Thanks!
> 
>   [0] https://www.spinics.net/lists/netdev/msg481490.html

I've tested it and applied to bpf tree considering that
the series were practically ready long before bpf-next was closed.
Thank you Eric.
perf build was also fine, but please watch out for any unexpected
breakages, since perf has to be built on variety of distros.
