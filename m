Return-Path: <kernel-hardening-return-12324-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu8riYgEoX+F7w7lD+nQbFqriw3kkQLfC5/WBnUbgWuIJjH1zDSES5YDUglFNBsOx3ICY+T
ARC-Seal: i=1; a=rsa-sha256; t=1520603399; cv=none;
        d=google.com; s=arc-20160816;
        b=Qwn/IYv9yDj2Hrk11JYj+0JIZJpyFjHOrsXsECtVK9kvtyOffx2PC66dxXTZjIem6D
         2faRFQRijJOT09zBtNVwUZ1CUYHs22wkxlG/hpDmDykjg7dZjjMahu5f5gGS365fKWY9
         L8RZqKbKWA8+ZQ8R3sILWDY8/Pkk6s6S+08JZkAdjTnJOO6Nl6b0Q7X/r7cRVJLYkj/4
         mMBIybQzWA+PggZnx3+nhkrJBUSVc+upC4dZWbTR84Ueqiv9z7lyG9TsPuwDWEUDBadH
         KbxEbtfEHrfIHPsGEyEXDqNWir4cQLyigJVWorIATClrQIEL+XOpU4UqKHTl23gpN4e1
         iFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=uYXpkzbztsjfHi+U4PJ5Yy6/0C9S809pbkG6pawIA1Q=;
        b=nat+H66nUtVifz7r9edGvuMqvwhiaIuB/vC5iKhcU/xZk1yzhER10n3sRFccqdM3uK
         +Lsjtksh2bkViiB4036pASXtSkFlMQCbv7bFB+oMy+QyGV1Som7KGV+acBpzzO/eMa6Y
         /pqOQuK3P+InM5PJzdDWlamzEWnSs96Z23tHu9F6G78JKiGkEu5MQK80MyHEdPjrWUXi
         oHz2qq7AtKE9tBNUWDw4nkS7cIZ967FA4u4h7CDzej+7iCf+PEjhIzSPARCvNhr3z/ij
         liWjPJ9X2TVmChRmCPNZKEVXv5fIgFineADMW3U0WYiZ6jIryzgd83Dw3nTCfi/qZiHJ
         AfXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D86jBEeN;
       spf=pass (google.com: domain of kernel-hardening-return-12324-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12324-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D86jBEeN;
       spf=pass (google.com: domain of kernel-hardening-return-12324-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12324-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180309130220.is5i4qu3fdcmyngq@gauss3.secunet.de>
References: <1520598106-3271-1-git-send-email-andreaschristofo@gmail.com>
 <CA+rthh9g3gcgTt8jbcRrVUK=Lagnz8HWJJLERwSbMi++3VqS1A@mail.gmail.com> <20180309130220.is5i4qu3fdcmyngq@gauss3.secunet.de>
From: Andreas Christoforou <andreaschristofo@gmail.com>
Date: Fri, 9 Mar 2018 15:49:40 +0200
Message-ID: <CAEY5He5=0M8rVpDecKp=wHxPHWWdQEcamBubmWReF2VwnHmKJQ@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: xfrm6_state: remove VLA usage
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Mathias Krause <minipli@googlemail.com>, Kees Cook <keescook@chromium.org>,
	kernel-hardening@lists.openwall.com, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c0d99086065f70566fb108f"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463771060382720?=
X-GMAIL-MSGID: =?utf-8?q?1594468229937344473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c0d99086065f70566fb108f
Content-Type: text/plain; charset="UTF-8"

Right, thank you for your feedback I will create a new patch.

Kind Regards,
Andreas Christoforou

On Mar 9, 2018 15:02, "Steffen Klassert" <steffen.klassert@secunet.com>
wrote:

On Fri, Mar 09, 2018 at 01:49:07PM +0100, Mathias Krause wrote:
> On 9 March 2018 at 13:21, Andreas Christoforou
> <andreaschristofo@gmail.com> wrote:
> > The kernel would like to have all stack VLA usage removed[1].
> >
> > Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
> > ---
> >  net/ipv6/xfrm6_state.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
> > index b15075a..45c0d98 100644
> > --- a/net/ipv6/xfrm6_state.c
> > +++ b/net/ipv6/xfrm6_state.c
> > @@ -62,7 +62,12 @@ __xfrm6_sort(void **dst, void **src, int n, int
(*cmp)(void *p), int maxclass)
> >  {
> >         int i;
> >         int class[XFRM_MAX_DEPTH];
> > -       int count[maxclass];
> > +       int *count;
> > +
> > +       count = kcalloc(maxclass + 1, sizeof(*count), GFP_KERNEL);
> > +
> > +       if (!count)
> > +               return -ENOMEM;
> >
> >         memset(count, 0, sizeof(count));
> >
> > @@ -80,6 +85,7 @@ __xfrm6_sort(void **dst, void **src, int n, int
(*cmp)(void *p), int maxclass)
> >                 src[i] = NULL;
> >         }
> >
> > +       kfree(count);
> >         return 0;
> >  }
>
> Instead of dynamically allocating and freeing memory here, shouldn't
> we just get rid of the maxclass parameter and use XFRM_MAX_DEPTH as
> size for the count[] array, too?

Right, that's the way to go. Aside from that, allocating
with GFP_KERNEL is definitely wrong here.

--94eb2c0d99086065f70566fb108f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Right, thank you for your feedback I will create a n=
ew patch.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Kind Regards,<=
/div><div dir=3D"auto">Andreas Christoforou</div><div dir=3D"auto"><div cla=
ss=3D"gmail_extra" dir=3D"auto"><br><div class=3D"gmail_quote">On Mar 9, 20=
18 15:02, &quot;Steffen Klassert&quot; &lt;<a href=3D"mailto:steffen.klasse=
rt@secunet.com">steffen.klassert@secunet.com</a>&gt; wrote:<br type=3D"attr=
ibution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div class=3D"elided-text">On Fri, Mar 09=
, 2018 at 01:49:07PM +0100, Mathias Krause wrote:<br>
&gt; On 9 March 2018 at 13:21, Andreas Christoforou<br>
&gt; &lt;<a href=3D"mailto:andreaschristofo@gmail.com">andreaschristofo@gma=
il.com</a>&gt; wrote:<br>
&gt; &gt; The kernel would like to have all stack VLA usage removed[1].<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Andreas Christoforou &lt;<a href=3D"mailto:andreas=
christofo@gmail.com">andreaschristofo@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 net/ipv6/xfrm6_state.c | 8 +++++++-<br>
&gt; &gt;=C2=A0 1 file changed, 7 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c<br>
&gt; &gt; index b15075a..45c0d98 100644<br>
&gt; &gt; --- a/net/ipv6/xfrm6_state.c<br>
&gt; &gt; +++ b/net/ipv6/xfrm6_state.c<br>
&gt; &gt; @@ -62,7 +62,12 @@ __xfrm6_sort(void **dst, void **src, int n, in=
t (*cmp)(void *p), int maxclass)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int class[XFRM_MAX_DEPTH];<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int count[maxclass];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int *count;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D kcalloc(maxclass + 1, sizeo=
f(*count), GFP_KERNEL);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!count)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
NOMEM;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(count, 0, sizeof(count));=
<br>
&gt; &gt;<br>
&gt; &gt; @@ -80,6 +85,7 @@ __xfrm6_sort(void **dst, void **src, int n, int=
 (*cmp)(void *p), int maxclass)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src[=
i] =3D NULL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(count);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 }<br>
&gt;<br>
&gt; Instead of dynamically allocating and freeing memory here, shouldn&#39=
;t<br>
&gt; we just get rid of the maxclass parameter and use XFRM_MAX_DEPTH as<br=
>
&gt; size for the count[] array, too?<br>
<br>
</div>Right, that&#39;s the way to go. Aside from that, allocating<br>
with GFP_KERNEL is definitely wrong here.<br>
<br>
</blockquote></div><br></div></div></div>

--94eb2c0d99086065f70566fb108f--
