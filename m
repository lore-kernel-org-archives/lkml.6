Return-Path: <drdeimosnn@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524784765; cv=none;
        d=google.com; s=arc-20160816;
        b=EfH5D8BPiqh0GQ7aIioYKs77v41Fhxo8BRdMzpJ7S8uHWFMAos7/lHJHamJRWekscU
         JtuiZuHlc/AcQneA1+kCmvxi/5FKnWvk5fV4+yAaXodRnsBtfePMsdXIXyDhGPWqpcek
         AwCBmE5QTK0VxL3MINAYavvAi5H8Nd/j/C8/XKMIWMaTYfp2RCi5NsjPS9M/HFqCRn44
         LdUFVUH5lqCxYWgptm7BSSySopHOd/jzccMiCB7snDf+29HG0eRZUtXr9NAK7WrzImcK
         5deekW7sffWIwPImJ3IiUsnNIoch1/FBaLNhpq3GPtANdNGoCePgsUMzEG6nZ25R6Etg
         qXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eitbJ2k/FvrM2cl9AOdfPIpX/1x4jmBpe6kSnLHA0/k=;
        b=0mS+GnDvfHaeGsJLteRxs8NntfadCYRxZtYA/ZpAiYntrehwWRIoF26+UTBXdSM9zH
         4gnue4XTc+okAjxRxXq413zl8XY+qKlhnGFZBA/jz31c3ymQcm6z5wPLW66IKRo6c5g3
         9pPNLor5+GPPpQ+U5EEA5qSkKe8tucMdFjG7Cb4vrpicR5sebU8X+jaj54aK3TOa4vt6
         icq0VMskaj9SVwry99RLOXvJlVjN8B0A3ll8FyO7xK0dou6JUNIhiesLFwOKEBi7jK6i
         nYrV4GzMiKhSHxCdP1tn9vh6dux6NotOfpeAWCWlOjxC1+SsXlKixbEE6O1Fm6ORJohy
         YfmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NWn1O6I4;
       spf=pass (google.com: domain of drdeimosnn@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=drdeimosnn@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NWn1O6I4;
       spf=pass (google.com: domain of drdeimosnn@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=drdeimosnn@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZovpAwfimIpq6XPl6VX8U0TgIWiqhc3ueMIGNvgYxJMpXW/Lrx6Cx2OmaGHwvvmjqM0wE0/H1CeNLZK2OCxfV4=
MIME-Version: 1.0
In-Reply-To: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
References: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
From: =?UTF-8?B?0JzQuNGF0LDQuNC7INCd0L7RgdC+0LI=?= <drdeimosnn@gmail.com>
Date: Fri, 27 Apr 2018 02:19:24 +0300
Message-ID: <CA+MChEqqReWRVDELTqzOQe73sv_bCVtk5TQ9n=FqYjJwndDN7w@mail.gmail.com>
Subject: Re: stable 4.16.5 hmm build error
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: multipart/alternative; boundary="00000000000043906f056ac89e90"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598847241183995427?=
X-GMAIL-MSGID: =?utf-8?q?1598852709851166169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--00000000000043906f056ac89e90
Content-Type: text/plain; charset="UTF-8"

Oh. Yes. Tag v4.16.5 without commit
9d8a463a7016e9e5578a561588a18acef139919c.
It's in v4.17-rc1/2.
Thank you.

2018-04-27 0:52 GMT+03:00 Randy Dunlap <rdunlap@infradead.org>:

> https://bugzilla.kernel.org/show_bug.cgi?id=199515
>
> kernel/fork.o: In function `__mmdrop':
> /kernel/build_kernel/linux-4.16.4/kernel/fork.c:600: undefined reference
> to `hmm_mm_destroy'
>
> "It is also reproduced in linux-4.16.5"
>
>
> There have been a few attempts to fix this build error.  The kernel
> mainline
> repo seems to have it fixed, but it looks to me like Arnd's latest patch
> (9d8a463a7016e: "mm/hmm: fix header file if/else/endif maze, again")
> was mis-merged to 4.16.5 stable.
>
> Please take a look.  Do you already have a fixup for this?
>
> thanks,
> --
> ~Randy
>

--00000000000043906f056ac89e90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Oh. Yes. Tag=C2=A0v4.16.5 without commit 9d8a463a7016e9e55=
78a561588a18acef139919c.<br>It&#39;s in=C2=A0v4.17-rc1/2.=C2=A0<br>Thank yo=
u.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2018-04-2=
7 0:52 GMT+03:00 Randy Dunlap <span dir=3D"ltr">&lt;<a href=3D"mailto:rdunl=
ap@infradead.org" target=3D"_blank">rdunlap@infradead.org</a>&gt;</span>:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><a href=3D"https://bugzilla.kernel.org/sho=
w_bug.cgi?id=3D199515" rel=3D"noreferrer" target=3D"_blank">https://bugzill=
a.kernel.org/<wbr>show_bug.cgi?id=3D199515</a><br>
<br>
kernel/fork.o: In function `__mmdrop&#39;:<br>
/kernel/build_kernel/linux-4.<wbr>16.4/kernel/fork.c:600: undefined referen=
ce to `hmm_mm_destroy&#39;<br>
<br>
&quot;It is also reproduced in linux-4.16.5&quot;<br>
<br>
<br>
There have been a few attempts to fix this build error.=C2=A0 The kernel ma=
inline<br>
repo seems to have it fixed, but it looks to me like Arnd&#39;s latest patc=
h<br>
(9d8a463a7016e: &quot;mm/hmm: fix header file if/else/endif maze, again&quo=
t;)<br>
was mis-merged to 4.16.5 stable.<br>
<br>
Please take a look.=C2=A0 Do you already have a fixup for this?<br>
<br>
thanks,<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
~Randy<br>
</font></span></blockquote></div><br></div>

--00000000000043906f056ac89e90--
