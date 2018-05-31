Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeEaIOk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:14:40 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:49353
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754022AbeEaIOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:14:36 -0400
X-IronPort-AV: E=Sophos;i="5.49,463,1520895600";
   d="scan'208";a="267088168"
Date: Thu, 31 May 2018 10:14:26 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Dan Carpenter <dan.carpenter@oracle.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bpf: devmap: remove redundant assignment of dev
 = dev
In-Reply-To: <20180531070518.obnfw5tv23sbpfys@mwanda>
Message-ID: <alpine.DEB.2.20.1805311011310.2416@hadrien>
References: <20180530150916.16808-1-colin.king@canonical.com> <20180530210713.v4cf4wjniwyobfmm@ast-mbp.dhcp.thefacebook.com> <20180531070518.obnfw5tv23sbpfys@mwanda>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 May 2018, Dan Carpenter wrote:

> On Wed, May 30, 2018 at 05:07:15PM -0400, Alexei Starovoitov wrote:
> > On Wed, May 30, 2018 at 04:09:16PM +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > The assignment dev = dev is redundant and should be removed.
> > >
> > > Detected by CoverityScan, CID#1469486 ("Evaluation order violation")
> > >
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >
> > Applied, Thanks.
> >
> > Please use [PATCH bpf-next] in the subject next time.
> > See Documentation/bpf/bpf_devel_QA.rst
>
> Guys, be reasonable...
>
> git log --author=Carpenter | \
> 	grep -A1 "Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>" | \
> 	grep -v Carpenter | grep Signed | cut -d '<' -f 1 | sort -u | wc -l
>
> I have sent patches to 206 maintainers.  It doesn't scale for everyone
> to have their own special document for sending patches.

Thanks Dan, I support this point of view completely.  Special information
has to be in one place and in a machine readable manner.  Maybe
get_maintainers can produce this information in some way, if it is
essential.

julia

>
> I asked this last time, and I even skimmed your document, but how are
> people supposed to go from linux-next to the correct bpf-next git tree?
> It's a pain for me to do this for net, but net is way larger and busier
> than any other tree.  I know it's a bit rude for me to say that you guys
> are not as important as net, but that's how I feel.  I'm only going to
> report bugs instead of writing patches if you guys are going to insist
> on all sorts of new rules.
>
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
