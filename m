Return-Path: <kstewart@linuxfoundation.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517603201; cv=none;
        d=google.com; s=arc-20160816;
        b=ejQeEmkDlF8O3gs/Rh+pDWSyPtEBso7i5vmLQWzoVl5HvW7vui/pHV4MPFgAVMLI2V
         a1CgqBsK6invaR2qVaDnWubwDmFwuvgWkoG/qfvtLYtE3q3li0rh41FmghX9kH0UbabG
         cfQ2BKyLwlAFo0lUoyDnH4jjPjbNzIB4jyNUtRxRCm9knIZU9B8rSFCfkyvoVrzdIhH/
         zRJdb1IV8/Aw4Q128Q1XYBKYv8MEMJJxUEElNAWp4i1ZA7RqpBW1FkJ1/d5WU/2TPjB2
         BBUdt9Q8P59gNr8FgcYhm7fQVd8j7vG6ZOUpMoLjs4YMv8fOIIOgbv/8QqdsJs2Wlacj
         JRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=fdR/uM2xxa2aaEx7L3CuaFF3D3CHKZ264AGlQgOO7Mw=;
        b=ap2CpnLHqFYTS/nwo3rvDetr3UdUZDBuOgxYNW+nq94vvHXmYjBT8Y0qgySt5bwZm3
         5nUsr2HDpMVhaOIp9D6Qx9XY6ytWVPuSV6d+cINGmPkMv5pnMTGTm/OjE800yPrUhoJb
         aMgUxX1AbA0TZJD5FcYYCzrbbSufMCQEPFRDPKsFUGoNYemlQdnS9+GLrcjbyqGbThCD
         E/N1YkmrLTTDjhsYcL7QvuC8ACoL3aMi9ifPuIL+ueoFC0VZDrH4v0ycaxNf1TqjMwfD
         tscUxZE6Fpy8hqjFvIrAk23KRPcJm7Rwmy4Ry45JMjEQkd87IJLDsoW6Vz7xNMq9auvO
         5KiA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=blWCAPFb;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=blWCAPFb;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
X-Google-Smtp-Source: AH8x224pShuGlDLPfhVTnZgXI/WNnR+5OD09gs39M+9dmratsTargBujy8Dv7q6cY7+eh2SsRIdJe0ZkIdO6y3XDssw=
MIME-Version: 1.0
In-Reply-To: <CAG_66ZT6R2Ki3AnH6RWRXpd8d64NDR2y-0BwyqJRpQD4hD01oQ@mail.gmail.com>
References: <20180202154026.15298-1-robh@kernel.org> <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
 <1517598363.7489.126.camel@perches.com> <CAG_66ZT6R2Ki3AnH6RWRXpd8d64NDR2y-0BwyqJRpQD4hD01oQ@mail.gmail.com>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Fri, 2 Feb 2018 14:26:40 -0600
Message-ID: <CAG_66ZT3OHQ1xcnAAFJX+fjpB1d7Z0EWuuFmDEXVPALEpmXhkQ@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Joe Perches <joe@perches.com>
Cc: Rob Herring <robh@kernel.org>, Igor Stoppa <igor.stoppa@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: multipart/alternative; boundary="94eb2c0750fab7969305644087f2"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591322294848678845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c0750fab7969305644087f2
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 2, 2018 at 2:18 PM, Kate Stewart <kstewart@linuxfoundation.org>
wrote:
>
> On Fri, Feb 2, 2018 at 1:06 PM, Joe Perches <joe@perches.com> wrote:
>>
>> On Fri, 2018-02-02 at 12:27 -0600, Rob Herring wrote:
>> > On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa <igor.stoppa@huawei.com>
wrote:
>> > > On 02/02/18 17:40, Rob Herring wrote:
>> > > > Add SPDX license tag check based on the rules defined in
>> > >
>> > > Shouldn't it also check that the license is compatible?
>> > >
>> >
>> > Perhaps we shouldn't try to script legal advice.
>>
>> True.
>>
>> I believe what was meant was that the
>> entry was a valid SPDX License entry
>> that already exists as a specific file
>> in the LICENSES/ path.
>>
>> So that entry must be some combination of:
>>
>> $ git ls-files LICENSES/ | cut -f3- -d'/' | sort
>> BSD-2-Clause
>> BSD-3-Clause
>> BSD-3-Clause-Clear
>> GPL-1.0
>> GPL-2.0
>> LGPL-2.0
>> LGPL-2.1
>> Linux-syscall-note
>> MIT
>> MPL-1.1
>>
>> From my perspective, it'd be better if the
>> various + uses had their own individual
>> license files in the LICENSES/ path.
>
>
> At the end of december, the SPDX license list[1] was rev'd to
> Version: 3.0 28 December 2017.   At the request of
> FSF, the GNU license family would not use the "+" notation,
> and would bias towards using "-only" and "-or-later", explicitly.
> So adding both variants to the LICENSES/ path aligns with
> this forward direction.
>
>>
>> Right now, there are many missing licenses
>> that are already used by various existing
>> SPDX-License-Identifier: entries.
>>
>>
>> APACHE-2.0
>> BSD
>> CDDL
>> CDDL-1.0
>> ISC
>> GPL-1.0+
>> GPL-2.0+
>> LGPL-2.1+
>> OpenSSL
>>
>> There are odd entries like:
>>
>> GPL-2.0-only
>
>
> This is the new way to represent GPLv2 only, as described above.
> While the GPL-2.0 and GPL-2.0+ notation is still valid,  it is deprecated
> in the latest version, so transitioning existing over time will probably
> be needed.   So I think the list of licenses to be added to
> LICENSES/ path is:
>
> APACHE-2.0
> BSD
> CDDL

