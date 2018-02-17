Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518874815; cv=none;
        d=google.com; s=arc-20160816;
        b=uiE5xHns+4dcG0j4sahyfvTarx3sL0CJi64dnWCScBxL89cOdAy03F3kX1UZ0etLb7
         CkuCKLiax9DKBlA+YUnbI5YMapyp1msOwsC2HPVyVkUmxvHf41R2hvXZkLFYdOCEz7rA
         pmKSu/2lg0ZdVpyFa6Ysvl+TxrWgWQyU913l7N9ugbwp/cKiwackS3Osrh993SmHGQsJ
         kG5YTENTcW8B8ZCDjINoDGnh7r7SemgN5bkbDrJGUlx55N1UGYnPbm52YPhyfQIE43zC
         kgw4dQTcxqpUv3JX3akMFNAe54gezDJBQMa3I3+WGpBUZfeJ4K978dYBO1XgyzbVCkX5
         S2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=U+oiU4r7t3t4l86XcWWxn09CzMTqaTaxBskGpwokUSY=;
        b=Y4gmp672ZUUDHV5xawwtryJB5VBwrn2iw877n1G58ZyPzJAd5sTU1HL26sDyxZ58+z
         pAenyNNLdpeUZKKS0P23h/ov2em9I56jOmSwK4VzUdtJh5SDfM2KYq+Cf7hN/cdhn9Bw
         GJFeiCw8pRd/aDGBp45ObCcR6QpZ5A4rYlIqY/32+apW6vDAIFz8sRb4BCXqeSrXD46r
         DWdiJC98lldUQTg3J4z3nvHmaEDHZ8izkmhEW1EEtQi8FvWAq6IhMFrVfNyX4ssBJJ01
         H7UlTne2alPN3m8BW/gGD5/Io0I+E3XfdFpN/spDhrOticG0U5MsGwXjg/q7YaJKZDUt
         ydDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gBJiOjO4;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gBJiOjO4;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225NJSqLMwyE3XDBjFrZuxjh4d4mfxk7Rk48JZNMWZBuCoRvKoZ9WXYcubBqYuxpgIEpVnd+u+ZO2cu/msjovtM=
MIME-Version: 1.0
References: <20180217132437.GA15213@kroah.com>
In-Reply-To: <20180217132437.GA15213@kroah.com>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Sat, 17 Feb 2018 13:40:04 +0000
Message-ID: <CALpmF+HDd-rE8HTgLuWxXqhbFL3ds4x5xcscV47MYHFPef4A9g@mail.gmail.com>
Subject: Re: Linux 3.18.95
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>,
	linux-kernel@vger.kernel.org, lwn@lwn.net, stable@vger.kernel.org,
	torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="089e082664a8d2d56e05656899bb"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592655678907363298?=
X-GMAIL-MSGID: =?utf-8?q?1592655678907363298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--089e082664a8d2d56e05656899bb
Content-Type: text/plain; charset="UTF-8"

On Sat 17 Feb, 2018, 7:00 PM Greg KH, <gregkh@linuxfoundation.org> wrote:

> I'm announcing the release of the 3.18.95 kernel.
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

No issues on the oneplus3 over the course of the past couple of hours.
Clean merge into Codeaurora's tree, should be the same for AOSP
kernel-common.

Thanks,

Harsh Shandilya

>

--089e082664a8d2d56e05656899bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sat 17 Feb, 2018, 7:=
00 PM Greg KH, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh@lin=
uxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I&#=
39;m announcing the release of the 3.18.95 kernel.<br>
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
greg k-h<br></blockquote></div><div><br></div><div>No issues on the oneplus=
3 over the course of the past couple of hours. Clean merge into Codeaurora&=
#39;s tree, should be the same for AOSP kernel-common.</div><div><br></div>=
<div>Thanks,</div><div><br></div><div>Harsh Shandilya</div><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"></blockquote></div>

--089e082664a8d2d56e05656899bb--
