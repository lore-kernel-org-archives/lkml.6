Return-Path: <972cb970.AMsAAAZdfIgAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5NDP@bnc3.mailjet.com>
X-Google-Smtp-Source: AB8JxZrC6I3TikojMFCeeIk3CyPbfoveuLifIkUJSg8wv4nwN8brJxGNBJUGOYpO0moIlsDic9Or
ARC-Seal: i=1; a=rsa-sha256; t=1524945104; cv=none;
        d=google.com; s=arc-20160816;
        b=aHYUuw+08w6iCGRrg7LDwqEQyLztY1qigfp0TN0bM6CKy60sc0GyOY7Pxgq1KLGXaN
         onTF6UPuW32oTMSGuHKK7Wq843JxCcL0hUQrl/tCaWloEYur5S7r1Vgj3ksKqVd1+hGW
         ekYzVzQkH71gau6sP2xNLJx/drkR3fQxu2Rp27iwJKKFLabblH3ITFqR43CosNmSBwR9
         cLlhPmUn45uPbX0rtAn/pMDf+y4Y0yZfubrjFFYVU7XnpVOBFP/uPrHR/GYXx80TN7Zk
         ys7kOc9tMhHEBezdGlYTSMuDQo+44X9VrIP3mhv6lP0DiX77oKuw2f+CSzPqeruTZPoe
         3X+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:cc:list-unsubscribe:date:subject:to:from
         :mime-version:message-id:dkim-signature:arc-authentication-results;
        bh=PvFVf5d0CYlVahoTKdEXo5gvKkcUNLdU7BB6D6lQKME=;
        b=XwyOWzsdm0f+Q1SwlhalT1B/jPnqiWPuHFllSSIIW5RJcsHPdu5e3CeUV7pORKlPfm
         4A81kbyfGY72Wqzx4Bbl0GafhDNmtOPut6T8Xx73OKeHkkPoi3pFRDx2cCGokdY+BjD+
         oyNTlZwLfPpQ1j+W8dwevC249W9y2GHN9NRZo3g+WTLTWq0wxB92R6W13UkIsgJVZjtA
         nwhsGwL55+IEbkLThdM78j6ToLZPVyM3l09J+3ocNlZvaRcFOds2bygbgR/GlqHmBy9e
         HeBWRaUkOJ3i5iNT6PNrHfH35iw7CiiqUTn8Cvyr3CPCUUWXDyzV1Nr1rM1TtdWBoEA0
         fG8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@elg.io header.s=mailjet header.b=n9XNxbCz;
       spf=pass (google.com: domain of 972cb970.amsaaazdfigaaaaaaaaaaadfwyuaaaasziyaaaaaaarw7aba5ndp@bnc3.mailjet.com designates 87.253.234.102 as permitted sender) smtp.mailfrom=972cb970.AMsAAAZdfIgAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5NDP@bnc3.mailjet.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@elg.io header.s=mailjet header.b=n9XNxbCz;
       spf=pass (google.com: domain of 972cb970.amsaaazdfigaaaaaaaaaaadfwyuaaaasziyaaaaaaarw7aba5ndp@bnc3.mailjet.com designates 87.253.234.102 as permitted sender) smtp.mailfrom=972cb970.AMsAAAZdfIgAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5NDP@bnc3.mailjet.com
Message-Id: <972cb970.AMsAAAZdfIgAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5NDP@mailjet.com>
MIME-Version: 1.0
From: Efstratios Gavas <xtrat@elg.io>
To: gregkh@linuxfoundation.org
Subject: Re: [PATCHv3] staging: wlan-ng: prism2sta: fixed indent coding
 style issues.
Date: Sat, 28 Apr 2018 19:51:06 +0000
List-Unsubscribe: <mailto:unsub-972cb970.7334.smk9z9mtsqhk@bnc3.mailjet.com>
Cc: devel@driverdev.osuosl.org, thibaut.sautereau@telecom-sudparis.eu,
	chris@pezley.net, linux-kernel@vger.kernel.org,
	abdallah.meziti.pro@gmail.com, aviyae42@gmail.com, dan.carpenter@oracle.com,
	palaviv@gmail.com
