Return-Path: <outreachy-kernel+bncBDZJXP7F6YLRBAGN4DKQKGQETYAVPOI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1522017920; cv=pass;
        d=google.com; s=arc-20160816;
        b=nbiTqrK/nf4zTjGpKfQpHD0cBWdsxBVqkBri7jXmuidCG4gRvB7cwotw1baHkZtPvA
         qhE1QSRV1daHBpwsFoMx2eDjiZEy5/683NpNAEgn3rHw50xfBMleXvKuLSG/lpYqJbLw
         4YBDibBhdSO7Tkgo2j4rSKo+8tKykLRfdEE3bKBWMSSyI0J4AZdBz4JhMaqdws+UFnJU
         eQYeEZBcdTXlHY0Hrg3/zGEr5B4014N+AzxKFSjZrCYHCzFeXvWC+SuhF7YrstHvL3Gj
         OeEYQ4tyP79nzXYN3yNRyrOeHmxIQuZNJZLCImrUOVQn0L5OcHx995FXftEtlYu7Ddz5
         mtkg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=M/Qbz+gerzfsbWhDoVBh7fiAHUm+2m0exudZ6NkR9SM=;
        b=bQRTR8avcK3KGaWhYcH4RhIqRF3PbzvoUxy8PuxUSB5cfZeVzIbhKzfU/wBKQ2Lt3l
         MAR/+V6fhGfTAPWdHqtIifbmXPk2Q/QVAeQ7RLTOTp4j9TOQv+uf4Cqh1/MTLVtelJsg
         937Z/hSB8w/UEf8VphHPq/Lib1WLlpcx8Dy1HcQej0+7P/NH8x3yFDj+Huo3f+yziuo/
         jgEv4WtTiEmSzIOF0at2FFhPZO00Z4fSQGeYTkpn1hYnTrMHihqO1viAmkNRdLDgOjRV
         VbEU+hWH5Fr3PiIfiEwqDgkKUXV/gZtIvDtzyFsqLJugSgInYo6iF/kQK7KfTfa5iNKs
         A44Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=omD87mH0;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrbagn4dkqkgqetyavpoi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRBAGN4DKQKGQETYAVPOI@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=omD87mH0;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrbagn4dkqkgqetyavpoi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRBAGN4DKQKGQETYAVPOI@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1522017920; cv=pass;
        d=google.com; s=arc-20160816;
        b=mU68aXo1IfW7FOIMuQAmnVcI/kc2dRK51HcEnzDBW8dxBBMHH+LqfOvTcwd6BWLhj3
         1xlq/3quCODq+ejiGraNbdqfx9KX5fSXTncXa5d0kuMg+bSRN0g66SzwinzpK/0iPKC3
         KHbnISZpWnuqcI/Bv0KEyotITJxDKs2EazblmeN2mDqmR2NDLhS3vqk0cSI/1LrePwts
         E1Bt1QcSMCh2smQZfjmypglsnnE5UZZu9CsnEeQbA3ExTe2ZMIg7CcXSZLpxbkh9cflq
         NmwpeONoPcvZhpE9O4n7J6T0djpeoBhmR7wBy3He7x/cWK75CHG5Ni1IJdK/coN3sRW+
         Q6WQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=M/Qbz+gerzfsbWhDoVBh7fiAHUm+2m0exudZ6NkR9SM=;
        b=q79l0lnOSNYLrp46qA6vARQB6fl/0SDQfA0p8c1HwXv9qo2Xka0hzEZCsiIu5+qA+K
         bQhOG/wakFJsUbNsjnmEgYjSwsB4Euycc5FdqBT8UlMn8o6jXJmsCCjK96Y3GkV4T8xC
         BvWkgMrNxHbTsDgDVn1GMaT/tq45mpQYnmLbGj0XF21x5d3eKw9MHvBHN+PmAVueo6uy
         YEIE7n5cKZFK/5hAfri+YTqISc/52r3EigxNJItqHKVuOCuINWDFUnLQSywUZ2nb16Dt
         CYbHK8vtAq8h2d2pzrl92JvPypUfPuAIpFt4VJiu8QIqWsuanUpwddx8orXdJ+1aHlrq
         Y4kQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.104 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELuUoFgGS3onA3toVp7gE8z6x/4RMaqu0euJP8WZOk6/oX1xse4P5yKF0B43NhzCe+BAreQReA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1522017919; cv=none;
        d=google.com; s=arc-20160816;
        b=lVRlBkUaV5Egi93iBQqLuCGlnbFglyEoEsedaB8qKln6AWm+92aK6zYqEUdu6U815m
         pPNUkBjReSMyR8VcItJ2d6Mc1okPB0tuYBdB9sjiKxW1dj+iIlz5xP1ww5HLySj/SWPD
         O+zenjOgYI/iijNjQmfaN8ZsnMI/zwxlDLLl7HPCM87KpBGAmxobHiIQgCMhKifR/0w1
         oPiR31dRIo3o3i4xiSEUurzTHeR9dmUfBu+JPXy22a5wQGeCCfD9qwVPAMFidtGoumyZ
         HoKfx3pxFZ1T6O4VcqZvJ1Jj66JcGnCceqKwoiLm5pgD8i4NCLhz5F/Xs4NNx0/0zdm9
         W2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=SNe6h/wNdeueDDkLWNqy2CYeLrLfDQfrgv82TSZWb0I=;
        b=OBcSDpbOrvtkW+LhKmM6xb7+lLs92wkxAIUcbF4jkn1IxrQ8ULa9CHRwfRCGGfoKNZ
         nrozJBGB9OC82B9qOL2cPV7TIt4ce5rduecBHPqT5gbVPAGB4iTTEeOdyUyHi5lKkWFU
         22BMW9KAorkmZvgWHYkJVAmfwlfvSgN6C9dU6dr/vhEAcIZiO1TIcIZSF9jEI4P01Om8
         fev2IkI9Mvw/MeC/KyYTvWX2Vp0J09WpRY+pijnQ5UbWp9vYk3+tNjcK8iLkz46fQSqb
         vg2AQwVhGKVwrzsWcef2WXjTVTBHenrLI2yjK1kF9r+n8OITRf+t3w615TEJzp5bf9Kq
         RtBQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.104 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.48,362,1517871600";
   d="scan'208";a="259740526"
