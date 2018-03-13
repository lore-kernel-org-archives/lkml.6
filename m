Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520958356; cv=none;
        d=google.com; s=arc-20160816;
        b=TIwfuZs+eNgDDCbjg0acEcbEOGKsCFIi1hAiYnmzmoV76R3fMjIzxKurOOAnJkr/sx
         wyLiVH6p0KLAcAlbS0ULRq37lLn5oj0wmQHQa1FcjKT40ZKTNKDo/4cOr8GtK510NvRH
         Hj3vN+4RdogmsAdVh9+YA9WtrptFk1QRGYnpwxdR/7z1NpCuiEtabux01rEAb7E9DyIR
         dJ/FMa3vlcSlAuMjFCACGssiMaHWw/SLDkRY/PZOAmDINROWuOlQHPeZmfUhL9EjCZ0c
         ooYU9h3mWas8d2YlJ68ltw2VSpt7VcDPXMG3v/UjwwMoQJAx0Ln000esAvavneY93JSy
         vTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=G7qrenketRqVB9h/oQBijPSzIYKoVRJM2znLlIhrzJs=;
        b=ziFM1jXZERK0ItAv7U9BOAAnKF9VuKmG1iX/3ugkdzroddXWQmR/l8z2nUP0xZdkVI
         GSq0q7MYotOOW02m488EutiJfBIyDC4yPybQ/IJeZD33eax7tIsuhKxAmtrT9UvgmO14
         /yfqaJc70N1XTeENAI3BhY7/wD3Yz6GGUa7hV2dKUQQX3RBFk2NeZSpiw4l9YpgXQF/C
         Mm8yJF8INR2IxT+Sk3UFoWN5rAPMfDYi9vWnytCu/tJSMkkBZPZ0MQbmFayW/rl30/L9
         L25JuDt6ZOPpEQ1RmaJz+US+VAetBqxYW6azCRIGOSTzeuuMsBehiNzqGLb+cwkUujyR
         vS/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V0iqaJM7;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V0iqaJM7;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu4+1UwoLfrXikxkzFhn5N3UhtL8DUEOiajOn4oWGyp4lcdx9Sm+EeNKVq/NwGRBquxtgrT62CT+iyPiiHNlZ8=
MIME-Version: 1.0
In-Reply-To: <87r2oo9jsk.fsf@kamboji.qca.qualcomm.com>
References: <20180309221243.15489-2-andresx7@gmail.com> <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
 <CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
 <bbdc304f-edd5-38df-ea88-012fefc54b90@gmail.com> <5AA5B777.5020106@broadcom.com>
 <20180312192704.GX4449@wotan.suse.de> <87r2oo9jsk.fsf@kamboji.qca.qualcomm.com>
From: Andres Rodriguez <andresx7@gmail.com>
Date: Tue, 13 Mar 2018 12:25:54 -0400
Message-ID: <CAFQ_0eGrjDKJegK+8kJD90nThFeDHgdzGqYrmiYXSqKBorog0Q@mail.gmail.com>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
To: Kalle Valo <kvalo@codeaurora.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Arend Van Spriel <arend.vanspriel@broadcom.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>, Ilia Mirkin <imirkin@alum.mit.edu>
Content-Type: multipart/alternative; boundary="001a1147b12a83db8605674db63c"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594840429597528623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a1147b12a83db8605674db63c
Content-Type: text/plain; charset="UTF-8"

Hi All,

