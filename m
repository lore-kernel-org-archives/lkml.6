Return-Path: <arvindprasanna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519849785; cv=none;
        d=google.com; s=arc-20160816;
        b=d4wXpzOY3XGyCe3EWL25Xb9gR+deMcdkW8NgNHqlkTZlarysYIjEmDxyKexSRXHyLV
         jCbGmiTNEbfHaJU8wc5jAJlLPzOLBczegVLdyDfpYOa/AfdiWFJBKedVplz2vcpnE3UP
         CZkrCoYwesG2c9NWE17d9UerZxYoavmu0wZ+bAwq7Xs8MSzBTdFeghkdzl8LV9X4U7o+
         THiiTO862foAJuewqxAsEYGXA4bG9KjFH5OnIMt+CvZAEMHsz+IIuGtWbMl1Y+dU9mdm
         lwTnSlk/QsD57oEs3N1YiuDjLM1mlfXQ0Nv7RYusQT1tRtehDMQPytv/IvZxyXs36fZL
         UcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/3lZahC0BTob9a8+lJ5T5ZFbHoh2TU14oJNaLe9D9Rw=;
        b=Gmk/xmXI02oIkiM1NqtE0iTYnJd0Hrjf77/fv98lMr92f6hl2zuN2YfGPkRrPdmdLm
         oXDg/rNWwckxeov3LTOBJ8OcQA2Nm6bDTMzu/jvML+ieZaCwyRVzSszGlcGJl7wCs5eM
         q0MgjaGXaDppB6SRlTmrrlwSG9EA7ePnQm5ZbmvUMNJ99L/4Hzo8j4f3KFXB8k5Bu98n
         /o1hkLcE1383a/TleauurQjCfJtcJjJGJNYRNAlSWcf967aH/70LxNHd6pcATLNESrC0
         IKfMUgzsw6zkdsW54UM6LOYsSWhAPPwG3DgGBRtDyaZAXv1w4gOLFzXHIPn+pkcVMc3i
         6CPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Tl4ezCja;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Tl4ezCja;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELshlpuS9j3Cr9hbxOPwUxLcpDDqFy/gqgljcHbmTAV5gyRDjSTTpPDwzpr4avg3M7x/4muaTz03bR0Vg3WVv1Q=
MIME-Version: 1.0
In-Reply-To: <CAK-=9Lph+GXzEsRf+2L2T1W4fJx-wo0HahPxfi6vPKSSxKxmqQ@mail.gmail.com>
References: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
 <43a91eb4-646a-b4d8-5b3d-b0bfde0019d9@infradead.org> <CAK-=9LoNfYP_-tm+W2GvUWjWgs=BZ-VRFmVNzTCadzQWaee9yg@mail.gmail.com>
 <e484c42f-4fe6-10f5-dab8-cfd749911486@infradead.org> <CAK-=9Lph+GXzEsRf+2L2T1W4fJx-wo0HahPxfi6vPKSSxKxmqQ@mail.gmail.com>
From: Arvind Prasanna <arvindprasanna@gmail.com>
Date: Wed, 28 Feb 2018 15:29:44 -0500
Message-ID: <CAK-=9LpTkTtQqqAL+NZEGL53s-vpzic0+3Q+ocrvL9pCwjb9KQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Update ncurses package names for menuconfig
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c1a68cc94501d05664b9a3f"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593678009397895131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c1a68cc94501d05664b9a3f
Content-Type: text/plain; charset="UTF-8"

If it is not possible or difficult to identify the ncurses development
package name for all existing and future Linux distributions, one
possibility is that we can change the message to say "Please install the
ncurses library development package and try again". This way we don't have
to specify a package name.

On Wed, Feb 28, 2018 at 2:59 PM, Arvind Prasanna <arvindprasanna@gmail.com>
wrote:

> If a Linux distribution is RPM based, the package name is libncurses-dev
> and if it is Debian based, it is ncurses-devel. Here are some examples:
>
> # cat /etc/os-release | grep "PRETTY_NAME"
> PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
> # apt-cache search libncurses-dev
> libncurses5-dev - developer's libraries for ncurses
>
> # cat /etc/os-release | grep "PRETTY_NAME"
> PRETTY_NAME="Ubuntu 16.04.3 LTS"
> # apt-cache search libncurses-dev
> libncurses5-dev - developer's libraries for ncurses
>
>
> # cat /etc/os-release | grep "PRETTY_NAME"
> PRETTY_NAME="CentOS Linux 7 (Core)"
> # yum search ncurses-devel
> ======================================================================
> N/S matched: ncurses-devel ==============================
> =========================================
> ncurses-devel.i686 : Development files for the ncurses library
> ncurses-devel.x86_64 : Development files for the ncurses library
>
> # cat /etc/os-release | grep "PRETTY_NAME"
> PRETTY_NAME="Fedora 27 (Twenty Seven)"
> # yum search ncurses-devel
> Last metadata expiration check: 0:05:07 ago on Wed Feb 28 19:20:24 2018.
> ================================================================== Name
> Exactly Matched: ncurses-devel ==============================
> ====================================
> ncurses-devel.i686 : Development files for the ncurses library
> ncurses-devel.x86_64 : Development files for the ncurses library
>
>
> I have tried RPM based and Debian based linux distros as they are
> extensively used and widely distributed. For other (independent) Linux
> distributions, it is possible they have their own names for the ncurses
> development package.
>
> Thanks,
>
> - Arvind.
>
> On Wed, Feb 28, 2018 at 1:59 PM, Randy Dunlap <rdunlap@infradead.org>
> wrote:
>
>> On 02/28/2018 09:39 AM, Arvind Prasanna wrote:
>> > Hi Randy:
>> >
>> > On 02/27/2018 10:59 PM, Arvind Prasanna wrote:
>> >> The package name is ncurses-devel for Redhat based distros
>> >> and libncurses-devel for Debian based distros.
>> >
>> > The above lines are part of the commit message and the patch says to
>> install either ncurses-devel or libncurses-dev based on the user's Linux
>> distribution. Would you prefer I add my commit message lines to the patch
>> as well?
>> >
>> > Thanks,
>> >
>> > Arvind.
>> >
>> >
>> > On Wed, Feb 28, 2018 at 12:31 PM, Randy Dunlap <rdunlap@infradead.org
>> <mailto:rdunlap@infradead.org>> wrote:
>> >
>> >     On 02/27/2018 10:59 PM, Arvind Prasanna wrote:
>> >     > The package name is ncurses-devel for Redhat based distros
>> >     > and libncurses-devel for Debian based distros.
>> >
>> >           ^^^^^^^^^^^^^^^^ That's not what the patch says. Please
>> clarify.
>>
>> For Debian-based distros, is it libncurses-devel (above) or is it
>> libncurses-dev (as below)?  [latter is without the ending "el"]
>>
>>
>> And what about the other few hundred distros?  (rhetorical)
>>
>>
>> >     >
>> >     > Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com <mailto:
>> arvindprasanna@gmail.com>>
>> >     > ---
>> >     >  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
>> >     >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >     >
>> >     > diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh
>> b/scripts/kconfig/lxdialog/check-lxdialog.sh
>> >     > index a10bd9d..4353e40 100755
>> >     > --- a/scripts/kconfig/lxdialog/check-lxdialog.sh
>> >     > +++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
>> >     > @@ -55,7 +55,8 @@ EOF
>> >     >           echo " *** required header files."
>>       1>&2
>> >     >           echo " *** 'make menuconfig' requires the ncurses
>> libraries." 1>&2
>> >     >           echo " *** "
>>       1>&2
>> >     > -         echo " *** Install ncurses (ncurses-devel) and try
>> again."    1>&2
>> >     > +         echo " *** Install ncurses (ncurses-devel or
>> libncurses-dev   1>&2
>> >     > +                *** depending on your distribution) and try
>> again."    1>&2
>> >     >           echo " *** "
>>       1>&2
>> >     >           exit 1
>> >     >       fi
>>
>>
>> --
>> ~Randy
>>
>
>

--94eb2c1a68cc94501d05664b9a3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">If it is not possible or difficult to identify the ncurses=
 development package name for all existing and future Linux distributions, =
one possibility is that we can change the message to say &quot;Please insta=
ll the ncurses library development package and try again&quot;. This way we=
 don&#39;t have to specify a package name. =C2=A0=C2=A0</div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Wed, Feb 28, 2018 at 2:59 PM=
, Arvind Prasanna <span dir=3D"ltr">&lt;<a href=3D"mailto:arvindprasanna@gm=
ail.com" target=3D"_blank">arvindprasanna@gmail.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>If a Linux distribut=
ion is RPM based, the package name is libncurses-dev and if it is Debian ba=
sed, it is ncurses-devel. Here are some examples:</div><div><br></div><div>=
# cat /etc/os-release | grep &quot;PRETTY_NAME&quot;</div><div>PRETTY_NAME=
=3D&quot;Debian GNU/Linux 9 (stretch)&quot;</div><div># apt-cache search li=
bncurses-dev</div><div>libncurses5-dev - developer&#39;s libraries for ncur=
ses</div><div><br></div><div># cat /etc/os-release | grep &quot;PRETTY_NAME=
&quot;<br></div><div>PRETTY_NAME=3D&quot;Ubuntu 16.04.3 LTS&quot;</div><div=
># apt-cache search libncurses-dev</div><div>libncurses5-dev - developer&#3=
9;s libraries for ncurses</div><div><br></div><div><br></div><div># cat /et=
c/os-release | grep &quot;PRETTY_NAME&quot;<br></div><div>PRETTY_NAME=3D&qu=
ot;CentOS Linux 7 (Core)&quot;</div><div># yum search ncurses-devel=C2=A0</=
div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D N/S matched: ncurses-devel =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wb=
r>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>ncurses-devel.i686 : Developm=
ent files for the ncurses library</div><div>ncurses-devel.x86_64 : Developm=
ent files for the ncurses library</div><div><br></div><div># cat /etc/os-re=
lease | grep &quot;PRETTY_NAME&quot;<br></div><div>PRETTY_NAME=3D&quot;Fedo=
ra 27 (Twenty Seven)&quot;</div><div># yum search ncurses-devel</div><div>L=
ast metadata expiration check: 0:05:07 ago on Wed Feb 28 19:20:24 2018.</di=
v><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D Name E=
xactly Matched: ncurses-devel =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=
=3D=3D=3D=3D=3D</div><div>ncurses-devel.i686 : Development files for the nc=
urses library</div><div>ncurses-devel.x86_64 : Development files for the nc=
urses library</div><div><br></div><div><br></div><div>I have tried RPM base=
d and Debian based linux distros as they are extensively used and widely di=
stributed. For other (independent) Linux distributions, it is possible they=
 have their own names for the ncurses development package.=C2=A0</div><div>=
