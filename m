Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526038580-2-1249493511589567779
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, HTML_MESSAGE 0.001,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8', html='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526038579; b=HZ5+qzesmJ787Pv2z1Ggmf75M81gXGyNifi3oGgYYNuuEtyMbr
    kEgOqRSnLgNgHq1HYlWdhZkcHqabLE2/ZM4lI2YAwqtt1sHU+aUpytO75P0yF98s
    C4VXWj2zdrzNMJGc9iujhGFpChUKAI4d6QgXJPvgtR8s+GK3AFB0ABLmHQcubflD
    QJJHKS/1cCHY2QjBg3MKahgoP0Rhh+B95etTIVFV6NEjKTHkLaHEgFWKJQr4dFrN
    DrTGt5RkOb60kOF7NuriwbRjmnZRZ8MJ+z+Mn1IHwZvtEcSo33uyf341qWX2cU6R
    /+8d31F6UkPGNwarWbI8M/sHmhEGNl0SEirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:list-id:list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:content-type; s=fm2; t=1526038579; bh=ssRTc+Kvuw
    Ka/w5H6BB/xHCvBjIqP6jFCMi9dpVBgUo=; b=hyqenOliHwqKhM5QrJU9SWsClR
    dy0RYiS24a3Lvq5Ylb+Vf6LmMuNB/vmqd9/kNed9VkYq3FRRSmmnmwLC+8cijYXa
    qBjL2R47u6dYdG7HT6jXkpVYqZnYU3LA0scwThYKV6leOw4UAcZmvdCla03j/hTg
    Lp7h1Npj7DXSatyblZi3tjEAjAmmyH9wz8bHJdG5t9j8u9vUj224IfWJyJRotcKK
    4EbKpx2YwG067lTWuB9gdgOfiXgkHiVBXW4AgS1iYPPd5MBaTR4lGRknM9QgL8kV
    adBIHqHpKLKhTMlaRrPw+C7+vPDfh60JNxl+aSaah4CuLkevIeZgAbEfDenQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=dvk5Uyjt x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org
    smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Dg6fnsUi;
    x-ptr=pass x-ptr-helo=shelob.surriel.com
    x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=dvk5Uyjt x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org
      smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Dg6fnsUi;
    x-ptr=pass x-ptr-helo=shelob.surriel.com
      x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPGRW68ekTkNK9KOGETUZa2zn8K8JHbEdav2eBBPUCYsv1sGmqubV3ALzcjB8OEbp3RiFHz+9LM88HLvT4Os/i3Npp0RDn1WlojcF0OeI2iflUiB3nFP
    /YnwcAUH/jJr910uCmoa/ACjmljJEgOP11nB87AlodK7mqXbvrH752XqOAttEPDk2fLvaj4ZyGs4saAXZne4uby3Sg2BbHD7BEE=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=rY4dWIxwDULXyY+dMrlW8Q==:117
    a=rY4dWIxwDULXyY+dMrlW8Q==:17 a=x7bEGLp0ZPQA:10 a=czdFmxznmnoA:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=GGdKqnK_KW9Sck3OX-AA:9 a=1K8ewAGmg4rX2cu2:21 a=atutN0o5x7TmsORt:21
    a=QEXdDO2ut3YA:10 a=nbgc9u9JYlDev0Wnx_cA:9 a=-wVxLY0Yommcmw6X:21
    a=SiqW3_QkAAAA:8 a=pA5yba_4-WtoxGtPXkoA:9 a=CjuIK1q_8ugA:10 a=Fe-e93FlemcA:10
    a=0-oVHmElw7bdUHZZ8WX8:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Google-Smtp-Source: AB8JxZprtYyvXhiBH0Kq+JXgWCUHY59PWQ+w6rlgu34UVL9QtGSZLAgdDHAtoRAPej4EGNJvjDfehtlz5PdS9t65EXI=
MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 11 May 2018 17:04:50 +0530
Message-ID: <CAOuPNLjqJVsPOVPCnswtFyXudAJ88_F0QVUq-Z6qWE=UpH0mBA@mail.gmail.com>
Subject: Not able to set smp_affinity for an IRQ on i.MX7
To: open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernelnewbies@kernelnewbies.org
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2595804741952351622=="
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============2595804741952351622==
Content-Type: multipart/alternative; boundary="00000000000024d142056bec86f6"

--00000000000024d142056bec86f6
Content-Type: text/plain; charset="UTF-8"

Hi,

I need one help.
I am using i.MX7 Sabre board with kernel version 4.1.15

Let's say I am interested in GPIO number: 21
I wanted to set CPU affinity for particular GPIO->IRQ number, so I tried
the below steps:
root@10:~# echo 21 > /sys/class/gpio/export
root@10:~# echo "rising" > /sys/class/gpio/gpio21/edge
root@10:~# cat /proc/interrupts | grep 21
  47: 0 0 gpio-mxc 21 Edge gpiolib
root@10:~# cat /sys/class/gpio/gpio21/direction
in
root@10:~# cat /proc/irq/47/smp_affinity
3
root@10:~# echo 2 > /proc/irq/47/smp_affinity
-bash: echo: write error: Input/output error

But I get input/output error.
When I debug further, found that irq_can_set_affinity is returning 0:
[    0.000000] genirq: irq_can_set_affinity (0): balance: 1, irq_data.chip:
a81b7e48, irq_set_affinity:   (null)
[    0.000000] write_irq_affinity: FAIL

I also tried first setting /proc/irq/default_smp_affinity to 2 (from 3).
This change is working, but the smp_affinity setting for the new IRQ is not
working.

When I try to set smp_affinity for mmc0, then it works.
# cat /proc/interrupts | grep mmc
295:         55          0     GPCV2  22 Edge      mmc0
296:          0          0     GPCV2  23 Edge      mmc1
297:         52          0     GPCV2  24 Edge      mmc2

