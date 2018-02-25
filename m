Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519565002; cv=none;
        d=google.com; s=arc-20160816;
        b=EIMBWOy9iuqOWFilDA4bH60ZI/GR5zAVOdKZ7z9pWlyp1P0zoeX1EDyFSRvMgXJxCx
         VTxo0f2OpKuqmtcYH8RtoNnWl8hUJ4vTaMrbVKv7i9NFcYkb7fr29/Y89kElpUWTEPiX
         n7ZT77PDIG1Gy8Kf/mryMPpgdbwpHr9fbEgkicV/dxZbiTbrVKy2Kox/lCjtPQPexzQA
         wTujQlxZHSbIbpX6tjqSg/YsE2uADn2KNvtpkrTfhm3g5HtTaXrLYqzoAkhDWDd6UOtD
         tWKshodpDE6a4RaUGyt8+mTSpY79/VZQ6tuxOWyXRLzT32i+WOTl/BU+jDWaMNIJUMZk
         znGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=IJ00ZcunpnM94qUspFeJOIKv2m1gVMHU0MnxDOB+E+Q=;
        b=KR17l7MVYKt68Ky0mtm5cy46d7UxZ/EXQEI6EIDIeV6+ah40etFhaXc9ERUQrPqjC8
         quqW6CwYNGTZgI6qLBdRF3wx50iJqloJuMXMmjljngcp2DMfotoXGhhjKbZ1zOW1ThWt
         iKEWxo1B3DX7fFOjxeF+vEN2wEn14uSH0y4L5tXk+7MhWQbTcxQZeKq2YC7IeCRvYMag
         kXdLHP3wL2FV6Nyrmi8xsP0jk5C5+v/b6fuWysf5YcYSyw0XArbsxdjoLNEK2Tmfyd6L
         CnhV5RZ5DaEstD7NNhpMOPCKyWLC0gojr69sPQLoyGTXSnTXkBhWa0Bc0kxoiJvGdBgL
         QJNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mQi+sZD2;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mQi+sZD2;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvJbP9akalbNBy1aUMvkEGFjaakuRIoqeKyrKbafdyFQzP+DPGc91itlY+gJeaftCFufNYlxzkR6w+FJbTKVAk=
MIME-Version: 1.0
References: <20180225110809.GA21422@kroah.com>
In-Reply-To: <20180225110809.GA21422@kroah.com>
From: Harsh Shandilya <msfjarvis@gmail.com>
Date: Sun, 25 Feb 2018 13:23:11 +0000
Message-ID: <CALpmF+HhxEQUXy5ZiYFTzK8wMCSi7rwwUwV7tr7m6RhrsmEEhw@mail.gmail.com>
Subject: Re: Linux 3.18.96
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>,
	linux-kernel@vger.kernel.org, lwn@lwn.net, stable@vger.kernel.org,
	torvalds@linux-foundation.org
Content-Type: multipart/alternative; boundary="94eb2c19059c2a2ba80566094c82"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1593379392739815758?=
X-GMAIL-MSGID: =?utf-8?q?1593379392739815758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c19059c2a2ba80566094c82
Content-Type: text/plain; charset="UTF-8"

On Sun 25 Feb, 2018, 4:38 PM Greg KH, <gregkh@linuxfoundation.org> wrote:

> I'm announcing the release of the 3.18.96 kernel.
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


No regressions on the OnePlus 3. Merged cleanly into CAF msm-3.18 tree.

Thanks,
Harsh Shandilya

--94eb2c19059c2a2ba80566094c82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sun 25 Feb, 2018, 4:=
38 PM Greg KH, &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh@lin=
uxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I&#=
39;m announcing the release of the 3.18.96 kernel.<br>
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
a=3Dsummary</a></blockquote></div><div><br></div><div>No regressions on the=
 OnePlus 3. Merged cleanly into CAF msm-3.18 tree.</div><div><br></div><div=
>Thanks,</div><div>Harsh Shandilya</div>

--94eb2c19059c2a2ba80566094c82--
