Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBZUM33KQKGQESADIAAY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521976935; cv=pass;
        d=google.com; s=arc-20160816;
        b=RQYheNIz4Ht2kDZm1ZtJuzTQk8TOUPUitGUkGSy8AzReRlaVFckeugFUXb82XspKVB
         UHvuPtmO2UZP151B/pneFmalCSSYtQB58cGq0k3WW4qFTnxHBPPbKsWAhKQhi7fQcBIO
         tcuopZvA4K/PjowlC5NW0AVv2y6YqXqqXQGkx91U+VbYDEFtgfE73pyXxv/dXoEtVDWU
         7y1o0Kcw+u1KlBA+IG4/ERsggaNQv7oEdnikj1HK8lUaSfy+m27ULXvEMDnBcs6G24KB
         C8dSwRyFjIg8T3c7ypXtb9so3XMmLWcHKfCPIo0j+DnTceCKWOo2izU/tHdrtWaQNfKe
         6TgQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=aj9tl4qAogCCerKhKmK2r7ldfXSNWdDm/6ciAlWPTEI=;
        b=ZtvPVpTrLuj4zesF0WgaxrxZSq/2EFXkAXbhH1JcbMn3rSPY9Q4mGArn14uUwc+Jm7
         unxcDDo8bDvipjGf8QRhZdgRSeFMCFGdvxR1A8DaRzAh3RMTlt2nbazYN/kTNsm+mufW
         ucvj0cbnbjYJZhPThND6DktMma+gQXSfjkSv3Ml6x7nbzeqJMA1erspB+ZsdLNTtW/w9
         y1JC7fsGVmnfiG7Ul2N6s2OoEiwngdZUkBrzVbHKy9Xogm8XW0M6w3HizuMHv8rVIIg9
         /dad/MGjbeiCCiAxom1ViEfooA8mEBIXSd7xWDLePXvyr98Xn2upgT9ccPxq1Lcjd7TR
         CNUQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=fMWR7I1T;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H6iERfjA;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbzum33kqkgqesadiaay@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBZUM33KQKGQESADIAAY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=fMWR7I1T;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H6iERfjA;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbzum33kqkgqesadiaay@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBZUM33KQKGQESADIAAY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1521976935; cv=pass;
        d=google.com; s=arc-20160816;
        b=Y/qV3NN/C6k9xNMCCA3FnJAFqTJ4WasdEareJ9VtcyHXhqGWtWVFwodijEwK929+qM
         8mQYJPz4VevjDMSPcuzlYZrPyGjmYVkaebQvpJDjzvxXs/c4BNVjpSzhHYv3hbTNA1vR
         6PJhg0UBVMBjhuwcAkqOD5X2/otDN04hgI/PYWE1xFtQdhaH74VRSQ+y8xpAtc6p9bwL
         OLVZLjByCU5R+tpDI3G0xACWYD1yBepHGZNmuY3fPZaHJyI9mPBEoIfuwe2ephQ3Ix7u
         obvIbpuml3qa8QpB7XXNe7FuEGdKWiDBywXNrhkX1BhhHzIf7p7i40bH+uqxtNaaRWFm
         B30A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=aj9tl4qAogCCerKhKmK2r7ldfXSNWdDm/6ciAlWPTEI=;
        b=JTfeUa6xFopmPmtCzEWdF/CrCjjC2/gyA6YWfil8rytorQwkD4+flZnDShECALsVlO
         QFN+dIaWq1lNoZZ+/DZ0zELy25A3OFgJLzEkMe5m7xIr/QUsfFhQonzqz9+oAARquQS6
         I5EZQnW0VttL4lGSIWCpdNPPtYRdIv2H/ubz0wMHCdFzyCqqBqM3UTx0jwlkGv8/UGZL
         mC1PgH4k6TFQi0q5gb+kM0XXfDcuwCSmgGO61joPGaQZNvqAbjcIAOxSKdBeL8e0zcei
         5xPkE+2h++UAPcjdDwQsyadBB7BwR6vjqxBNto6T0kPf1S9FrxItxHCjnGk14P2XuptA
         noLw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H1FmjBME;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::22e as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELuoEd9q7tuNMJ/8GTxfcHwym70N3Rjx5Cl6s1JRTNcU4wlkFUK/7eqJQ/FhwAfwZg8xb55LIQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521976934; cv=none;
        d=google.com; s=arc-20160816;
        b=gry9mEzhtb/C5fim0xx6urUo/VZL2vSPzry8Mut2CrUdb1ulQ7LmUgHwCVcqQDmp9I
         NCxqT0mv/06Sd83GSxlq1hHvz+IjEd3xDII5f1gVm9irUJjA/poWxi+CbDhWeB6lA7e/
         e3ak7YFyPJ1TIqqbvf0NtR6MDe7r2VqDnLrmBFF3WcmM+sdmvcnehA1oZzvRVpty910v
         DwuTLJB7CYvOn4qwsTT2fgWEh2qZzPdwsi4HiQ7DDXlH1ygmKEwE1p/N9L7DIyGfhu9G
         EIl0Zp/ylcXvmDCsUEkK+09ZJ9FZ6pKJYohIpfkl7841TAmDrK1yWOJ29MfKxSCqvlyc
         spVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gmg6eOIBT79KXGo8apT37QQLok1lcGp3orCbGcnt3Gs=;
        b=X1vSFhIvvEGJge4dEVc1zbBXg/c08CYmGZqJtbrFJ1vwEvy8Kwx1l29uDiPPFt5Vyg
         PwSu5RZl1mDV6XlyF7tbZsKkOlrDpBJD4JmfhQHreIvsry7LcSqmzyjJg1hHxsT2QuzS
         jA3yz/Zj8FyzmA1T472Oogz2ZV0tPAoAOZY6czytZpzaDCDwzR3mpi1FOZuRH/FlmIT+
         dhmUKD76NSy9UczOH4yEfVXcqLd3CQ7/Yw/TfDy61dUxLqYEl5LHxWmW0cezkVK0Ccss
         5ffOo0YkPqvqBamkxTWlKqt6OpOsAuv/+iZ5i/bE1BQy0/RGBxzCoY/cv2aKZ6wgoIyo
         j6mQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H1FmjBME;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::22e as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803190805260.2864@hadrien>