root@10:~# echo 2 > /proc/irq/295/smp_affinity
root@10:~#


So, I wanted to know what are the conditions for which setting smp_affinity
for an IRQ will work ?

Is there any way by which I can set CPU affinity to a GPIO -> IRQ ?
Whether, irq_set_affinity_hint() will work in this case ?


Thanks,
Pintu

--00000000000024d142056bec86f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Hi,</div><div class=3D"gmail_default" style=3D"font-family:verd=
ana,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family=
:verdana,sans-serif">I need one help.</div><div class=3D"gmail_default" sty=
le=3D"font-family:verdana,sans-serif">I am using i.MX7 Sabre board with ker=
nel version 4.1.15</div><div class=3D"gmail_default" style=3D"font-family:v=
erdana,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:verdana,sans-serif">Let&#39;s say I am interested in GPIO number: 21</d=
iv><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">I =
wanted to set CPU affinity for particular GPIO-&gt;IRQ number, so I tried t=
he below steps:</div><div class=3D"gmail_default" style=3D"font-family:verd=
ana,sans-serif"><span style=3D"font-family:arial,sans-serif">root@10:~# ech=
o 21 &gt; /sys/class/gpio/export</span></div><div class=3D"gmail_default" s=
tyle=3D"font-family:verdana,sans-serif"><span style=3D"font-family:arial,sa=
ns-serif">root@10:~# echo &quot;rising&quot; &gt; /sys/class/gpio/gpio21/ed=
ge</span></div><div class=3D"gmail_default" style=3D"font-family:verdana,sa=
ns-serif"><span style=3D"font-family:arial,sans-serif">root@10:~# cat /proc=
/interrupts | grep 21</span></div><div class=3D"gmail_default" style=3D"fon=
t-family:verdana,sans-serif"><span style=3D"font-family:arial,sans-serif">=
=C2=A0 47:          0          0  gpio-mxc  21 Edge      gpiolib</span></di=
v><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><sp=
an style=3D"font-family:arial,sans-serif">root@10:~# cat /sys/class/gpio/gp=
io21/direction</span></div><div class=3D"gmail_default" style=3D"font-famil=
y:verdana,sans-serif"><span style=3D"font-family:arial,sans-serif">in</span=
></div><div class=3D"gmail_default"><span style=3D"font-family:verdana,sans=
-serif">root@10:~# cat /proc/irq/47/smp_affinity</span></div><div class=3D"=
gmail_default"><span style=3D"font-family:verdana,sans-serif">3</span></div=
><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">

<div class=3D"gmail_default">root@10:~# echo 2 &gt; /proc/irq/47/smp_affini=
ty</div><div class=3D"gmail_default">-bash: echo: write error: Input/output=
 error</div><div class=3D"gmail_default"><br></div><div class=3D"gmail_defa=
ult">But I get input/output error.</div><div class=3D"gmail_default">When I=
 debug further, found that irq_can_set_affinity is returning 0:</div><div c=
lass=3D"gmail_default"><div class=3D"gmail_default">[=C2=A0 =C2=A0 0.000000=
] genirq: irq_can_set_affinity (0): balance: 1, irq_data.chip: a81b7e48, ir=
q_set_affinity:=C2=A0 =C2=A0(null)</div><div class=3D"gmail_default">[=C2=
=A0 =C2=A0 0.000000] write_irq_affinity: FAIL</div><div class=3D"gmail_defa=
ult"><br></div><div class=3D"gmail_default">I also tried first setting=C2=
=A0/proc/irq/default_smp_affinity to 2 (from 3).</div><div class=3D"gmail_d=
efault">This change is working, but the smp_affinity setting for the new IR=
Q is not working.</div><div class=3D"gmail_default"><br></div><div class=3D=
"gmail_default">When I try to set smp_affinity for mmc0, then it works.</di=
v><div class=3D"gmail_default"># cat /proc/interrupts | grep mmc</div><div =
class=3D"gmail_default"><div class=3D"gmail_default">295:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A055=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0=
GPCV2=C2=A0 22 Edge=C2=A0 =C2=A0 =C2=A0 mmc0</div><div class=3D"gmail_defau=
lt">296:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0=C2=A0 =C2=A0 =C2=A0GPCV2=C2=A0 23 Edge=C2=A0 =C2=A0 =C2=A0 mmc1</div>=
<div class=3D"gmail_default">297:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A052=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0GPCV2=C2=A0 24 Edge=C2=A0=
 =C2=A0 =C2=A0 mmc2</div><div class=3D"gmail_default"><br></div><div class=
=3D"gmail_default"><div class=3D"gmail_default">root@10:~# echo 2 &gt; /pro=
c/irq/295/smp_affinity</div><div class=3D"gmail_default">root@10:~#</div></=
div></div><div class=3D"gmail_default"><br></div><div class=3D"gmail_defaul=
t"><br></div><div class=3D"gmail_default">So, I wanted to know what are the=
 conditions for which setting smp_affinity for an IRQ will work ?</div><div=
 class=3D"gmail_default"><br></div><div class=3D"gmail_default">Is there an=
y way by which I can set CPU affinity to a GPIO -&gt; IRQ ?</div><div class=
=3D"gmail_default">Whether, irq_set_affinity_hint() will work in this case =
?</div><div class=3D"gmail_default"><br></div><div class=3D"gmail_default">=
<br></div><div class=3D"gmail_default">Thanks,</div><div class=3D"gmail_def=
ault">Pintu</div><div class=3D"gmail_default"><br></div></div></div></div>

--00000000000024d142056bec86f6--


--===============2595804741952351622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============2595804741952351622==--