Oops - should not have included CDDL as its not a valid SPDX identifier.
It should be either CDDL-1.0 or CDDL-1.1,  and the place where it was
found needs to be fixed.   See [1] for valid SPDX identifiers.

> CDDL-1.0
> ISC
> GPL-1.0-only
> GPL-1.0-or-later (note: actually same contents as one GPL-1.0-only)
> GPL-2.0-only
> GPL-2.0-or-later (same contents as GPL-2.0-only)
> LGPL-2.0-only
> LGPL-2.0-or-later (same contents as LGPL-2.0-only)
> LGPL-2.1-only
> LGPL-2.1-or-later (same contents as LGPL-2.1-only)
> OpenSSL
>
> Having files with the same contents, but different names is
> irritating, but I can't see a another way of complying with REUSE
> guidelines.   Any better suggestions?
>
>>
>> Parentheses around AND/OR aren't consistent.
>
>
> The SPDX specification has an appendix that calls for "(",")"
> around every license expresssion.   After discussion with some
> developers it was decided to be ok to relax that, and only add them
> when they were essential to clarify the logic.   The next rev of the
> SPDX specification will have this clarified as well.   I think we caught
> most of the changes in the kernel documentation patches for describing
> this,  but if you have specific cases to be reviewed,  happy to have
> a look.
>
> Thanks, Kate
>
>
> [1] https://spdx.org/licenses/

--94eb2c0750fab7969305644087f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>On Fri, Feb 2, 2018 at 2:18 PM, Kate Stewart &lt;<a hr=
ef=3D"mailto:kstewart@linuxfoundation.org">kstewart@linuxfoundation.org</a>=
&gt; wrote:<br>&gt;<br>&gt; On Fri, Feb 2, 2018 at 1:06 PM, Joe Perches &lt=
;<a href=3D"mailto:joe@perches.com">joe@perches.com</a>&gt; wrote:<br>&gt;&=
gt;<br>&gt;&gt; On Fri, 2018-02-02 at 12:27 -0600, Rob Herring wrote:<br>&g=
t;&gt; &gt; On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa &lt;<a href=3D"mail=
to:igor.stoppa@huawei.com">igor.stoppa@huawei.com</a>&gt; wrote:<br>&gt;&gt=
; &gt; &gt; On 02/02/18 17:40, Rob Herring wrote:<br>&gt;&gt; &gt; &gt; &gt=
; Add SPDX license tag check based on the rules defined in<br>&gt;&gt; &gt;=
 &gt;<br>&gt;&gt; &gt; &gt; Shouldn&#39;t it also check that the license is=
 compatible?<br>&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Perhap=
s we shouldn&#39;t try to script legal advice.<br>&gt;&gt;<br>&gt;&gt; True=
.<br>&gt;&gt;<br>&gt;&gt; I believe what was meant was that the<br>&gt;&gt;=
 entry was a valid SPDX License entry<br>&gt;&gt; that already exists as a =
specific file<br>&gt;&gt; in the LICENSES/ path.<br>&gt;&gt;<br>&gt;&gt; So=
 that entry must be some combination of:<br>&gt;&gt;<br>&gt;&gt; $ git ls-f=
