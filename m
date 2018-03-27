Return-Path: <outreachy-kernel+bncBDO7FFV3W4PBBTFE5DKQKGQEXJVX3SI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1522143820; cv=pass;
        d=google.com; s=arc-20160816;
        b=p1t0qmrvioJwllwLDVotfxuUsw48JbCfFUZInyAB8s5cXy60fPsaoTuE1YoCQ9VEnx
         uG+fkU1jOxVjb8Wuk3KXQ9ylEW72o085AHJdJUhzM8iKvj5Dj+TNIh7Wuuo1aMtjekIC
         uvpUXOz3E9Ra/JYfG/a51tlMB7FCCWGrNxtBdrVto+5v6HEu6C04CeyAHPPAZR3d0/kY
         nIyovUjFuJ1hZB6kN4qm27GWZF4/3r4Cf+XVvKxEJNKekC5r0L4L2RGqju2uonWkzO+x
         918jvnEzzt+xF6HlArQNltnWgfUJPssDivkdsUtXkEzq6Nw21PJ2LRVHT5H8Crmi2cCw
         IWZg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=sk9CdCRITRWkC0CC5AGDKXytGiiewxore4ycqAr9KRg=;
        b=oGgTZcvnlQzvt4MEXL4OindqfRPsN9VqXd2N2opPlND9CrGrnI6hRL80ZTL3+ig70w
         rXp7GK68sh9QxvhthWL2memPe82bwmuVBefe1VmZQQIBgQn1Z+V8MqnbMWEq2/e+Bnq/
         /HCbsM+n4puXFyZy3l5+raCbzYq5YkcMHU4rw0LBnGT2ELC+x92N5OBGX5KPO2w5wgU3
         smdbj+TWV0+0lWGVd5EMv6k8RIa3WjXP41w5/PQFGXz5psErHrJY0eQHKv+kOjCvmHKg
         6dNSOvH+PcAZ6yPfB9pk457bVl68xw0YcmV+4dpHgTvduC2ZC79n08SsQk/oa5Tc7Nuw
         X11Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=OuSuwmlE;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E6zbI3zH;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbdo7ffv3w4pbbtfe5dkqkgqexjvx3si@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDO7FFV3W4PBBTFE5DKQKGQEXJVX3SI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=OuSuwmlE;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E6zbI3zH;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbdo7ffv3w4pbbtfe5dkqkgqexjvx3si@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDO7FFV3W4PBBTFE5DKQKGQEXJVX3SI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1522143820; cv=pass;
        d=google.com; s=arc-20160816;
        b=mgylfzPDYSOp9rFlbAdBf8maxbcaAjExonUCj39Zh6PbGa6s5u1kMvwpPzwGk9CEq6
         auuBkV35paHSU9lU3RQGjoJ2jYlhsHjqoohAY9eL9ZDGZZZDpAtD8A/+a453zt6qfYRD
         gQqROf716xikLLrCQJaip0Vd7+LQgfoExwnofe3kjSaPqHdbkY43i7I7btjnCHgcXXRj
         Aa8WXK/f26qmz6wDfc2v5RlwypEs9YxH+ii6V3RisCKco165/Xh08/SIDhHdVkposOgU
         eb9xTo2lvLK9GtIn5YIRv4WerVrFDw9/VRh40WBbHx6+lRyynVOyK9NJx0JTtlv2yQ6O
         ECaA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=sk9CdCRITRWkC0CC5AGDKXytGiiewxore4ycqAr9KRg=;
        b=WbfFRisolMM186rtP8sDQMokBQqAJldmWN3kwvutZ+MFMVX6vk5L/rDdLvfN+K6ohC
         DuOU4YvGDFzkERk+xmmQH2rbXSmLObtQdqWCtsWny2iVblqW+zQ/cej5HhwxMUEvGdC0
         PvDLwPmOsHuJ6YDCDSjTkkxfgsJ3PaulOtk8cBQhoDc96BxXLEVbR+G4oHmjH3lGEYiH
         Y2DC7pjx/ntDjNLPCnn9mLhM/Y6tCI9vztCgi3Onv3Mc8a0QeTbPZHi5d2s14aolohjs
         VNQQedEaVkyKzN+qVgqvzzRDT0Gc+e8rBTvWWU6Nm1TrE+7J0b25vPyHpCigNN00y0ze
         h1fA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ruIo1CDS;
       spf=pass (google.com: domain of skeggsb@gmail.com designates 2607:f8b0:400c:c05::22e as permitted sender) smtp.mailfrom=skeggsb@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELtiNt7ZQPP5hShMj/4+snhGdsMBB1RTSyJ7HONU4FkLLTqHqVdTAvZ+y3NQE9o5+bOdbV2jxg==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1522142046; cv=none;
        d=google.com; s=arc-20160816;
        b=lRmHOmytYxj/FOO/eVJTFWLqo4oElMRbDbRrJzAdv5Itbjab8yYNDk0cU0WRkr1y1W
         Dx84ZFuqcC89Y91WjTGP+T6ns5WtXCljhlF7MK2Wx5ngak9x6/TSPUCtzPMxGKNGYcID
         YQ/hE6wQCclqZXO/dharR/7Rsz+tw8DnDXJ4Hc9j7AYrvebrw66IxJXo8QUM1L4CwKac
         W2YZkuwAPyKLApwpOSfAfd31ONAoVJfvvKv/QpfkKnnrFKew5+U1VNyM6QwewDsr6H4z
         MNJtHvx5phA0QTGvimN91jzFBAEBK2CBr4pVOg7dvrlWSSdfRu8/IM1mKMi1eFOG0K2e
         ditA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=fo5j6+wcAg13jWE8T4OWUV2bENjTphMQ9FelCU+/XPk=;
        b=PdoeZR31ObUzGLU8ylkNXuF/mEgXOiDbsVN9SkKHBw6v6QStpCoQ91jxyYU4E4J8Bx
         cHI8Sbdo2F0FJJy6SQayuEFDvFeNGdWOgfT78LhiiiJUZj+u+DrNDZ80TEbkQ0LF1CoP
         Nm0WTbxmMsL7wqmhFQqxwR7bZobuSNTQDncQvRTdumRxMiiAZ0Gx26VZXK+HIa1NHk2E
         wtV4STyCzTa0jnS0q6l66IaTWhj+rnLW9y5yohISQTQysHJU1SE2rnjwQfyadCouF4Vy
         a2zK6mm5+9LS8slV2uKSigHiI6kxGFywgPIia5a3iSmAR7vwXlAt72fVxm2ifsxgMU2t
         x+wA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ruIo1CDS;
       spf=pass (google.com: domain of skeggsb@gmail.com designates 2607:f8b0:400c:c05::22e as permitted sender) smtp.mailfrom=skeggsb@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