I've been a little busy at the hospital with a kidney stone, sorry for no
updates :(

Just wanted to also chime in to say that I'm also okay with using a
different name. Preference for nowarn over quiet since I don't think we'll
provide a guarantee about other error messages being printed.

I probably won't have time for a respin of the patch until at least next
week.

Regards,
Andres



On Mar 13, 2018 9:39 AM, "Kalle Valo" <kvalo@codeaurora.org> wrote:

> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
>
> > On Mon, Mar 12, 2018 at 12:10:47AM +0100, Arend van Spriel wrote:
> >> On 3/11/2018 5:05 PM, Andres Rodriguez wrote:
> >> > > Your patch series then should also have the driver callers who you
> >> > > want to modify to use this new API. Collect from the 802.11 folks
> the
> >> > > other drivers which I think they wanted changed as well.
> >> >
> >> > Arend, Kalle, would love to hear your feedback.
> >>
> >> I am not sure if it was ath10k, but Kalle will surely know. The other
> driver
> >> firing a whole batch of firmware requests is iwlwifi. These basically
> try to
> >> get latest firmware version and if not there try an older one.
> >
> > Ah I recall now. At least for iwlwifi its that it requests firmware with
> a
> > range of api files, and we don't need information about files in the
> middle
> > not found, given all we need to know if is if at lest one file was found
> > or not.
> >
> > I have future code to also enable use of a range request which would
> replace
> > the recursive nature of iwlwifi's firmware API request, so it simplifies
> it
> > considerably.
> >
> > Once we get this flag to be silent in, this can be used later. Ie, the
> new
> > API I'd add would replace the complex api revision thing for an internal
> set.
>
> TBH I doubt we would use this kind of "range" request in ath10k, the
> current code works just fine only if we can get rid of the annoying
> warning from request_firmware(). Unless if it's significantly faster or
> something.
>
> --
> Kalle Valo
>

--001a1147b12a83db8605674db63c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi All,<div dir=3D"auto"><br></div><div dir=3D"auto">I&#3=
9;ve been a little busy at the hospital with a kidney stone, sorry for no u=
pdates :(</div><div dir=3D"auto"><br></div><div dir=3D"auto">Just wanted to=
 also chime in to say that I&#39;m also okay with using a different name. P=
reference for nowarn over quiet since I don&#39;t think we&#39;ll provide a=
 guarantee about other error messages being printed.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">I probably won&#39;t have time for a respin of=
 the patch until at least next week.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Regards,</div><div dir=3D"auto">Andres</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><br></div></div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On Mar 13, 2018 9:39 AM, &quot;Kalle Valo&quot; =
&lt;<a href=3D"mailto:kvalo@codeaurora.org">kvalo@codeaurora.org</a>&gt; wr=
ote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&quot;Luis R. R=
odriguez&quot; &lt;<a href=3D"mailto:mcgrof@kernel.org">mcgrof@kernel.org</=
a>&gt; writes:<br>
<br>
&gt; On Mon, Mar 12, 2018 at 12:10:47AM +0100, Arend van Spriel wrote:<br>
&gt;&gt; On 3/11/2018 5:05 PM, Andres Rodriguez wrote:<br>
&gt;&gt; &gt; &gt; Your patch series then should also have the driver calle=
rs who you<br>
&gt;&gt; &gt; &gt; want to modify to use this new API. Collect from the 802=
.11 folks the<br>
&gt;&gt; &gt; &gt; other drivers which I think they wanted changed as well.=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Arend, Kalle, would love to hear your feedback.<br>
&gt;&gt;<br>
&gt;&gt; I am not sure if it was ath10k, but Kalle will surely know. The ot=
her driver<br>
&gt;&gt; firing a whole batch of firmware requests is iwlwifi. These basica=
lly try to<br>
&gt;&gt; get latest firmware version and if not there try an older one.<br>
&gt;<br>
&gt; Ah I recall now. At least for iwlwifi its that it requests firmware wi=
th a<br>
&gt; range of api files, and we don&#39;t need information about files in t=
he middle<br>
&gt; not found, given all we need to know if is if at lest one file was fou=
nd<br>
&gt; or not.<br>
&gt;<br>
&gt; I have future code to also enable use of a range request which would r=
eplace<br>
&gt; the recursive nature of iwlwifi&#39;s firmware API request, so it simp=
lifies it<br>
&gt; considerably.<br>
&gt;<br>
&gt; Once we get this flag to be silent in, this can be used later. Ie, the=
 new<br>
&gt; API I&#39;d add would replace the complex api revision thing for an in=
ternal set.<br>
<br>
TBH I doubt we would use this kind of &quot;range&quot; request in ath10k, =
the<br>
current code works just fine only if we can get rid of the annoying<br>
warning from request_firmware(). Unless if it&#39;s significantly faster or=
<br>
something.<br>
<br>
--<br>
Kalle Valo<br>
</blockquote></div></div>

--001a1147b12a83db8605674db63c--
