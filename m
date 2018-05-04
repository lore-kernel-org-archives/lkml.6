Return-Path: <loic.tourlonias@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-82987-1525436005-2-15035567740317999508
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, HTML_MESSAGE 0.001,
  RCVD_IN_DNSWL_LOW -0.7, RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.214.53', Host='mail-it0-f53.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', plain='UTF-8', html='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: loic.tourlonias@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525436004; b=TYoy7xrkhG0lvFAR4/oLBV40pMKJ+5k4BRTF18MIHRAeaYmzim
    ONPkTLGLE4ZwNiCS9D4RZ83JA3Nzw8x2WCBWdyHKdz/w5STlXPUcvLKhV7NgFgjC
    Tg/KU+RG/U1CZdzZVWX1R9ZOQDRKyyOSFC63WL5K2G2quVD+Ys2CABr4g7C7AitQ
    J41Oc1ZoHM0vZ2M73bioPASELeqTpixbkMZwOTdw3hVriibJDPlIMoaubVbS6a8I
    BWz6v86ojnUH6PkgUilDJDvzp8CchyEw0xU40ZKH5FMXimC+CmODQkRrk/rieCT4
    JDsmY8SJnQy/kFslm9PkCNzEJDROVHkCNIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=fm2; t=
    1525436004; bh=bvjzEpr/+pAaJ7SS8pz0K5egHXzxi3vbV+kuObbH6lI=; b=h
    6ZAOUMYYHLxCkM1bt1uXCF4/jwiiLae80IFBey8aJPbJmri7ekSKyz3Ir0ZSjTIs
    A7JJoHl4jFmLwO/ie/z0f80Nt+9O/tBFJclSINK8fCDu0iqyGOvRERrQ8TyMneRj
    9hKlN1RaEDQNwUU6yQEagXCud+HqqZd6InL+d4sSs1JvX9pBLEvGlcNLhUpR6otn
    mkj9owUfYMyLalHJBfrXlaLA3UgWq6sRqFSd6yRlw99b79wv/0GGGuIiiZ10xdjU
    +VBnE/gHWn1fNGdSJlCFqb0l2MVZ9JYTZgxMoQQiXojDk8PKRyHcOd4BtzivTAg3
    z7foZvKL7XC4II71lSrLg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=Lp/687Zq x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.214.53 (mail-it0-f53.google.com);
    spf=pass smtp.mailfrom=loic.tourlonias@gmail.com
    smtp.helo=mail-it0-f53.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=RSEN++hD;
    x-ptr=pass x-ptr-helo=mail-it0-f53.google.com
    x-ptr-lookup=mail-it0-f53.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=Lp/687Zq x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.214.53 (mail-it0-f53.google.com);
    spf=pass smtp.mailfrom=loic.tourlonias@gmail.com
      smtp.helo=mail-it0-f53.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=RSEN++hD;
    x-ptr=pass x-ptr-helo=mail-it0-f53.google.com
      x-ptr-lookup=mail-it0-f53.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFK6b3S8TIvljk8Ram9dSn6HryNUMYg/Sn5Pz2k8RQ/2TE366zpWRaLgkP/MCTSIEPuCeZP/p4fYpGaem7zdOQR2UWCaU2tjfesdfJWenARvTw4FB9XK
    7uV0p4MhJUJWNSflHdP/PkQBvJs8/Q8zzj1VRgm5Gq7x4c+8Ym01ziXQsnr6N1JCqnS6dYn7xMsavo5mcFCs3DPW48WKAxKgTRo=
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=oZdUfUROREmolQ2/CxK9Cg==:117
    a=x7bEGLp0ZPQA:10 a=p5xw8m4aqZMA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=2C6YHBdLAAAA:8 a=P-IC7800AAAA:8 a=SiqW3_QkAAAA:8 a=7_jKLjTcgOJeYW-93ikA:9
    a=QEXdDO2ut3YA:10 a=ZLdsGG2wkhYVdveqkSQA:9 a=RwFMxkEq3jXED-zy:21
    a=yxGMNg53M24zlVSZdvMH:22 a=d3PnA9EDa4IxuAV0gXij:22 a=0-oVHmElw7bdUHZZ8WX8:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Google-Smtp-Source: AB8JxZr4BAWt8VLoEIcFB2jpPWQxzPmYpXb47y8y0gdWFBO8Eact4qQxP43zKXaQtR7E66uEZozuxFClDOkmrLxHFWA=
