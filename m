Return-Path: <jyknight@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522950430; cv=none;
        d=google.com; s=arc-20160816;
        b=ObR9KEog5pgvxzu1God+qDzGO3QSYvSQjmEg6djmeSWFHalITEoRLeIw4Qps/1Z5Pg
         R41dHT1zbiO3c1CkQXCcokUrSyX2kKuMRCzJjw3Xp1ab4W2t5La7B3sMbRP1pHqroez+
         wbPHmrL1w/0LHKEQet7y7wwCM4MCP5n96PDFqF8rjBFRGoKk8jiRIGTEArkl+D8Zh+t7
         +sd6Ut12YFMYS3v1f/lXsPk0We+590Z86c3kZRINL0TSm2MusqArUSEcjRFlGs4qFcw+
         bWwdhcO/rBKSleAjD4MGwz5gRu55ZKsDkZ7Jto80oKXE7IM/5Ufu1u/RznPbnE+3EhvO
         KU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=IOFN2zoSxvnLBHQ0TXk0DWL76gARNKETPNex8DMhSYM=;
        b=i2//aV68c9y1NzDUj3yeeZ8Tb5lLCx4HvM3oo58+iTWVQEZWR6nXNCaGkw1foMLKI2
         5wdyRlSsHLjXBE/hnQiHeg2ZZn+8UYu8SedW8ODMzxZ0lLkP2HB+Ap/E82DnMnP717x+
         p6Pwad0ieb+wmjbcyNQHA1ps+n0Y4EhHvHdVSMR5SEoQ19mD/k1Qd7NiE/StShUeClDV
         shmmDNfap7aXXxtREfKdIDYO1tuGek9kAgIYrJChKjVkNpszE9kYN9J9xngdMPE0RCE0
         SKQK2hB/v3JkJzuqvQ86+YRt2ZAEAlbnbtemB8uS4fR+KAyEIhJVeRgGj3Cl/A0cZT+9
         aYAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eZGGhPdk;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eZGGhPdk;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/kJgJ9d9Gc5Np1uc25XV7EkF63f/VCEfD6Vqy9vPKMpQMu0G/+9aK+W8f0mSARsMacSybk7k5xc4I8ZBr/2l4=
MIME-Version: 1.0
References: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com> <20180405072017.GN4043@hirez.programming.kicks-ass.net>
In-Reply-To: <20180405072017.GN4043@hirez.programming.kicks-ass.net>
From: James Y Knight <jyknight@google.com>
Date: Thu, 05 Apr 2018 17:46:58 +0000
Message-ID: <CAA2zVHraWtmmW1yFvVH+kUbih5wxiDLuM=wArnQanrWN9NF=Xw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Peter Zijlstra <peterz@infradead.org>
Cc: mka@chromium.org, Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de,
	Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>, gregkh@linuxfoundation.org
Content-Type: multipart/alternative; boundary="f4030435a3845f758305691d8763"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596929270754678035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--f4030435a3845f758305691d8763
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 5, 2018 at 3:20 AM Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 04, 2018 at 04:31:11PM -0700, Matthias Kaehlcke wrote:
>
> > From some experiments it looks like clang, in difference to gcc, does
> > not treat constant values passed as parameters to inline function as
> > constants.
>
> Then you're also missing a heap of optimizations in code like
> rb_erase_augmented() which is specifically constructed to take advantage
> of constant propagation like that.
>
> Other sites where we expect that to happen is __mutex_lock_common(),
> __update_load_sum() and a bunch of others. There isn't strictly a bug
> here, but not doing that constant propagation will still result in shit
> code gen.
>

I think maybe you're confused; those functions do not appear to use
__builtin_constant_p, which is the issue at hand. Clang's optimizer is of
course not a complete joke...it can perfectly well optimize functions after
inlining in order to not generate "shit code gen".

GCC, however, mixes up the concept of a C "constant expression" with the
results of running optimization passes such as inlining for its
definition/implementation of __builtin_constant_p. Clang does not, and
quite likely will not ever, do that.

That said, I do believe there are ongoing discussions as to how to best
provide a useful alternative which is less semantically strange, and not
too difficult for to conditionally adopt for a gcc/clang-compatible
codebase such as the kernel.

--f4030435a3845f758305691d8763
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Ap=
r 5, 2018 at 3:20 AM Peter Zijlstra &lt;<a href=3D"mailto:peterz@infradead.=
org">peterz@infradead.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">On Wed, Apr 04, 2018 at 04:31:11PM -0700, Matthias Kaehlcke wrote:<br=
>
<br>
&gt; From some experiments it looks like clang, in difference to gcc, does<=
br>
&gt; not treat constant values passed as parameters to inline function as<b=
r>
&gt; constants.<br>
<br>
Then you&#39;re also missing a heap of optimizations in code like<br>
rb_erase_augmented() which is specifically constructed to take advantage<br=
>
of constant propagation like that.<br>
<br>
Other sites where we expect that to happen is __mutex_lock_common(),<br>
__update_load_sum() and a bunch of others. There isn&#39;t strictly a bug<b=
r>
here, but not doing that constant propagation will still result in shit<br>
code gen.<br></blockquote><div><br></div><div>I think maybe you&#39;re conf=
used; those functions do not appear to use __builtin_constant_p, which is t=
he issue at hand. Clang&#39;s optimizer is of course not a complete joke...=
it can perfectly well optimize functions after inlining in order to not gen=
erate &quot;shit code gen&quot;.</div><div><br></div><div>GCC, however, mix=
es up the concept of a C &quot;constant expression&quot; with the results o=
f running optimization passes such as inlining for its definition/implement=
ation of __builtin_constant_p. Clang does not, and quite likely will not ev=
er, do that.</div><div><br></div><div>That said, I do believe there are ong=
oing discussions as to how to best provide a useful alternative which is le=
ss semantically strange, and not too difficult for to conditionally adopt f=
or a gcc/clang-compatible codebase such as the kernel.</div></div></div>

--f4030435a3845f758305691d8763--
