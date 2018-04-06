Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeDFQzE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:55:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751412AbeDFQzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:55:02 -0400
Date: Fri, 6 Apr 2018 18:54:45 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/9] kbuild: Do not pass arguments to link-vmlinux.sh
Message-ID: <20180406165445.GB13785@krava>
References: <20180405151645.19130-1-jolsa@kernel.org>
 <20180405151645.19130-4-jolsa@kernel.org>
 <CAK7LNAQHEWAk_J8uZ4_ETR=JzBU9szDCVNxmUvY447uMj1XLVA@mail.gmail.com>
 <20180405185950.GA3668@krava>
 <CAK7LNATU9_zBH9DpayNOCGsFVL0K+Y8Np0z7wxFuwO3Cf1K_tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATU9_zBH9DpayNOCGsFVL0K+Y8Np0z7wxFuwO3Cf1K_tg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 09:59:59AM +0900, Masahiro Yamada wrote:
> 2018-04-06 3:59 GMT+09:00 Jiri Olsa <jolsa@redhat.com>:
> > On Fri, Apr 06, 2018 at 12:50:00AM +0900, Masahiro Yamada wrote:
> >> 2018-04-06 0:16 GMT+09:00 Jiri Olsa <jolsa@kernel.org>:
> >> > There's no need to pass LD* arguments to link-vmlinux.sh,
> >> > because they are passed as variables. The only argument
> >> > the link-vmlinux.sh supports is the 'clean' argument.
> >> >
> >> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >> > ---
> >>
> >> Wrong.
> >>
> >> $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux)
> >> exist here so that any change in them
> >> invokes scripts/linkk-vmlinux.sh
> >
> > sry, I can't see that.. but it's just a side fix,
> > which is actually not needed for the rest
> >
> > I'll check on more and address this separately
> 
> 
> The link command is recorded in .vmlinux.cmd

i see.. just for the sake command line,

thanks for explanation
jirka
