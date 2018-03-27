Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBGGW5DKQKGQEW34FQZI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1522150168; cv=pass;
        d=google.com; s=arc-20160816;
        b=K2GbyPjzPQPqvqU0JUHRiAJLGJu4IwdYx5GkEbx29SRFkyNWPNUferfZI97awXNxR1
         JHkUqEiR92o3JIlUt1JM5jgMSSWJfCCSkcdbgTvD2e3//QQhJzxMY7GKIiYGlUj8Umk1
         PLlztDTjNcQs6zOjfNFx5IRO/NdkMsg6mN7Sp/inuiTnnU7tvza4pK233aNFuOqYSix/
         mRV1ajoPCX5QHAX7xMnyZyynWpkNjzSvR+f0hoeEq5uOyiHWfVtZ/UOiXySWySwwds5E
         pObfoCEZCrlF1cGdsyoJM5tgkpFAl4aKvC9FbXBYCyl08mRGmZIbeWPhpCVEIfHO+1my
         4KPQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=IMH0p3qbGPjI4uIwnuuTmPb5JuVxzLv19oobnGuhREU=;
        b=J2Doe61uuZQ2ohap8BjPU/i+FonKtRrahF+Ekm975dn6Zws9Q200oLruDK5zQntVpR
         LLFaRjMQalbhRq280J0A95oSXkwRuz80ANOUWTLP9yK43CJCh+W1oD3nripBgafvJyuu
         mPGQ2tU6q5XLRiG2LD147ubDPSzEwW6gfPeSOZ9pEiEBah0ilGJn6IJQJi+RjHjlUEyS
         SBE86XIqHCDQjklFO092yJ8+1d+SQ8KzwxvhLhD9T4iM1dBxhtnLmyq3gp4pb1e0zfWF
         S8Fzip0/ONwVwrwpVU56QBHsFJc37a3TyRlE966THNy8GBSNcRU76+/afJqgX6CV2YwW
         mNiQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Qbqapwwl;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XJ8NDuwX;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbggw5dkqkgqew34fqzi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBGGW5DKQKGQEW34FQZI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Qbqapwwl;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XJ8NDuwX;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbggw5dkqkgqew34fqzi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBGGW5DKQKGQEW34FQZI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1522150168; cv=pass;
        d=google.com; s=arc-20160816;
        b=UeQraQYaBMqwJyP+rdVxuNSAQZ4wS3/EkVj1uum8Z3Js3uvzuTOKQmDdJ8nUoQJWpC
         ZrLECVe4gUnDu6vva8bNxZSOrcfe4ty/aOLp2JL9u38E6AP1RZDFbIsYO/puMJ2teT24
         N5TdbGq/wY/E5/x0K58fvo7veAdl1TocN6Uw0Jf00HfaD8HKZ72bszRY0Y/itjHcgWKB
         TmiZ26ROgrC1MmU4uyqKTHN8F4txeiyJHWFEUg6GOuXTYPAuBtdIIDRlRJJFGZ2W6o+l
         1SzmtRzmR13v+4RGeJ54r/uNVPDlhJQzvt0qUAPzV1PNaZx1EYIBjAXanh1H5Whwy4Kp
         hijA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=IMH0p3qbGPjI4uIwnuuTmPb5JuVxzLv19oobnGuhREU=;
        b=jvm3MpVTs4GnUPFoi0/dQIZsU7PHUghuGfypbq4L4lcF3EAes9n0FDKlLVqhQ75Yw/
         dIPpSfNj5FF2laFCZaQ0/NKJFhEsSqsbHz07HB/KJ7WEZYyYduhv+qeuRx5TcqoO49aF
         FL0DBBSygUe3F7Kx2f829w+ODC5i90Sot9/tUUkswDZhnjg3TBaEj7CudzgRbVewA1Gy
         xra9EeZG6ExlH2PwV6HxyFkkOhGgHXmBe2b1UFjeL2fefzh4pE/ovWAQmjt8cveogGgi
         pcabDjRZeKHrLRlubm6IS9agcOuUyWInR9Yde+G9OCyUU6yj4Ff/mlMV1bBU3+rQmVYP
         pcnw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mp1pYamM;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::22a as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELv33EsMBaGrsBTp80XVj/JFzSuYBTkwLLRdV0fgOF1Fc6RHCSIaR9iSg4V+x21pPZn1XjT5nw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1522150167; cv=none;
        d=google.com; s=arc-20160816;
        b=XHcQQsixghDdNCDA0Nvwg7hnAQ5cEjLIe04BbO0BhuaDlbXsJ/P0lPL0mkg4wGbtkm
         apM9xEDyWpWa0V4BUpCAZfBzyyFJ6mZ86lgZu0BYTbsBtclB6RHdlp0u/n3/Irhg/DVZ
         isAUcIrs4Nocng/pn8+Hz4e6q8lZ+tcfXTjsQmNJDyX7pBTK80L3f0pLD2Qx83fmfGnK
         CQb7DcHPOAcsyTkr+jWVsCQfOx6T4wu6pfG6l6WBo+z4tk1ZLOCweWs+L6MKVWYa84XY
         xk2zHHXQIvyLvXXLIcMgWzApvHw/zT3fKho9eAksqjGVBlM+WAwA9aG/8LMOxMGCaycW
         /fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=jF55mc2srbd4xL5nklpr1sa1BfC/YVHJ164/AcFvWqA=;
        b=Pw6LHvnTaqOXR6rYI2dHr0DScv9Bi4xpj41fASJABFx1SHaVUqLC/9KFqfQwC2kaqZ
         sHXFQNxkR+4q1dKRN/+rT+l9gmsdCgyRP/mECpWCJg23HeGj8uBJfkbyl15MpQIB3Ftk
         l4GrLnO4hNs+5ny/sqKSlG4HlZb5rsNimAejLpMt73HyEnbaMKCd7zLai1Y373kN0KFi
         MtpLe1AJsOGsGiw56wVBI1K1v6iuJTaeokUenmdFjGedgSy4EQD3Hn/h76+5V8BW04RE
         ocz0/uP5qSFPr7sELh0vfWBqKwi/tk3jqSIA8r4BN4b5lGsEtJLuM2dbkhgm8Kh5uBv3
         bVxA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mp1pYamM;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::22a as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
