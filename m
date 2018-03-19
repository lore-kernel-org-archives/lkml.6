Return-Path: <outreachy-kernel+bncBDYZDG4VSMIRB44KX7KQKGQEMZ5R3WI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521468788; cv=pass;
        d=google.com; s=arc-20160816;
        b=DmMCxecFJjTzAXMFqK6KkE7RhDgR/nWn8WkKPUce7Qw2/0bKe6k98csWDzsvQ3ni/O
         Iryn88GGKc3bduOOOD3hBrAU7I+oq1wETU63wUNqj5V8ioQIGJwNJtOG/Vs2Gi0JhChC
         7dQxqsYIh+j3NC3h66duT9BZ+8szrfGo+fZfW7PXXvggqI03lHw/XYp0zupU4YZ3FAmP
         sZidqqWfum2ueXoGKssJXbd2FvMsrqCDCZlnum3eesL5ZN235QVK8KGwzJ/KSYlMyqcI
         /2yCZRqjazKagJVDoXAjCA1KTagBph7Cotc3u+P0341yJn552GtI+9mKf/znGwS4NDSm
         XfiQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:arc-authentication-results:arc-message-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=btlH5rlj4XbcaahnU2Hy7M2nUvApyn/YkHIh9Fwlxgs=;
        b=yG6axaP/woJDgnkiiu3FOe2JosloTzE+NFTKdoMhT2deNldQUnCb17XRdMkmpnZEJc
         /OAGPvB858b3x1jYrBtXcK+zsaRoinLuJp11/gFKZct0dVKCijm83ux/yeTElH2Qn49P
         zyOhTROscj4VBHcGIlEKefERqSFdOdf/MlNGm6WnW/f7llFEuzAS/soYBDdLqQjYCQ4X
         YCDw43ZxgZvsaPlp1/ckcHsY/ZcE8uqOxu6OR+PqQ/A6U0wBHj3MDdZhWCT4LChjwW6n
         uJ+pHuyOi6BDRLgJu5xTUKYauTrA92VjXXEJa8lV8iGBngiv6kLHE+lMr9U9fiEEo36r
         0TKA==
