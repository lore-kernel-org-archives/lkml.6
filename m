Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932453AbeD0I7D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:59:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932370AbeD0I7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:59:01 -0400
Date: Fri, 27 Apr 2018 10:58:59 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kubakici@wp.pl>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCHv3 3/3] tools bpftool: Display license GPL compatible in
 prog show/list
Message-ID: <20180427085859.GD22874@krava>
References: <20180425174108.6586-1-jolsa@kernel.org>
 <20180425174108.6586-4-jolsa@kernel.org>
 <20180425140346.3e0f3ba7@cakuba.netronome.com>
 <0e84fe67-59c9-a419-5ff7-05be2aa1991e@iogearbox.net>
 <20180426073905.GI3396@krava>
 <639b2b78-af9e-4605-2b33-9bd1af8e760a@iogearbox.net>
 <20180426081801.GK3396@krava>
 <dbc91e08-4c99-e01f-eab5-ac235812cee7@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc91e08-4c99-e01f-eab5-ac235812cee7@iogearbox.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 10:49:25PM +0200, Daniel Borkmann wrote:
> On 04/26/2018 10:18 AM, Jiri Olsa wrote:
> [...]
> > v3 of the last patch attached, the branch is also updated
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > Display the license "gpl" string in bpftool prog command, like:
> > 
> >   # bpftool prog list
> >   5: tracepoint  name func  tag 57cd311f2e27366b  gpl
> >           loaded_at Apr 26/09:37  uid 0
> >           xlated 16B  not jited  memlock 4096B
> > 
> >   # bpftool --json --pretty prog show
> >   [{
> >           "id": 5,
> >           "type": "tracepoint",
> >           "name": "func",
> >           "tag": "57cd311f2e27366b",
> >           "gpl_compatible": true,
> >           "loaded_at": "Apr 26/09:37",
> >           "uid": 0,
> >           "bytes_xlated": 16,
> >           "jited": false,
> >           "bytes_memlock": 4096
> >       }
> >   ]
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Ok, v2 from prior two patches and v3 of this one applied to bpf-next. Please
> next time always submit a fresh new series at once, thanks Jiri.

noted, thanks a lot

jirka
