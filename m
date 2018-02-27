Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519697846; cv=none;
        d=google.com; s=arc-20160816;
        b=gfIWYRs0cq0HxElKRiNzNKg9Sni+EDft4YMA6g8BjS7iNi7c3ZI/dRh02E+Wl28IV1
         N+JYragEChIar8p90XnBxtvfdg1fi5xxYtaya7pTJg8k9sRQrHjIUX9DNjJWOHE/42V5
         pLGe3oypDx5+kGH4Fxy//ufSZVM+dIlu9GyzVLavaKpnNNN0Wj5svsz5i3mcy8X+Ge3t
         fRhaI+6HA7uG8gE2C5nu+xIVE2xln/e820XERil6XtZToZt5VbQLOP7Hbh/PYwgir6Bq
         SqILAUtfLaXUZXKXvMItckIaNUa95rJBLIpApyDcltRpA/wSb6C6ATt9X7sWGVWNz6j2
         vR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/rDmAs/GjDaAUMPlBuLWuyolSb1AyhZNoDM2Vr9JY7I=;
        b=bgI9t423D24wjZauvXPAXpHnfPKt8YSbXuUGIedQqNFSh82Cdh0gggH62YepQmDS3w
         r9p4TLM9h1qkagIHQR0lnqUrYrvBM4MKEUthKkSYl4w5rtGAsSHNmfWr30isHCHV2EB9
         WGiONqYHPZMLV4Et1gVOil6ej4xSfU9dl7n3aRl2h0Zr3DRLdxWUpjtcWFBNSan0BNej
         h5aqw0UDhh0gGqP6u74Me3Pm0vSylfFiK6vXwaCVfVCoVurGtFfFxkD2OalW5i/mq1/F
         inMf4DPvrX0qFdnZJM3OO7z7ij403N5+2Vv/OGwlVBkqMIXzba03JpLbgCrZONihzanp
         N6Cg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XGYnbSOk;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XGYnbSOk;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv35d5ZVuFAUdbu8wGwIcmGp8pMsAoC0Ay+pts5Exj6CeRUY7Nw+SIklB0AheFgFM3Wcke/OHWxmC5EUZ+702I=
MIME-Version: 1.0
References: <20180226201527.242286068@linuxfoundation.org>
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Tue, 27 Feb 2018 02:17:15 +0000
Message-ID: <CALpmF+F8D=BpTP+Z3Vh+6JTLR+y07bDQ+jEtOo+OoQ37D=k65Q@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/13] 3.18.97-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="089e0822696c45c7a50566283a2e"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593495935920451612?=
X-GMAIL-MSGID: =?utf-8?q?1593518689197701849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--089e0822696c45c7a50566283a2e
Content-Type: text/plain; charset="UTF-8"

On Tue 27 Feb, 2018, 1:47 AM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
wrote:

> This is the start of the stable review cycle for the 3.18.97 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 28 20:15:12 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>
> https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.97-rc1.gz
> or in the git tree and branch at:
>         git://
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-3.18.y
> and the diffstat can be found below.
>

No regressions noticed on the OnePlus 3T. CAF's msm-3.18 tree requires
reverting commit
https://source.codeaurora.org/quic/la/kernel/msm-3.18/commit?id=1278f001ef9bf1329bc2aa123f6038ad9f8a65ee
to avoid conflicting with the patch titled "usb: gadget: f_fs: Process all
descriptors during bind", kernel-common has no merge problems. Thanks for
the update.

Harsh Shandilya

--089e0822696c45c7a50566283a2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue 27 Feb, 2018, 1:=
47 AM Greg Kroah-Hartman, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org"=
>gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">This is the start of the stable review cycle for the 3.18.97 releas=
e.<br>
There are 13 patches in this series, all will be posted as a response<br>
to this one.=C2=A0 If anyone has any issues with these being applied, pleas=
e<br>
let me know.<br>
<br>
Responses should be made by Wed Feb 28 20:15:12 UTC 2018.<br>
Anything received after that time might be too late.<br>
<br>
The whole patch series can be found in one patch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://www.kernel.org/pub/linux/ker=
nel/v3.x/stable-review/patch-3.18.97-rc1.gz" rel=3D"noreferrer" target=3D"_=
blank">https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.1=
8.97-rc1.gz</a><br>
or in the git tree and branch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/stable/linux-stable-rc.git" rel=3D"noreferrer" target=3D"_=
blank">git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git</=
a> linux-3.18.y<br>
and the diffstat can be found below.<br></blockquote></div><div><br></div><=
div>No regressions noticed on the OnePlus 3T. CAF&#39;s msm-3.18 tree requi=
res reverting commit=C2=A0<a href=3D"https://source.codeaurora.org/quic/la/=
kernel/msm-3.18/commit?id=3D1278f001ef9bf1329bc2aa123f6038ad9f8a65ee">https=
://source.codeaurora.org/quic/la/kernel/msm-3.18/commit?id=3D1278f001ef9bf1=
329bc2aa123f6038ad9f8a65ee</a> to avoid conflicting with the patch titled &=
quot;usb: gadget: f_fs: Process all descriptors during bind&quot;, kernel-c=
ommon has no merge problems. Thanks for the update.</div><div><br></div><di=
v>Harsh Shandilya</div><div><br></div><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
</blockquote></div>

--089e0822696c45c7a50566283a2e--
