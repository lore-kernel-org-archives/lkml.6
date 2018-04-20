Return-Path: <nivedita@alum.mit.edu>
X-Google-Smtp-Source: AIpwx4+nI9wx0QG6rBZHp3+Y3BcjQ1WK8skwRdgjyl5CZcYPOP6kYC6XM1XJL8yv2sGoBDXn5thz
ARC-Seal: i=1; a=rsa-sha256; t=1524186771; cv=none;
        d=google.com; s=arc-20160816;
        b=ep0r1SZAEAxHFtzhB8BbQO/Oz0nTY9eGDBNPxGiFnKLvymsARnRz7l9+dTD15/K2fv
         89wRlBFQwLhgt8DE1Ujxju0+L40UguKn9RABIsINsHlOqAa2X1Oj4J+X3zU4sh2CWsZ+
         e7p2JWMlnPVJEq6ytlYyZnswQ/8xZ9fozcH8yzqNtxjvn9vSwL5G7zFjMdxcypMYgSDe
         X3l1UM82LFCjntVMLkdQNWOSj8zV6JY6zvl+Y25OF0M37S2Ha6p/XtzzJaL6fmj0NvEE
         1mm88OwE6IqmPeZ5OOLny9uArtsFiQOVt6tCKDIWvcmrbif6KdZ5GziQcRhz9QZ/O+M4
         X42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=NxwNEc3SdPHKY0OfprJVPc1vZt493g44CGck/0dgeI8=;
        b=d3XQCUjZy7jLGOjTEpqMyK+BbDsbEY816z4aUPZlTc6kyDiaFCRTmF3fsHCkRL+rQ/
         AkWn4TL0f6VWD6YwmUUP95882YcgGNp5z1BKb8976nBPgBz1Cfi9yPKQCdjrBtlx1aCZ
         X1Ws1alyQkRkG0WhVeNxoMCG07zncimMEC98YpElsceCK48BSXaY9Ge57AJ2nUjECMH+
         dCb+Ypq0bOaoGH4KfibboxGo7ALprgup90g969SKw0+lDO16maksqAi3fuencIKPJFwq
         0ATXRX/edQDQejuzrOC5/O8FACcejb7lAzJvFG1fghWiTMIG4fxF6Lt57AsO623DPMd4
         bBMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of nivedita@alum.mit.edu designates 18.7.68.19 as permitted sender) smtp.mailfrom=nivedita@alum.mit.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of nivedita@alum.mit.edu designates 18.7.68.19 as permitted sender) smtp.mailfrom=nivedita@alum.mit.edu
X-AuditID: 12074413-b6bff70000006608-0e-5ad93e8c9625
MIME-Version: 1.0
In-Reply-To: <20180209011728.GB5132@kernel.org>
References: <20180124003831.GA34667@rani.riverdale> <20180124205411.lpzcpqnuw3nlyg4n@treble>
 <20180125081652.GA23548@kernel.org> <20180209000009.GA54330@rani.riverdale> <20180209011728.GB5132@kernel.org>
From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Thu, 19 Apr 2018 21:12:42 -0400
X-Gmail-Original-Message-ID: <CAFU=Bqe60qW3ziN0x1zRziU3KzV1SMNhP12gCeeYfvcrz8gfng@mail.gmail.com>
Message-ID: <CAFU=Bqe60qW3ziN0x1zRziU3KzV1SMNhP12gCeeYfvcrz8gfng@mail.gmail.com>
Subject: Re: [PATCH] tools: libsubcmd: Drop the less hack that was inherited
 from Git.
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000926674056a3d62a4"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsUixO6iqDvZ7maUwZZHbBbNi9ezOTB67J+7
	hj2AMYrLJiU1J7MstUjfLoEr4+XMTywF3T4V8342MjcwrrfrYuTkkBAwkZjVuZCli5GLQ0hg
	B5PEjbvn2SCcV0wSB6ffg3KmM0qc6l/ICtFSLjFlwxUou0hi059JUHalxNJDU5hBbF4BQYmT
	M5+wgNhCAuESczq+gcU5BfQlGpt/MUMMPcsoseLIPyaQBJuAtsS1x1PZQGwWAVWJW88OM0EM
	TZRo6b7FBDE0QOLKnMdgQ4UFIiS+3p4HtlhEQE+iZ/pjVpChzAIvGCUuPf0BVsQs4CPRs3E2
	2wRG4VlIjpqFJAVha0q0bv/NDmFrSCy4s48RwtaWWLbwNfMCRtZVjHKJOaW5urmJmTnFqcm6
	xcmJeXmpRbrmermZJXqpKaWbGCFRIbyDcddJuUOMAhyMSjy8H9bdiBJiTSwrrsw9xCjJwaQk
	yntsMlCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG+C2c0oId6UxMqq1KJ8mJQ0B4uSOC+zyd4o
	IYH0xJLU7NTUgtQimKwMB4eSBO9sW6BGwaLU9NSKtMycEoQ0EwcnyHAeoOFvQGp4iwsSc4sz
	0yHypxjtOZY87e5h5liwZRKQPPR+CpA8ByKFWPLy81KlxHkvg7QJgLRllObBTYYlvFeM4kCP
	CvO6g1TxAJMl3OxXQGuZgNYaqNwAWVuSiJCSamA0u/E8rd7Narbzn7zs44LFJ24WRE4pe3O+
	8eOseiaH2EcVXNZvr4vE6M9WXrXBxC5sdfvh/rOsM/Zr5gV9a7v6xCMootTn4lb5G+47xKbf
	8Sh0eDr11Zrb7pGThJn613u6O8aseZNsJi9/piz27xqL55vulDdodwaV2D0Lskx1KNvwuXnt
	KR8lluKMREMt5qLiRAD77V9ZUwMAAA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590432180841544172?=