References: <20180319050530.GA25589@seema-Inspiron-15-3567> <alpine.DEB.2.20.1803190805260.2864@hadrien>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Sun, 25 Mar 2018 16:52:13 +0530
Message-ID: <CA+XqjF8-33LS=5obrhxtBUB97WSCSLNTxCTFH_oNN6EqUZE52g@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] gpu: drm: Use list_{next/prev}_entry
 instead of list_entry
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: daniel.vetter@intel.com, Gustavo Padovan <gustavo@padovan.org>,
	Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
	Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>, nouveau@lists.freedesktop.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: multipart/alternative; boundary="001a114af28a845f5805683adec8"
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=H1FmjBME;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2a00:1450:4010:c07::22e as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
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
X-GMAIL-MSGID: =?utf-8?q?1595908486872974166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114af28a845f5805683adec8
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 19, 2018 at 12:44 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Mon, 19 Mar 2018, Arushi Singhal wrote:
>
> > This patch replace list_entry with list_{next/prev}_entry as it makes
> > the code more clear to read.
> > Done using coccinelle:
> >
> > @@
> > expression e1;
> > identifier e3;
> > type t;
> > @@
> > (
> > - list_entry(e1->e3.next,t,e3)
> > + list_next_entry(e1,e3)
> > |
> > - list_entry(e1->e3.prev,t,e3)
> > + list_prev_entry(e1,e3)
> > )
>
> This looks like a rule that could be nice for the Linux kernel in general,
> because the code really is much simpler.
>
> I would suggest to write the rule in a more robust way, as follows:
>
> @@
> identifier e3;
> type t;
> t *e1;
> @@
>
> (
> - list_entry(e1->e3.next,t,e3)
> + list_next_entry(e1,e3)
> |
> - list_entry(e1->e3.prev,t,e3)
> + list_prev_entry(e1,e3)
> )
>
> @@
> expression e1;
> identifier e3;
> @@
>
> (
> - list_entry(e1->e3.next,typeof(*e1),e3)
> + list_next_entry(e1,e3)
> |
> - list_entry(e1->e3.prev,typeof(*e1),e3)
> + list_prev_entry(e1,e3)
>
> This checks that the type that is specified corresponds to the one on e1.
> It could actually be that the call is getting the first element of a list,
> from some different type, and coincidentally the two types have the same
> field name for the list element.
>
> Unfortunately, the second rule, with the typeof call, doesn't currently
> work in Coccinelle, because the semantic patch language doesn't actually
> support typeof, and thinks that it is a function call.  I will fix this.
>
> To make a semantic patch for the kernel, you can try running spgen on the
> above file and answer the questions that it asks.  You can find examples
> in the coccinelle/scripts directory.  Just run
>
> spgen foo.cocci
>
> Then answer the questions.  Then run
>
> spgen foo.cocci > foo_for_kernel.cocci
>
> The second run will use the results of the first run to print the semantic
> patch.  Let me know if you have any questions.  You can always adjust the
> semantic patch that is generated by hand afterwards if needed.
>
>
Thanks Julia for explanation and it helped me to learn about Spgen tool.
I'll make the changes and resend.

Arushi

> julia
>
>
> >
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_lease.c                    | 2 +-
> >  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> > index 1402c0e..4dcfb5f 100644
> > --- a/drivers/gpu/drm/drm_lease.c
> > +++ b/drivers/gpu/drm/drm_lease.c
> > @@ -340,7 +340,7 @@ static void _drm_lease_revoke(struct drm_master *top)
> >                               break;
> >
> >                       /* Over */
> > -                     master = list_entry(master->lessee_list.next,
> struct drm_master, lessee_list);
> > +                     master = list_next_entry(master, lessee_list);
> >               }
> >       }
> >  }
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > index e4c8d31..81c3567 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > @@ -134,7 +134,7 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct
> nvkm_pstate *pstate,
> >                              nvkm_volt_map(volt, volt->max2_id,
> clk->temp));
> >
> >       for (cstate = start; &cstate->head != &pstate->list;
> > -          cstate = list_entry(cstate->head.prev, typeof(*cstate),
> head)) {
> > +          cstate = list_prev_entry(cstate, head)) {
> >               if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
> >                       break;
> >       }
> > --
> > 2.7.4
> >
> > --
> > You received this message because you are subscribed to the Google
> Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send
> an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/
> msgid/outreachy-kernel/20180319050530.GA25589%40seema-Inspiron-15-3567.
> > For more options, visit https://groups.google.com/d/optout.
> >
>

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF8-33LS%3D5obrhxtBUB97WSCSLNTxCTFH_oNN6EqUZE52g%40mail.gmail.com.
For more options, visit https://groups.google.com/d/optout.

