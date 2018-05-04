Return-Path: <yong.deng@magewell.com>
X-Google-Smtp-Source: AB8JxZqYthrPFvdyskcVUhI4dPde3yFn77mYA2B+MSjyD3m5kxpRGs5JBtH7K4yi/Ypy2o61Z6p1
ARC-Seal: i=1; a=rsa-sha256; t=1525396793; cv=none;
        d=google.com; s=arc-20160816;
        b=fqxQo3h2kyjwBrMSx/b6kbxvTKmm2mzkV6RM4JrCHuIlE/c4o/q6RoOqJscxQC09My
         o8PgFLeHFv2Psvn7gUKSU7gf17Kro1Iw0SC5Uc1zIiH94If1Jos6ekkeH4WppLR2J2Ld
         mpAhbo7fMy1lLF7Lwx/lmVdN6i6u/vqicNsIo3rLA7SiXogUxXxMoc81z4FMjgEHm3ST
         FUo7xDeHPDiJl7zTUCLT3UmnINAaZQSXd0X4JnLKP6b4FpVNbO7Vdt3nCX4zJ+tsXSEf
         PgIXoZZhEJhdaBFi8jdOznxhx7AF7obL08CdvAFOvYdluJuqqOQphmZZlAKPsZtrPwGT
         NpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=92Ibytqc/3rwJ+IE3JcAxL991FUfVzrJcDhWRgx4Eqc=;
        b=rO2pY+xdbLkgToZZSorjDwe9oQRT0E/Kt7X2kK1IjUNl/8owOGvhJcMBh2P+Bbjg0V
         bHU/LM+JPyo+cWCuekw0Vw1jGl4+1OnQDofBgkGZk0/tTTiLOs56FGw4MYXslZbv2C66
         i1JBqTr9xTGTsxeuQ4KHqUYpIyA8q4L6f/kFLMdbTC6+lvxo4mpPAwvTzS36b6z0ZA41
         9ZqbFvHnoBWHByjDP5g3GUfq6L/I5LqZOD2w2NnVobVr9z3qLNWwQ47QNzt57S+z7R+D
         IUDnYjChhgCrdgD85jFxa0xKbMXThGFVa3X/iwioo7QXBQCwVr4YXs3tJ79zNMOI0ahN
         xnZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yong.deng@magewell.com designates 115.124.20.86 as permitted sender) smtp.mailfrom=yong.deng@magewell.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yong.deng@magewell.com designates 115.124.20.86 as permitted sender) smtp.mailfrom=yong.deng@magewell.com
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09746583|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01534;MF=yong.deng@magewell.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.BvEsMFP_1525396779;
Date: Fri, 4 May 2018 09:19:40 +0800
From: Yong <yong.deng@magewell.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai
 <wens@csie.org>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
 <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Hans
 Verkuil <hans.verkuil@cisco.com>, Stanimir Varbanov
 <stanimir.varbanov@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Philipp
 Zabel <p.zabel@pengutronix.de>, Ramesh Shanmugasundaram
 <ramesh.shanmugasundaram@bp.renesas.com>, Yannick Fertre
 <yannick.fertre@st.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Todor
 Tomov <todor.tomov@linaro.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v9 0/2] Initial Allwinner V3s CSI Support
Message-Id: <20180504091940.88dbbe8eed8da931ab4bfbea@magewell.com>
In-Reply-To: <20180503171410.q52ak27u47gycy6o@flea>
References: <1520301070-48769-1-git-send-email-yong.deng@magewell.com>
	<20180503171410.q52ak27u47gycy6o@flea>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594151284000328035?=
X-GMAIL-MSGID: =?utf-8?q?1599494468475724982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Maxime,

On Thu, 3 May 2018 19:14:10 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi Yong,
> 
> On Tue, Mar 06, 2018 at 09:51:10AM +0800, Yong Deng wrote:
> > This patchset add initial support for Allwinner V3s CSI.
> > 
> > Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> > interface and CSI1 is used for parallel interface. This is not
> > documented in datasheet but by test and guess.
> > 
> > This patchset implement a v4l2 framework driver and add a binding 
> > documentation for it. 
> > 
> > Currently, the driver only support the parallel interface. And has been
> > tested with a BT1120 signal which generating from FPGA. The following
> > fetures are not support with this patchset:
> >   - ISP 
> >   - MIPI-CSI2
> >   - Master clock for camera sensor
> >   - Power regulator for the front end IC
> 
> Do you plan on sending another version some time soon? It would be
> awesome to have this in 4.18.

I was waiting for Sakari Ailus's feedback. But ...
I will send a new version soon. But not all suggestion from Sakari Ailus
would be accepted.

> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com


Thanks,
Yong
