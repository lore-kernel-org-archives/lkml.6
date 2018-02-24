Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519472473; cv=none;
        d=google.com; s=arc-20160816;
        b=C/Jyq4yAKJ4jf6vCUrH5GH23B/a555K7Kuek336KgRxACqAWxjzTj5AzUQgc7gI5ZL
         mkm8qpk9T/49xNUSXxqLOVxkVWiJgicR7imu5MuRsB3hmir0ES0OF/qTuxgSFc3LB0G8
         Z4I6LYvZU+GoFO6LisX/TZml/Ch+izoFv2Ljq2qt2g7ulUqNfSw0dl4n6dIRlLixG4bQ
         hUxqEAlhmrHucPmN1zV3W8mR8yPXasyQ+G5iV/Pv/C6NkiSBqmrNPBT3SbC8C4PPD2GF
         S3qF7Eckv2LsZUSIkdLf0oTFuipWek44LTOeqLhJqR8ZicwYW3DW4mqs7qiSEXMEftQC
         fWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=lf47BIm+B8rM0b/0fMgSURTntgSX4ghTRQ2eoSxgUzY=;
        b=qqVFzxizRCtf++mRffJeoLS+AHP/gyCL9GkEqWyNevhr08nq/0pPtxTygAcR1OEZwU
         +Q8xSQlrg6HKwlZqe3sa/GiQCUM5XYg22YAkKku6qoR64zYJf8pChLDIsYFsd5SXsdW7
         k2H6Apq2ITuRMNOtBkDB1kpUSTrzyFg9yYC52OwD9z7I1ycEXwV5a54Dg07+tNk4y0sG
         s6IjThKb62lEn946o37iwSXwphqzgMZLhvPuqsOLCok88Uvn7bkRwq7+RNGOFE/Zsa1/
         CJ4pQR4a8V29DUAvLSYVS5g7QIue1Z07LjJmEnSqhm7c2Kb9FrMWA4qdYL73SWQd/+O+
         X6aQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NSGfYQb5;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NSGfYQb5;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtWvw7z4CBKCD8VR9WWGtDm6uEiXg3bUJdiTgnxwF74nzkk87lMYJz8PBs7kBgumhJdbnF/qUj4K1Ep2cYEto8=
MIME-Version: 1.0
References: <20180223170206.724655284@linuxfoundation.org>
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Sat, 24 Feb 2018 11:41:01 +0000
Message-ID: <CALpmF+EXvmUHRD=bKEKT3fUJYRQ2g48odV4MEbZ2tNRMj7KEbQ@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/58] 3.18.96-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="001a11487338ea70aa0565f3c05c"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593217489993597435?=
X-GMAIL-MSGID: =?utf-8?q?1593282368026583219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a11487338ea70aa0565f3c05c
Content-Type: text/plain; charset="UTF-8"

On Sat 24 Feb, 2018, 12:01 AM Greg Kroah-Hartman, <
gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 3.18.96 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Feb 25 17:01:41 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>
> https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.96-rc1.gz
> or in the git tree and branch at:
>         git://
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-3.18.y
> and the diffstat can be found below.
>

Clean merge into the msm-3.18 CAF tree, no regressions noticed on the
OnePlus 3T. Thanks for the update :)

>

--001a11487338ea70aa0565f3c05c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sat 24 Feb, 2018, 12=
:01 AM Greg Kroah-Hartman, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org=
">gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">This is the start of the stable review cycle for the 3.18.96 relea=
se.<br>
There are 58 patches in this series, all will be posted as a response<br>
to this one.=C2=A0 If anyone has any issues with these being applied, pleas=
e<br>
let me know.<br>
<br>
Responses should be made by Sun Feb 25 17:01:41 UTC 2018.<br>
Anything received after that time might be too late.<br>
<br>
The whole patch series can be found in one patch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://www.kernel.org/pub/linux/ker=
nel/v3.x/stable-review/patch-3.18.96-rc1.gz" rel=3D"noreferrer" target=3D"_=
blank">https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.1=
8.96-rc1.gz</a><br>
or in the git tree and branch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/stable/linux-stable-rc.git" rel=3D"noreferrer" target=3D"_=
blank">git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git</=
a> linux-3.18.y<br>
and the diffstat can be found below.<br></blockquote></div><div><br></div><=
div>Clean merge into the msm-3.18 CAF tree, no regressions noticed on the O=
nePlus 3T. Thanks for the update :)</div><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"></blockquote></div>

--001a11487338ea70aa0565f3c05c--
