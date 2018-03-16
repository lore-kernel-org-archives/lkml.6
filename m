Return-Path: <pratik.jain0509@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-2645812-1521195917-2-6981538148906240330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  HTML_MESSAGE 0.001, HTML_OBFUSCATE_05_10 0.26,
  MIME_BOUND_DIGITS_15 0.798, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.161.196', Host='mail-yw0-f196.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='UTF-8', html='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: pratik.jain0509@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521195916; b=s7Bjyi2mGyu4c1M9f3dTehU2MGECUitR3ZD/C1FD1SgK48S
    u+6uPWgyfBoJzrYG+BLCHynw5sRNEDsx0m8Z7g70HhB9ORbPyxALwQGXF0mIn5t/
    lYzVOw9xyF6mApAGpBc8xAzn3q1wemSDcmmxpkwig3OUDnsMHpmoyp8UCcCAdCOu
    99FjhSXwKWdeOTzVvEeJJf+5tMrIJ/vYjh1Q1QdzPJnZCJaCDY39bNvNWBHWjQ4Y
    PiKagu4Fp8tZCbWjSpshiKh4rvbQH07TjloaXYUtrhWiNueNMDqMmKCypCo1pJNU
    Te4C+fyu+JWL5oyv0KIdz13CEW6ndPy+aEshlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1521195916; bh=kgqHhGNzUvrCzjJ9pKC6I9Can/jFY8EzkJSPDv3qXZg=; b=F
    W1MvVxP8HJILf7Mg3fmr+H8l5MlyZE2IYdQpPFT6kWKlG/APC3bGGas7rwsoEdCR
    Wh5m2BC5LWiTD6a623njoz763L2OnBbieySJpTgCEhFl+pOwoJe/Qff/pRmp1h1P
    uYbDGbix4B/qWwQtrA652x565CB8aasrXjNB3tWO8Ldyxo+vBullY0T2BzN+YJl9
    f7GfBhZxyGlvjAWzhJsQWmlk4JpIveK7bf0Ai+pIzD++HUVhW4ggZ6LYeLxZ/ir3
    QWXfIUESUDf6dvahocqVITmq9NF6OzEtMI3FT+6Nx8ibF41wG1qMn5OUrhIVGjsb
    Xjv1ucso/Zy/RK1jKt5FA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qEym8lXC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.161.196 (mail-yw0-f196.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-yw0-f196.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=o2AeEnr5;
    x-ptr=pass x-ptr-helo=mail-yw0-f196.google.com x-ptr-lookup=mail-yw0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qEym8lXC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.161.196 (mail-yw0-f196.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-yw0-f196.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=o2AeEnr5;
    x-ptr=pass x-ptr-helo=mail-yw0-f196.google.com x-ptr-lookup=mail-yw0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELuleBmFSLDsnSXMcclF39OSd0LeVWzfPyl7mjeh3HVe6PR4wJeR9uhC56AylXYM+iDeLpcI5epxkmMMe6Q5cKE=
MIME-Version: 1.0
In-Reply-To: <2dd4e733-b74a-c296-a554-3520a85e8ce2@mev.co.uk>
References: <CABbwmYcnDNcA70_-BhLkBcuK-77tk3BWKcvzQts6eWqu5_mMKA@mail.gmail.com>
 <20180315185943.18902-1-pratik.jain0509@gmail.com> <2dd4e733-b74a-c296-a554-3520a85e8ce2@mev.co.uk>
From: Pratik Jain <pratik.jain0509@gmail.com>
Date: Fri, 16 Mar 2018 15:55:14 +0530
Message-ID: <CABbwmYc1C=4v7R5uinA+m=156yehhN6X18CV_dkChtjmUnnMfA@mail.gmail.com>
Subject: Re: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line
 derefernce issue
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org
Content-Type: multipart/alternative; boundary="0000000000002486010567850661"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--0000000000002486010567850661
Content-Type: text/plain; charset="UTF-8"

Yes, that can be done. But isn't 80 column limit more of a history based
convention?

On Fri, Mar 16, 2018 at 3:47 PM, Ian Abbott <abbotti@mev.co.uk> wrote:

> On 15/03/2018 18:59, Pratik Jain wrote:
>
>> Fixed coding style issue.
>>
>> Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
>> ---
>>   drivers/staging/comedi/drivers/ni_atmio.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/comedi/drivers/ni_atmio.c
>> b/drivers/staging/comedi/drivers/ni_atmio.c
>> index b9e9ab548c4b..4e27a2959b64 100644
>> --- a/drivers/staging/comedi/drivers/ni_atmio.c
>> +++ b/drivers/staging/comedi/drivers/ni_atmio.c
>> @@ -226,8 +226,8 @@ static int ni_isapnp_find_board(struct pnp_dev **dev)
>>         for (i = 0; i < ARRAY_SIZE(ni_boards); i++) {
>>                 isapnp_dev = pnp_find_dev(NULL,
>>                                           ISAPNP_VENDOR('N', 'I', 'C'),
>> -                                         ISAPNP_FUNCTION(ni_boards[i].
>> -                                                         isapnp_id),
>> NULL);
>> +                                         ISAPNP_FUNCTION(ni_boards[i].
>> isapnp_id),
>> +                                         NULL);
>>                 if (!isapnp_dev || !isapnp_dev->card)
>>                         continue;
>>
>>
> I suggest splitting the expression just after the '=' to avoid going over
> 80 columns.
>
> --
> -=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
> -=(                          Web: http://www.mev.co.uk/  )=-
>

--0000000000002486010567850661
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Yes, that can be done. But isn&#39;t 80 column limit =
more of a history based<br></div>convention?<br></div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Fri, Mar 16, 2018 at 3:47 PM, Ian A=
bbott <span dir=3D"ltr">&lt;<a href=3D"mailto:abbotti@mev.co.uk" target=3D"=
_blank">abbotti@mev.co.uk</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><span class=3D"">On 15/03/2018 18:59, Pratik Jain wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Fixed coding style issue.<br>
<br>
Signed-off-by: Pratik Jain &lt;<a href=3D"mailto:pratik.jain0509@gmail.com"=
 target=3D"_blank">pratik.jain0509@gmail.com</a>&gt;<br>
---<br>
=C2=A0 drivers/staging/comedi/drivers<wbr>/ni_atmio.c | 4 ++--<br>
=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/staging/comedi/drive<wbr>rs/ni_atmio.c b/drivers/stagi=
ng/comedi/drive<wbr>rs/ni_atmio.c<br>
index b9e9ab548c4b..4e27a2959b64 100644<br>
--- a/drivers/staging/comedi/drive<wbr>rs/ni_atmio.c<br>
+++ b/drivers/staging/comedi/drive<wbr>rs/ni_atmio.c<br>
@@ -226,8 +226,8 @@ static int ni_isapnp_find_board(struct pnp_dev **dev)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(ni_boards); i++=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isapnp_dev =3D pnp_=
find_dev(NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I=
SAPNP_VENDOR(&#39;N&#39;, &#39;I&#39;, &#39;C&#39;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IS=
APNP_FUNCTION(ni_boards[i].<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isapnp_id), NULL);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IS=
APNP_FUNCTION(ni_boards[i].<wbr>isapnp_id),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NU=
LL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!isapnp_dev || =
!isapnp_dev-&gt;card)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
<br>
</blockquote>
<br></span>
I suggest splitting the expression just after the &#39;=3D&#39; to avoid go=
ing over 80 columns.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
-=3D( Ian Abbott @ MEV Ltd.=C2=A0 =C2=A0 E-mail: &lt;<a href=3D"mailto:abbo=
tti@mev.co.uk" target=3D"_blank">abbotti@mev.co.uk</a>&gt; )=3D-<br>
-=3D(=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Web: <a href=3D"http://www.mev.co.uk/" rel=3D"noreferr=
er" target=3D"_blank">http://www.mev.co.uk/</a>=C2=A0 )=3D-<br>
</font></span></blockquote></div><br></div>

--0000000000002486010567850661--
