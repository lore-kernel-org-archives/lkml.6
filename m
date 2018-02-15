Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518708915; cv=none;
        d=google.com; s=arc-20160816;
        b=op8yxtLLJeETKUbzU9ZXI0/DC1HM0vbaI4kjxvuv1PV09FVe0E4lF/NcKCAVfaP95G
         /aVtR92FQOF1vxVQW0BZ2Ci2hFU7uchju0LxusmXAEJjn4zVDDAm63TcCd+B2o5Wu7Ri
         KI9TUohjNAedub3NSG5Jx5n5z7NidK/475YIC7por66u0gtWCNRHi8m56th5dabS75JI
         7JKvpzz7zN+CQkt1evM+3AkegKYDfIIEDqqeH6xBpWD24/O4/H3O9f6lozQ8GouEZMJb
         PfBeDDDq+I5N8WYNzpx70x6SRr36PqYxX8QK0ctpakzdOUCSZEdWaUNeqOx4Hi+IuWUY
         rxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ThWH9ayReSTnXpRz9E7BYKK/wGCbrUqIt3rkVUvLpsM=;
        b=vcD1+SdPamfQSb23XdP2EoTuCKph5+aLXHOZCCDflFB7NLNVF1QFx4qjTxEfy3e/dL
         JXsGbZAgr8zVH1ok72s/iekTEWJxk+ilJSZJW5xDuqZ+ah2doNgrhA6IJaU1kXkPK5ZM
         lCVzfd+t3dkygzXJ7gCubliNdaQc+S236xSBqxFnGCCQX6vS/uNrooyD5MJ3ZJEkkVsq
         ueqANxcp+jqc41Yd8qSTvNajM9yo5uW9+MGEtXzoPr/sfEfd/fSdZSnfKLmrZapbkU8F
         mFszdJ9arQrnkX9BfRJuFeYjIm1jegu9tiIndlvZbwj6IiFdBIpXAcN+WGK1m2JBrl1z
         eZdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T058aRL5;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T058aRL5;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226QRE55oIhUVCYvOzl1WfgCUEMwSie8cwSTczkv+XW3h9x5WnA9WyGm7K5vCc032CxRbC4BfTa+6TrO5aeUcc4=
MIME-Version: 1.0
References: <20180215144115.863307741@linuxfoundation.org>
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Thu, 15 Feb 2018 15:35:03 +0000
Message-ID: <CALpmF+EMZAaKEB0jwgfz8-aCp2_QQ2d2A-wcjJf3bKEaJh7cqg@mail.gmail.com>
Subject: Re: [PATCH 3.18 00/45] 3.18.95-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org, shuahkh@osg.samsung.com,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="001a114872e45b79a5056541f93c"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592480703978774067?=
X-GMAIL-MSGID: =?utf-8?q?1592481718970507337?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114872e45b79a5056541f93c
Content-Type: text/plain; charset="UTF-8"

On Thu 15 Feb, 2018, 8:50 PM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
wrote:

> This is the start of the stable review cycle for the 3.18.95 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Feb 17 14:40:54 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>
> kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.95-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-3.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds and boots on the OnePlus 3T, no regressions in general usage or
dmesg. Another peaceful and boring update :P

Thanks,

Harsh Shandilya

>

--001a114872e45b79a5056541f93c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu 15 Feb, 2018, 8:=
50 PM Greg Kroah-Hartman, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org"=
>gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">This is the start of the stable review cycle for the 3.18.95 releas=
e.<br>
There are 45 patches in this series, all will be posted as a response<br>
to this one.=C2=A0 If anyone has any issues with these being applied, pleas=
e<br>
let me know.<br>
<br>
Responses should be made by Sat Feb 17 14:40:54 UTC 2018.<br>
Anything received after that time might be too late.<br>
<br>
The whole patch series can be found in one patch at:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://kernel.org/pub/linux/kernel/v=
3.x/stable-review/patch-3.18.95-rc1.gz" rel=3D"noreferrer" target=3D"_blank=
">kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.95-rc1.gz</a><b=
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
OnePlus 3T, no regressions in general usage or dmesg. Another peaceful and =
boring update :P</div><div><br></div><div>Thanks,</div><div><br></div><div>=
Harsh Shandilya</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
</blockquote></div>

--001a114872e45b79a5056541f93c--