--001a114af28a845f5805683adec8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Mar 19, 2018 at 12:44 PM, Julia Lawall <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:julia.lawall@lip6.fr" target=3D"_blank">julia.lawall@lip6.f=
r</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">=
<br>
<br>
On Mon, 19 Mar 2018, Arushi Singhal wrote:<br>
<br>
&gt; This patch replace list_entry with list_{next/prev}_entry as it makes<=
br>
&gt; the code more clear to read.<br>
&gt; Done using coccinelle:<br>
&gt;<br>
&gt; @@<br>
&gt; expression e1;<br>
&gt; identifier e3;<br>
&gt; type t;<br>
&gt; @@<br>
&gt; (<br>
&gt; - list_entry(e1-&gt;e3.next,t,e3)<br>
&gt; + list_next_entry(e1,e3)<br>
&gt; |<br>
&gt; - list_entry(e1-&gt;e3.prev,t,e3)<br>
&gt; + list_prev_entry(e1,e3)<br>
&gt; )<br>
<br>
</span>This looks like a rule that could be nice for the Linux kernel in ge=
neral,<br>
because the code really is much simpler.<br>
<br>
I would suggest to write the rule in a more robust way, as follows:<br>
<br>
@@<br>
identifier e3;<br>
type t;<br>
t *e1;<br>
<span class=3D"">@@<br>
<br>
(<br>
- list_entry(e1-&gt;e3.next,t,e3)<br>
+ list_next_entry(e1,e3)<br>
|<br>
- list_entry(e1-&gt;e3.prev,t,e3)<br>
+ list_prev_entry(e1,e3)<br>
)<br>
<br>
</span><span class=3D"">@@<br>
expression e1;<br>
identifier e3;<br>
</span>@@<br>
<br>
(<br>
- list_entry(e1-&gt;e3.next,typeof(<wbr>*e1),e3)<br>
+ list_next_entry(e1,e3)<br>
|<br>
- list_entry(e1-&gt;e3.prev,typeof(<wbr>*e1),e3)<br>
+ list_prev_entry(e1,e3)<br>
<br>
This checks that the type that is specified corresponds to the one on e1.<b=
r>
It could actually be that the call is getting the first element of a list,<=
br>
from some different type, and coincidentally the two types have the same<br=
>
field name for the list element.<br>
<br>
Unfortunately, the second rule, with the typeof call, doesn&#39;t currently=
<br>
work in Coccinelle, because the semantic patch language doesn&#39;t actuall=
y<br>
support typeof, and thinks that it is a function call.=C2=A0 I will fix thi=
s.<br>
<br>
To make a semantic patch for the kernel, you can try running spgen on the<b=
r>
above file and answer the questions that it asks.=C2=A0 You can find exampl=
es<br>
in the coccinelle/scripts directory.=C2=A0 Just run<br>
<br>
spgen foo.cocci<br>
<br>
Then answer the questions.=C2=A0 Then run<br>
<br>
spgen foo.cocci &gt; foo_for_kernel.cocci<br>
<br>
The second run will use the results of the first run to print the semantic<=
br>
patch.=C2=A0 Let me know if you have any questions.=C2=A0 You can always ad=
just the<br>
semantic patch that is generated by hand afterwards if needed.<br>
<br></blockquote><div><br></div><div>Thanks Julia for explanation and it he=
lped me to learn about Spgen tool.<br></div><div>I&#39;ll make the changes =
and resend.<br><br>Arushi<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
julia<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt;<br>
&gt; Signed-off-by: Arushi Singhal &lt;<a href=3D"mailto:arushisinghal19971=
997@gmail.com">arushisinghal19971997@gmail.<wbr>com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/drm_lease.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 drivers/gpu/drm/nouveau/nvkm/<wbr>subdev/clk/base.c | 2 +-<br>
&gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c=
<br>
&gt; index 1402c0e..4dcfb5f 100644<br>
&gt; --- a/drivers/gpu/drm/drm_lease.c<br>
&gt; +++ b/drivers/gpu/drm/drm_lease.c<br>
&gt; @@ -340,7 +340,7 @@ static void _drm_lease_revoke(struct drm_master *t=
op)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* Over */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0master =3D list_entry(master-&gt;lessee_<wbr>list.next, struct drm_m=
aster, lessee_list);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0master =3D list_next_entry(master, lessee_list);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/gpu/drm/nouveau/<wbr>nvkm/subdev/clk/base.c b/dri=
vers/gpu/drm/nouveau/<wbr>nvkm/subdev/clk/base.c<br>
&gt; index e4c8d31..81c3567 100644<br>
&gt; --- a/drivers/gpu/drm/nouveau/<wbr>nvkm/subdev/clk/base.c<br>
&gt; +++ b/drivers/gpu/drm/nouveau/<wbr>nvkm/subdev/clk/base.c<br>
&gt; @@ -134,7 +134,7 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct=
 nvkm_pstate *pstate,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvkm_volt_map(volt, volt-&gt;max2_id, cl=
k-&gt;temp));<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (cstate =3D start; &amp;cstate-&gt;head =
!=3D &amp;pstate-&gt;list;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cstate =3D list_entry(cstate-&gt;h=
ead.prev, typeof(*cstate), head)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cstate =3D list_prev_entry(cstate,=
 head)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvkm_cstate_=
valid(clk, cstate, max_volt, clk-&gt;temp))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; You received this message because you are subscribed to the Google Gro=
ups &quot;outreachy-kernel&quot; group.<br>
&gt; To unsubscribe from this group and stop receiving emails from it, send=
 an email to <a href=3D"mailto:outreachy-kernel%2Bunsubscribe@googlegroups.=
