Return-Path: <andy.gross@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524777465; cv=none;
        d=google.com; s=arc-20160816;
        b=NaLdzWDfY8dcWt6c8su3YycXRSItAu1HJ/C5jyYOw1sxZT2DD5vciqIIEtSNoeXgfJ
         7H9KXUeHrs5/NKSp4sR655MfPpWdqPiM5lLZ+k5zAeH4aEwn3PmVBH9NwRfxyUQcuDKz
         F58Nl7AxhTconbLgei/uyPDJOgBYNwN0mbPYb8zf5KCsDLYtxtTEWu6p6R5Xb5h9O4MH
         Bt1T9OI5lLMCVL7K4OIJtVYNpUC1/EtIp/pin3/JMTYz9FzcZ8mBS4O2I9fY/BxIdiZA
         kw3deQRnIxBnWzZ/N3frmyainVwOV1lwrFHBpit8ukokIRV/XNwbK7v5fBlXVr2r2oQT
         I9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=d7sgkDSeRoTfi06dTL9NMRnGN5FHme+USrOm6nGHPJU=;
        b=Dc6noUXg2zysddDRN7J+skS8Q2ygBLCdDmytApDh+6sug/6APCKFn/5SawSoNf7jO7
         KxwA+TBXHF8tAtMrXxOkO88j/Dkd23M+OhaE5ua6aQVW1dUI2fanJin6xnyM+5H+CYOH
         pyL/YyK8gI8fLg+lpkqXkg9X7JSDMpeI8ALUdeqTg1XH6aioQDI7MrIZSK2PMTcIl35i
         CibGP0fNVOUVyFmJp8vY3gIYs1FKcPMx+ym2Es5PogDWkfN2jRqh8WiZPG/OSYt1B+wx
         jOwsK6dzQ5QWvSxYd7Z1WXGBVUUeGsmn3hcU9vpyfeTOcoow3Jg0q8eJBQvqAKblOdYN
         99RA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Zw7IJCo8;
       spf=pass (google.com: domain of andy.gross@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.gross@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Zw7IJCo8;
       spf=pass (google.com: domain of andy.gross@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.gross@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpqI48TRLMPBMDhJhfZaNLsqDkJy4pqdJPcfBxChTYVviaP78Zq23kxdc/IhHrPQZO1DAm0VQ==
Date: Thu, 26 Apr 2018 16:17:40 -0500
From: Andy Gross <andy.gross@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: srinivas.kandagatla@linaro.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
	linux-arm-msm@vger.kernel.org, plai@codeaurora.org,
	spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com,
	david.brown@linaro.org, robh+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
	perex@perex.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
Message-ID: <20180426211740.GC25699@hector.attlocal.net>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
 <20180426113911.GA21755@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426113911.GA21755@sirena.org.uk>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801756443527719?=
X-GMAIL-MSGID: =?utf-8?q?1598845055305052468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 12:39:11PM +0100, Mark Brown wrote:
> On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla@linaro.org wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > 
> > This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> > ARP driver is made as a bus driver so that the apr devices can added removed
> 
> What is the plan for getting this patch merged?  I think the only review
> I've seen from maintainers thus far has been from Rob on the DT binding.
> It's obviously going to be a dependency for everything else.
> 
> Also just saw ARP->APR there.

Mark,

I just acked this, so it'd be great if you took it along with the others.  If
you don't want to do that, I can just pull it in with my pull requests.

Up to you,

Andy