MIME-Version: 1.0
In-Reply-To: <20180327091156.GA23787@seema-Inspiron-15-3567>
References: <20180327091156.GA23787@seema-Inspiron-15-3567>
From: Ben Skeggs <skeggsb@gmail.com>
Date: Tue, 27 Mar 2018 19:14:05 +1000
Message-ID: <CACAvsv5Wzd6yFsweNXRNA93i5UeTX5qrb_xwPOeobqSjhLEMjg@mail.gmail.com>
Subject: [Outreachy kernel] Re: [PATCH] gpu: drm: nouveau: Use list_for_each_entry_from_reverse
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: skeggsb@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=ruIo1CDS;       spf=pass
 (google.com: domain of skeggsb@gmail.com designates 2607:f8b0:400c:c05::22e
 as permitted sender) smtp.mailfrom=skeggsb@gmail.com;       dmarc=pass
 (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596081478733159476?=
X-GMAIL-MSGID: =?utf-8?q?1596083479535910548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27 March 2018 at 19:11, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:
> It's better to use "list_for_each_entry_from_reverse" for iterating list
> than "for loop" as it makes the code more clear to read.
> This patch replace "for loop" with "list_for_each_entry_from_reverse"
> and remove "cstate" variable as it is redundant in the code.
I would prefer to also see "start" renamed to "cstate" with this change.

Ben.

>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> index 81c3567..5e56f74 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> @@ -113,7 +113,6 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
>  {
>         struct nvkm_device *device = clk->subdev.device;
>         struct nvkm_volt *volt = device->volt;
> -       struct nvkm_cstate *cstate;
>         int max_volt;
>
>         if (!pstate || !start)
> @@ -133,13 +132,12 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
>                 max_volt = min(max_volt,
>                                nvkm_volt_map(volt, volt->max2_id, clk->temp));
>
> -       for (cstate = start; &cstate->head != &pstate->list;
> -            cstate = list_prev_entry(cstate, head)) {
> -               if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
> +       list_for_each_entry_from_reverse(start, &pstate->list, head) {
> +               if (nvkm_cstate_valid(clk, start, max_volt, clk->temp))
>                         break;
>         }
>
> -       return cstate;
> +       return start;
>  }
>
>  static struct nvkm_cstate *
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CACAvsv5Wzd6yFsweNXRNA93i5UeTX5qrb_xwPOeobqSjhLEMjg%40mail.gmail.com.
For more options, visit https://groups.google.com/d/optout.
