Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517565595; cv=none;
        d=google.com; s=arc-20160816;
        b=YcnRlQIhI0k+85Ed1HBDCiliMDhh8V7qCv/Zq29FdCmr5QaAafdlah+b7F4ln05t0d
         2A/0LRqEr23kqITdttP0YxGJIw7KPVDqQzCuTL5XmGTDBA7M7aecNza/s0ruglSk51YW
         s51jTcsHfnlQSvUkfYSBdY9kosXexEFIWl3VjBMYPqbXXcZCGxBdUZn1GSoQ0Y64Dsh5
         ZpteTQ4O62r8iYY2T112ylS4bZAbrWK8K4Gwd413Ri60gBO4JuSYa9dtWx4GwaBYJrBy
         6x19FycoO+FcpmSts2iSYErfGGbMerKonar86g7izUa+zgBZfAAN2H5mAe7RB1jIXKtQ
         e2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=lb6SuMHt1/rPTWAyAVCiFYKu+9iIS45/vWCkGr9PGFM=;
        b=Yc5KjeXI+uijjHuOSpe6IE1QoIt2jOltt1QaVW27IrOmBDOdoyvuszEwCkDyaNZvmn
         9ceUlbKJC0fbR+r1Rtwo5TegOMpSL2VnzBRtm4mhh9KQleQnTB3Nn/drphUQS7xo1dHm
         INou/4gaYddvUTOkyWmx1DjWhAfgecfjccvrgNGL92Ugpj6lVAxO0IDRPqDj0O5CD0jl
         vyplvRRc0KzB2NKz8m4zNnZvVWAhjQ75Wgty1jK5dcQ8kL+iV/57il4d/SKysAToBBAL
         KgWMT9ArDJNxcuUNNMWrJB0M0HYKrdA9WCrhFhF83000J2X7TA1B1TU578t/uJt2etFT
         LFoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M9SGxE/u;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M9SGxE/u;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227c2i/IJQyxhZkseuZTpH274N/A9a+YiKQ/KDyzP3thwTrllyyIu8WhKUZVjPUQ0zlc0GuiqM3f7/A3lmVWPFs=
MIME-Version: 1.0
References: <20180131152534.GA11909@kroah.com>
In-Reply-To: <20180131152534.GA11909@kroah.com>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Fri, 02 Feb 2018 09:59:44 +0000
Message-ID: <CALpmF+EeckyWMNLd4wp466xwFgYKWAwnpca+rdkNrU+1cp-EUA@mail.gmail.com>
Subject: Re: Linux 3.18.93
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>,
	linux-kernel@vger.kernel.org, lwn@lwn.net, stable@vger.kernel.org,
	torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="089e08e5683d3407f3056437c6fc"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591282861834124289?=
X-GMAIL-MSGID: =?utf-8?q?1591282861834124289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--089e08e5683d3407f3056437c6fc
Content-Type: text/plain; charset="UTF-8"

On Wed 31 Jan, 2018, 8:56 PM Greg KH, <gregkh@linuxfoundation.org> wrote:

> I'm announcing the release of the 3.18.93 kernel.
>
> All users of the 3.18 kernel series must upgrade.
>
> The updated 3.18.y git tree can be found at:
>         git://
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> linux-3.18.y
> and can be browsed at the normal kernel.org git web browser:
>
> http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
>
> thanks,
>
> greg k-h
>

Better late than never: no regressions noticed on OnePlhs 3 over the past
two days.

>

--089e08e5683d3407f3056437c6fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed 31 Jan, 2018, 8:=
56 PM Greg KH, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh@lin=
uxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I&#=
39;m announcing the release of the 3.18.93 kernel.<br>
<br>
All users of the 3.18 kernel series must upgrade.<br>
<br>
The updated 3.18.y git tree can be found at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/stable/linux-stable.git" rel=3D"noreferrer" target=3D"_bla=
nk">git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git</a> lin=
ux-3.18.y<br>
and can be browsed at the normal <a href=3D"http://kernel.org" rel=3D"noref=
errer" target=3D"_blank">kernel.org</a> git web browser:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://git.kernel.org/?p=3Dlinux/ker=
nel/git/stable/linux-stable.git;a=3Dsummary" rel=3D"noreferrer" target=3D"_=
blank">http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;=
a=3Dsummary</a><br>
<br>
thanks,<br>
<br>
greg k-h<br></blockquote></div><div><br></div><div>Better late than never: =
no regressions noticed on OnePlhs 3 over the past two days.</div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div>

--089e08e5683d3407f3056437c6fc--
