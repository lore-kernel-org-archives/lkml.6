Return-Path: <john3909@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521966377; cv=none;
        d=google.com; s=arc-20160816;
        b=qFlQ/vP5lVW5kx+ZpA2sOjK0IQwdUP4lzUv0DByS8p22OmDh7JZELD/hDoNR/d5kMz
         beVEFbP63lmfYOR+vCFbx97YmgF3XylNJlbpT9eGF6s7ThjfBP2LoWrUfxX3FjMeYPAm
         BiBxOgdmSPtUzzRGSbf+ii4hRXfeS2tCh3zEO+dZQKbQd1jERpZLjYmpDDZXwu0z/fsa
         +8XbS9DuD7v9fSWnk+XvO85udsuivdeksDD4iXQ69D6ITAiIhKsS4Kh6q18yonuyyS9u
         lpNiv+TpcWiRLpHarwH89k8FrpsRUtwcJjkZzXLezSNkHUMSQptFYOWN/k7sX0+s0wvf
         kGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:dkim-signature:arc-authentication-results;
        bh=x70fIyKJfuqdrqVRkYuKfNSB+FFpztSAeGOCZ0sNlF0=;
        b=MXygsCFjpPfr9SnYpmF26W+Ky7fUu1GQhNvVYOcJH3ZBfKhXsIITe58e/Oim3n7cUe
         eQbq7D+d/fJ04E7buN+UyCghAZpl4S8owKqMI0fRD8BMMLYGgZk94JYj8V9EhNARPu11
         VswUjDXNjvsXdZ9K4YWZLdoFdRQB7HLoieurk62UBRDPW4zRiS9rwdvUcAtEYAMiGBaL
         vOlZfSVO5goBapoySUFGdN1lyT6c+Io5gZ+vUtvRi/faglDUScO1ovmFehnySQzFL1zX
         l/CCMRLE+h46IOK+J0s0jliOgRM4kAdjlctV2b6TaYGXg0jWxUbq0dCqyrj2jG5tdYLT
         GW3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ky9o+Znw;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ky9o+Znw;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvIR6p3mDnCOxMzEUB40Qj4cQiHEaHI3bIWOSQF9+mgaRwLifW2an+AnjNyfuiFP7aAJzhh1g==
From: John Syne <john3909@gmail.com>
Message-Id: <A5474D1B-B6B4-438C-AEC7-27DD0B0775AD@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_1BEC0274-47E4-4C3C-8F24-217E38ACC87F"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Date: Sun, 25 Mar 2018 01:26:09 -0700
In-Reply-To: <20180324151829.7d03ad15@archlinux>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 devel@driverdev.osuosl.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com,
 Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
 <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
 <20180317203037.1093cc11@archlinux>
 <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
 <20180318122312.0d395367@archlinux>
 <F6FE75D3-5289-4675-9345-F46CABEFA99E@gmail.com>
 <20180324151829.7d03ad15@archlinux>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595278152164006674?=
X-GMAIL-MSGID: =?utf-8?q?1595897416308659912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Apple-Mail=_1BEC0274-47E4-4C3C-8F24-217E38ACC87F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Jonathan,

I was speaking with Rodrigo and here is what I think must be done to =
move ADE7878 out of staging

Here are the steps as I see them:

1) Define the IIO Attributes so they are consistent with the IIO ABI. =
This should be pretty simple given agreement on the naming convention.=20=

2) Map the ADE7854 interrupt status to IIO events. This requires an =
interrupt processing section.
3) Add DeviceTree support.
4) Create DeviceTree overlay for the ADE7854.
5) Update ADE7854 probe to read in the DeviceTree register settings.
6) Add support for power modes (PM1, PM2).
7) Not sure if we will support measurement streaming on the ADE7854. The =
problem is ADE7854 is designed as an SPI master, which means it controls =
the SPI clock, so the driver must support SPI slave mode. However, the =
Linux Kernel does not currently support SPI slave mode. We have three =
choices to make this work and they are all a lot of work: 1) Add support =
for SPI Slave mode to the kernel,  2) Use hardware to convert SPI =
signals to I2S signals and with the use of a custom codec, use the ALSA =
framework to stream the samples (this is an approach I used, but I =
don=E2=80=99t like it), 3) Move the I2S driver out of the sound =
subsystem and use it together with DMA to stream samples directly into =
the ADE7854 driver (my preferred solutions). Perhaps Mark Brown has some =
ideas on how to make this work.=20

The ADE9000 will be much easier because it uses an SPI Slave interface.=20=


I hope I have captured everything, but let me know if I have missed =
anything.

Regards,
John






--Apple-Mail=_1BEC0274-47E4-4C3C-8F24-217E38ACC87F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Hi =
Jonathan,<div class=3D""><br class=3D""></div><div class=3D"">I was =
speaking with Rodrigo and here is what I think must be done to move =
ADE7878 out of staging</div><div class=3D""><br class=3D""></div><div =
class=3D""><div class=3D"">Here are the steps as I see them:</div><div =
class=3D""><br class=3D""></div><div class=3D"">1) Define the IIO =
Attributes so they are consistent with the IIO ABI. This should be =
pretty simple given agreement on the naming convention.&nbsp;</div><div =
class=3D"">2) Map the ADE7854 interrupt status to IIO events. This =
requires an interrupt processing section.</div><div class=3D"">3) Add =
DeviceTree support.</div><div class=3D"">4) Create DeviceTree overlay =
for the ADE7854.</div><div class=3D"">5) Update ADE7854 probe to read in =
the DeviceTree register settings.</div><div class=3D"">6) Add support =
for power modes (PM1, PM2).</div><div class=3D"">7) Not sure if we will =
support measurement streaming on the ADE7854. The problem is ADE7854 is =
designed as an SPI master, which means it controls the SPI clock, so the =
driver must support SPI slave mode. However, the Linux Kernel does not =
currently support SPI slave mode. We have three choices to make this =
work and they are all a lot of work: 1) Add support for SPI Slave mode =
to the kernel, &nbsp;2) Use hardware to convert SPI signals to I2S =
signals and with the use of a custom codec, use the ALSA framework to =
stream the samples (this is an approach I used, but I don=E2=80=99t like =
it), 3) Move the I2S driver out of the sound subsystem and use it =
together with DMA to stream samples directly into the ADE7854 driver (my =
preferred solutions). Perhaps Mark Brown has some ideas on how to make =
this work.&nbsp;</div><div class=3D""><br class=3D""></div><div =
class=3D"">The ADE9000 will be much easier because it uses an SPI Slave =
interface.&nbsp;<br class=3D""><div class=3D""><div class=3D"" =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; line-break: =
after-white-space;"></div></div></div><div class=3D""><br =
class=3D""></div><div class=3D"">I hope I have captured everything, but =
let me know if I have missed anything.</div><div class=3D"">
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""><br class=3D"Apple-interchange-newline">Regards,</div><div =
class=3D"">John</div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div></div><br =
class=3D"Apple-interchange-newline" style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: =
0px;"></div><br class=3D""><br class=3D""></div></body></html>=

--Apple-Mail=_1BEC0274-47E4-4C3C-8F24-217E38ACC87F--