MIME-Version: 1.0
In-Reply-To: <CACAvsv5Wzd6yFsweNXRNA93i5UeTX5qrb_xwPOeobqSjhLEMjg@mail.gmail.com>
References: <20180327091156.GA23787@seema-Inspiron-15-3567> <CACAvsv5Wzd6yFsweNXRNA93i5UeTX5qrb_xwPOeobqSjhLEMjg@mail.gmail.com>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Tue, 27 Mar 2018 16:59:26 +0530
Message-ID: <CA+XqjF_iDq1KXcKp2j_HYz3JBg+GgKvkVXQ8Y62r8jNiGhE8=w@mail.gmail.com>
Subject: [Outreachy kernel] Re: [PATCH] gpu: drm: nouveau: Use list_for_each_entry_from_reverse
To: Ben Skeggs <skeggsb@gmail.com>
Cc: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: multipart/alternative; boundary="00000000000002e425056863345d"
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=mp1pYamM;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2a00:1450:4010:c07::22a as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1596081478733159476?=
X-GMAIL-MSGID: =?utf-8?q?1596090135077690524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--00000000000002e425056863345d
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 27, 2018 at 2:44 PM, Ben Skeggs <skeggsb@gmail.com> wrote:

> On 27 March 2018 at 19:11, Arushi Singhal
> <arushisinghal19971997@gmail.com> wrote:
> > It's better to use "list_for_each_entry_from_reverse" for iterating list
> > than "for loop" as it makes the code more clear to read.
> > This patch replace "for loop" with "list_for_each_entry_from_reverse"
> > and remove "cstate" variable as it is redundant in the code.
> I would prefer to also see "start" renamed to "cstate" with this change.
>
Hello Ben

Yes, using cstate is more accurate, as most of the functions are using
"cstate" variable.

Best
Arushi