X-GMAIL-MSGID: =?utf-8?q?1598225668440980863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000926674056a3d62a4
Content-Type: text/plain; charset="UTF-8"

Hey did this ever make it in?

On Thu, Feb 8, 2018 at 8:17 PM, Arnaldo Carvalho de Melo <acme@kernel.org>
wrote:

> Em Thu, Feb 08, 2018 at 07:00:10PM -0500, Arvind Sankar escreveu:
> > We inherited this hack with the original code from the Git project. The
> > select call is invalid as the two fd_set pointers should not be aliased.
> >
> > We could fix it, but the Git project removed this hack in 2012 in commit
> > e8320f3 (pager: drop "wait for output to run less" hack). The bug it
> > worked around was apparently fixed in less back in June 2007.
> >
> > So remove the hack from here as well.
>
> Ok, so e8320f3 was merged directly by Linus, I'll wait till perf/urgent
> pulls from upstream and then will merge this,
>
> Thanks,
>
> - Arnaldo
>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  - Merge with commit ad343a98 (tools/lib/subcmd/pager.c: do not alias
> >    select() params) by Sergey
> >
> >  tools/lib/subcmd/pager.c       | 20 --------------------
> >  tools/lib/subcmd/run-command.c |  2 --
> >  tools/lib/subcmd/run-command.h |  1 -
> >  3 files changed, 23 deletions(-)
> >
> > diff --git a/tools/lib/subcmd/pager.c b/tools/lib/subcmd/pager.c
> > index 9997a8805a82..94d61d9b511f 100644
> > --- a/tools/lib/subcmd/pager.c
> > +++ b/tools/lib/subcmd/pager.c
> > @@ -1,5 +1,4 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include <sys/select.h>
> >  #include <stdlib.h>
> >  #include <stdio.h>
> >  #include <string.h>
> > @@ -23,24 +22,6 @@ void pager_init(const char *pager_env)
> >       subcmd_config.pager_env = pager_env;
> >  }
> >
> > -static void pager_preexec(void)
> > -{
> > -     /*
> > -      * Work around bug in "less" by not starting it until we
> > -      * have real input
> > -      */
> > -     fd_set in;
> > -     fd_set exception;
> > -
> > -     FD_ZERO(&in);
> > -     FD_ZERO(&exception);
> > -     FD_SET(0, &in);
> > -     FD_SET(0, &exception);
> > -     select(1, &in, NULL, &exception, NULL);
> > -
> > -     setenv("LESS", "FRSX", 0);
> > -}
> > -
> >  static const char *pager_argv[] = { "sh", "-c", NULL, NULL };
> >  static struct child_process pager_process;
> >
> > @@ -87,7 +68,6 @@ void setup_pager(void)
> >       pager_argv[2] = pager;
> >       pager_process.argv = pager_argv;
> >       pager_process.in = -1;
> > -     pager_process.preexec_cb = pager_preexec;
> >
> >       if (start_command(&pager_process))
> >               return;
> > diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-
> command.c
> > index 5cdac2162532..9e9dca717ed7 100644
> > --- a/tools/lib/subcmd/run-command.c
> > +++ b/tools/lib/subcmd/run-command.c
> > @@ -120,8 +120,6 @@ int start_command(struct child_process *cmd)
> >                                       unsetenv(*cmd->env);
> >                       }
> >               }
> > -             if (cmd->preexec_cb)
> > -                     cmd->preexec_cb();
> >               if (cmd->exec_cmd) {
> >                       execv_cmd(cmd->argv);
> >               } else {
> > diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-
> command.h
> > index 17d969c6add3..6256268802b5 100644
> > --- a/tools/lib/subcmd/run-command.h
> > +++ b/tools/lib/subcmd/run-command.h
> > @@ -46,7 +46,6 @@ struct child_process {
> >       unsigned no_stderr:1;
> >       unsigned exec_cmd:1; /* if this is to be external sub-command */
> >       unsigned stdout_to_stderr:1;
> > -     void (*preexec_cb)(void);
> >  };
> >
> >  int start_command(struct child_process *);
> > --
> > 2.13.6
>

--000000000000926674056a3d62a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey did this ever make it in?</div><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote">On Thu, Feb 8, 2018 at 8:17 PM, Arnaldo =
Carvalho de Melo <span dir=3D"ltr">&lt;<a href=3D"mailto:acme@kernel.org" t=
arget=3D"_blank">acme@kernel.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">Em Thu, Feb 08, 2018 at 07:00:10PM -0500, Ar=
vind Sankar escreveu:<br>
&gt; We inherited this hack with the original code from the Git project. Th=
e<br>
&gt; select call is invalid as the two fd_set pointers should not be aliase=
d.<br>
&gt; <br>
&gt; We could fix it, but the Git project removed this hack in 2012 in comm=
it<br>
&gt; e8320f3 (pager: drop &quot;wait for output to run less&quot; hack). Th=
e bug it<br>
&gt; worked around was apparently fixed in less back in June 2007.<br>
&gt; <br>
&gt; So remove the hack from here as well.<br>
<br>
</span>Ok, so e8320f3 was merged directly by Linus, I&#39;ll wait till perf=
/urgent<br>
pulls from upstream and then will merge this,<br>
<br>
Thanks,<br>
<br>
- Arnaldo<br>
<div class=3D"HOEnZb"><div class=3D"h5">=C2=A0<br>
&gt; Signed-off-by: Arvind Sankar &lt;<a href=3D"mailto:nivedita@alum.mit.e=
du">nivedita@alum.mit.edu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 - Merge with commit ad343a98 (tools/lib/subcmd/pager.c: do not a=
lias<br>
&gt;=C2=A0 =C2=A0 select() params) by Sergey<br>
&gt; <br>
&gt;=C2=A0 tools/lib/subcmd/pager.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 20 --------=
------------<br>
&gt;=C2=A0 tools/lib/subcmd/run-command.c |=C2=A0 2 --<br>
&gt;=C2=A0 tools/lib/subcmd/run-command.h |=C2=A0 1 -<br>
&gt;=C2=A0 3 files changed, 23 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tools/lib/subcmd/pager.c b/tools/lib/subcmd/pager.c<br>
&gt; index 9997a8805a82..94d61d9b511f 100644<br>
&gt; --- a/tools/lib/subcmd/pager.c<br>
&gt; +++ b/tools/lib/subcmd/pager.c<br>
&gt; @@ -1,5 +1,4 @@<br>
&gt;=C2=A0 // SPDX-License-Identifier: GPL-2.0<br>
&gt; -#include &lt;sys/select.h&gt;<br>
&gt;=C2=A0 #include &lt;stdlib.h&gt;<br>
&gt;=C2=A0 #include &lt;stdio.h&gt;<br>
&gt;=C2=A0 #include &lt;string.h&gt;<br>
&gt; @@ -23,24 +22,6 @@ void pager_init(const char *pager_env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0subcmd_config.pager_env =3D pager_env;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static void pager_preexec(void)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 * Work around bug in &quot;less&quot; by not sta=
rting it until we<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 * have real input<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0fd_set in;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0fd_set exception;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0FD_ZERO(&amp;in);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0FD_ZERO(&amp;exception);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0FD_SET(0, &amp;in);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0FD_SET(0, &amp;exception);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0select(1, &amp;in, NULL, &amp;exception, NULL);<b=
r>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0setenv(&quot;LESS&quot;, &quot;FRSX&quot;, 0);<br=
>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 static const char *pager_argv[] =3D { &quot;sh&quot;, &quot;-c&q=
uot;, NULL, NULL };<br>
&gt;=C2=A0 static struct child_process pager_process;<br>
&gt;=C2=A0 <br>
&gt; @@ -87,7 +68,6 @@ void setup_pager(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pager_argv[2] =3D pager;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pager_process.argv =3D pager_argv;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://pager_process.in" rel=3D"n=
oreferrer" target=3D"_blank">pager_process.in</a> =3D -1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0pager_process.preexec_cb =3D pager_preexec;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (start_command(&amp;pager_process)<wbr>)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; diff --git a/tools/lib/subcmd/run-<wbr>command.c b/tools/lib/subcmd/ru=
n-<wbr>command.c<br>
&gt; index 5cdac2162532..9e9dca717ed7 100644<br>
&gt; --- a/tools/lib/subcmd/run-<wbr>command.c<br>
&gt; +++ b/tools/lib/subcmd/run-<wbr>command.c<br>
&gt; @@ -120,8 +120,6 @@ int start_command(struct child_process *cmd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsete=
nv(*cmd-&gt;env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmd-&gt;preexec_c=
b)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cmd-&gt;preexec_cb();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmd-&gt;exec=
_cmd) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0execv_cmd(cmd-&gt;argv);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; diff --git a/tools/lib/subcmd/run-<wbr>command.h b/tools/lib/subcmd/ru=
n-<wbr>command.h<br>
&gt; index 17d969c6add3..6256268802b5 100644<br>
&gt; --- a/tools/lib/subcmd/run-<wbr>command.h<br>
&gt; +++ b/tools/lib/subcmd/run-<wbr>command.h<br>
&gt; @@ -46,7 +46,6 @@ struct child_process {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned no_stderr:1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned exec_cmd:1; /* if this is to be ext=
ernal sub-command */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned stdout_to_stderr:1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0void (*preexec_cb)(void);<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int start_command(struct child_process *);<br>
&gt; -- <br>
&gt; 2.13.6<br>
</div></div></blockquote></div><br></div>

--000000000000926674056a3d62a4--
