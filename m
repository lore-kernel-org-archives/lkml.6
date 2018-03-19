Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AG47ELvE+lWAoJuj9pqeneyKnVSCQJ8SOmnZhmV5LgMou0PiS5/8SCgO4u1OiNkmL6Z9+TlT+Enf
ARC-Seal: i=1; a=rsa-sha256; t=1521484606; cv=none;
        d=google.com; s=arc-20160816;
        b=KwFsABA6LxmYtEt6kZDhDqsJyfJHwTjAEwjTwQcMnLIuybvYaPfSGkee0DhIlQpdKp
         FwvHuyhhEEYkG9iUUd5o6GIHPlQaZaOZxXckp2AqwNLN3MJWGU5zbHL2TdHQquSXO6N/
         ea8ZhO9lJsUn0vU7Mfc3/TUMs6TZ06v5iqmnbOysw/rY1dJmzGhQTMJJOCS1Sfl3FxCy
         vogj+f+C5HvTlqDuOh/lja5L7PW4SKW1+DkPzlX7Puyv1MhVf79b0X7tTusuR0a36bp/
         nYs7i+uD6077ad8eHH3G/FMqphauJPtA77UtoiNPQNKkXrtiWV36PZ7XEDQzUh3CCRJm
         B39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Cfn48sERb6IH97Nm4GfD5OXzEPwzXLs6qW6vZcMiMeo=;
        b=CpZu9XW3o4cVhEe+qxahoTccb//vXjP37DGiJ6jEYyDQHSozrOKxJE+yCnp1tjV2TE
         dbRgcQaBMpPZYH1bPwQUr4yKYqgiCRKqE5wmg4/eN4445p4saZEGdfw9id3m/S19wMWG
         H6mIDgCtptDu48WURt6KQJBu/UeI4H401ufFcS+XLNUuJltRCz9rcTCrSOGE9rmGVXLY
         L0IQE8sfw4agEoUBuJYihg2+luDFU2PfZ0TvldmKGx5IT97rNCLXuPuZbbVdgiL/+ioK
         mnl7GdYdBdTvEgzJbZHeHg4QRE/ViMZOGf1tHmK2Kq2ANurlg7UZ2jGio/ef8uzsenQM
         50Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=q/g0l3oD;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=q/g0l3oD;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 1/3] iio: rename the multiplexer category to wrapper
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180319170246.26830-1-peda@axentia.se>
 <20180319170246.26830-2-peda@axentia.se>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6b97bd50-b2bb-2695-4efb-16bc70fd638b@infradead.org>
Date: Mon, 19 Mar 2018 11:36:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319170246.26830-2-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386347268786589?=
X-GMAIL-MSGID: =?utf-8?q?1595392242205624982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 10:02 AM, Peter Rosin wrote:
> Paves the way for other wrappers.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---

> diff --git a/drivers/iio/multiplexer/Kconfig b/drivers/iio/wrapper/Kconfig
> similarity index 88%
> rename from drivers/iio/multiplexer/Kconfig
> rename to drivers/iio/wrapper/Kconfig
> index 735a7b0e6fd8..f27de347c9b3 100644
> --- a/drivers/iio/multiplexer/Kconfig
> +++ b/drivers/iio/wrapper/Kconfig
> @@ -1,9 +1,9 @@
>  #
> -# Multiplexer drivers
> +# Wrapper drivers
>  #
>  # When adding new entries keep the list in alphabetical order
>  
> -menu "Multiplexers"
> +menu "Wrapers"

         Wrappers

>  
>  config IIO_MUX
>  	tristate "IIO multiplexer driver"


-- 
~Randy
