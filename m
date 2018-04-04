Return-Path: <jforbes@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522805450; cv=none;
        d=google.com; s=arc-20160816;
        b=yQkWtTOvCiCp4CXJEp1ctq1Gxh9UpJ+jXzVSxzOHfrzOfhBHuacG1ZmpguttNE8+82
         XYGmRpK+/69rDmEd3FGaJKOrr710JFtr69BVKodR6I4bNoIjGyimZpi50e3+jNBZlTXm
         efKs3+XAy9aWoyjtRjyTN+VNGuXCii88RSZThR+7CvDEgmECYaSzxBvtbEITgN/JQhCD
         PmgGtC5xyE/a0fosE2f2TQ5kmJ1TUfZPv6+mL6sR2IxFb2jBvhsrHIjEFwAPdZbcjMBx
         46Egu1T8tbBKh+5M1xJ98i4B89sMBvjGwFC5ds9cE5KMhXDR95inm/B8O49alghi+e3u
         isPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=M308pbioOzyXvLEDs5qW4O38uNlkmphbyaawTz/qTWs=;
        b=LHGgGacmggV2IktcGk6Eu+NcTrWU3TGQtUVzHVPEJ0OTcMQnsoIxyG7PAWUNYov3M5
         i5se4OL/oDGDbYWVUQT4vt22bBaqERH0Sii5hbY4IQdxoz/ZKNsw+gX5dAWzFs4raIGu
         Rumme2DN3KJ6QeKog0e/jQLcaOhXKlMulm55j5tHE9JAMX05nYlUFSeVIvyHKicUTC3l
         p9i/9uWqksslnnaPy+fa65APlMZQW7HQDhNbOFt4j/7j6Uy45X5HwjQ/hLsTBzmSuwaJ
         gqGm0LNl6falYH26nn2cx659cKail4nRdwpN3HAz5MiDd3BkrPybMeDgbRyR9qEu1Yzj
         URJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jforbes@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jforbes@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jforbes@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jforbes@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx49u4kH0LxYopCD7OQHbe1fwKUit0stYNrbsu13kF49A4dvBgPhmr86FyZ4pSGicWBCSq7Begy8odOadkxOEB4M=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
 <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
 <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
 <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
 <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com>
 <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
 <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com> <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
From: Justin Forbes <jforbes@redhat.com>
Date: Tue, 3 Apr 2018 20:30:49 -0500
Message-ID: <CAFbkSA0ursG3RGWU19LQiD6u30h5V=Aqj3oVyHQCiX6MLopYUg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Garrett <mjg59@google.com>, Andrew Lutomirski <luto@kernel.org>,
	David Howells <dhowells@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	James Morris <jmorris@namei.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
	joeyli <jlee@suse.com>, LSM List <linux-security-module@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	linux-efi <linux-efi@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000e27fd70568fbc536"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596407243846270411?=
X-GMAIL-MSGID: =?utf-8?q?1596777247357017425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000e27fd70568fbc536
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 3, 2018 at 7:56 PM, Linus Torvalds <
torvalds@linux-foundation.org> wrote:

> On Tue, Apr 3, 2018 at 5:46 PM, Matthew Garrett <mjg59@google.com> wrote:
> >
> > The generic distros have been shipping this policy for the past 5 years.
>
> .. so apparently it doesn't actually break things? Why not enable it
> by default then?
>
> And if "turn off secure boot" really is the accepted - and actuially
> used - workaround for the breakage, then
>
> While there is very little breakage in the *years* we have been shipping
this in distro kernels, the accepted and used workaround has always been
"turn off secure boot" or sign/import your own keys, depending on the
problems encountered.


>    WHY THE HELL DIDN'T YOU START OFF BY EXPLAINING THAT IN THE FIRST
> PLACE WHEN PEOPLE ASKED WHY THE TIE-IN EXISTED?
>
> Sorry for shouting, but really. We have a thread of just *how* many
> email messages that asked for the explanation for this? All we got was
> incomprehensible and illogical crap explanations.

