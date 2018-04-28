Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AB8JxZoNydk7NB7ViU6WKWkxFKLEHjb5etNnJeBpqLTzS5NZRpkLtpMtP06KZ2nfvBm+dakSCmGh
ARC-Seal: i=1; a=rsa-sha256; t=1524934953; cv=none;
        d=google.com; s=arc-20160816;
        b=ARh/DyYEvvvat/fb+UmJZPlN9xzVh3nzyD1cP6hmj+cBv5blWNQ5xJbGA3+O/t2SmM
         LxyIpV27FyOYotVG4TkqvQaLSi9+1Ia0aan3wsItnm/4+ChNvLo+154w6h/I+VjgGP0J
         rXJnHJa6eV9L7Fne+I3gNgyEd4IutqkItxUC4g0BHmT62B9bQc+a/VbsdxexMhkotHla
         Cps7ZZKj2OJjMuVaGqBrDugUn6ifyI0XV+MgrDoIzpkR8xM/oSlu2AySh5VY6Hhk9LHs
         dhgNE/kyv1CWAIzdTH1o20vgxvGjWb3pV0jXCam1QM56EZrYVsZ4Ti8FKHoGzEZtR0oR
         Hkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=gCA/efImHgHzyr+/nJi4mqC9KYuV+pj2c3gGUdaD5gY=;
        b=iWjJNcUwk9TGFsZ7o+rmvgZ2/cn91M9Jdxbp5dF/bNe0Cfk4GrQnfyhZxwyL0X0qRK
         AG17XypHTb4IrDIrCX2NWKCq3/JO1FNd5dJqd/UXkvmZc8okWgTZq1hjyoVLYTkusO84
         u+Bxb/3W26KBHeZ1R0jLEnuH1JEmfHFjCaVhLc7nmWn8TnDTIwdlj+zq77KOQo/bPhV1
         T3Z0SHXSHwlyiTNJ2X8/xzwPRyuHftvoCALASqpH2SD4+Deh3sChqGyUI0GD4MwJPxfa
         IFOzEJEC9jCMscIl61VkPMgnBN1ar3d+lnmVHCxdvh7FnZcHX0fP4MATBcc7AC/wVwUK
         2pmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311432256D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 28 Apr 2018 18:02:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org, Hartmut
 Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Andrew Morton
 <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, "Andrew
 F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: iio: afe: add binding for
 current-sense-amplifier
Message-ID: <20180428180226.66ca35ae@archlinux>
In-Reply-To: <20180427143025.v2pbl6ejikjhsoyh@rob-hp-laptop>
References: <20180423210809.29586-1-peda@axentia.se>
	<20180423210809.29586-4-peda@axentia.se>
	<20180427143025.v2pbl6ejikjhsoyh@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572695361215117?=
X-GMAIL-MSGID: =?utf-8?q?1599010193483561366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 09:30:25 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Apr 23, 2018 at 11:08:08PM +0200, Peter Rosin wrote:
> > Similar to current sense shunts, but an amplifier enables the use
> > of a smaller sense resistance.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  .../bindings/iio/afe/current-sense-amplifier.txt   | 26 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
Applied

Thanks,

Jonathan
