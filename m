Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518016759; cv=none;
        d=google.com; s=arc-20160816;
        b=iyWOc3mGXHomueXZl805gIbAAAF2MTZ/4/wn+bT+c2ASUYOeFRIKpVNkgn1ivyg8yd
         oOwAOKnUEFxBs9Z4IFNHkGz/TyZ52jfGdqSazOVhkaNjCFZOt6T+xd+jv8LVkh/7WcAb
         3TWu7x1cvyHwAUrFI0P3kjEFC5VRxgggM2PgVrm5u+O2d506FFiV1qJKPkuQvK2XfM1l
         OQfXAQgZGSbB9ZhrbcXpWeVsg5WoDxmNTN4b0+kkfZjIPehr7FBPSqKnauvnrQp5seJO
         8Rqhej+ZuPrf0kIAaLn8FyTdDQfX9SfdBDzjVmF1sSkYvHLr1JfncrVoEpAxm/pQD5EQ
         5pAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DnsNEgRmsxvOe2aEU0iXp99yMouMtWc9RoZYY2Dr3cM=;
        b=N0Rhdxv4BR23Rs2nRVr6dObRWrx1CpHq+QtLjpx2avTtpEj4AEfGPpQnHXDitxCegi
         DVOS8sT8dEZZROL4ElyT8vI7IECyNaW4Kfl8dh/D008C/rxkPtrD+vgswqYvN8oK+6me
         mYi0dhgiWSgRSAFHwPcEuWcr7qoqxjwvXnzPCSf71RSjaOUVovIJJZPtsmcobwsQabrt
         FjVTimWnO2AsJmkDZ91EVvZM9+P95RcvlibVNQHVUscJtDYDbFraHOax2SrNg5mZTV7x
         WG9SjB9blLm9O4451jKedMXRQDLlTSyzr8dGepE+ZWR4YtbCa8/XSXr6A2BLnPJKUGAP
         Yihg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GNjVXWed;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GNjVXWed;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226OB3zqJkQXXExW3fzFlA9MXb0q98yrKR+3vhw/4h0QbYXvAjagJRyN8Vyatvdaa9Gu03ejoRo+tYrMgCt/X6s=
MIME-Version: 1.0
References: <20180205182351.774761393@linuxfoundation.org>
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Wed, 07 Feb 2018 15:19:07 +0000
Message-ID: <CALpmF+F0K4eXMe2BrHraRyhNK3hktKoEQNNjhdELC9tqaAZHvg@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="001a1137b696a6993a0564a0d191"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591586546649955538?=
X-GMAIL-MSGID: =?utf-8?q?1591755941480109185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a1137b696a6993a0564a0d191
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

Let's find out if I am too late.

https://www.spinics.net/lists/stable/msg213160.html will have to be lined
up for 3.18.94, or to .95 if I'm late since it's fixing a erroneous
backport from 3.18.93 which went unnoticed until after release. The email
bringing it up and the subsequent patch were probably lost in the usual
stable noise. I have applied it to the CAF tree for the oneplus3 and
verified that it does not break compilation or userspace for arm64.

Thanks,
Harsh Shandilya
projekt development LLC

>

--001a1137b696a6993a0564a0d191
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
Anything received after that time might be too late.<br></blockquote></div>=
<div><br></div><div>Let&#39;s find out if I am too late.</div><div><br></di=
v><div><a href=3D"https://www.spinics.net/lists/stable/msg213160.html">http=
s://www.spinics.net/lists/stable/msg213160.html</a> will have to be lined u=
p for 3.18.94, or to .95 if I&#39;m late since it&#39;s fixing a erroneous =
backport from 3.18.93 which went unnoticed until after release. The email b=
ringing it up and the subsequent patch were probably lost in the usual stab=
le noise. I have applied it to the CAF tree for the oneplus3 and verified t=
hat it does not break compilation or userspace for arm64.<br></div><div><br=
></div><div>Thanks,</div><div>Harsh Shandilya</div><div>projekt development=
 LLC</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div>

--001a1137b696a6993a0564a0d191--