<br></div><div>Thanks,</div><div><br></div><div>- Arvind.</div></div><div c=
lass=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Wed, Feb 28, 2018 at 1:59 PM, Randy Dunlap <span dir=3D=
"ltr">&lt;<a href=3D"mailto:rdunlap@infradead.org" target=3D"_blank">rdunla=
p@infradead.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><sp=
an>On 02/28/2018 09:39 AM, Arvind Prasanna wrote:<br>
&gt; Hi Randy:<br>
&gt;<br>
&gt; On 02/27/2018 10:59 PM, Arvind Prasanna wrote:<br>
&gt;&gt; The package name is ncurses-devel for Redhat based distros<br>
&gt;&gt; and libncurses-devel for Debian based distros.<br>
&gt;<br>
&gt; The above lines are part of the commit message and the patch says to i=
nstall either ncurses-devel or libncurses-dev based on the user&#39;s Linux=
 distribution. Would you prefer I add my commit message lines to the patch =
as well?<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Arvind.<br>
&gt;<br>
&gt;<br>
</span><span>&gt; On Wed, Feb 28, 2018 at 12:31 PM, Randy Dunlap &lt;<a hre=
f=3D"mailto:rdunlap@infradead.org" target=3D"_blank">rdunlap@infradead.org<=
/a> &lt;mailto:<a href=3D"mailto:rdunlap@infradead.org" target=3D"_blank">r=
dunlap@infradead.org</a>&gt;<wbr>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 02/27/2018 10:59 PM, Arvind Prasanna wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The package name is ncurses-devel for Redhat b=
ased distros<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and libncurses-devel for Debian based distros.=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^ That&#39;s no=
t what the patch says. Please clarify.<br>
<br>
</span>For Debian-based distros, is it libncurses-devel (above) or is it<br=
>
libncurses-dev (as below)?=C2=A0 [latter is without the ending &quot;el&quo=
t;]<br>
<br>
<br>
And what about the other few hundred distros?=C2=A0 (rhetorical)<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Arvind Prasanna &lt;<a href=3D"=
mailto:arvindprasanna@gmail.com" target=3D"_blank">arvindprasanna@gmail.com=
</a> &lt;mailto:<a href=3D"mailto:arvindprasanna@gmail.com" target=3D"_blan=
k">arvindprasanna@gmail.c<wbr>om</a>&gt;&gt;<br>
<div class=3D"m_5059714135315977379HOEnZb"><div class=3D"m_5059714135315977=
379h5">&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 scripts/kconfig/lxdialog/check<wbr>-lxdi=
alog.sh | 3 ++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 2 insertions(+), 1 delet=
ion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/scripts/kconfig/lxdialog/che<wbr>=
ck-lxdialog.sh b/scripts/kconfig/lxdialog/che<wbr>ck-lxdialog.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index a10bd9d..4353e40 100755<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/scripts/kconfig/lxdialog/che<wbr>ck-lxdi=
alog.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/scripts/kconfig/lxdialog/che<wbr>ck-lxdi=
alog.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -55,7 +55,8 @@ EOF<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &=
quot; *** required header files.&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &=
quot; *** &#39;make menuconfig&#39; requires the ncurses libraries.&quot; 1=
&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &=
quot; *** &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=
 *** Install ncurses (ncurses-devel) and try again.&quot;=C2=A0 =C2=A0 1&gt=
;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=
 *** Install ncurses (ncurses-devel or libncurses-dev=C2=A0 =C2=A01&gt;&amp=
;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *** depending on your distribution) and try again.&quot;=C2=A0 =
=C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &=
quot; *** &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
<br>
<br>
</div></div><span class=3D"m_5059714135315977379HOEnZb"><font color=3D"#888=
888">--<br>
~Randy<br>
</font></span></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--94eb2c1a68cc94501d05664b9a3f--
