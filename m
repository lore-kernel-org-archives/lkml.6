Return-Path: <gilad@benyossef.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520519205; cv=none;
        d=google.com; s=arc-20160816;
        b=K96dhXtTDhUNYCR1cQTc69NIz6+yFXPCnzfMoOXSluqtnwDGdg7k+WENterW/Zso14
         6PTo23RGerTbDQKqDuu6ZY/vL+c9YDiNGhzAQXi2faNRBpSGhTL8KINQLRMFEq3uFsZi
         RNL0JA/9r9+kt9AIkWckb6kyR8Gj+03obkrtP3R1TC5CaOPfoqQEhLcnkyfmFYWEspw7
         WdFIBL0ceo3mAe/GekwS0Xb9aCRONJcLuJ9eSl/Fs6BaTt4b3h2obJYAw2vHqDNn2mrb
         5afLnNn6HOPh/keN5kSGSrm0/NkbRlk2F3NGQUzMwXiikjLV+QLdDnxqBmzz0ObynOgM
         oLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=JlR9s6qvp04YFjSi33wZ3tr9sq91aWw/5W/rXef3LT4=;
        b=n7WP7rtjKeY1pWNFIAeOnHkOtDznSXTmMuPE1kAQvyCkvaDjcgcjqssqcsXqt28BiJ
         txKh1E1hQ+i796TwZe4NhKN/dH2tXpDLOWdD0sHoJ9d55owyn0Lo67tKsgpt5+l7FW2a
         Hjo28DjyWsJjpM6r4l6ZKIbrGaVeiJmJP+oLflZ9isFItU7BPEtJ3Q8HKF5pQ/KyGcjA
         cz8YZoHGl/Ik7ZmL/ggo3z+QtT9eqYonTbn5A39QdcvLomblWjKrEyH7N4om1vuSa/3F
         kPChUqkl/KO9kyCHTi51MnTiFcCJj98G8XmceJH5kBMvTiZzYrmAK/sG7RpvflnrE8ZI
         vilQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@benyossef-com.20150623.gappssmtp.com header.s=20150623 header.b=UdD9c9ce;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of gilad@benyossef.com) smtp.mailfrom=gilad@benyossef.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@benyossef-com.20150623.gappssmtp.com header.s=20150623 header.b=UdD9c9ce;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of gilad@benyossef.com) smtp.mailfrom=gilad@benyossef.com
X-Google-Smtp-Source: AG47ELvFr0Q21vwPGEdmgCQnmcqPsMqgN6lePLTDWYSuS1RYkBLrf5thKMr8yYWz/7r47AI2AFEramhWr/jojwEGVJA=
MIME-Version: 1.0
X-Originating-IP: [217.140.96.140]
In-Reply-To: <20180308110819.v4zfw6iru2tg3ssv@mwanda>
References: <1520498678-32175-1-git-send-email-gilad@benyossef.com> <20180308110819.v4zfw6iru2tg3ssv@mwanda>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Thu, 8 Mar 2018 16:26:43 +0200
Message-ID: <CAOtvUMcbeEW7br+5YxzgzScECUxJyAi4ie_p8WFa08vGrr87jQ@mail.gmail.com>
Subject: Re: [PATCH] staging: ccree: remove ccree staging copy
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, Ofir Drang <ofir.drang@arm.com>
Content-Type: multipart/alternative; boundary="001a1143f81c0d5ea30566e777ed"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358433276712536?=
X-GMAIL-MSGID: =?utf-8?q?1594379945515589519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a1143f81c0d5ea30566e777ed
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 8, 2018 at 1:08 PM, Dan Carpenter <dan.carpenter@oracle.com>
wrote:

> Congratulations.  :)
>
>
Thanks goes to you, Greg and all other contributors and reviewers that help
made this happen.

You have my eternal gratitude and a an open invitation to a free beverage
of your choice, adult or otherwise, when we next meet :-)


It's worth mentioning I'll be giving a presentation next week at Embedded
Linux Conference US about some of the surprising benefits we got from the
process -
https://elciotna18.sched.com/event/d47bcefac0cd7dd456ad35d0f6ec9159

Come say hi if you're there.


Gilad



-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a situation
where the homework eats your dog?"
 -- Jean-Baptiste Queru

--001a1143f81c0d5ea30566e777ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Mar 8, 2018 at 1:08 PM, Dan Carpenter <span dir=3D"ltr">&lt;<a =
href=3D"mailto:dan.carpenter@oracle.com" target=3D"_blank">dan.carpenter@or=
acle.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Congratulations.=C2=A0 :)<br>
<br>
</blockquote><div><br></div><div>Thanks goes to you, Greg and all other con=
tributors and reviewers that help made this happen.</div><div>

<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial"><=
br class=3D"gmail-Apple-interchange-newline">You have my eternal gratitude =
and a an open invitation to a free beverage of your choice, adult or otherw=
ise, when we next meet :-)</div><br></div><div><br></div><div>It&#39;s wort=
h mentioning I&#39;ll be giving a presentation next week at Embedded Linux =
Conference US about some of the surprising benefits we got from the process=
 -=C2=A0<a href=3D"https://elciotna18.sched.com/event/d47bcefac0cd7dd456ad3=
5d0f6ec9159">https://elciotna18.sched.com/event/d47bcefac0cd7dd456ad35d0f6e=
c9159</a></div><div><br></div><div>Come say hi if you&#39;re there.</div><d=
iv><br></div><div><br></div><div>Gilad</div></div><br><br clear=3D"all"><di=
v><br></div>-- <br><div class=3D"gmail_signature">Gilad Ben-Yossef<br>Chief=
 Coffee Drinker<br><br>&quot;If you take a class in large-scale robotics, c=
an you end up in a situation where the homework eats your dog?&quot;<br>=C2=
=A0-- Jean-Baptiste Queru</div>
</div></div>

--001a1143f81c0d5ea30566e777ed--
