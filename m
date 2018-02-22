Return-Path: <herbert@gondor.apana.org.au>
X-Google-Smtp-Source: AH8x225qOhAmgL8+fCub73nm1dwc8lngBBTJsXeIObKuxzYCAb4B9nmQbPDwLgupJmfl5U9Qpb4t
ARC-Seal: i=1; a=rsa-sha256; t=1519308227; cv=none;
        d=google.com; s=arc-20160816;
        b=bs5VCD9kpXRx7vZOfjSPEuCz24JlszrONcWrZE13MKfKWL0TAkT5C/d6LriHQi5mRf
         rvO3wuhEmSmu/aecGa5dCWYhwpL/56VNJ5Lp5y7sC+fH6XqU+6pf0fCx+gXNqSqxxxBf
         +GO0Qf419s8O9ULK+h3zc5s6k7HJ6jbFjY71FVO75yJPeCc88AA26L+EfoDXcBnhJoEj
         jtwf1/vl2DETbhlg18TGMhymLStw2Oys7r/8pGNWbyuvHXWoEOk6flubEfqXdnYxAtzV
         J2YaHGi49XfmJ1m9MxfpNVmqWUh4XS5S0c5XMYr0nUSCcW4+pYob+JfYIGaK6Vwy1E1r
         PTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=IP02vbo4ou+JdTrZzC6XK/afvHOaZm5JiCub2Ckn6b4=;
        b=KLa4sXRcHjH+EBx0prIARdODBTlKgxVHXJa5neqMwx1xpX2OKevZGpnDkwhCkg+kxV
         hzdlYOxC1YgH9IZZ2DAadpCh3V+qMv4sIcsncWWEPGIpd7oTghJf37lS87ZLUtZs0ZXf
         3hUhDFUsMccLZOTmh5jYPqUexu4ZXUY9D9/SGtZPF+o9VGLWAJBYXhSmH0gujuQEsmbs
         +jMbj26y7//42Pe2cElcWR2DW1BauCnKwY6Cu4kLwjNGsmjWdvpvbjuk7V5ANG6Po/wx
         hnH1lq1VY1nPhN2P7rfKMHJmf+aXP9rqLdgO9dweo9FALgd6OVbpf0kjWpUvMi9ZsgT4
         +qvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Date: Thu, 22 Feb 2018 22:03:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lionel Debieve <lionel.debieve@st.com>
Cc: Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Rob Herring <rob.herring@linaro.org>, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>,
	Ludovic Barre <ludovic.barre@st.com>
Subject: Re: [PATCH Resend 0/5] hwrng: stm32 - Improvement for stm32-rng
Message-ID: <20180222140328.GE28447@gondor.apana.org.au>
References: <20180215130312.23612-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215130312.23612-1-lionel.debieve@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472174804694074?=
X-GMAIL-MSGID: =?utf-8?q?1593110143862723185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 02:03:07PM +0100, Lionel Debieve wrote:
> This set of patches add extended functionalities for stm32 rng
> driver.
> Patch #1 includes a reset during probe to avoid any error status
> which can occur during bootup process and keep safe rng integrity.
> 
> Patch #3 adds a new property to manage the clock error detection
> feature which can be disabled on specific target.
> 
> Patch #5 rework the timeout calculation for read value that was
> previously defined based on loop operation and is now based on
> timer.

I should take only patches 1/3/5, right?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