Date: Mon, 26 Mar 2018 00:45:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: daniel.vetter@intel.com, Gustavo Padovan <gustavo@padovan.org>,
    Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
    Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
    LKML <linux-kernel@vger.kernel.org>, nouveau@lists.freedesktop.org,
    outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] [PATCH] gpu: drm: Use list_{next/prev}_entry
 instead of list_entry
In-Reply-To: <CA+XqjF9jHrOFL4LosK5GdbAgpmQRd9=08eNzvfzYxFaeXk972g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1803260044440.2488@hadrien>
References: <20180319050530.GA25589@seema-Inspiron-15-3567> <alpine.DEB.2.20.1803190805260.2864@hadrien> <CA+XqjF9jHrOFL4LosK5GdbAgpmQRd9=08eNzvfzYxFaeXk972g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1052078271-1522017915=:2488"
X-Original-Sender: julia.lawall@lip6.fr
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 192.134.164.104 is neither permitted nor denied by domain of
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
X-GMAIL-MSGID: =?utf-8?q?1595951463370520234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--8323329-1052078271-1522017915=:2488
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Sun, 25 Mar 2018, Arushi Singhal wrote:

>
>
> On Mon, Mar 19, 2018 at 12:44 PM, Julia Lawall <julia.lawall@lip6.fr> wro=
te:
>
>
>       On Mon, 19 Mar 2018, Arushi Singhal wrote:
>
>       > This patch replace list_entry with list_{next/prev}_entry as
>       it makes
>       > the code more clear to read.
>       > Done using coccinelle:
>       >
>       > @@
>       > expression e1;
>       > identifier e3;
>       > type t;
>       > @@
>       > (
>       > - list_entry(e1->e3.next,t,e3)
>       > + list_next_entry(e1,e3)
>       > |
>       > - list_entry(e1->e3.prev,t,e3)
>       > + list_prev_entry(e1,e3)
>       > )
>
>       This looks like a rule that could be nice for the Linux kernel
>       in general,
>       because the code really is much simpler.
>
>       I would suggest to write the rule in a more robust way, as
>       follows:
>
>       @@
>       identifier e3;
>       type t;
>       t *e1;
>       @@
>
>       (
>       - list_entry(e1->e3.next,t,e3)
>       + list_next_entry(e1,e3)
>       |
>       - list_entry(e1->e3.prev,t,e3)
>       + list_prev_entry(e1,e3)
>       )
>
>       @@
>       expression e1;
>       identifier e3;
>       @@
>
>       (
>       - list_entry(e1->e3.next,typeof(*e1),e3)
>       + list_next_entry(e1,e3)
>       |
>       - list_entry(e1->e3.prev,typeof(*e1),e3)
>       + list_prev_entry(e1,e3)
>
>       This checks that the type that is specified corresponds to the
>       one on e1.
>       It could actually be that the call is getting the first element
>       of a list,
>       from some different type, and coincidentally the two types have
>       the same
>       field name for the list element.
>
>       Unfortunately, the second rule, with the typeof call, doesn't
>       currently
>       work in Coccinelle, because the semantic patch language doesn't
>       actually
>       support typeof, and thinks that it is a function call.=C2=A0 I will
>       fix this.
>
>       To make a semantic patch for the kernel, you can try running
>       spgen on the
>       above file and answer the questions that it asks.=C2=A0 You can fin=
d
>       examples
>       in the coccinelle/scripts directory.=C2=A0 Just run
>
>       spgen foo.cocci
>
>       Then answer the questions.=C2=A0 Then run
>
>       spgen foo.cocci > foo_for_kernel.cocci
>
>       The second run will use the results of the first run to print
>       the semantic
>       patch.=C2=A0 Let me know if you have any questions.=C2=A0 You can a=
lways
>       adjust the
>       semantic patch that is generated by hand afterwards if needed.
>
>
> Hi Julia,
>
> I tried spgen and found that second rule is still not working. It's not a=
ble
> to detect the second rule.
> Is it working for you?

If you get the latest version of Coccinelle from github, it shoudl be
working now.

julia

>
> Thanks,
> Arushi
>
>
>       julia
>
>
>       >
>       > Signed-off-by: Arushi Singhal
>       <arushisinghal19971997@gmail.com>
>       > ---
>       >=C2=A0 drivers/gpu/drm/drm_lease.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-
>       >=C2=A0 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 2 +-
>       >=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
>       >
>       > diff --git a/drivers/gpu/drm/drm_lease.c
>       b/drivers/gpu/drm/drm_lease.c
>       > index 1402c0e..4dcfb5f 100644
>       > --- a/drivers/gpu/drm/drm_lease.c
>       > +++ b/drivers/gpu/drm/drm_lease.c
>       > @@ -340,7 +340,7 @@ static void _drm_lease_revoke(struct
>       drm_master *top)
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>       >
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* Over */
>       > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0master =3D
>       list_entry(master->lessee_list.next, struct drm_master,
>       lessee_list);
>       > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0master =3D list_next_entry(master,
>       lessee_list);
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>       >=C2=A0 }
>       > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
>       b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
>       > index e4c8d31..81c3567 100644
>       > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
>       > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
>       > @@ -134,7 +134,7 @@ nvkm_cstate_find_best(struct nvkm_clk
>       *clk, struct nvkm_pstate *pstate,
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvkm_volt_map(volt,
>       volt->max2_id, clk->temp));
>       >
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0for (cstate =3D start; &cstate->head !=
=3D &pstate->list;
>       > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cstate =3D list_entry(cstate-=
>head.prev,
>       typeof(*cstate), head)) {
>       > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cstate =3D list_prev_entry(cs=
tate, head)) {
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvkm_cs=
tate_valid(clk, cstate, max_volt,
>       clk->temp))
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>       > --
>       > 2.7.4
>       >
> > --
> > You received this message because you are subscribed to the Google
> Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it,
> send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to
> outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visithttps://groups.google.com/d/msg=
id/outreachy-kernel/20180319050530.GA25589%4
> 0seema-Inspiron-15-3567.
> > For more options, visit https://groups.google.com/d/optout.
> >
>
>
>
>

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/alpine.DEB.2.20.1803260044440.2488%40hadrien.
For more options, visit https://groups.google.com/d/optout.

--8323329-1052078271-1522017915=:2488--
