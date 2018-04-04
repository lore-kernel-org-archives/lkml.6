Return-Path: <ndesaulniers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522864010; cv=none;
        d=google.com; s=arc-20160816;
        b=IlKKL0dK7Aje/xz+u+I/ivqzX1skorjjKYh/cmPKYH+y5ATLWWYzYQwYqxMTI1g3MB
         lJ/CdgD2OakxVnIw4GjN9cGCOvrflbA9lrw9e5H1u01N0KQZqD/LQJLcXdJIOjtgfpha
         LF2bKnYk8OkFYIIvD5QAH/aQeDDbrU+ea+jI4hDHdCC58hpm6mxd8hZqkRGJ9DJHzKFb
         DW2ss+gT9sEq4NzC9rGPartvuACWKXo71ATwFABu7NXol3pXYywg5vUYTo8gWMwUk7du
         fxz7CNzjkcjVLXXOTb3HGsJ18V/WhyQjMXJcMMMPRlGirg9WJT5ddzHM6ds38nMYhWVf
         YoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Qd6FzUmqRfQzffHTNK7JPa9iEIO1gs6tTkqehpvxYJg=;
        b=F/W5l2yVbpWiJgxN1MdlpFAPN7WHF75Ezr+PQKzZFGmxRtiQ/OJrv4uWGCYcoTNQm5
         TRACxh//AxMZBWLLRiabeKwgeY61GgfgWnK2oYWYohcvGFAYZBfATnm09gzDiHHBIaV+
         UfEEsZU8EehcvvPnDkj/m2iLwry6jES/aTiHXS2A4kkmzgg8wTbxKbb7TsWJqSG9i9Y1
         so/DQAGb8I+Pjd2LFxI7pDM8RGnunFufnElO3GKV/u/Is6SdbK4fcdvt7CFoxwB/4X4G
         DI+ShiRbr5pDmwmFhoSzhTyYtlnJgko0ylWicMdHKh7meXqgKjsJQefzMxb2yXGumGE2
         Qbhg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HAyRkGBc;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HAyRkGBc;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49E4enkygr/ujTBv9H0nO4UBcX+pLiFAC4eUPg8r/8GcN7Iag6MOIP3jrDC61oNy4/pvUurqe1vlLg43gHdWcI=
MIME-Version: 1.0
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com> <CAKwvOdkjB2LGXGn-9chPDtGyVmw9JF1FZ1ZBjSKEtK7BqbwF2g@mail.gmail.com>
 <CA+55aFyZA5t-+OyzSDDPGjDoaKsh=Erz8zuoEdDo7hOCBU6ZfQ@mail.gmail.com>
In-Reply-To: <CA+55aFyZA5t-+OyzSDDPGjDoaKsh=Erz8zuoEdDo7hOCBU6ZfQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 04 Apr 2018 17:46:38 +0000
Message-ID: <CAKwvOdkWfawHQNiUYrOemGe3td8JvkxryUYoX5ryYRPa0QF=4g@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>,
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>, Stephen Hines <srhines@google.com>,
	Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>
Content-Type: multipart/alternative; boundary="0000000000005cef0c05690968cb"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596838653077084946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--0000000000005cef0c05690968cb
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 4, 2018 at 10:13 AM Linus Torvalds <
torvalds@linux-foundation.org> wrote:

> On Wed, Apr 4, 2018 at 9:49 AM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > It's definitely something curious that I'll need to sit down and
> investigate
> > more.  If there are other known instances, it would be good to let me
> know.
>

> The one I'm actually upset about is when a compiler goes even
> *further* and does things that are NOT EVEN allowed by the paper
> standard, much less by real code.
>
> The fact that clang by default enables "-fmerge-all-constants"
> behavior is just inexcusable. That's not just "let's do invalid
> optimizations based on undefined behavior". That's an actual "let's do
> known invalid optimizations that are explicitly disallowed even by the
> standard".
>

The LLVM developers are in agreement here:
https://bugs.llvm.org/show_bug.cgi?id=18538#c16
-- 
Thanks,
~Nick Desaulniers

--0000000000005cef0c05690968cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Apr 4,=
 2018 at 10:13 AM Linus Torvalds &lt;<a href=3D"mailto:torvalds@linux-found=
ation.org">torvalds@linux-foundation.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Wed, Apr 4, 2018 at 9:49 AM, Nic=
k Desaulniers<br>
&lt;<a href=3D"mailto:ndesaulniers@google.com" target=3D"_blank">ndesaulnie=
rs@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt; It&#39;s definitely something curious that I&#39;ll need to sit down a=
nd investigate<br>
&gt; more.=C2=A0 If there are other known instances, it would be good to le=
t me know.<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
The one I&#39;m actually upset about is when a compiler goes even<br>
*further* and does things that are NOT EVEN allowed by the paper<br>
standard, much less by real code.<br>
<br>
The fact that clang by default enables &quot;-fmerge-all-constants&quot;<br=
>
behavior is just inexcusable. That&#39;s not just &quot;let&#39;s do invali=
d<br>
optimizations based on undefined behavior&quot;. That&#39;s an actual &quot=
;let&#39;s do<br>
known invalid optimizations that are explicitly disallowed even by the<br>
standard&quot;.<br></blockquote><div><br></div><div>The LLVM developers are=
 in agreement here:</div><div><a href=3D"https://bugs.llvm.org/show_bug.cgi=
?id=3D18538#c16">https://bugs.llvm.org/show_bug.cgi?id=3D18538#c16</a></div=
></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">T=
hanks,<div>~Nick Desaulniers</div></div></div></div>

--0000000000005cef0c05690968cb--