iles LICENSES/ | cut -f3- -d&#39;/&#39; | sort<br>&gt;&gt; BSD-2-Clause<br>=
&gt;&gt; BSD-3-Clause<br>&gt;&gt; BSD-3-Clause-Clear<br>&gt;&gt; GPL-1.0<br=
>&gt;&gt; GPL-2.0<br>&gt;&gt; LGPL-2.0<br>&gt;&gt; LGPL-2.1<br>&gt;&gt; Lin=
ux-syscall-note<br>&gt;&gt; MIT<br>&gt;&gt; MPL-1.1<br>&gt;&gt;<br>&gt;&gt;=
 From my perspective, it&#39;d be better if the<br>&gt;&gt; various + uses =
had their own individual<br>&gt;&gt; license files in the LICENSES/ path.<b=
r>&gt;<br>&gt;<br>&gt; At the end of december, the SPDX license list[1] was=
 rev&#39;d to<br>&gt; Version: 3.0 28 December 2017. =C2=A0 At the request =
of<br>&gt; FSF, the GNU license family would not use the &quot;+&quot; nota=
tion,<br>&gt; and would bias towards using &quot;-only&quot; and &quot;-or-=
later&quot;, explicitly.<br>&gt; So adding both variants to the LICENSES/ p=
ath aligns with<br>&gt; this forward direction.<br>&gt;<br>&gt;&gt;<br>&gt;=
&gt; Right now, there are many missing licenses<br>&gt;&gt; that are alread=
y used by various existing<br>&gt;&gt; SPDX-License-Identifier: entries.<br=
>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; APACHE-2.0<br>&gt;&gt; BSD<br>&gt;&gt; CD=
DL<br>&gt;&gt; CDDL-1.0<br>&gt;&gt; ISC<br>&gt;&gt; GPL-1.0+<br>&gt;&gt; GP=
L-2.0+<br>&gt;&gt; LGPL-2.1+<br>&gt;&gt; OpenSSL<br>&gt;&gt;<br>&gt;&gt; Th=
ere are odd entries like:<br>&gt;&gt;<br>&gt;&gt; GPL-2.0-only<br>&gt;<br>&=
gt;<br>&gt; This is the new way to represent GPLv2 only, as described above=
.<br>&gt; While the GPL-2.0 and GPL-2.0+ notation is still valid, =C2=A0it =
is deprecated<br>&gt; in the latest version, so transitioning existing over=
 time will probably<br>&gt; be needed. =C2=A0 So I think the list of licens=
es to be added to<br>&gt; LICENSES/ path is:<br>&gt; =C2=A0<br>&gt; APACHE-=
2.0<br>&gt; BSD<br>&gt; CDDL<br><br>Oops - should not have included CDDL as=
 its not a valid SPDX identifier.<br>It should be either CDDL-1.0 or CDDL-1=
.1, =C2=A0and the place where it was<br>found needs to be fixed.=C2=A0 =C2=
=A0See [1] for valid SPDX identifiers.<br><br>&gt; CDDL-1.0<br>&gt; ISC<br>=
&gt; GPL-1.0-only<br>&gt; GPL-1.0-or-later (note: actually same contents as=
 one GPL-1.0-only)<br>&gt; GPL-2.0-only<br>&gt; GPL-2.0-or-later (same cont=
ents as GPL-2.0-only)<br>&gt; LGPL-2.0-only<br>&gt; LGPL-2.0-or-later (same=
 contents as LGPL-2.0-only)<br>&gt; LGPL-2.1-only<br>&gt; LGPL-2.1-or-later=
 (same contents as LGPL-2.1-only)<br>&gt; OpenSSL<br>&gt;<br>&gt; Having fi=
les with the same contents, but different names is<br>&gt; irritating, but =
I can&#39;t see a another way of complying with REUSE<br>&gt; guidelines. =
=C2=A0 Any better suggestions?<br>&gt; =C2=A0<br>&gt;&gt;<br>&gt;&gt; Paren=
theses around AND/OR aren&#39;t consistent.<br>&gt;<br>&gt;<br>&gt; The SPD=
X specification has an appendix that calls for &quot;(&quot;,&quot;)&quot;<=
br>&gt; around every license expresssion. =C2=A0 After discussion with some=
<br>&gt; developers it was decided to be ok to relax that, and only add the=
m<br>&gt; when they were essential to clarify the logic. =C2=A0 The next re=
v of the<br>&gt; SPDX specification will have this clarified as well. =C2=
=A0 I think we caught<br>&gt; most of the changes in the kernel documentati=
on patches for describing<br>&gt; this, =C2=A0but if you have specific case=
s to be reviewed, =C2=A0happy to have<br>&gt; a look.<br>&gt;<br>&gt; Thank=
s, Kate<br>&gt;<br>&gt;<br>&gt; [1] <a href=3D"https://spdx.org/licenses/">=
https://spdx.org/licenses/</a><br></div>

--94eb2c0750fab7969305644087f2--
