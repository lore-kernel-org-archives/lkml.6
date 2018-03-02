Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520012499; cv=none;
        d=google.com; s=arc-20160816;
        b=CCUpM5mNp2xGyanM9mcZTfIHG4+A9P5glWKbN9hEWbTuVXBGHKDJ1EDK4pX8FbSza3
         OQE8Ynai+kWS+VxQKlgCCpgKJQvjo/Pv1R+Sb68pD+bY/wAC4FjpkijpotnzF4TxwG5P
         UQhcRcIyUy1epNpk/30txAX+FDfWMdK3j9eVR6Egqibl85TkqF8fJbM5I9V+tFuuPVCm
         6b94XR/xdJyRP94oMt0Fs+kUsS1hh6ZxoNzZ2bTUtxHvjJh3/waEgyk1tduVFxO/r382
         r4o9Lo9W8qPxRq6d4DMPN6JR6A8dz+viqnAcnxX0/t+8Tgn2DIVwWhDmx6NLgWxlzvW9
         Jj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Yk85fke+CPqyQpsYqSDJV18EJcl6Thm4jpZp4ZTLIx4=;
        b=gigP3Wg2OkPwwPhKCTAFJhI6OlniXSCyqGeNl1Z+/hndkpTZE00RWk3S7X92Q0JbnA
         tyukvY6gr4EIRubZeJfZH+YQP149XCd7EfHyRlHR9BU1l+6ebrvYu8f/dMuEprYBITKD
         AAtCzbygRw1cWvxapnGzHoTIHk5wDrF5+aQYue3VkAvP10iJ7qWVrebm8HSgw/Rgm5+R
         +hB/jb9cF1zHuhnd+zHKzJ0JDEzCg1nfIs0rA9st1xMTV1zRHkcjaFdFuLkRRtcak1l/
         lhW/EzoA4X8MsrNWBC+ZbeiP5uqXxH6XRBFYPwKWTHw+7V4noTOYWZWK6ghbNrwhcbhK
         kohg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L49HvsSE;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L49HvsSE;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuaTtvkmKSfs6SZVDFMy5ehzr4AQYPEzo/BAMFcawElvWL5Evv4fPke5GmrS1U0bgbqB7uAvsNOk7VxWLxp49s=
MIME-Version: 1.0
References: <20180302084239.157503766@linuxfoundation.org>
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Fri, 02 Mar 2018 17:41:28 +0000
Message-ID: <CALpmF+Ess8+k+N0q6YyVEUL+YmM5m1rS2ORs9xyR=sZoYXTwHA@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/24] 3.18.98-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="001a114873380fba560566717d02"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593815265016315476?=
X-GMAIL-MSGID: =?utf-8?q?1593848627093780755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114873380fba560566717d02
Content-Type: text/plain; charset="UTF-8"

On Fri 2 Mar, 2018, 2:25 PM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
wrote:

> This is the start of the stable review cycle for the 3.18.98 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar  4 08:42:22 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>
> https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.98-rc1.gz
> or in the git tree and branch at:
>         git://
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-3.18.y
> and the diffstat can be found below.
>

Builds and boots on the OnePlus 3T, no merge issues with CAF's msm-3.18
tree.

>

--001a114873380fba560566717d02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri 2 Mar, 2018, 2:2=
5 PM Greg Kroah-Hartman, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">=
gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">This is the start of the stable review cycle for the 3.18.98 release=
.<br>
There are 24 patches in this series, all will be posted as a response<br>
to this one.=C2=A0 If anyone has any issues with these being applied, pleas=
e<br>
let me know.<br>
<br>
Responses should be made by Sun Mar=C2=A0 4 08:42:22 UTC 2018.<br>
Anything received after that time might be too late.<br>
<br>
The whole patch series can be found in one patch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://www.kernel.org/pub/linux/ker=
nel/v3.x/stable-review/patch-3.18.98-rc1.gz" rel=3D"noreferrer" target=3D"_=
blank">https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.1=
8.98-rc1.gz</a><br>
or in the git tree and branch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/stable/linux-stable-rc.git" rel=3D"noreferrer" target=3D"_=
blank">git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git</=
a> linux-3.18.y<br>
and the diffstat can be found below.<br></blockquote></div><div><br></div><=
div>Builds and boots on the OnePlus 3T, no merge issues with CAF&#39;s msm-=
3.18 tree.</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div>

--001a114873380fba560566717d02--
