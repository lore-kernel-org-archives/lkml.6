Return-Path: <outreachy-kernel+bncBDZJXP7F6YLRBPVTX3KQKGQERRWSFHI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521457598; cv=pass;
        d=google.com; s=arc-20160816;
        b=MeQuF3H5yqUMK27f0uz6h/C1a06olL+iLZFLaGqaS9Tlp1LgBLv1jmTo6I/+vbPHT2
         ZXQcFLyspYHAsWts+MTdtbPZq7IIQOSBiAD75F1m2DVtWBCnG7dtBnS6rWBNMDW+KM/N
         06XhoJQxF2CJgp+Z0UX0rVbQm7wGc4IVSUfbA/BWdFzUVSPQRHjFUobvnXN/E7VjVe+U
         qpweOesOzOPj9aYvOi2ebWbNTv2aiHErkQLkvk2VEMy+x/T56m3D4+NPvPA3y9A3LYoB
         2IMcuZAXIzJh+OXlL2mArA52sn1/FTGeIuki9pQt6MmkdtOalSH9CU++kxLJO9gi6ZC0
         zUVg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=rO9dlhSUNOmpETETJzq+XqHs/OnjLORSSNpbrbuq7qw=;
        b=1GdeJ+UG2VIHjIM2hP8hIVT2mAn3Xtkm19hjg4kC6ynMjtvlwKDc2aOxXe0oI0rZbt
         KHgbiht65dqeW5YKoiydPWg1Mqhbb6kTB82vwJgatUczKzOA8rYhcWoyd0Bi+KrgYIIY
         GWczoJqTtHHwF3iyUGnBNfeQnS4ElbGB9Vby4UEyoIJC+l5+SgwiDXv7c3zpRybchxKy
         4moOdNQucFixAKHu3xbMSOgB4H5eIEBxXUAw+tfpWxkaLFUR4EgY/++Szk9K1MJNa8ln
         oq/sIjPyzd3CjMQc16RzI88LoeLKNsHZjaRMHKFSE8lGFTQzUvmxjWufx2ANiuiMpOYB
         hq9Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=jhiaxflM;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrbpvtx3kqkgqerrwsfhi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRBPVTX3KQKGQERRWSFHI@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=jhiaxflM;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrbpvtx3kqkgqerrwsfhi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRBPVTX3KQKGQERRWSFHI@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1521457598; cv=pass;
        d=google.com; s=arc-20160816;
        b=1AR3R++HQRhpFbNB6mt51rxCAlzloXVTPfTVS/LDh8L5b8RYsFe54KrQ5rtxAHXmBs
         UhmYUcwZH/r97DZwOkfM/lVk2f4eTyQqpbF3SG/QC2Vf6HB778srdh7wLEypc2nZNdW0
         HqkJrR8M0FuZrYdOnHyj7Nn42H2ruQRdU5NZs/CPfsLHgBt4zv2gVih3VHCor5zYXDK+
         ZHSQrfTfi4WGnlDswjd4Irj8oTOQPJAtWJ1iyrmwBjItJSLwtWjvU9CSdeQKGXRkxDHI
         0qmlU3pyMuxRIQzxuVf0O4ivNDT4KkOxGl3uo82ZiO0xvpDC5Gsvcb+b476vZKWCxNQI
         A/Gw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=rO9dlhSUNOmpETETJzq+XqHs/OnjLORSSNpbrbuq7qw=;
        b=UFNtyG50NV+rRV3/2DW0EklN+8ERLhFB/1xOfal9Vm/k3An29r9dAvtJvQwr6GMYug
         vqhq+7T+XvBlJioqPEW39ISwvlN0d+NrMhsp2vOaaM/f31eAwSp2DmK4/jLsCld1nw5q
         4QEq07fjU+6qW9r/f0xDlKm9Hmwcorf9no8ze9S8O1pQqIlyx78TnT4tKGZM5OemXSIw
         /5WpFXFaimNmPnHJwFbKPj4aSNRz2T6K4Nk1kDMxGnz5WWSBT1mykbi7pD88g/EgkuM7
         AWylYl+s7J1uWgPFyzv+Wa9k/YvHSFRp8LNuDPRWvjHdcjc69VJ5uS20mPzh0DAMDt9x
         TcDw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELsZSv7tDB44Ln5AsejhDOWRyjfIgJMa5VxxBuQNLUINRXoNu4z7FBQTS4DGTPY7x89IPJ62oQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521457597; cv=none;
        d=google.com; s=arc-20160816;
        b=QCFWfkdLMiVSeOEZczyxUFJv2LnF22RXv6VNoTrQW0WzLO4sBORSLzYLvRiqu5k6Oz
         sUu6R7bBzIX9xvtuf3aiQkjsYEciRBFktufNUPej61iu0/NnPkt4ur1oB5rKxpehegEd
         EsurYREDcSiVX/ot2YanuJ5Fo8E3DKPM6oH0/mbeXdzx1YDW3rqtMtbsGmdO+W5dJgYj
         kyAqzpGvWWEpbgRa7tOclwH2PC/HvdZ+EigfaW9BhWcVWTzao4BoKcbEfAflPL2Gd8iz
         Obsk8O7JWIqVllU+IbPSj6+SU7Aiv8guVZSuSvB7NYdJBVbqH6W9l42sXYiTFBBXK6dm
         E6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=V3E5N+AmP6pfzusU54/PFC+v8NdoMmSFWOUiqch9PD4=;
        b=tq5Ddy+UIsfE1ew29x+9uKyTiT3PerVwyS3XIjuCNGNzFaLaIIJchAelseCB5djbH/
         u7b1wE+MZhENphmMdOsiPoHhnBrBfuS2bUHvn1jMOKwNaf1SF8LThOqJSR82HPrAlX6p
         dpm6CIrVOk0pWlaSscu/2mfuqdXlo3LEIpBGJ7fhHwx3ZFBAa4CtX1ahegAB56IN2L5r
         kXLliXfhcnqMEji8C60JfbLvCJEFk7Ly6cUKWAvXWBR1lI4EHFeWTwyxTT1No6m07hhi
         5dI6MoPAyujECcQXlBWuKzmLNjegyHy33SHoA18ouJDpbrrLo9DKOxuoIET4rcw3rIF3
         pulA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.48,330,1517871600";
   d="scan'208";a="318780748"
