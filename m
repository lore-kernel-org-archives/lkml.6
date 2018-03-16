Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521228125; cv=none;
        d=google.com; s=arc-20160816;
        b=ocek/apsebdP/0l44VNDaHO0vGliklrzveMXgvD0co48f6XKUPyfmjujR5OsBJ7+Gs
         XLV8Yb6APnuduLgYm0WgLnhcKv4ymFjN13+hkaaXONrpxk1PIvD15Id8RDnm65WHFr6x
         /TXrfOJ+rRmULeJA/h+NFNKrkaluMWc4z55gUbF5/gVAqRtyO/5a1NRI7w4FLVISLItC
         VW6TNqUEtTWOEb+VGxVTlpS1ss9A+q50jYdg9IRGPKm+/hrsuOtZQj41YUamFfIwr8L/
         addwiQrj2/7tAa09Si3EPPuoF2LhRbmUZf9CQ1cLv0HvXrIK6o32U2rtqgRRqU6DV8cF
         8/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=topvCzlooDxRtmSzBQZ8V/WaLDr75bEo9GLGc35CQtg=;
        b=rGRmEYfkCkbR/ulkwdiNrEm2Jyk8k4+8tmdjqN+5VJKebrlg2yFm6IYVpKAdf6+JtQ
         h1oUpRYFxh8qva4rqkc0tUFMt1cJzB7fFsCZCMjrcUE6+3ZrGY+T3ekbafhTOEWWckCw
         /ViqvOFemLPmFrVnl7luN5FagKz8ZYbCH1SZUgNbV8Z6IqI+SFIS7A+Cg+PiUHimwm/q
         OKvz0FRyoPnpKWlBK9l8VkGWH25qVxRmORk+XraTZZc6jyPz9GH+9MkuKFbZsUB5AzD9
         2273Gdan6MzIgmLjQLeKCvoZnpWFco+vEKWbmcFYxKVPjNrIdCwmFIQ666+H5jDlNyLd
         namw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RBOSrJCO;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RBOSrJCO;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsmafVBsK8xW5GWmgSM3uy4W6ygWHyTyk9Wa9orxob/7YrllGSzPfxtzkkI+ay2ZVIky0rjNObgfBx+HO4BVkY=
MIME-Version: 1.0
References: <20180316152232.750180431@linuxfoundation.org>
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Fri, 16 Mar 2018 19:21:53 +0000
Message-ID: <CALpmF+FmSSq9S=PX+pZzDmgFZRWJk5hNSd5msqAnfp=xFDFSEQ@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/25] 3.18.100-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="001a113f8d1efae61d05678c8569"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595108276054795320?=
X-GMAIL-MSGID: =?utf-8?q?1595123302992745714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a113f8d1efae61d05678c8569
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Mar, 2018, 8:53 PM Greg Kroah-Hartman, <
gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 3.18.100 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 18 15:22:18 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>
> https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.100-rc1.gz
> or in the git tree and branch at:
>         git://
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-3.18.y
> and the diffstat can be found below.
>

Builds and boots on the OnePlus 3T, no immediate issues noticed. Thanks for
the update.

Harsh Shandilya

>

--001a113f8d1efae61d05678c8569
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, 16 Mar, 2018, 8=
:53 PM Greg Kroah-Hartman, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org=
">gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">This is the start of the stable review cycle for the 3.18.100 rele=
ase.<br>
There are 25 patches in this series, all will be posted as a response<br>
to this one.=C2=A0 If anyone has any issues with these being applied, pleas=
e<br>
let me know.<br>
<br>
Responses should be made by Sun Mar 18 15:22:18 UTC 2018.<br>
Anything received after that time might be too late.<br>
<br>
The whole patch series can be found in one patch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://www.kernel.org/pub/linux/ker=
nel/v3.x/stable-review/patch-3.18.100-rc1.gz" rel=3D"noreferrer" target=3D"=
_blank">https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.=
18.100-rc1.gz</a><br>
or in the git tree and branch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/stable/linux-stable-rc.git" rel=3D"noreferrer" target=3D"_=
blank">git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git</=
a> linux-3.18.y<br>
and the diffstat can be found below.<br></blockquote></div><div><br></div><=
div>Builds and boots on the OnePlus 3T, no immediate issues noticed. Thanks=
 for the update.</div><div><br></div><div>Harsh Shandilya</div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div>

--001a113f8d1efae61d05678c8569--
