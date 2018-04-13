Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523655725; cv=none;
        d=google.com; s=arc-20160816;
        b=eLox0ATYCdFjZplibIp22br9n+mX53NtbJTgTvHBdXxnu1qczqts8fHcpnrVDOIB4B
         mOKuspV9tMplmU3i2eZdKBaj9c2TjBFwlIm3WDvl/xEo7Ysv1qaDLpQ3HNbECRNXr5LP
         NzAJ1tthMdaa17XHK+t8KdDqT2/kJiJhqERqxcVJMfP2NoHOzkFZa9ItHNGjEI2GsO9D
         qqnplr5pEVeBHJ6dYW5eHHzby+mMPBB7jLTX58aJLA45VRp2JBN0fv9aQdomPEQF3vSU
         c/3INWXRsTVcPB4BVUGUAXfcYk7l/j4QhGZXcYpTp4rq4smIrazh9B+JYwpzYyJZhOdU
         bLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=O/1Za+/uA5lUSeH/NGJgd+C/togu7Fg6szYvsFoB8HI=;
        b=YNWChgrtHv6pZJrb+0xLdT8ICpRmsNyTJxcxDJSx+JMFef0CzP/YcloC58eNoZPl5R
         1zbv6U7fPOAqaw9jdfp7k0OVdxusNozDb0tv3K1lTefipasOxBm4qkWSksxFjLP8AZyc
         Zbd8E6mxaLRStkF2H7PrAbINzejfg5tH4KPak5lfQkBEUuooeNnlCWEOeNeQN0WGxylM
         lJj2FSKv9ixV/SjXmx3o+MYWFaYsJHgtA62UZCf5qF0DHtU58WQ3zORkMkNj0DoiC+J6
         UNefTDnxgcE6lFPbOU7213FJrU0ndfLLQY7oaaVMlHwjqumvA7N4ZknCoKYzYZMrUlW4
         7nLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4/TpF5twS8N0F55MDhPd/e+sADpslDp6/VzqTdRvpNRambpNONb0qcdv+6XkF83Li9iAnvFjQ==
Date: Fri, 13 Apr 2018 16:42:04 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: afe: add current-sense-shunt
 and voltage-divider
Message-ID: <20180413214204.6msvqb4sk3uaeiq3@rob-hp-laptop>
References: <20180410152802.30958-1-peda@axentia.se>
 <20180410152802.30958-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410152802.30958-2-peda@axentia.se>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373529205381513?=
X-GMAIL-MSGID: =?utf-8?q?1597668825917352750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 05:28:01PM +0200, Peter Rosin wrote:
> An ADC is often used to measure other quantities indirectly. These
> bindings describe two cases, a current through a shunt resistor, and
> a "big" voltage measured with the help of a voltage divider.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/iio/afe/current-sense-shunt.txt       | 41 ++++++++++++++++++++
>  .../bindings/iio/afe/voltage-divider.txt           | 45 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt

Reviewed-by: Rob Herring <robh@kernel.org>