>
> Ben.
>
> >
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > index 81c3567..5e56f74 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > @@ -113,7 +113,6 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct
> nvkm_pstate *pstate,
> >  {
> >         struct nvkm_device *device = clk->subdev.device;
> >         struct nvkm_volt *volt = device->volt;
> > -       struct nvkm_cstate *cstate;
> >         int max_volt;
> >
> >         if (!pstate || !start)
> > @@ -133,13 +132,12 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct
> nvkm_pstate *pstate,
> >                 max_volt = min(max_volt,
> >                                nvkm_volt_map(volt, volt->max2_id,
> clk->temp));
> >
> > -       for (cstate = start; &cstate->head != &pstate->list;
> > -            cstate = list_prev_entry(cstate, head)) {
> > -               if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
> > +       list_for_each_entry_from_reverse(start, &pstate->list, head) {
> > +               if (nvkm_cstate_valid(clk, start, max_volt, clk->temp))
> >                         break;
> >         }
> >
> > -       return cstate;
> > +       return start;
> >  }
> >
> >  static struct nvkm_cstate *
> > --
> > 2.7.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF_iDq1KXcKp2j_HYz3JBg%2BGgKvkVXQ8Y62r8jNiGhE8%3Dw%40mail.gmail.com.
For more options, visit https://groups.google.com/d/optout.

--00000000000002e425056863345d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Mar 27, 2018 at 2:44 PM, Ben Skeggs <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:skeggsb@gmail.com" target=3D"_blank">skeggsb@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">On 27 March 2018 at 19:11,=
 Arushi Singhal<br>
<span class=3D"">&lt;<a href=3D"mailto:arushisinghal19971997@gmail.com">aru=
shisinghal19971997@gmail.<wbr>com</a>&gt; wrote:<br>
&gt; It&#39;s better to use &quot;list_for_each_entry_from_<wbr>reverse&quo=
t; for iterating list<br>
&gt; than &quot;for loop&quot; as it makes the code more clear to read.<br>
&gt; This patch replace &quot;for loop&quot; with &quot;list_for_each_entry=
_from_<wbr>reverse&quot;<br>
&gt; and remove &quot;cstate&quot; variable as it is redundant in the code.=
<br>
</span>I would prefer to also see &quot;start&quot; renamed to &quot;cstate=
&quot; with this change.<br></blockquote><div>Hello Ben<br><br>Yes, using c=
state is more accurate, as most of the functions are using &quot;cstate&quo=
t; variable.<br><br></div><div>Best<br></div><div>Arushi<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<br>
Ben.<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt; Signed-off-by: Arushi Singhal &lt;<a href=3D"mailto:arushisinghal19971=
997@gmail.com">arushisinghal19971997@gmail.<wbr>com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/nouveau/nvkm/<wbr>subdev/clk/base.c | 8 +++-----=
<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/nouveau/<wbr>nvkm/subdev/clk/base.c b/dri=
vers/gpu/drm/nouveau/<wbr>nvkm/subdev/clk/base.c<br>
&gt; index 81c3567..5e56f74 100644<br>
&gt; --- a/drivers/gpu/drm/nouveau/<wbr>nvkm/subdev/clk/base.c<br>
&gt; +++ b/drivers/gpu/drm/nouveau/<wbr>nvkm/subdev/clk/base.c<br>
&gt; @@ -113,7 +113,6 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct=
 nvkm_pstate *pstate,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvkm_device *device =3D clk-&g=
t;subdev.device;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvkm_volt *volt =3D device-&gt=
;volt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvkm_cstate *cstate;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int max_volt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pstate || !start)<br>
&gt; @@ -133,13 +132,12 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, stru=
ct nvkm_pstate *pstate,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max_volt =
=3D min(max_volt,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvkm_volt_map(volt, volt-&gt;max2=
_id, clk-&gt;temp));<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0for (cstate =3D start; &amp;cstate-&gt;hea=
d !=3D &amp;pstate-&gt;list;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cstate =3D list_prev_entry(=
cstate, head)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvkm_cstat=
e_valid(clk, cstate, max_volt, clk-&gt;temp))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_entry_from_<wbr>reverse(star=
t, &amp;pstate-&gt;list, head) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvkm_cstat=
e_valid(clk, start, max_volt, clk-&gt;temp))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return cstate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return start;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static struct nvkm_cstate *<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
</div></div>&gt; ______________________________<wbr>_________________<br>
&gt; dri-devel mailing list<br>
&gt; <a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.fre=
edesktop.<wbr>org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" r=
el=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mail=
man/listinfo/dri-devel</a><br>
</blockquote></div><br></div></div>

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
om/d/msgid/outreachy-kernel/CA%2BXqjF_iDq1KXcKp2j_HYz3JBg%2BGgKvkVXQ8Y62r8j=
NiGhE8%3Dw%40mail.gmail.com?utm_medium=3Demail&utm_source=3Dfooter">https:/=
/groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF_iDq1KXcKp2j_HYz3JBg%2=
BGgKvkVXQ8Y62r8jNiGhE8%3Dw%40mail.gmail.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--00000000000002e425056863345d--
