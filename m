Return-Path: <arvindprasanna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519834727; cv=none;
        d=google.com; s=arc-20160816;
        b=Ci5yw3rue4g+CkZT9FgIYzcnAcaN9cDs12J+BrIAGfu6XEItHJK1A+7CoBNxX+h49l
         H7arKVtFnG9GgVtVzMxalYqMRFtT9jlHbmAmNBLTfcqIEEPyX8WnjJboB8n02rmqTtkj
         DnBvncLiEEmioCAPlNpEAOuhIPT9Jacj5GJysoEIM8hpUWBqS4nLFH0DDzS4BVDPLe+5
         Zkjz9O8SMy6LTFtOL8pP/O35h6GX7rKBYpD05eWT0rrHPvL6TRWIQ+uTuxvPUFeT6qXT
         tzm2TVv1Ms+nojgfVAHJEzR+/nRAKaybnM/rlvQadmB4nrxMscpzwOrcxQLmFYh/ZEYB
         3h8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=YlOPpMX/vYjHVWuVAgQVzF41kd/CwHa3Z0WfgKBE7l0=;
        b=0yCXbTir9a3+eR10zM2DBpQuAvUiflf5udZZkvyuggZLu01eab5jzNfM5aoJMZM94v
         6l2ovDd/gZKN4t/dsT46meXrBtxHvdoGFIIvGx6OXsau6sDTdDucz8yYdEK8ZFiepjHM
         7rI+z7RKRokXoXQ5sEwFlPKTOMMOlwyoniimErfm4fpobim2YIWW06MABFUFIqoTgBvE
         DR1eUsXVNBkxpRPrWYudoOaJsNefQntplLNCrySRdT7Roacpr/J8rdhG3vvR8oMgYe4H
         ww0jNel6JcDcAoj9VONi/V9dPB3fKLuHhUkJrWsvnNFOiRkfBQYOh7tdycwy8kF1AViQ
         lXWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZSEvioo1;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZSEvioo1;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtPCFREbamPK2+3Mt6/atIQMKCdC3Y3rMtnXimVfk6eGI4CCLbyySZf4DyLaDMf8XQ1AFwvaMkTevSHRLPj2Pg=
MIME-Version: 1.0
In-Reply-To: <1519834482-1756-1-git-send-email-arvindprasanna@gmail.com>
References: <CAK7LNATafNCOBMsNezrCT8j_N2kJiLt7S063wRtjGsaJTgxLvA@mail.gmail.com>
 <1519834482-1756-1-git-send-email-arvindprasanna@gmail.com>
From: Arvind Prasanna <arvindprasanna@gmail.com>
Date: Wed, 28 Feb 2018 11:18:46 -0500
Message-ID: <CAK-=9LqONXM-j4guLWaVrzQ8y8=W7z4DVvyDSLN27cERMmk+nQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: Update ncurses package names for menuconfig
To: Arvind Prasanna <arvindprasanna@gmail.com>
Cc: yamada.masahiro@socionext.com, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c1cc0fc091109056648195e"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593662219389994819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c1cc0fc091109056648195e
Content-Type: text/plain; charset="UTF-8"

Hi Masahiro Yamada:

I appreciate you having a look at my patch. I am still learning the ropes
contributing to open source. I have sent out version 2 of the patch with
the fix.

Thanks,

Arvind.


On Wed, Feb 28, 2018 at 11:14 AM, Arvind Prasanna <arvindprasanna@gmail.com>
wrote:

> The package name is ncurses-devel for Redhat based distros
> and libncurses-devel for Debian based distros.
>
> Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>
> ---
>
> Changes in v2:
> - Add a missing echo as pointed out by one of the reviewers.
>
>  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh
> b/scripts/kconfig/lxdialog/check-lxdialog.sh
> index a10bd9d..6c0bcd9 100755
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
> +           echo " *** Install ncurses (ncurses-devel or libncurses-dev "
> 1>&2
> +           echo " *** depending on your distribution) and try again."
> 1>&2
>             echo " *** "
> 1>&2
>             exit 1
>         fi
> --
> 2.7.4
>
>

--94eb2c1cc0fc091109056648195e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Masahiro Yamada:<div><br></div><div>I appreciate you ha=
ving a look at my patch. I am still learning the ropes contributing to open=
 source. I have sent out version 2 of the patch with the fix.</div><div><br=
></div><div>Thanks,</div><div><br></div><div>Arvind.</div><div><br></div></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Feb 2=
8, 2018 at 11:14 AM, Arvind Prasanna <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:arvindprasanna@gmail.com" target=3D"_blank">arvindprasanna@gmail.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">The pa=
ckage name is ncurses-devel for Redhat based distros<br>
and libncurses-devel for Debian based distros.<br>
<br>
Signed-off-by: Arvind Prasanna &lt;<a href=3D"mailto:arvindprasanna@gmail.c=
om">arvindprasanna@gmail.com</a>&gt;<br>
---<br>
<br>
</span>Changes in v2:<br>
- Add a missing echo as pointed out by one of the reviewers.<br>
<span class=3D""><br>
=C2=A0scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh b/scripts/kcon=
fig/lxdialog/<wbr>check-lxdialog.sh<br>
</span>index a10bd9d..6c0bcd9 100755<br>
<span class=3D"">--- a/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh<br>
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
ncurses-devel or libncurses-dev &quot; 1&gt;&amp;2<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** depending =
on your distribution) and try again.&quot;=C2=A0 =C2=A0 1&gt;&amp;2<br>
<div class=3D"HOEnZb"><div class=3D"h5">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 echo &quot; *** &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
--<br>
2.7.4<br>
<br>
</div></div></blockquote></div><br></div>

--94eb2c1cc0fc091109056648195e--
