Return-Path: <outreachy-kernel+bncBDZJXP7F6YLRB3WGXXKQKGQE6ZV5N3I@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521443695; cv=pass;
        d=google.com; s=arc-20160816;
        b=kkI5ALhLFB2bpHBVUZ36E+F76h6NDHed7T3wlHwfXQoBwI4ohqMOsPV8qj8ul6xjDY
         2s0ByB4bA+qTdxXXjPupZG/LJhU9sDWbhRGnuv+lYt5yacGxb7np2ZXuZTeFSdw1Zgif
         hMvLTQ/npJC87AOm9F0Geht2/P3SzNB/Ln0ZbA5/J41UKiCVus2dBjYqlBx8joDGdqtO
         Z3LaEm3T4BkSJvOUQUCVCJ2/z8FB601XdkiPSilMakt9T1EB49IDj3qAQdj/4lEfrYRW
         owIKSCgaEmmtKM3keQiAQqfyKk8JgDiy4oFDFzz5Qa3rTRlnzktlQ8vyn/5xqL848rNx
         Z7UQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=tAYMt/4oLI4E/aF1Ol1mOswoks1jxDyjoHqpb1Hwc6I=;
        b=oc0tpt7MxPOJzBMhYIEffF++kZNBCB1ukceO5QqXcahJYdPM3AuOw4y4BzgnM5qx3h
         TcOdTWbpx5xs63Aqpr3i6Yo6IN7mQIs4OsXRwMGI/BQc+7CGT3MlB70ixyg3razRPgq2
         BZwscHbhqKcllFBtCzOy4O1Wgm4UNDiGmriPTIEmqdMAzQTb4oEZlwOZFs3vGlDz47no
         CEDcTGQPE805yNxc0Hhpg9jyeSkYcMklETiTPePhHCjKZjUmsCi2uEcBLVUxBEaFUTzF
         C1bMXGHuQfodmVWJ2uimWAi62rotXaAhsyDYjQGxtOf3jxFyun4RfFRQX0N92y6ZOyae
         soyA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=sQOK21Yx;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrb3wgxxkqkgqe6zv5n3i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRB3WGXXKQKGQE6ZV5N3I@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=sQOK21Yx;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrb3wgxxkqkgqe6zv5n3i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRB3WGXXKQKGQE6ZV5N3I@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1521443695; cv=pass;
        d=google.com; s=arc-20160816;
        b=zuAHL5Y2hW/kRUGA2XOjdyhZmYqROMfiDPOwlH9O/imrAf72HLjKPPbuhlRljHpI6W
         eaflRp8L5s6FUrLI38EvkKE5wCt7ODN+5JRvBGUuay1pgHeGR3UCt+kEsLZ2RPVI53bT
         38YE9Ca3sGGGaCGQ3OjifoEP2EyQjQQjWlWzQAAuUqoaXvHYDxEVHvQQdKvZ2v0UVj46
         jWcYLtmM6xAXVxPM0kEQzco3L8Yy9pIr5opN2mmlO6fRHEJwTuKrxw2nsbkE11XbvHb5
         nQk+K149iFb1uQlIpmXa86a2bkAao3htQLCtrH0Q0aG55d+s1XUUVXGkmA60lCUqVBKI
         3RVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=tAYMt/4oLI4E/aF1Ol1mOswoks1jxDyjoHqpb1Hwc6I=;
        b=L3xqpPqZiMZSbuz93MXwgqTMefibaLpODo4M1uylMFKvwjT3OFe1HS6sgUHNbjiS6z
         CDyPVihDRHOmip/oQxil3Wg67Kq9pC58UioNPxTKScL0bGaBCdR1qKvDUDqGDTNyYJzD
         1UzrSHbU88Ss+FFiL6H10NwN+Ym+w6CD6IvFYo8lLJ99oA8M47KEWxROie0dESU4zBbk
         TUafWQ0o+0XRyitgvCE5Gmu9ycpWYx+QSEJktYnU6qZYUyfL3RK8989aujm8ZH7zSrbH
         aJ4FMppqN0T7hpaPns1fPpFUA4Q+pvwLbTvg+WCF2nW1qu+CVvZPf+6Dwpe/okNcfoTf
         fCcQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELtgJyIenZTVmWY1u2iBvOtZBFSXDdmHKQqUFTz+R7JUJ0tI5cE2yfEpO3Su10aO362793pMKQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521443694; cv=none;
        d=google.com; s=arc-20160816;
        b=pjnU/y64oq35OuHr4OJ4ElCySx+hLEgzwxeUHNdp7iKHN6ExeKRXtqhNnMPFpZCGvD
         VuUfVM3gDcbhwGrC3R4RWEk4ZtX+lOt9whDB+weZQ26sfBWWkm2jtM+/ch7pmCvOkMv5
         wubJgJpMt7ewdcAiOEykP3O2XgUl0xgLlpuI8BQOH39VclmJg82trzj1tR+lo98/6EMM
         d/PayLPah0UTqEHan8gnhTWYwIbgGaAABUeDVrseDqqXT6E+6kIzYcWr5Xf+1JBiLg0u
         QxQPXo6KeiTL8CpYz/GuSLyvSkNDDIvHi2kHvVv/BGU6abQt6CQacA0+YzM0omyVR+/p
         3cHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=kxP1FkMmRj0PieX4Pzpy79sd82Cvm1D3LRBjD+4WwaE=;
        b=WhPJ9ADus6CHgVsaD3zi0mbp6T+38r/VLfDfOLMxIjMXmUjzS3d9fupjFBuHSs9UYb
         wO1owWY5tCSNb9eX9RPoJR9AhF//qJZHXWTdVyTKjFD3bsQsh7A+yBVciidbBBXbC+z3
         yifeurm/6YoAq1LaiUkYkt48Bk7zhlxQd4JAn+66F+g31Mj85qPtlKz1em5JACmNAOcR
         2pInnD3AyIqeoEklMVrNkrvYYdYJnu8UzcssEHOV7Jn34koqCLW7ayT+ldMoEVY/Jfl0
         DWLWASUa3lf4wIjiZIsNWCGSHxaaxyryPfAhWkM1VkQxrTGe3MIG+dDDv8ezCUbsUcK0
         whag==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.48,329,1517871600";
   d="scan'208";a="318729739"