com">outreachy-kernel+unsubscribe@<wbr>googlegroups.com</a>.<br>
&gt; To post to this group, send email to <a href=3D"mailto:outreachy-kerne=
l@googlegroups.com">outreachy-kernel@googlegroups.<wbr>com</a>.<br>
&gt; To view this discussion on the web visit <a href=3D"https://groups.goo=
gle.com/d/msgid/outreachy-kernel/20180319050530.GA25589%40seema-Inspiron-15=
-3567" rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/<wb=
r>msgid/outreachy-kernel/<wbr>20180319050530.GA25589%<wbr>40seema-Inspiron-=
15-3567</a>.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
 rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/<wbr>opto=
ut</a>.<br>
&gt;<br>
</font></span></blockquote></div><br></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;outreachy-kernel&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:outreachy-kernel+unsubscribe@googlegroups.com">ou=
treachy-kernel+unsubscribe@googlegroups.com</a>.<br />
To post to this group, send email to <a href=3D"mailto:outreachy-kernel@goo=
glegroups.com">outreachy-kernel@googlegroups.com</a>.<br />
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/outreachy-kernel/CA%2BXqjF8-33LS%3D5obrhxtBUB97WSCSLNTxCTFH_oNN6=
EqUZE52g%40mail.gmail.com?utm_medium=3Demail&utm_source=3Dfooter">https://g=
roups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF8-33LS%3D5obrhxtBUB97WSC=
SLNTxCTFH_oNN6EqUZE52g%40mail.gmail.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--001a114af28a845f5805683adec8--
