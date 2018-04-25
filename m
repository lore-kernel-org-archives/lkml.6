Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeDYKBY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:01:24 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36543 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeDYKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:01:20 -0400
X-Google-Smtp-Source: AIpwx490aYTEIGtVBfzlC7NmtJZz3oziHLKQq7XFSJ1ae7YFEPaUppTlu58X3JEOwG+SSsep5zQIVQ==
Date: Wed, 25 Apr 2018 18:01:13 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] samples/bpf: Fix typo in comment
Message-ID: <20180425100113.GA28567@leoy-ThinkPad-X240s>
References: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
 <1524101646-6544-2-git-send-email-leo.yan@linaro.org>
 <20180420141004.259d7d6f@redhat.com>
 <20180420132116.uswpqniteogfu4zz@holly.lan>
 <20180420155213.2867fcf5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420155213.2867fcf5@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 03:52:13PM +0200, Jesper Dangaard Brouer wrote:
> On Fri, 20 Apr 2018 14:21:16 +0100
> Daniel Thompson <daniel.thompson@linaro.org> wrote:
> 
> > On Fri, Apr 20, 2018 at 02:10:04PM +0200, Jesper Dangaard Brouer wrote:
> > > 
> > > On Thu, 19 Apr 2018 09:34:02 +0800 Leo Yan <leo.yan@linaro.org> wrote:
> > >   
> > > > Fix typo by replacing 'iif' with 'if'.
> > > > 
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > ---
> > > >  samples/bpf/bpf_load.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
> > > > index bebe418..28e4678 100644
> > > > --- a/samples/bpf/bpf_load.c
> > > > +++ b/samples/bpf/bpf_load.c
> > > > @@ -393,7 +393,7 @@ static int load_elf_maps_section(struct bpf_map_data *maps, int maps_shndx,
> > > >  			continue;
> > > >  		if (sym[nr_maps].st_shndx != maps_shndx)
> > > >  			continue;
> > > > -		/* Only increment iif maps section */
> > > > +		/* Only increment if maps section */
> > > >  		nr_maps++;
> > > >  	}  
> > > 
> > > This was actually not a typo from my side.
> > > 
> > > With 'iif' I mean 'if and only if' ... but it doesn't matter much.  
> > 
> > I think 'if and only if' is more commonly abbreviated 'iff' isn't it?
> 
> Ah, yes![1]  -- then it *is* actually a typo! - LOL
> 
> I'm fine with changing this to "if" :-)

Thanks for the reviewing, Daniel & Jesper.
I also learn it from the discussion :)

> [1] https://en.wikipedia.org/wiki/If_and_only_if
> 
> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