Date: Mon, 19 Mar 2018 12:06:31 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
    alexander.deucher@amd.com, David Airlie <airlied@linux.ie>,
    linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
    outreachy-kernel@googlegroups.com, Tomi Valkeinen <tomi.valkeinen@ti.com>,
    amd-gfx@lists.freedesktop.org
Subject: Re: [Outreachy kernel] Re: [PATCH] gpu: drm: Use list_first_entry
 instead of list_entry
In-Reply-To: <8b1e22f8-7a05-b66b-8825-7d4d97e46dac@amd.com>
Message-ID: <alpine.DEB.2.20.1803191204550.3392@hadrien>
References: <20180318215105.GA15431@seema-Inspiron-15-3567> <8b1e22f8-7a05-b66b-8825-7d4d97e46dac@amd.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-369822278-1521457591=:3392"
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
X-GMAIL-THRID: =?utf-8?q?1595313921234886794?=
X-GMAIL-MSGID: =?utf-8?q?1595363923249837575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-369822278-1521457591=:3392
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 19 Mar 2018, Christian K=C3=B6nig wrote:

> Mhm, actually that patch isn't correct. What we grab get here is the next
> entry, not the first one.
>
> We don't have an alias list_next_entry for list_first_entry?

As compared to the semantic patch I proposed earlier today, it would seem
that list_first_entry is useful when the types are different?  One would
have to check the result of course, but a list eleemnt with the same type
as the structure that contains the list might be unlikely?

julia

