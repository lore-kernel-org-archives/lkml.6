Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520788579; cv=none;
        d=google.com; s=arc-20160816;
        b=a1zo0VwPNXN8/NvXSwjWonziQahTAPi1WNLV9iDwGg3hSmPh9nq9gtP/RIiXxD++lO
         8BRoG3jMgsEga6K4sRuNbaBbs+eU8m9SwiaeK7jvycC5A6jIKBZJ4ZbkCgM8W7VtheVb
         z+VQFPIBTM91dVFjN3fvgo/4stblhKS0TUUkD0UN1pjnRzmkHOXjxe8AiPwrFc0YEZVk
         e/XczntRHstAWN8l7GyEfE3O4OnOotfENzBo9YCXt2T4X24Y5JguK5mRWNTs8FPEjIV+
         dLwHTWfUeLQS5UHDBjq6jZh69HWMwLt/MLj1tR/ZEL10n1sw1UyvbpmfZB3QmNBp7AJt
         lo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=kYgiAnBgQHebinmXhiqGssKJ1UBMoRuiGaVgnO2gu0U=;
        b=p6edAR+2BHY7ZnPVSU34eZyJIvFiFR++Sn/OGNxvlTZN/OkMnSMJVoWoRZc2YTqcr7
         VcUCVHZF+zJmQDooRsPZ+nFdmmY0EMHUriHRlJNydPZiTxx4wHj4HALKwJX9fSDps+3H
         c+74EXu43+TS7CNT1WHdIArEMmiMOal2PipJWDrjHVY2Jbn+4tl28VT5qYKXdTV2hMWV
         g/G23WOiaIfM6q3BVP5n0Gh4+A93sxpKYQpCuspPP0D5ZVFxhN4jqHTlDjNk7N32kpl1
         KdCaLWuAm37otUefd/oX8UrAyV6kLqbdxjykbsLkrE1hoARD3M4MJHRBXolhM5RAqCSK
         ufJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NTbofYnh;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NTbofYnh;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu/aPcwIiqvXKmbpfq5nSvlL6FsnG0ywCykJs2LqaEc3zJ0gDC8QtVvpy3jOnqidPj4yxVvYqEhSEeSgXeNGg4=
MIME-Version: 1.0
References: <20180311164429.GA11253@kroah.com>
In-Reply-To: <20180311164429.GA11253@kroah.com>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Sun, 11 Mar 2018 17:16:08 +0000
Message-ID: <CALpmF+FpDH8ug8M08SvFs5mFVE32qnWVvu=LGUzdnjo_n6ZgPw@mail.gmail.com>
Subject: Re: Linux 3.18.99
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>,
	linux-kernel@vger.kernel.org, lwn@lwn.net, stable@vger.kernel.org,
	torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="94eb2c1b67760439b70567262fb9"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1594662405757402962?=
X-GMAIL-MSGID: =?utf-8?q?1594662405757402962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c1b67760439b70567262fb9
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Mar, 2018, 10:14 PM Greg KH, <gregkh@linuxfoundation.org> wrote:

> I'm announcing the release of the 3.18.99 kernel.
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


Builds and boots on the OnePlus 3T, everything looks good. No merge issues
with the CAF msm-3.18 tree.

--94eb2c1b67760439b70567262fb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sun, 11 Mar, 2018, 1=
0:14 PM Greg KH, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh@l=
inuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I=
&#39;m announcing the release of the 3.18.99 kernel.<br>
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
a=3Dsummary</a></blockquote></div><div><br></div><div>Builds and boots on t=
he OnePlus 3T, everything looks good. No merge issues with the CAF msm-3.18=
 tree.</div>

--94eb2c1b67760439b70567262fb9--
