Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeDZHjy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:39:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751508AbeDZHjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:39:49 -0400
Date: Thu, 26 Apr 2018 09:39:47 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jakub Kicinski <kubakici@wp.pl>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH 3/3] tools bpftool: Display license GPL compatible in
 prog show/list
Message-ID: <20180426073947.GJ3396@krava>
References: <20180425174108.6586-1-jolsa@kernel.org>
 <20180425174108.6586-4-jolsa@kernel.org>
 <20180425140346.3e0f3ba7@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425140346.3e0f3ba7@cakuba.netronome.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 02:03:46PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Apr 2018 19:41:08 +0200, Jiri Olsa wrote:
> > @@ -295,6 +297,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
> >  	printf("tag ");
> >  	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
> >  	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
> > +	printf(" license GPL %scompatible", info->gpl_compatible ? "" : "NON ");
> 
> 3 nit picks:
> 
> Other "fields" are separated by two spaces between each other:
> 
>   4: kprobe  name func_begin  tag 57cd311f2e27366b license GPL compatible
>            ^^               ^^                    X
>           loaded_at Apr 25/11:20  uid 0
>                                 ^^
>           xlated 16B  not jited  memlock 4096B
>                     ^^         ^^
> 

will change

> Could you also update the example outputs in the man page:
> 
> tools/bpf/bpftool/Documentation/bpftool-prog.rst

oops, I always forget that.. will do

thanks,
jirka