>
> Regards,
> Christian.
>
> Am 18.03.2018 um 22:51 schrieb Arushi Singhal:
> > This patch replaces list_entry with list_first_entry as it makes the
> > code more clear.
> > Done using coccinelle:
> >
> > @@
> > expression e;
> > @@
> > (
> > - list_entry(e->next,
> > + list_first_entry(e,
> >    ...)
> > |
> > - list_entry(e->prev,
> > + list_last_entry(e,
> >    ...)
> > )
> >
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 4 ++--
> >   drivers/gpu/drm/omapdrm/dss/display.c  | 4 ++--
> >   drivers/gpu/drm/radeon/radeon_sa.c     | 4 ++--
> >   3 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> > index 3144400..646f593 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> > @@ -158,7 +158,7 @@ static void amdgpu_sa_bo_try_free(struct
> > amdgpu_sa_manager *sa_manager)
> >   	if (sa_manager->hole->next =3D=3D &sa_manager->olist)
> >   		return;
> >   -	sa_bo =3D list_entry(sa_manager->hole->next, struct amdgpu_sa_bo,
> > olist);
> > +	sa_bo =3D list_first_entry(sa_manager->hole, struct amdgpu_sa_bo,
> > olist);
> >   	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist)=
 {
> >   		if (sa_bo->fence =3D=3D NULL ||
> >   		    !dma_fence_is_signaled(sa_bo->fence)) {
> > @@ -183,7 +183,7 @@ static inline unsigned amdgpu_sa_bo_hole_eoffset(st=
ruct
> > amdgpu_sa_manager *sa_ma
> >   	struct list_head *hole =3D sa_manager->hole;
> >     	if (hole->next !=3D &sa_manager->olist) {
> > -		return list_entry(hole->next, struct amdgpu_sa_bo,
> > olist)->soffset;
> > +		return list_first_entry(hole, struct amdgpu_sa_bo,
> > olist)->soffset;
> >   	}
> >   	return sa_manager->size;
> >   }
> > diff --git a/drivers/gpu/drm/omapdrm/dss/display.c
> > b/drivers/gpu/drm/omapdrm/dss/display.c
> > index 0c9480b..fb9ecae 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/display.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/display.c
> > @@ -158,8 +158,8 @@ struct omap_dss_device *omap_dss_get_next_device(st=
ruct
> > omap_dss_device *from)
> >   				goto out;
> >   			}
> >   -			dssdev =3D list_entry(l->next, struct omap_dss_device,
> > -					panel_list);
> > +			dssdev =3D list_first_entry(l, struct omap_dss_device,
> > +						  panel_list);
> >   			omap_dss_get_device(dssdev);
> >   			goto out;
> >   		}
> > diff --git a/drivers/gpu/drm/radeon/radeon_sa.c
> > b/drivers/gpu/drm/radeon/radeon_sa.c
> > index 197b157..66c0482 100644
> > --- a/drivers/gpu/drm/radeon/radeon_sa.c
> > +++ b/drivers/gpu/drm/radeon/radeon_sa.c
> > @@ -158,7 +158,7 @@ static void radeon_sa_bo_try_free(struct
> > radeon_sa_manager *sa_manager)
> >   	if (sa_manager->hole->next =3D=3D &sa_manager->olist)
> >   		return;
> >   -	sa_bo =3D list_entry(sa_manager->hole->next, struct radeon_sa_bo,
> > olist);
> > +	sa_bo =3D list_first_entry(sa_manager->hole, struct radeon_sa_bo,
> > olist);
> >   	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist)=
 {
> >   		if (sa_bo->fence =3D=3D NULL ||
> > !radeon_fence_signaled(sa_bo->fence)) {
> >   			return;
> > @@ -182,7 +182,7 @@ static inline unsigned radeon_sa_bo_hole_eoffset(st=
ruct
> > radeon_sa_manager *sa_ma
> >   	struct list_head *hole =3D sa_manager->hole;
> >     	if (hole->next !=3D &sa_manager->olist) {
> > -		return list_entry(hole->next, struct radeon_sa_bo,
> > olist)->soffset;
> > +		return list_first_entry(hole, struct radeon_sa_bo,
> > olist)->soffset;
> >   	}
> >   	return sa_manager->size;
> >   }
>
> --
> You received this message because you are subscribed to the Google Groups
> "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/outreachy-kernel/8b1e22f8-7a05-b66b-882=
5-7d4d97e46dac%40amd.com.
> For more options, visit https://groups.google.com/d/optout.
>

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/alpine.DEB.2.20.1803191204550.3392%40hadrien.
For more options, visit https://groups.google.com/d/optout.

--8323329-369822278-1521457591=:3392--
