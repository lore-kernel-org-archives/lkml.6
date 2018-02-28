Return-Path: <arvindprasanna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519852851; cv=none;
        d=google.com; s=arc-20160816;
        b=dKM39ptFv+LF8ZY1oUf3wDCyeABroN3CyDjYAK90TK7kz0j5GSW42eZw9lItfiX+ZD
         jDHlxWm2s7SrPKhe5nDNC4hneDSTo390j0NJD7UDsZRv9GmRof6ArNeLI6DT1hjJZqGp
         jryODN08gY6aW4J3KwY1mwEfJ/HmsWDPUon5245oTVLDBMSVpHti0Nl2avbNk5VGrQp4
         xq79ZkVJM8j2c85FH/oMCvGjKwrIetLN8xMNSJ3KIIEIPYn49wc/UgiKtg+fp1m4oyeP
         PS1IeAj+IiCPI1O16ZQldh51ZckVDvxJvCsuMvDQCUoHBs5wwCRWeLAAGK5BMNg/3Ac1
         Ww9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=c3GIJpzBD97UxT3T1xWpSz52mAEJAoDtznrBpRLOsxo=;
        b=P8GGqezuXaOFCtkty6gSi6mBI1ZP/M+WAozkkLuUwdVAtyYgOnQFOJ/0WN3/NkRWo2
         TyaQtTZ4+ftJLzJL5XXyYAOEVKngIllvmwqdWOR/r1qmUs6n9aLsJOJvWu7UGUJ5D2Y1
         /gImtYs4DTVl9KNzWnWVIxPYDD+EbGIaoXzl8IVyu5aH+rqIQrVtFwQ9t8So5cRch4uK
         RdkdIqC8/LwUmHGq7XbAeQ1z4oQUCIjyGdtUaLi81lQ/wg2xT2IYlJG2Xb9+l5QFGoik
         /iMNM73huIWyY8gFxJZ4w+f1vhggdEJTf1HbrtFrwHxnu3231izXBWt8tW3HS9p/Pmdg
         3+XA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b8/QojP8;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b8/QojP8;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvW3A07VMigPGjuU1H9vzoE/1rW8WVCCtQz68QooFQd4aPuQdO8vw2rBBMgYAjPFw+CiaygDhE14/vDo7YQZ6g=
MIME-Version: 1.0
In-Reply-To: <80562d48-0524-eea2-947c-4fba0cb36b7a@infradead.org>
References: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
 <43a91eb4-646a-b4d8-5b3d-b0bfde0019d9@infradead.org> <CAK-=9LoNfYP_-tm+W2GvUWjWgs=BZ-VRFmVNzTCadzQWaee9yg@mail.gmail.com>
 <e484c42f-4fe6-10f5-dab8-cfd749911486@infradead.org> <CAK-=9Lph+GXzEsRf+2L2T1W4fJx-wo0HahPxfi6vPKSSxKxmqQ@mail.gmail.com>
 <CAK-=9LpTkTtQqqAL+NZEGL53s-vpzic0+3Q+ocrvL9pCwjb9KQ@mail.gmail.com> <80562d48-0524-eea2-947c-4fba0cb36b7a@infradead.org>
From: Arvind Prasanna <arvindprasanna@gmail.com>
Date: Wed, 28 Feb 2018 16:20:50 -0500
Message-ID: <CAK-=9LoRtOjN9_jCxtHf_fLeh3NpW6KOgYNuD09PKbDkCaCajg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Update ncurses package names for menuconfig
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c0e5d9a4904b105664c51eb"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593681223806105656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c0e5d9a4904b105664c51eb
Content-Type: text/plain; charset="UTF-8"

Hi Randy:

Apologies. I now understand what you are referring to. My commit message is
incorrect. The correct package names are ncurses-devel and libncurses-dev.
Thank you for pointing this out. I will send a patch for this.

Thanks,

Arvind.



On Wed, Feb 28, 2018 at 3:53 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
>
> I think that you are missing my point, so let me start over and try to
> clarify it.
>
> In the patch description, it says "libncurses-devel" (not libncurses-dev).
>
> In the patch itself, it says libncurses-dev (not libncurses-devel).
>
> I suspect that one of these is incorrect.  Which one is it?
>
> Thanks.
> ~~~~~~~~~~~~~~
>
> The package name is ncurses-devel for Redhat based distros
> and libncurses-devel for Debian based distros.
>
> Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>
> ---
>  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh
> b/scripts/kconfig/lxdialog/check-lxdialog.sh
> index a10bd9d..4353e40 100755
> --- a/scripts/kconfig/lxdialog/check-lxdialog.sh
> +++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
> @@ -55,7 +55,8 @@ EOF
>             echo " *** required header files."
> 1>&2
>             echo " *** 'make menuconfig' requires the ncurses libraries."
> 1>&2
>             echo " *** "
> 1>&2
> -           echo " *** Install ncurses (ncurses-devel) and try again."
> 1>&2
> +           echo " *** Install ncurses (ncurses-devel or libncurses-dev
>  1>&2
> +                  *** depending on your distribution) and try again."
> 1>&2
>             echo " *** "
> 1>&2
>             exit 1
>         fi
>
>
> --
> ~Randy
>

--94eb2c0e5d9a4904b105664c51eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Randy:<div><br></div><div>Apologies. I now understand w=
hat you are referring to. My commit message is incorrect. The correct packa=
ge names are ncurses-devel and libncurses-dev. Thank you for pointing this =
out. I will send a patch for this.=C2=A0</div><div><br></div><div>Thanks,</=
div><div><br></div><div>Arvind.</div><div><br></div><div><br></div></div><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Feb 28, 201=
8 at 3:53 PM, Randy Dunlap <span dir=3D"ltr">&lt;<a href=3D"mailto:rdunlap@=
infradead.org" target=3D"_blank">rdunlap@infradead.org</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
I think that you are missing my point, so let me start over and try to<br>
clarify it.<br>
<br>
In the patch description, it says &quot;libncurses-devel&quot; (not libncur=
ses-dev).<br>
<br>
In the patch itself, it says libncurses-dev (not libncurses-devel).<br>
<br>
I suspect that one of these is incorrect.=C2=A0 Which one is it?<br>
<br>
Thanks.<br>
~~~~~~~~~~~~~~<br>
<span class=3D""><br>
The package name is ncurses-devel for Redhat based distros<br>
and libncurses-devel for Debian based distros.<br>
<br>
</span>Signed-off-by: Arvind Prasanna &lt;<a href=3D"mailto:arvindprasanna@=
gmail.com">arvindprasanna@gmail.com</a>&gt;<br>
<div class=3D"HOEnZb"><div class=3D"h5">---<br>
=C2=A0scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh b/scripts/kcon=
fig/lxdialog/<wbr>check-lxdialog.sh<br>
index a10bd9d..4353e40 100755<br>
--- a/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh<br>
+++ b/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh<br>
@@ -55,7 +55,8 @@ EOF<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot; *** required header f=
iles.&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot; *** &#39;make menucon=
fig&#39; requires the ncurses libraries.&quot; 1&gt;&amp;2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot; *** &quot;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** Install ncurses (=
ncurses-devel) and try again.&quot;=C2=A0 =C2=A0 1&gt;&amp;2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** Install ncurses (=
ncurses-devel or libncurses-dev=C2=A0 =C2=A01&gt;&amp;2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *** dependi=
ng on your distribution) and try again.&quot;=C2=A0 =C2=A0 1&gt;&amp;2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot; *** &quot;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
<br>
--<br>
~Randy<br>
</div></div></blockquote></div><br></div>

--94eb2c0e5d9a4904b105664c51eb--