Date: Mon, 19 Mar 2018 08:14:53 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: daniel.vetter@intel.com, Gustavo Padovan <gustavo@padovan.org>,
    Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
    Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
    linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
    outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] gpu: drm: Use list_{next/prev}_entry
 instead of list_entry
In-Reply-To: <20180319050530.GA25589@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803190805260.2864@hadrien>
References: <20180319050530.GA25589@seema-Inspiron-15-3567>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: julia.lawall@lip6.fr
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 192.134.164.83 is neither permitted nor denied by domain of
 julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595341254275374860?=
X-GMAIL-MSGID: =?utf-8?q?1595349344388333390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Mon, 19 Mar 2018, Arushi Singhal wrote:

> This patch replace list_entry with list_{next/prev}_entry as it makes
> the code more clear to read.
> Done using coccinelle:
>
> @@
> expression e1;
> identifier e3;
> type t;
> @@
> (
> - list_entry(e1->e3.next,t,e3)
> + list_next_entry(e1,e3)
> |
> - list_entry(e1->e3.prev,t,e3)
> + list_prev_entry(e1,e3)
> )

This looks like a rule that could be nice for the Linux kernel in general,
because the code really is much simpler.

I would suggest to write the rule in a more robust way, as follows:

@@
identifier e3;
type t;
t *e1;
@@

(
- list_entry(e1->e3.next,t,e3)
+ list_next_entry(e1,e3)
|
- list_entry(e1->e3.prev,t,e3)
+ list_prev_entry(e1,e3)
)

@@
expression e1;
identifier e3;
@@

(
- list_entry(e1->e3.next,typeof(*e1),e3)
+ list_next_entry(e1,e3)
|
- list_entry(e1->e3.prev,typeof(*e1),e3)
+ list_prev_entry(e1,e3)

This checks that the type that is specified corresponds to the one on e1.
It could actually be that the call is getting the first element of a list,
from some different type, and coincidentally the two types have the same
field name for the list element.

Unfortunately, the second rule, with the typeof call, doesn't currently
work in Coccinelle, because the semantic patch language doesn't actually
support typeof, and thinks that it is a function call.  I will fix this.

To make a semantic patch for the kernel, you can try running spgen on the
above file and answer the questions that it asks.  You can find examples
in the coccinelle/scripts directory.  Just run

spgen foo.cocci

Then answer the questions.  Then run

spgen foo.cocci > foo_for_kernel.cocci

The second run will use the results of the first run to print the semantic
patch.  Let me know if you have any questions.  You can always adjust the
semantic patch that is generated by hand afterwards if needed.

julia


>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/gpu/drm/drm_lease.c                    | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index 1402c0e..4dcfb5f 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -340,7 +340,7 @@ static void _drm_lease_revoke(struct drm_master *top)
>  				break;
>
>  			/* Over */
> -			master = list_entry(master->lessee_list.next, struct drm_master, lessee_list);
> +			master = list_next_entry(master, lessee_list);
>  		}
>  	}
>  }
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> index e4c8d31..81c3567 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> @@ -134,7 +134,7 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
>  			       nvkm_volt_map(volt, volt->max2_id, clk->temp));
>
>  	for (cstate = start; &cstate->head != &pstate->list;
> -	     cstate = list_entry(cstate->head.prev, typeof(*cstate), head)) {
> +	     cstate = list_prev_entry(cstate, head)) {
>  		if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
>  			break;
>  	}
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180319050530.GA25589%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.20.1803190805260.2864%40hadrien.
For more options, visit https://groups.google.com/d/optout.
