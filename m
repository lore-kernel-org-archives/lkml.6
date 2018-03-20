Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521568238; cv=none;
        d=google.com; s=arc-20160816;
        b=p/1q6ivdvtyGOZMNQFEM8UIvqCFRiOLyFFLKnplcApuKPFq0uXu3oSRw3K0DUBQhLx
         Lv/bx50uwZP9/72fo+uHY4YGlng2+iUfSjAujufi7Tv2Dkd3IC77iEI36NxuY+pQ5W2B
         D7GsAVzDsdXXQDmzMXFpkV/1LyngSJ0R21qTzUF2MlScX8x13cvpC8gBy1UrX/XcXghq
         L0KvvkoQ49iCBCCy2o0YgK2zw8BUWZUmpCSi9J8le4pXeoXs90Mz84z5H5aH4SAJ6hbH
         WN2zCGq3/VfLJPqp8DCgWoPuLAWpnh+It8UTs7YgFSoC/h0gFoYHPZ3QSeVTJbF7kuys
         OYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UWI2c0pWthfcdWQmrVrt9jPjcuIAFdQjVu3appKjmrE=;
        b=g9p6qkyOvwYUOVFv/0EI/TiiVY2kNILtzhi9K9pU411SgyocakunJuD65GnCtVFq0N
         WLbkADagdFwZNzNqP8uCK3eZ8bpooHEzUHjPFOpbxr39NQFFMQMRCX8Tlls7ICP0Ia4q
         MlwZTWZ4PJDdWlWuZOKGCoRhbqxmN10d4AwFo2UDj15gF3PLiItLfeQvz2iCExqkfpPW
         LccL0GyJtY6IDc+Dy2p8EXIqUEsixDTEeKfqMiIMMWTzcrn2w952PQMvdJrR9gwliwS3
         P96q4BVQf6H5rB4XeLdPvtluZMV+pNE0JxfPgwjwZnnNs9ydb/C5/IM86WgWPL13jwKL
         Oarw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=brDXA3M8;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=brDXA3M8;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu4OdDOPxPHjZHFdxHo9SvuGWSIz1Jt0Asx6o3XsG+XjwXok96oGJhTFF8onQQe1mkMBVaCpjWftaqg7g8kTNA=
MIME-Version: 1.0
References: <20180319171827.899658615@linuxfoundation.org>
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Tue, 20 Mar 2018 17:50:27 +0000
Message-ID: <CALpmF+Fu1EHkBrG__6u8mY2LNa4jpq5ka78Oaa97X14FPwLLQQ@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="001a113f8d1e4e068e0567dbb6e8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390591416246104?=
X-GMAIL-MSGID: =?utf-8?q?1595479937155205676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a113f8d1e4e068e0567dbb6e8
Content-Type: text/plain; charset="UTF-8"

On Tue 20 Mar, 2018, 2:14 AM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
wrote:

> This is the start of the stable review cycle for the 3.18.101 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>
> https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc1.gz
> or in the git tree and branch at:
>         git://
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-3.18.y
> and the diffstat can be found below.
>

No merge issues with the CAF msm-3.18 tree, no regressions noticed on the
OnePlus3T.

Thanks,
Harsh Shandilya

>

--001a113f8d1e4e068e0567dbb6e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue 20 Mar, 2018, 2:=
14 AM Greg Kroah-Hartman, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org"=
>gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">This is the start of the stable review cycle for the 3.18.101 relea=
se.<br>
There are 68 patches in this series, all will be posted as a response<br>
to this one.=C2=A0 If anyone has any issues with these being applied, pleas=
e<br>
let me know.<br>
<br>
Responses should be made by Wed Mar 21 17:17:59 UTC 2018.<br>
Anything received after that time might be too late.<br>
<br>
The whole patch series can be found in one patch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://www.kernel.org/pub/linux/ker=
nel/v3.x/stable-review/patch-3.18.101-rc1.gz" rel=3D"noreferrer" target=3D"=
_blank">https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.=
18.101-rc1.gz</a><br>
or in the git tree and branch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/stable/linux-stable-rc.git" rel=3D"noreferrer" target=3D"_=
blank">git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git</=
a> linux-3.18.y<br>
and the diffstat can be found below.<br></blockquote></div><div><br></div><=
div>No merge issues with the CAF msm-3.18 tree, no regressions noticed on t=
he OnePlus3T.</div><div><br></div><div>Thanks,</div><div>Harsh Shandilya</d=
iv><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div>

--001a113f8d1e4e068e0567dbb6e8--
