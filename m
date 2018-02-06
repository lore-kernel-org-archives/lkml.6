Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517899745; cv=none;
        d=google.com; s=arc-20160816;
        b=FxveVOcbeixQTrIp5Fhor7RY8Q075pZGFpqdVRS0fE9OtyLZbZ9r+SH2PX5tss+xyf
         VgybddctXDW7Tv6YQtHeYj1LgX60Ma7orrux7U1cbl3HEpoeNRYxf9idZIPjvzyRU1MI
         EmeV4YJyqpPUx57wGGwB2f8NML6833Hn9zxlazdW9KGJoIAeH1un8Gurdcu7fdMP4I/r
         JGhlqfs2y8TM53lHBRksCVE6J0M4lY/e0tebFp4BjwBLOtN2FDKXinxV2pC3kf+ePHwI
         YXKczRFkisiGHpLqFElHMNf3AF2crqn2pIC1yJ0a8a+hrBwDrHEcad3PFfQiH6MH2rgT
         VTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=0f4XXEnfgUUUryJoU6Xq0Vmi6vWcHv75+eyAb38Cz1Y=;
        b=uBCkyLoU88dnfkz//M1GF+J4tPufaJXqPWkO+5tHWSbM9jes1bI3KVXH26Q+9Af3o8
         lYbR67GSlChf502qrJx3+fGazL7egE0Vw8ipR8A7twlGzmY5Vf0kUtoI+1l/PaPsqyU/
         x8u+1hXMfm97iIX0+6NMqWF6ZZ8r+d8gGnKcSgYiQgHDu8P4aj1Q180HDP5pi81f6m66
         9aPWxB8dK1Pm7bF7SpBHKwJm04UQKVzpL40okc/rJmMAkaVnRxMG8DbPdXwjZ7T1N92+
         EHDZvMzrPuGg5g/bOzqnIjsrSK7W4sHVFar+blLPduwSLaX921zvkEj+A5lWven+72BV
         7dDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MlFpziO1;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MlFpziO1;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225H3OJONxLumloRsFrcnm0K/TEK5S/+GVR4JYOUu6ER0VoIBDBg5UXzkyWxTSjHVcpxIEkd3JJwooqoOfXp640=
MIME-Version: 1.0
References: <20180205182351.774761393@linuxfoundation.org>
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Tue, 06 Feb 2018 06:48:53 +0000
Message-ID: <CALpmF+GKNPabSb1QjBf4nogZRryhU7oD6MRsB8yrU3esT0KxMA@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="94eb2c04e5da0c8a6a05648593a3"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591586546649955538?=
X-GMAIL-MSGID: =?utf-8?q?1591633243084273368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c04e5da0c8a6a05648593a3
Content-Type: text/plain; charset="UTF-8"

On Tue 6 Feb, 2018, 12:09 AM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
wrote:

> This is the start of the stable review cycle for the 3.18.94 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>
> kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.94-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-3.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds and boots on the OnePlus 3T, no regressions noticed.

Thanks,

Harsh Shandilya
projekt development LLC

>

--94eb2c04e5da0c8a6a05648593a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue 6 Feb, 2018, 12:=
09 AM Greg Kroah-Hartman, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org"=
>gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">This is the start of the stable review cycle for the 3.18.94 releas=
e.<br>
There are 36 patches in this series, all will be posted as a response<br>
to this one.=C2=A0 If anyone has any issues with these being applied, pleas=
e<br>
let me know.<br>
<br>
Responses should be made by Wed Feb=C2=A0 7 18:23:41 UTC 2018.<br>
Anything received after that time might be too late.<br>
<br>
The whole patch series can be found in one patch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://kernel.org/pub/linux/kernel/v=
3.x/stable-review/patch-3.18.94-rc1.gz" rel=3D"noreferrer" target=3D"_blank=
">kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.94-rc1.gz</a><b=
r>
or in the git tree and branch at:<br>
=C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/stab=
le/linux-stable-rc.git" rel=3D"noreferrer" target=3D"_blank">git.kernel.org=
/pub/scm/linux/kernel/git/stable/linux-stable-rc.git</a> linux-3.18.y<br>
and the diffstat can be found below.<br>
<br>
thanks,<br>
<br>
greg k-h<br></blockquote></div><div><br></div><div>Builds and boots on the =
OnePlus 3T, no regressions noticed.</div><div><br></div><div>Thanks,</div><=
div><br></div><div>Harsh Shandilya</div><div>projekt development LLC</div><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div=
>

--94eb2c04e5da0c8a6a05648593a3--