If there actually was a good explanation for the tie-in, it should
> have been front-and-center and explained as such.
>
> Honestly, yes, the major distros have been shipping this patch set for
years now, and every time it comes to upstream, the same damn arguments
emerge.  I do not disagree that there are uses for lockdown outside of
secure boot, provided you have some other mechanism to verify your chain, I
believe chrome OS does. But the tie to secure boot is because that is the
use case that users have been using for years, it was discussed at kernel
summit quite a while ago, plans went forward there seemed to be agreement,
and when it comes time for a pull request, people come out of the woodwork
with an expectation that it solves every problem or it doesn't need to
exist. What is here is a good starting point. I would expect that if it
were merged, others would build upon that and use much of the code already
in place to extend it. It is tied to secure boot because that is what has
been using this for years as it never seems to get upstream.  I am sure
that once it does finally land, it can and will be extended to other
things, but I don't think I would want to spend a lot of time trying to
leverage another external patch set that has been delayed upstream so many
times until it actually did land.
As for the ties to MS that come up every time, and have here as well, there
is no requirement on the MS signature. You can import your own keys if you
don't want them involved, I keep a "test key" imported for actually running
what I build locally.

--000000000000e27fd70568fbc536
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Apr 3, 2018 at 7:56 PM, Linus Torvalds <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:torvalds@linux-foundation.org" target=3D"_blank">torvalds@l=
inux-foundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><span class=3D"">On Tue, Apr 3, 2018 at 5:46 PM, Matthew Garrett &lt;<a hr=
ef=3D"mailto:mjg59@google.com">mjg59@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The generic distros have been shipping this policy for the past 5 year=
s.<br>
<br>
</span>.. so apparently it doesn&#39;t actually break things? Why not enabl=
e it<br>
by default then?<br>
<br>
And if &quot;turn off secure boot&quot; really is the accepted - and actuia=
lly<br>
used - workaround for the breakage, then<br>
<br></blockquote><div>While there is very little breakage in the *years* we=
 have been shipping this in distro kernels, the accepted and used workaroun=
d has always been &quot;turn off secure boot&quot; or sign/import your own =
keys, depending on the problems encountered.=C2=A0</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
=C2=A0 =C2=A0WHY THE HELL DIDN&#39;T YOU START OFF BY EXPLAINING THAT IN TH=
E FIRST<br>
PLACE WHEN PEOPLE ASKED WHY THE TIE-IN EXISTED?<br>
<br>
Sorry for shouting, but really. We have a thread of just *how* many<br>
email messages that asked for the explanation for this? All we got was<br>
incomprehensible and illogical crap explanations.</blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
If there actually was a good explanation for the tie-in, it should<br>
have been front-and-center and explained as such.<br><span class=3D"HOEnZb"=
><font color=3D"#888888"><br></font></span></blockquote><div>Honestly, yes,=
 the major distros have been shipping this patch set for years now, and eve=
ry time it comes to upstream, the same damn arguments emerge.=C2=A0 I do no=
t disagree that there are uses for lockdown outside of secure boot, provide=
d you have some other mechanism to verify your chain, I believe chrome OS d=
oes. But the tie to secure boot is because that is the use case that users =
have been using for years, it was discussed at kernel summit quite a while =
ago, plans went forward there seemed to be agreement, and when it comes tim=
e for a pull request, people come out of the woodwork with an expectation t=
hat it solves every problem or it doesn&#39;t need to exist. What is here i=
s a good starting point. I would expect that if it were merged, others woul=
d build upon that and use much of the code already in place to extend it. I=
t is tied to secure boot because that is what has been using this for years=
 as it never seems to get upstream.=C2=A0 I am sure that once it does final=
ly land, it can and will be extended to other things, but I don&#39;t think=
 I would want to spend a lot of time trying to leverage another external pa=
tch set that has been delayed upstream so many times until it actually did =
land.</div><div>As for the ties to MS that come up every time, and have her=
e as well, there is no requirement on the MS signature. You can import your=
 own keys if you don&#39;t want them involved, I keep a &quot;test key&quot=
; imported for actually running what I build locally.</div><div>=C2=A0</div=
></div></div></div>

--000000000000e27fd70568fbc536--
