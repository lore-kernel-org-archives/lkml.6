Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521377305; cv=none;
        d=google.com; s=arc-20160816;
        b=Ogptn647/FGYHrPFdS5exuH7ZqsxoR61qNd2ZIaH/JS0Z+CjjAJiF2uW+Nr3g3UHGb
         Oxf8meSCQaqwUt3eyJy26SMkkuiMO/4viLe5viMlhppna4GRUqUlhupOTOtjlZzHEsoC
         tPUiSsp3UgoVoETfdTdAWDPf+ZZXRP4K3kXzLagJBABPZzf8Za12TXHN3kUrC3V9Q5SM
         UqfykvvZQzikjWBASEM6e24FLVfSnvMkczo148k714aUIaazF8FCKN806yO7emKdVa/z
         KYpQZ2qOPvaORlTIYN/KFa82gyxXuR5tsV7R6Ysij22ssl4IOaSP3UikPDetMSEtLzBU
         QAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=6tWq4rbuwTjgIDe+NDVSmZPZhaCxICbPyWue8MxQS58=;
        b=idNqjYmyIqvv51+WKtg5MO36F24Q5+1fwHNWHpRJMG85fkBfWUvIBKg6yoMx8P13vV
         CeYAYkmc9a6sK6qKmS4BciEKgxbKtY79jNrso/Au3ZdSfw4K+qBgMzxtQObDXkho8ioh
         CR+lG1iPle8z+TTZ/5+u7T/ehzw46yxzHCE/+RNR7+xYwv7EOYf42ebHGvl+Ku1W049U
         Qle+wyxLQ9imRZM4P8kHxNtniVMhVIR/NUMoLX5KvHmRBjL5SVa93F9kHM77lfLVVahF
         FwD1yC6vRyC2SFDiGuxanQejANSyip/UvuapDs8Ay3zbx4yrvvw2tbOGkKcirmR3UVu2
         Hd/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELvvUurw+wZe7XPpxDNh9W8Nn6mwLVJ64J4dsvIImUjmcuHj8ZU3nKx/ek1Pfcjsu9qZipMz+g==
Date: Sun, 18 Mar 2018 07:48:23 -0500
From: Rob Herring <robh@kernel.org>
To: Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 3/6] dt-bindings: soc: Add a binding for the Broadcom
 VCHIQ services. (v3)
Message-ID: <20180318124823.jfvoy3xraogsxpdi@rob-hp-laptop>
References: <20180309184417.23368-1-eric@anholt.net>
 <20180309184417.23368-3-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309184417.23368-3-eric@anholt.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594486750832006220?=
X-GMAIL-MSGID: =?utf-8?q?1595279729720921135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 10:44:14AM -0800, Eric Anholt wrote:
> The VCHIQ communication channel can be provided by BCM283x and Capri
> SoCs, to communicate with the VPU-side OS services.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> v2: VCHI->VCHIQ, dropped firmware property, added cache-line-size
> v3: Dropped cache-line-size, s/vchi@/mailbox@/
> 
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt

Reviewed-by: Rob Herring <robh@kernel.org>
