Return-Path: <kkamagui@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520338326; cv=none;
        d=google.com; s=arc-20160816;
        b=aOIX7E/2SJH9RACpYa1bMvQDjfA7nJ5ne+/n5BeafQNq101wz9+kK2xN/M9r21u84j
         S1C5gPAhil4Smp4IXfumeddvn0qRxg4DF/EiGwDGDC+EJ+/laMEc1e62xpFRpSuf0R+X
         yKORpW3mYuhO40UR01m8Mazr/u0bBK5S2usX8u9mECFbFQTY4nHqqwn+/8Z59B9I6gu5
         Z3RNjRTqe9wBnX3RDtg6EcOk+H6L0gY23XZ0Eoe2IaqGUcFLSss6VithBU5jyHfvqSjN
         4EmLMJ6eReNyGc5ep8L10YyUV0boLngHNK5EPNKrD/JWI+ZxcPlhdvhspRem37Ueu2Cj
         wP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=kuTrhdhJ8FxDPV8/wyEDg/U+GAJwVigX0JCMfhBHjUE=;
        b=McsMKWYPiYXS8Z5lhLsna8FtqgtL/dLrRruo5lHXePPUyPCuUz4pXlQ4tvVkj8uUyK
         CuatIJ7NbGzx+dHNKfv4Not4/yE7BIisy2Dsovz6BRsJL2MR6AdRHIN6x+e7icQYdozZ
         TBq4RNhr13mGmouITf9eXeUNKEEDaeoNXhmIX3jynDSHBlPwh17JUBT0GdNUcHOqswAc
         ektIiuFJwIha107fDiBt9bw508+OrOP4caf73mj7w4rXYSxVHIGesyhh2AQDPkg4qnMU
         Zp0i1iDsIcdp1mt5pRN93BfZnxBZad6I55Dow5u3oKxJK5b2LoEHjyMIhauMYxDcH0IR
         LP/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=i0EnutIo;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=i0EnutIo;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtO7LNd6vIjYKN04iqHjcHx3SuSVWtVn+fNKR/1xxy4eQqmEDtfVdg/Syuu2akx4qC6UwQr/wurqLkHJzM22rY=
MIME-Version: 1.0
In-Reply-To: <20180306114612.GA16784@kroah.com>
References: <20180302202706.9434-1-kkamagui@gmail.com> <20180306104320.GB11535@pd.tnic>
 <20180306105748.GA31087@kroah.com> <20180306110207.GC11535@pd.tnic> <20180306114612.GA16784@kroah.com>
From: Seunghun Han <kkamagui@gmail.com>
Date: Tue, 6 Mar 2018 21:12:05 +0900
Message-ID: <CAHjaAcRyY8=qSzV+xP9qniVN4c+EOrnwNJAZJE-v0uQrduQRkw@mail.gmail.com>
Subject: Re: [PATCH V3] x86: mce: fix kernel panic when check_interval is changed
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000da34bd0566bd5962"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1594190280860693798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000da34bd0566bd5962
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wow! Thank you Borislav and Greg.

2018. 3. 6. =EC=98=A4=ED=9B=84 8:46=EC=97=90 "Greg Kroah-Hartman" <gregkh@l=
inuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Tue, Mar 06, 2018 at 12:02:08PM +0100, Borislav Petkov wrote:
> > On Tue, Mar 06, 2018 at 02:57:48AM -0800, Greg Kroah-Hartman wrote:
> > > It would have been nice to add a cc:stable for this, but I'll try to
> > > watch it and when it hits Linus's tree I'll queue it up there.
> >
> > I can still add it - it is the top patch and I haven't sent it yet.
> >
> > /me goes and adds it.
> >
> > Voila!
> >
> > :-)
>
> Wonderful, thanks for doing that.
>

--000000000000da34bd0566bd5962
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Wow! Thank you Borislav and Greg.</div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">2018. 3. 6. =EC=98=A4=ED=9B=84 8:46=
=EC=97=90 &quot;Greg Kroah-Hartman&quot; &lt;<a href=3D"mailto:gregkh@linux=
foundation.org">gregkh@linuxfoundation.org</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=
=91=EC=84=B1:<br type=3D"attribution"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue=
, Mar 06, 2018 at 12:02:08PM +0100, Borislav Petkov wrote:<br>
&gt; On Tue, Mar 06, 2018 at 02:57:48AM -0800, Greg Kroah-Hartman wrote:<br=
>
&gt; &gt; It would have been nice to add a cc:stable for this, but I&#39;ll=
 try to<br>
&gt; &gt; watch it and when it hits Linus&#39;s tree I&#39;ll queue it up t=
here.<br>
&gt;<br>
&gt; I can still add it - it is the top patch and I haven&#39;t sent it yet=
.<br>
&gt;<br>
&gt; /me goes and adds it.<br>
&gt;<br>
&gt; Voila!<br>
&gt;<br>
&gt; :-)<br>
<br>
Wonderful, thanks for doing that.<br>
</blockquote></div></div>

--000000000000da34bd0566bd5962--