In-Reply-To: <20180428060141.GC18371@kroah.com>
References: <20180427065801.GC4361@kroah.com>
	<2ac130bd.AMIAAAY8Aw8AAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa45e6@mailjet.com>
	<20180428060141.GC18371@kroah.com>
X-CSA-Complaints: whitelist-complaints@eco.de
X-Gmail-Original-Message-ID: <CAFRovncgSgq0P8mq=XNxbNp2ZLrOXAbqqiVYcR0AE2yeXoAN0Q@mail.gmail.com>
X-MJ-Mid: AMsAAAZdfIgAAAAAAAAAAADFWYUAAAASzIYAAAAAAArW7ABa5NDPP0ANhUf8Slm2cBvsGW-nvwAKs_E
X-MJ-SMTPGUID: 3f400d85-47fc-4a59-b670-1bec196fa7bf
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
	abuse@mailjet.com with a copy of the message
Content-Type: multipart/alternative; boundary=000000000000205db1056aedf3eb
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598936794627162983?=
X-GMAIL-MSGID: =?utf-8?q?1599020837357817450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000205db1056aedf3eb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The second patch was submitted in error.  I will resubmit a new patch to
(hopefully) clarify the issue.

E.

On Sat, Apr 28, 2018 at 2:01 AM Greg Kroah-Hartman <
gregkh@linuxfoundation.org> wrote:

> On Fri, Apr 27, 2018 at 09:33:34PM +0000, Efstratios Gavas wrote:
> > Fixed format/style issues found with checkpatch. No code changes.
> > Corrected alignment of variables after open parenthesis and line breaks=
.
> > Checkpatch now returns clean except for line over 80 char warnings.
> >
> > Signed-off-by: Efstratios Gavas <xtrat@elg.io>
> > ---
> > v2(unlabled): changed title info
> > v3: improved changlog description
> > ---
> >  drivers/staging/wlan-ng/prism2sta.c | 52
> +++++++++++++++++--------------------
> >  1 file changed, 24 insertions(+), 28 deletions(-)
>
> Why was this sent twice?  Which one should I take?
>
> I'm dropping both, please only send 1 patch next time.
>
> thanks,
>
> greg k-h
>
=

--000000000000205db1056aedf3eb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The second patch was submitted in error.=C2=A0 I will resu=
bmit a new patch to (hopefully) clarify the issue.<div><br></div><div>E.<br=
><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sat, Apr 28, 2018 at 2:=
01 AM Greg Kroah-Hartman &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">=
gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">On Fri, Apr 27, 2018 at 09:33:34PM +0000, Efstratios Gavas wrote:<br=
>
&gt; Fixed format/style issues found with checkpatch. No code changes.<br>
&gt; Corrected alignment of variables after open parenthesis and line break=
s.<br>
&gt; Checkpatch now returns clean except for line over 80 char warnings.<br=
>
&gt; <br>
&gt; Signed-off-by: Efstratios Gavas &lt;<a href=3D"mailto:xtrat@elg.io" ta=
rget=3D"_blank">xtrat@elg.io</a>&gt;<br>
&gt; ---<br>
&gt; v2(unlabled): changed title info<br>
&gt; v3: improved changlog description<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/wlan-ng/prism2sta.c | 52 +++++++++++++++++------=
--------------<br>
&gt;=C2=A0 1 file changed, 24 insertions(+), 28 deletions(-)<br>
<br>
Why was this sent twice?=C2=A0 Which one should I take?<br>
<br>
I&#39;m dropping both, please only send 1 patch next time.<br>
<br>
thanks,<br>
<br>
greg k-h<br>
</blockquote></div></div></div>
=

--000000000000205db1056aedf3eb--