MIME-Version: 1.0
In-Reply-To: <CAHhAz+iub6boqtK7UgFuKW=4t9DYPrnPX6nDu8R4T2J4=v=-DA@mail.gmail.com>
References: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
 <20180503183408.GA12152@kroah.com> <CAHhAz+iub6boqtK7UgFuKW=4t9DYPrnPX6nDu8R4T2J4=v=-DA@mail.gmail.com>
From: =?UTF-8?Q?lo=C3=AFc_tourlonias?= <loic.tourlonias@gmail.com>
Date: Fri, 4 May 2018 14:13:22 +0200
Message-ID: <CA+XxOSG8UozW9uzmdrtmAOEYsgwxPVEUB8B=3HNnsrnZMuGF2w@mail.gmail.com>
Subject: Re: serial: start_tx & buffer handling
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-serial <linux-serial@vger.kernel.org>,
	kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: multipart/alternative; boundary="00000000000014c4d0056b603f0d"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--00000000000014c4d0056b603f0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, May 4, 2018 at 6:31 AM, Muni Sekhar <munisekharrms@gmail.com> wrote=
:

> On Fri, May 4, 2018 at 12:04 AM, Greg KH <greg@kroah.com> wrote:
> > On Thu, May 03, 2018 at 08:08:48PM +0530, Muni Sekhar wrote:
> >> Hi All,
> >>
> >> I=E2=80=99m trying to understand how user mode buffer is written to lo=
w level
> >> serial hardware registers.
> >>
> >> For this I read the kernel code and I came to know that from user mode
> >> write() API lands into kernel=E2=80=99s tty_write() ("drivers/tty/tty_=
io.c")
> >> and then it calls a uart_write() ("drivers/tty/serial/serial_core.c").
> >>
> >> In uart_write(), the buffer is copied to circ_buf and then it calls
> >> low level serial hardware driver=E2=80=99s start_tx() (struct uart_ops
> >> .start_tx). But here I could not find how the buffer kept in circ_buf
> >> is copied to serial port=E2=80=99s TX_FIFO registers?
> >>
> >> Can someone take a moment to explain me on this?
> >
> > It all depends on which specific UART driver you are looking at, they
> > all do it a bit different depending on the hardware.
> >
> > Which one are you looking at?  Look at what the start_tx callback does
> > for that specific driver, that should give you a hint as to how data
> > starts flowing.  Usually an interrupt is enabled that is used to flush
> > the buffer out to the hardware.
> >
>
> I=E2=80=99m looking for any existing sample code which does DMA transfers=
 of
> UART transmitted data. I looked at the bcm63xx_uart.c, it looks it
> does not handle DMA transfers. Even copying the Tx buffer (from
> circ_buf) to UART_FIFO_REG happening in ISR.
>

You can have a look at atmel_serial kernel module (built for ARM).
https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/atmel_ser=
ial.c

The dma buffer is linked to uart circular buffer in prepare_tx() function
called from uart_startup(). It's released in release_tx() function called
from uart_shutdown(). DMA buffer is managed in schedule_tx() function
called from a tasklet triggered by the ISR.

HTH

>
>
> > thanks,
> >
> > greg k-h
>
>
>
> --
> Thanks,
> Sekhar
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>

--00000000000014c4d0056b603f0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Fri, May 4, 2018 at 6:31 AM, Muni Sekhar <span dir=3D"ltr">&l=
t;<a href=3D"mailto:munisekharrms@gmail.com" target=3D"_blank">munisekharrm=
s@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><span class=3D"gmail-">On Fri, May 4, 2018 at 12:04 AM, Greg KH=
 &lt;<a href=3D"mailto:greg@kroah.com">greg@kroah.com</a>&gt; wrote:<br>
&gt; On Thu, May 03, 2018 at 08:08:48PM +0530, Muni Sekhar wrote:<br>
&gt;&gt; Hi All,<br>
&gt;&gt;<br>
&gt;&gt; I=E2=80=99m trying to understand how user mode buffer is written t=
o low level<br>
&gt;&gt; serial hardware registers.<br>
&gt;&gt;<br>
&gt;&gt; For this I read the kernel code and I came to know that from user =
mode<br>
&gt;&gt; write() API lands into kernel=E2=80=99s tty_write() (&quot;drivers=
/tty/tty_io.c&quot;)<br>
&gt;&gt; and then it calls a uart_write() (&quot;drivers/tty/serial/serial_=
<wbr>core.c&quot;).<br>
&gt;&gt;<br>
&gt;&gt; In uart_write(), the buffer is copied to circ_buf and then it call=
s<br>
&gt;&gt; low level serial hardware driver=E2=80=99s start_tx() (struct uart=
_ops<br>
&gt;&gt; .start_tx). But here I could not find how the buffer kept in circ_=
buf<br>
&gt;&gt; is copied to serial port=E2=80=99s TX_FIFO registers?<br>
&gt;&gt;<br>
&gt;&gt; Can someone take a moment to explain me on this?<br>
&gt;<br>
&gt; It all depends on which specific UART driver you are looking at, they<=
br>
&gt; all do it a bit different depending on the hardware.<br>
&gt;<br>
&gt; Which one are you looking at?=C2=A0 Look at what the start_tx callback=
 does<br>
&gt; for that specific driver, that should give you a hint as to how data<b=
r>
&gt; starts flowing.=C2=A0 Usually an interrupt is enabled that is used to =
flush<br>
&gt; the buffer out to the hardware.<br>
&gt;<br>
<br>
</span>I=E2=80=99m looking for any existing sample code which does DMA tran=
sfers of<br>
UART transmitted data. I looked at the bcm63xx_uart.c, it looks it<br>
does not handle DMA transfers. Even copying the Tx buffer (from<br>
circ_buf) to UART_FIFO_REG happening in ISR.<br></blockquote><div><br></div=
><div>You can have a look at atmel_serial kernel module (built for ARM).<br=
><a href=3D"https://elixir.bootlin.com/linux/latest/source/drivers/tty/seri=
al/atmel_serial.c">https://elixir.bootlin.com/linux/latest/source/drivers/t=
ty/serial/atmel_serial.c</a><br>=C2=A0<br></div><div>The dma buffer is link=
ed to uart circular buffer in prepare_tx() function called from uart_startu=
p(). It&#39;s released in release_tx() function called from uart_shutdown()=
. DMA buffer is managed in schedule_tx() function called from a tasklet tri=
ggered by the ISR.<br><br></div><div>HTH<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
<br>
&gt; thanks,<br>
&gt;<br>
&gt; greg k-h<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
-- <br>
Thanks,<br>
Sekhar<br>
</font></span><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
______________________________<wbr>_________________<br>
Kernelnewbies mailing list<br>
<a href=3D"mailto:Kernelnewbies@kernelnewbies.org">Kernelnewbies@kernelnewb=
ies.<wbr>org</a><br>
<a href=3D"https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies" =
rel=3D"noreferrer" target=3D"_blank">https://lists.kernelnewbies.<wbr>org/m=
ailman/listinfo/<wbr>kernelnewbies</a><br>
</div></div></blockquote></div><br></div></div></div>

--00000000000014c4d0056b603f0d--