ARC-Authentication-Results: i=3; mx.google.com;
       arc=pass (i=2 dkim=pass dkdomain=ffwll.ch);
       spf=pass (google.com: domain of outreachy-kernel+bncbdyzdg4vsmirb44kx7kqkgqemz5r3wi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDYZDG4VSMIRB44KX7KQKGQEMZ5R3WI@googlegroups.com
Authentication-Results: mx.google.com;
       arc=pass (i=2 dkim=pass dkdomain=ffwll.ch);
       spf=pass (google.com: domain of outreachy-kernel+bncbdyzdg4vsmirb44kx7kqkgqemz5r3wi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDYZDG4VSMIRB44KX7KQKGQEMZ5R3WI@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1521468788; cv=pass;
        d=google.com; s=arc-20160816;
        b=Vioo3EFKmk3PiOQ1AJml3o+UKjKaCKOpgScgIHG+OEwB3c59AMxvoLHQoIC2xBEcHd
         YqyakHF0mbtWASBNOs5+cmf7JVl6DfnpVRZQd+ACqcQxSRgr4VcGwdzRnl/LEvbL4a7s
         eyIFyNIxq/wS/L2ccSPTjH48bv/T+VqV6cyXTzFh6PNkoB8SNdlNDqULtp550WOTthIM
         8iRa+qZVFIzoQHY4HyJ0fEnjwrGG8tBhzmv+/mgR8DngFSjTckj+MJdMEdvc9GuFLOA8
         gPOmfZjEiUGc3f1FUFnd3DuV+f6miSXIK7q8q/ReecEPNQ1M0ZcsrpFdON9MavHnBzbL
         qXqA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=btlH5rlj4XbcaahnU2Hy7M2nUvApyn/YkHIh9Fwlxgs=;
        b=1K8KZvREg07e+VEg4RN3zUz49QPhIMhjSG3kFddbpuujtmYQwOGofZtu3cp2xNtO0B
         S6jZmGtH0nZQlORTN6A9gKtywo9DANqvvJwJ8SnyF+M+Vaipl0k7ejx1m/8mmESIRdSI
         LZTm74I5dyT4aj1nNtctN+t9hTAgNnUCyLbChs6wZTAYfPV6znwKBhoQuZGjsiQGa3sg
         ijr7mVfIa3wTmT0b620MRVDvLlBrQ7wtMmecQKhJ530n6v08D6Y3ruLav0z/Dti7HL4m
         MYqHBX57p/P67pP4+cDE/rCnw6Q9V13I/tap9+x7dllWwUmTThVJNb2B6Pu/2OZRqcDT
         ZJng==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=J05XW8L3;
       spf=neutral (google.com: 2a00:1450:400c:c09::236 is neither permitted nor denied by best guess record for domain of daniel@ffwll.ch) smtp.mailfrom=daniel@ffwll.ch
X-Google-Smtp-Source: AG47ELuxM7Xnv/+SFNmbAIp55oGbKzB2imj/OSk8ODE6PCBVFLLJWDLCCmdcnsxsmDot8AxFv4n+RA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521468787; cv=none;
        d=google.com; s=arc-20160816;
        b=hmm9UD7tq26RlUxUvxhlJZ12S6cflJWgUGDGYOnKRgZPtJHz5umUpi91LMFMq64JoK
         Nz+Wdjxro7R8So0t6+QVhxsWQJXychfYPNy8HklehmRShJLOEKLmAAmWKOXhuWU/WzAK
         ethyzrUj9PHEbEQABKzzZYQyL01l50K6ghcNK8RqMwbhMmJwF5Sev7kdY6ptfcO8RKDp
         jnk2cpacRBSExvoVi6DUnvvl5hbtM3iMre3wuDUmiSpMm7v14SDvFkF9oIjo/h2Gzp7r
         xwIpWvtGFvz7KzZWeIscrFWKJc4/Q93MCHfWI+eKOKVl5Q6cJOV58QptTa4tR7x9FCmx
         U9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:sender
         :dkim-signature:arc-authentication-results;
        bh=ErkHpsCZwuNJAcBMGqsubnJQStBFZDyIcUzZotoleXM=;
        b=xbk0s+zzOhj2/PR4Wno5i0WrwHRF4xs6akoHVEp6yRpQBQk7WE6ml3sl/ccbwhPCdK
         cz8EYzrFZ4luc76rvKlB4Bu/LtLtOgYjv/uYqMhJ56UMo11C2cfZaOMkSdf/5t4YA61P
         6fLsjJuNWGu7vIyouVM8ZmBWxk4K+oZaORGH2VZS5SZrOaOgO+4YaMXqVwqrWyHV2tzS
         mz5dJs/gQKafzyskHb/IGeUbMQhofKxczvmMsallvIZCivA6wlGL9hzw5HFYadHQcs7i
         7Z7cSLbNXXKfA4fs7x5nKB6i7aqWeb7QBfBdeZugCZNiMd7VbwZFDgB0XKuv2NSN1hQC
         mufw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=J05XW8L3;
       spf=neutral (google.com: 2a00:1450:400c:c09::236 is neither permitted nor denied by best guess record for domain of daniel@ffwll.ch) smtp.mailfrom=daniel@ffwll.ch
Sender: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 19 Mar 2018 15:13:04 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: daniel.vetter@intel.com, Gustavo Padovan <gustavo@padovan.org>,
	Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
	Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] gpu: drm: Use list_{next/prev}_entry
 instead of list_entry
Message-ID: <20180319141304.GP14155@phenom.ffwll.local>
Mail-Followup-To: Arushi Singhal <arushisinghal19971997@gmail.com>,
	daniel.vetter@intel.com, Gustavo Padovan <gustavo@padovan.org>,
	Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
	Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	outreachy-kernel@googlegroups.com
References: <20180319050530.GA25589@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20180319050530.GA25589@seema-Inspiron-15-3567>
X-Operating-System: Linux phenom 4.15.0-1-amd64
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Original-Sender: daniel@ffwll.ch
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@ffwll.ch header.s=google header.b=J05XW8L3;       spf=neutral
 (google.com: 2a00:1450:400c:c09::236 is neither permitted nor denied by best
 guess record for domain of daniel@ffwll.ch) smtp.mailfrom=daniel@ffwll.ch
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
X-GMAIL-MSGID: =?utf-8?q?1595375656331699775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 10:35:30AM +0530, Arushi Singhal wrote:
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
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>

Thanks for your patch. Looks correct, but for merge technical reasons can
you please split it into 2 patches? One for drm_lease.c, with a drm/lease:
prefix, and one for the nouveau driver change, with a nouveau: prefix.
Both patches need to be submitted to slightly different sets of
maintainers too, pls consult scripts/get_maintainers.pl

Thanks, Daniel

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

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180319141304.GP14155%40phenom.ffwll.local.
For more options, visit https://groups.google.com/d/optout.
