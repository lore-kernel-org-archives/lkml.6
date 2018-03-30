Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4+kVoh1MSSGbwxZUi4H0jMVPFbyZL6j/hAskKwfMgZFDCy6SDJ1hM3Oc3+EpoHyL3cHpp8c
ARC-Seal: i=1; a=rsa-sha256; t=1522396744; cv=none;
        d=google.com; s=arc-20160816;
        b=Ep/bZ+lvr4Yt+ixkm7/qrksP7BPMwzQdGLOq/uYdaTf+ZxgBIkLHH0aslYBAagCv68
         zSDO5W+Re+rjGePpKxWizYEkmJDthfLR4Q9bh/WtDuYVmDupQlorCHkNYEoBN/dzinrZ
         wIyWmiJEAz22nfpb7wR5MjNBiDPCHAmuVMz6NEyfqsUc4riG+nSDXuofIiSvARYyjROU
         KcTpr7GfC1IE/0YOaTFSFoBzR1j6/kvxRXmQrHZrYgVPnj5bG283DMBzpLKsCUfrjLUb
         dNjojO6ID0P8JY95LjzVCXi5Sb3phGYgAuDWvyVY6Rsw4Kxbb/oHA+8/gEJgqYMrapLj
         uOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5z9hMiun12L3BqR61E/khOnLfJpmr2iemLnrIGGhY/A=;
        b=R14RwQzatWweS25d/gieHbnsCXIvmpbRkxKGuEtf2y4xcKOu6TL8Qoe2jaYbHDHNod
         aUXKSizCwym75wOqvUnjXAbKNz8rVwIh3on6A0WVoGCAt4vDQePCe+qlkkDjv3l5BleT
         yF56FaEB2vgE2rB0gqZHIy5TpO8jkNiZAVair6W7mkZZf6BKYka0jKVTB1MKCu1hjTUR
         pRgsIF8I80Z68ay3pnvt/Jgmw9nrzDYcW6Pyffu11OT197BAEpjNJ8FIhMpfDgAiY2TI
         O+vnpAqY7RYmXBMH+vVsaFIpNtv84Pi9nNWwLGG2Q2VEGA24CBUaRUSfoUXECvCW2be/
         CpPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Fri, 30 Mar 2018 09:59:02 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec
 <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta
 <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja
 Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka
 <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal
 Ciepiela <rafalc@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring
 <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Vitor Soares <Vitor.Soares@synopsys.com>,
 Linus Walleij <linus.walleij@linaro.org>, Xiang Lin
 <Xiang.Lin@synaptics.com>, "open list:GPIO SUBSYSTEM"
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 04/10] dt-bindings: i3c: Document core bindings
Message-ID: <20180330095902.00f75106@bbrezillon>
In-Reply-To: <CAMuHMdW-MhzaW-bWL25Y+--UHxLB+Mm5+SmhwA+PiezUEg0Ycw@mail.gmail.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
	<20180330074751.25987-5-boris.brezillon@bootlin.com>
	<CAMuHMdW-MhzaW-bWL25Y+--UHxLB+Mm5+SmhwA+PiezUEg0Ycw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347989623961595?=
X-GMAIL-MSGID: =?utf-8?q?1596348688381400414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 30 Mar 2018 09:55:22 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Fri, Mar 30, 2018 at 9:47 AM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > A new I3C subsystem has been added and a generic description has been
> > created to represent the I3C bus and the devices connected on it.
> >
> > Document this generic representation.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> > Changes in v4:
> > - Clarify the fact that static address == I3C address and dynamic  
> 
> static address == I2C address?

hehe, indeed.

> 
> >   address == I3C address  
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
