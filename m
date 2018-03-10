Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520697098; cv=none;
        d=google.com; s=arc-20160816;
        b=J9htYdPqQ5ysZEvv+NfsGcVGSr960wXSq6dzfvSl2TLBuG6/I1c47awT2grI6z57ji
         TEywPpIAZ4iGCs5KovosGPJX2uHxhhwJUN+spPT5wt5XR/0QkkV3qNzmTV2tS6cv8jIo
         OBHXMooGEAxjA5QQqZtmpw/0dZv8vERyiaPOojALL/ASHlwnpQSnu0cgLj2rEXTWf7r/
         ABZahV9bf9jGAEG+myxrBDn3KeFwzW0YDPf/vWhI1okcX7etimxe6BqWfxbrdAI0YD8m
         4Dous0uXNftuq2ZDgdxZZ9FhtUhMSsm0V7YoPFV7Rd/ypptMF2muDeMN48hIsfTFFHLX
         p1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hcwJKhjESplHWvLL/wjKOCJD6q7GKn1vprUQlWq2Y1c=;
        b=P4P3vq8C89I/28UYzVUGmVK/C0VT7NUXRO6cWp5q7hC0R2UMwaYvFBm3j38jokkSqU
         RM2N0VVoZ9ekG2eU0uupEuhqG0DDc6wlQM53C76mUQzC52cPFzwDxbqeSBkbf9qWW9gF
         xVhojLHn/M3UovZr85f2pvfC5pCvwx1xSClneCK+oJDAlY3hjMsyPKMIiJksqbNhzYrH
         4ApPKkZiYPcIIA1+gFsCLoqQoWh1WfXyPNnKro4+V1cddfgBsv0X09B1UqS65TBN/yN4
         XoaWgieKbqF4wL51xck5rZ9FIRj6phldgEUMcsQBQ/pn0jIyghLEJZyA0svpQ0ck8sbn
         XSbA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MftmZVaX;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MftmZVaX;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELupoYKHnn1HO7Umx+vjEuvuJe6apz5rxQ7T2QllvgB1em38Zn57c9ofkaYpKDViL6R+IpJJ/Ob2g29Ona0sPos=
MIME-Version: 1.0
References: <20180310001801.045114869@linuxfoundation.org>
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Sat, 10 Mar 2018 15:51:27 +0000
Message-ID: <CALpmF+FAUJRNkuMDc4bZ6fKGNsVwd_1m=jY0vTdqkpbJqNPuNw@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/21] 3.18.99-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="001a1140fb705a8735056710e2f4"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507787184257773?=
X-GMAIL-MSGID: =?utf-8?q?1594566481422766199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a1140fb705a8735056710e2f4
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Mar, 2018, 5:48 AM Greg Kroah-Hartman, <
gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 3.18.99 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Mar 12 00:17:44 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>
> https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.99-rc1.gz
> or in the git tree and branch at:
>         git://
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-3.18.y
> and the diffstat can be found below.
>

No issues on the OnePlus 3T, clean merge into the CAF msm-3.18 tree.

>

--001a1140fb705a8735056710e2f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sat, 10 Mar, 2018, 5=
:48 AM Greg Kroah-Hartman, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org=
">gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">This is the start of the stable review cycle for the 3.18.99 relea=
se.<br>
There are 21 patches in this series, all will be posted as a response<br>
to this one.=C2=A0 If anyone has any issues with these being applied, pleas=
e<br>
let me know.<br>
<br>
Responses should be made by Mon Mar 12 00:17:44 UTC 2018.<br>
Anything received after that time might be too late.<br>
<br>
The whole patch series can be found in one patch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://www.kernel.org/pub/linux/ker=
nel/v3.x/stable-review/patch-3.18.99-rc1.gz" rel=3D"noreferrer" target=3D"_=
blank">https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.1=
8.99-rc1.gz</a><br>
or in the git tree and branch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/stable/linux-stable-rc.git" rel=3D"noreferrer" target=3D"_=
blank">git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git</=
a> linux-3.18.y<br>
and the diffstat can be found below.<br></blockquote></div><div><br></div><=
div>No issues on the OnePlus 3T, clean merge into the CAF msm-3.18 tree.</d=
iv><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div>

--001a1140fb705a8735056710e2f4--
