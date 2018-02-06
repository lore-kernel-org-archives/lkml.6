Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517917346; cv=none;
        d=google.com; s=arc-20160816;
        b=PIH2u8l1fNQjeCHGNl23S6UNvQjqAX8gbZVTxIyDgE+1nflXAQyJvEH2O51O+wM7JR
         b2+HZje1n7qcaIp63bYJphn70ZJT88imdvtJwjOL5P/zfMtDJbZstEsU+sSboe7WNrm1
         X0Hkv9cqQcXDeKIXf1hfcKTRfPbT6/PzljAWEu+PKhKNvCJMQEnzWkFcWAEk5M9ijsz+
         9bi/wsHjkrAcbErSLW3Uie+IUjN7jcqrWiOn6gJ4pMsWEq7amP6F/RhKKxvIb0BkEqN6
         MorEPO0RiZLwfvaHEnKvOAhVSLHe6NGK1HSFJjyvhE9YGV4RwlkayXvTw12ePnmqglOe
         FJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cg005lnnBp+bToYWMmP/OVLdUdemD1ruiGGu29KvTs0=;
        b=Ep+lyoHejBaiEgn6vXbRtazpg4DlID/SFUNWZaprE0bjHOVtPl+pw7P+nQOJXXqa0N
         VA7yYIBF/PZbrt+9GzebXUXlEOvSpgUXmgduJJBGb2yMwm5c5EUAwS7sR09iTBSvTb6H
         AsOKQVMpnwMUz7Y2u0Z73JStqvffSKjlA6uxJ8dWNkx8Bi7TI5k4qcwyet7cXhLRgNZM
         Vvll9PPoWQPpZ11Ee+h7n6F7BeFLglFDSM2YTaHlLYr1D76QrRop8wJ6B5fUteOPcA+o
         lwJ9ActYKRWjNOhyQvl4PGoKE5cSK+1cJ9w1oyFbMLrl1PCiSb6JHi/s/fGwK3mSJzXB
         M9rw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V0sS+ze5;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V0sS+ze5;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225Dmfvi8fKe1hUgH6kYfwl2khlSi7Dth/kjpdlHvxcKD4irGG1E1gV/m9YLgELwWHy36BxebQpDB6b3dhPYtNc=
MIME-Version: 1.0
References: <20180205182351.774761393@linuxfoundation.org> <CALpmF+GKNPabSb1QjBf4nogZRryhU7oD6MRsB8yrU3esT0KxMA@mail.gmail.com>
 <20180206103404.GC10790@kroah.com>
In-Reply-To: <20180206103404.GC10790@kroah.com>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Tue, 06 Feb 2018 11:42:15 +0000
Message-ID: <CALpmF+G1Cn7-1Oe2xiNXcGq-cvSPj8GPQTEf0AEF7wN-FDLvFQ@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="001a114110c839cb67056489ace1"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591586546649955538?=
X-GMAIL-MSGID: =?utf-8?q?1591651700227050497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114110c839cb67056489ace1
Content-Type: text/plain; charset="UTF-8"

On Tue 6 Feb, 2018, 4:04 PM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
wrote:

> On Tue, Feb 06, 2018 at 06:48:53AM +0000, Harsh Shandilya wrote:
> > On Tue 6 Feb, 2018, 12:09 AM Greg Kroah-Hartman, <
> gregkh@linuxfoundation.org>
> > wrote:
> >
> > > This is the start of the stable review cycle for the 3.18.94 release.
> > > There are 36 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >
> > > kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.94-rc1.gz
> > > or in the git tree and branch at:
> > >   git://
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > linux-3.18.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> >
> > Builds and boots on the OnePlus 3T, no regressions noticed.
>
> Yeah!  That device is the only reason I keep this tree alive :)
>
> thanks for testing and letting me know.
>
> greg k-h
>

Guess I should drop my kernel tree for the device and save you the pain of
maintaining 3.18 :P

Atleast CAF has been keeping up with upstream now thanks to your
kernel-common merges so there's still hope for MSM platform users :)

P.S. common merge should go in cleanly, both the merge conflicts I had were
from CAF changes.

Thanks,
Harsh Shandilya
projekt development LLC

>

--001a114110c839cb67056489ace1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue 6 Feb, 2018, 4:0=
4 PM Greg Kroah-Hartman, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">=
gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">On Tue, Feb 06, 2018 at 06:48:53AM +0000, Harsh Shandilya wrote:<br>
&gt; On Tue 6 Feb, 2018, 12:09 AM Greg Kroah-Hartman, &lt;<a href=3D"mailto=
:gregkh@linuxfoundation.org" target=3D"_blank">gregkh@linuxfoundation.org</=
a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt; This is the start of the stable review cycle for the 3.18.94 rele=
ase.<br>
&gt; &gt; There are 36 patches in this series, all will be posted as a resp=
onse<br>
&gt; &gt; to this one.=C2=A0 If anyone has any issues with these being appl=
ied, please<br>
&gt; &gt; let me know.<br>
&gt; &gt;<br>
&gt; &gt; Responses should be made by Wed Feb=C2=A0 7 18:23:41 UTC 2018.<br=
>
&gt; &gt; Anything received after that time might be too late.<br>
&gt; &gt;<br>
&gt; &gt; The whole patch series can be found in one patch at:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"http://kernel.org/pub/linux/kernel/v3.x/stable-review/=
patch-3.18.94-rc1.gz" rel=3D"noreferrer" target=3D"_blank">kernel.org/pub/l=
inux/kernel/v3.x/stable-review/patch-3.18.94-rc1.gz</a><br>
&gt; &gt; or in the git tree and branch at:<br>
&gt; &gt;=C2=A0 =C2=A0git://<a href=3D"http://git.kernel.org/pub/scm/linux/=
kernel/git/stable/linux-stable-rc.git" rel=3D"noreferrer" target=3D"_blank"=
>git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git</a><br>
&gt; &gt; linux-3.18.y<br>
&gt; &gt; and the diffstat can be found below.<br>
&gt; &gt;<br>
&gt; &gt; thanks,<br>
&gt; &gt;<br>
&gt; &gt; greg k-h<br>
&gt; &gt;<br>
&gt;<br>
&gt; Builds and boots on the OnePlus 3T, no regressions noticed.<br>
<br>
Yeah!=C2=A0 That device is the only reason I keep this tree alive :)<br>
<br>
thanks for testing and letting me know.<br>
<br>
greg k-h<br></blockquote></div><div><br></div><div>Guess I should drop my k=
ernel tree for the device and save you the pain of maintaining 3.18 :P</div=
><div><br></div><div>Atleast CAF has been keeping up with upstream now than=
ks to your kernel-common merges so there&#39;s still hope for MSM platform =
users :)</div><div><br></div><div>P.S. common merge should go in cleanly, b=
oth the merge conflicts I had were from CAF changes.</div><div><br></div><d=
iv>Thanks,</div><div>Harsh Shandilya</div><div>projekt development LLC</div=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div>

--001a114110c839cb67056489ace1--
