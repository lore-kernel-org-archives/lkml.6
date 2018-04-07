Return-Path: <paulmcquad@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523133483; cv=none;
        d=google.com; s=arc-20160816;
        b=hvMiTFBI8AxXtTBzN/OXnl8G+LzEO8JhkFgkyq86cqGpC8LAES/gHVwty8hrMKQ8L3
         vLgIwkJOh9x2Hznn4mvY1Mnf3QzCSRd7d8OIsMzxFF6D1m7pFCqm1qg9Eu92+JT8z1gB
         YD58IzGEv1YPe4mfSbGG2u3n+TzP42lXWt9EtJra3MlGJqQIjZAGqbWOD12TdgNXSaT4
         bNm5ihJA2LMBatyj2EbrnuygS7tlHBso0ysEdrYWtD3nxwh7gPGkiJaO+mXgi77Zx1pS
         yaKdXL7ZmDFXgHFSYx5ncHFZa69SmRuoHWAiQGSyCapU7onHTAI0UB7ycuy31fjJ0PIk
         nx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=uALF3W8Kktf30mwjT+uuyfJsJ13HDU8HLfRUoJWzDp4=;
        b=I1/QvUCFBV1j7OYPmJEgYKewL1wIpE6+IN7UxwOalxg/CmE7OqCkad3rg4N6eqmjiB
         f6j2LDMVIaxTy50+OdyecJuoJ1lc8+FPeugrJJchTagE86bSiWwFXqQ3bA0KYdMC/Nlo
         ko32+XOlXbjPzsT0gSwHA39ekeFqJ4+cZwrTa9hd5onkmZLDsyfQUrX8mp4TI52jiEYA
         x4tZbY+0v/7FQHdFafJOoQsY1X5s+mk51TCetL2GOo9OQKSzJCe3ZwAmHzgosrIME6Su
         WEdoa7rX6Rosksuk1s7Ljma2XokMZi4J3szFd8be6r6GuZKiKf/OrpcINe0BjNmyXk7r
         BUsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e4Rkozig;
       spf=pass (google.com: domain of paulmcquad@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=paulmcquad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e4Rkozig;
       spf=pass (google.com: domain of paulmcquad@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=paulmcquad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49U22NfOFyXFiC6r8Z4dcQysiA0j9AKicrJESWvLH8m8B6+dZT0ILBW+3HW8zj8jpvQSuc3ymqJgWGxqpZSSDs=
MIME-Version: 1.0
References: <20180407184726.8634-1-paulmcquad@gmail.com> <03c43ed43d0ec3ab42940bfffd4c3778bf5d0f11.camel@perches.com>
In-Reply-To: <03c43ed43d0ec3ab42940bfffd4c3778bf5d0f11.camel@perches.com>
From: Paul Mc Quade <paulmcquad@gmail.com>
Date: Sat, 07 Apr 2018 20:37:52 +0000
Message-ID: <CAKi5BqYCaxsuuOQtfXqyd+ddf=8ggLB89HQ5TWky6JOq_xxOKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: replace S_IRUGO with 0444
To: Joe Perches <joe@perches.com>
Cc: konrad.wilk@oracle.com, labbott@redhat.com, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, guptap@codeaurora.org, vbabka@suse.cz,
	mgorman@techsingularity.net, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rppt@linux.vnet.ibm.com, dave@stgolabs.net,
	hmclauchlan@fb.com, tglx@linutronix.de, pombredanne@nexb.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/alternative; boundary="00000000000033db28056948262b"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597114285663933591?=
X-GMAIL-MSGID: =?utf-8?q?1597121216048029755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--00000000000033db28056948262b
Content-Type: text/plain; charset="UTF-8"

Cool, thanks! I didn't know that.

On Sat 7 Apr 2018, 21:11 Joe Perches <joe@perches.com> wrote:

> On Sat, 2018-04-07 at 19:47 +0100, Paul McQuade wrote:
> > Fix checkpatch warnings about S_IRUGO being less readable than
> > providing the permissions octal as '0444'.
>
> Hey Paul.
>
> I sent a cleanup a couple weeks ago to Andrew Morton for the
> same thing.
>
> https://lkml.org/lkml/2018/3/26/638
>
> Andrew said he'd wait until after -rc1 is out.
>
> btw: checkpatch can do this substitution automatically
>
> cheers, Joe
>

--00000000000033db28056948262b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Cool, thanks! I didn&#39;t know that.=C2=A0</div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr">On Sat 7 Apr 2018, 21:11 Joe Perche=
s &lt;<a href=3D"mailto:joe@perches.com">joe@perches.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On Sat, 2018-04-07 at 19:47 +0100, Pau=
l McQuade wrote:<br>
&gt; Fix checkpatch warnings about S_IRUGO being less readable than<br>
&gt; providing the permissions octal as &#39;0444&#39;.<br>
<br>
Hey Paul.<br>
<br>
I sent a cleanup a couple weeks ago to Andrew Morton for the<br>
same thing.<br>
<br>
<a href=3D"https://lkml.org/lkml/2018/3/26/638" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://lkml.org/lkml/2018/3/26/638</a><br>
<br>
Andrew said he&#39;d wait until after -rc1 is out.<br>
<br>
btw: checkpatch can do this substitution automatically<br>
<br>
cheers, Joe<br>
</blockquote></div>

--00000000000033db28056948262b--
