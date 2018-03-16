Return-Path: <smfrench@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521217157; cv=none;
        d=google.com; s=arc-20160816;
        b=ZVn66N8TiPGLSOPGfeubUSOxcT1GHi3HlAPWRFZHptvztlsOgHEYsdK3tmTIrMb4LD
         8WG09dWiXhlfbrG82QjFqJR1jho3agYeYAllfSJoGmkDIxbMUVR/5FqFHVa8CIVj7X6r
         5xN2EjJWhVd3DfKahy63GKelRRv6vNJEtJgbUId262irn3L1c/rxLF3eoNu7M97oPX7T
         YaSMh6JgewqAJbSlJytukleH8GeW9xhaQVQsEiMg+SI04XMC0ESavoMqmFzr6rAkSMrK
         TSw19waUE5wt/C8U0Yt/gAar3MHDkhvpJyyxLa1z0LpQKqW8ZG8zD4EV6NxnIQlUAEA7
         zZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5wluBGUN/FrEMoigu3/1m6kRCpJUy2asnJT+46RJDhE=;
        b=KJJptOHkmSdk556LXVWs2wd8OZwzWQSDxOhqa5HbOa0Z81HxSB8/if/TGouJsyYqOa
         2W+Ro+ckE6Yw8ndaUM9AY/kfNRqnVSDD8TcIsTu09XOPyI5QvQNwXsK/kyrmqvUEhrZ3
         K/Ip4rF9H+2ldK/GvBN5L6oJpFDPzEkIO8HZHWXv/1wsVvzP1gzcKr8QeOgrVkgxAKYf
         Vtudx8EXq1Ad+/TlEW9OIf1dZGvKYqoXIX/9iRxBrtVXMa+Ia7uGy4FDHD8sm3bP4vKN
         hhHCd/XD1dGcZDksGqaReVArs0A2gfe6us1HO5RNgkNKMaXxjdurEl/WJZAj5sq2JOqK
         yCxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FWcyC8uz;
       spf=pass (google.com: domain of smfrench@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=smfrench@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FWcyC8uz;
       spf=pass (google.com: domain of smfrench@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=smfrench@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtr7E7pqGDzPu4GtPo7NMkigOLIMO3/I4mc7gsK40R6j0nx0HkkoboJ9/i6AmQXjJBG13ag5V9SjuBohY3zFcw=
MIME-Version: 1.0
References: <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
 <20180227085428.GA16879@kroah.com> <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
 <20180227124050.GB31888@kroah.com> <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu>
 <CAH2r5mt91WGHDk-+LP4EBTEfAOmrY2k6_X7KKjc0D+LcDCfxRw@mail.gmail.com>
 <309db6c4-7e21-bfbe-44d4-eb41f5516d5e@csail.mit.edu> <CAH2r5muUfsZsqaBqkAfi_dXRheib+7DN=VSsbGcV22C2MdJaGw@mail.gmail.com>
 <20180313092133.GA13325@kroah.com> <CAH2r5mvmiTaC4W=LAaOvWv6xGEMce957c+u+Af6wNgxudbO3_w@mail.gmail.com>
 <20180316133241.GC11397@kroah.com>
In-Reply-To: <20180316133241.GC11397@kroah.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 16 Mar 2018 16:19:04 +0000
Message-ID: <CAH2r5mvFMhqBrMJAseURWU5g=nNVuZH6DjCR5rocZYM-G6pLew@mail.gmail.com>
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, Thomas Backlund <tmb@mageia.org>,
	=?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
	LKML <linux-kernel@vger.kernel.org>, Stable <stable@vger.kernel.org>,
	Ronnie Sahlberg <lsahlber@redhat.com>, Pavel Shilovskiy <pshilov@microsoft.com>,
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/alternative; boundary="94eb2c1930563e3c58056789f871"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1582766661007473179?=
X-GMAIL-MSGID: =?utf-8?q?1595111801749549741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c1930563e3c58056789f871
Content-Type: text/plain; charset="UTF-8"

Am going through the list of patches one by one (just got back in town) to
find the missing one.

On Fri, Mar 16, 2018, 08:32 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
wrote:

> On Tue, Mar 13, 2018 at 10:21:45AM -0500, Steve French wrote:
> > There will be a fix needed to correct an oops in calc_signature,
> > besides the easy patch (smb3 validate negotiate patch).
>
> Ok, I still have no idea how to parse this for a stable tree submission.
>
> So can someone please just send me a simple "apply these git ids to tree
> X.X.y so we can fix the problem", otherwise I'm not going to do anything
> here as I'm really confused,
>
> greg k-h
>

--94eb2c1930563e3c58056789f871
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Am going through the list of patches one by one (just got=
 back in town) to find the missing one.</div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr">On Fri, Mar 16, 2018, 08:32 Greg Kroah-Hartman &lt;<a hre=
f=3D"mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">On Tue, Mar 13, 2018 at 10:2=
1:45AM -0500, Steve French wrote:<br>
&gt; There will be a fix needed to correct an oops in calc_signature,<br>
&gt; besides the easy patch (smb3 validate negotiate patch).<br>
<br>
Ok, I still have no idea how to parse this for a stable tree submission.<br=
>
<br>
So can someone please just send me a simple &quot;apply these git ids to tr=
ee<br>
X.X.y so we can fix the problem&quot;, otherwise I&#39;m not going to do an=
ything<br>
here as I&#39;m really confused,<br>
<br>
greg k-h<br>
</blockquote></div>

--94eb2c1930563e3c58056789f871--
