Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeEOI7W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:59:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45478 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeEOI7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:59:19 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the pm tree
Date: Tue, 15 May 2018 10:58:47 +0200
Message-ID: <3798543.7VT4y5RNEA@aspire.rjw.lan>
In-Reply-To: <20180515082109.3b57619a@canb.auug.org.au>
References: <20180515082109.3b57619a@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 15, 2018 12:21:09 AM CEST Stephen Rothwell wrote:
> 
> --Sig_/LKqNOwcm4.nPHJQHAB_CO6g
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi Rafael,

Hi Stephen,

> Commit
> 
>   e689ba60f1f0 ("Merge branch 'opp/genpd-pstate-updates' of git://git.kerne=
> l.org/pub/scm/linux/kernel/git/vireshk/pm")
> 
> is missing a Signed-off-by from its author and committer.
> 
> This is probably because (despite its description) this is not a merge
> commit - it seems to have been flattened in the rebase :-(

Thanks for letting me know!

This commit shouldn't have reached you at all, sorry about that.

Should be fixed now.

Thanks,
Rafael
