Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518999019; cv=none;
        d=google.com; s=arc-20160816;
        b=jfduV8v1kQN/FdP3AlhmS/30/ZZ59faNZ55tu7ZlARI7Gys7PUu+EDRRb7A1p7ZfMK
         Lbk+FocbizxcTyIyDn2K90uGQ1UXHB8r+rIL7UTtTS51A5dNlDs2pf9FAMQRKqDkHlIp
         QDhVUesQp7LaAbiyn5FD+jRyYGew/VeraxD44z30d9iL0hF4m61gmqd7I7Ty7qqVKx4b
         pHpa7xZwP/c42OaEBgOzR73I0I6rmn7rLXrPX9Cgfl8oirOEVG3qMGA3Plo/inurGrtI
         ludIUysIWNqLiz6F8hqSUIUX77aNrh9yALeqy/5URcQwXym4nqYvzeBp6azVStJuR2di
         8RBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DZpf3PM8BDt7Txscj+AQGfL7ZBTYM9XovN4YjwQYxuA=;
        b=ZcCibHwuYBl74NlTy+vAexZe8wgtzye4X7+eB3ljnVk5Yh2LDPcz7EaUspsCMpL3cy
         CiZ6Ozf8GE6cAe2HRFS/+t9OaotyU5svfB2LHbTWy7k4ww+gx9CqHbh8nTIAmcTNiW77
         VJFzedCBNWdP1+yYsQt1BhtPG9KV8CMej5VSIcADPPWHiN0CWhHRVC6u3ZwRuvd7C9Rw
         2KwzVnxdqZxpsoqrVBxC6Y1gAJxVDJ7Nh6r3Rn6PWEymvAWveLxiNAS3RBOqt2gSbTRq
         IWPrLHdwwYmhRueHBv278oluYw5bn/3z5tO32P0rdnwlwdxSPtcGYopZoiZ8qYdhZz+0
         krWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AH8x224JOps9J6ABY/GhAuDFqoW6h5SEsDYC6mNUOl9KYrj1Ar3VhPe2sRXAObd7/rMr8QQiZ6xdqA==
Date: Sun, 18 Feb 2018 18:10:17 -0600
From: Rob Herring <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>, Cyril Bur <cyrilbur@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Lei YU <mine260309@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: aspeed-lpc: Document LPC Host Interface
 Controller
Message-ID: <20180219001017.cnei34oijn7ybh72@rob-hp-laptop>
References: <20180212070847.32387-1-joel@jms.id.au>
 <20180212070847.32387-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212070847.32387-2-joel@jms.id.au>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178085601098938?=
X-GMAIL-MSGID: =?utf-8?q?1592785915821807101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 05:38:45PM +1030, Joel Stanley wrote:
> The LPC Host Interface Controller is part of a BMC SoC that is used for
> communication with the host.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt         | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
