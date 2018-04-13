Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523657474; cv=none;
        d=google.com; s=arc-20160816;
        b=Kpnt2iuPC8J4xI6+GYUzJtAA2t29ab4N8PWssS8Y/TefEUAIa/CvgfHhZuKAN0QUAo
         cGD2YRYGM4WbzTxjxJBSe2MEoMAqFhUsIXrvlGqsETaxymeeKmcqgKAO0oFlbYc48j2G
         AsXGF59PXWno6IN9vGsS3sjapVY1q995fhxi+Ah1w9oC0+HhBSRBwh2/RcwzYRfk1h7D
         zSp/DlKrnGsihm+dvVmtrdFOlgVEz9BfBI3BoArkqTjHroP04XTp5T/99VpVu4HKWDv9
         Wm3+n8LDOk7/s5HxTBrhhqd5+A4LAVgARH1hjtqzPZvmSnCFGjqM5TQfG0EdtkYyX83V
         aeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=BEYlPo1ZOcf9fkTLNQFAXNPUV79SOL0z0d/Q1SZvgwc=;
        b=ASrVEYHsknZXpBcSuqdwiMieC4DfUAgHIaVHlN1EYZzkEBgymQf94hZ3OxWc28yXWK
         d0X6yVhzimBegS8hHnlFDhD3eyJz6fu6QZM8ss2m4oz3qQthtZjatR4MSxA9YD59g+Hr
         CK5rUiqvsG4LRgDN6yjBUze2muNKx1UP9XpQpKndOuqyrqDBl4xcpUypV7sFgYo1jlpR
         r81tQkeXKKDWVYdFoBJS0edfZuM0Sikfd/FWJvefxqeLw3dbEeyUwgl0JtIJmiI08+kg
         ea/5jFfZAzRcfFAjM5inx1GYSDIRmpWdS8/+Z+jxbW1zZjLg3G9sy15mFOXk6WOBE8qn
         eEbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=igPG+Teg;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=igPG+Teg;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48FZbXkyXlk59myEKKxCbqrJKlYsfXf/BYjMp78EFmS2SaoEMlRYr9WXJdDWWAZcWFnmDvuIQ==
Subject: Re: [PATCH/RFC] soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies
 return failure
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <c158783d-dd08-c197-8fc7-a0c56571743e@gmail.com>
Date: Fri, 13 Apr 2018 15:11:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597168233130064314?=
X-GMAIL-MSGID: =?utf-8?q?1597670660371427475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/08/2018 02:05 AM, Geert Uytterhoeven wrote:
> If CONFIG_RASPBERRYPI_FIRMWARE=n:
> 
>     drivers/gpio/gpio-raspberrypi-exp.c: In function ‘rpi_exp_gpio_get_polarity’:
>     drivers/gpio/gpio-raspberrypi-exp.c:71: warning: ‘get.polarity’ is used uninitialized in this function
>     drivers/gpio/gpio-raspberrypi-exp.c: In function ‘rpi_exp_gpio_get_direction’:
>     drivers/gpio/gpio-raspberrypi-exp.c:150: warning: ‘get.direction’ is used uninitialized in this function
> 
> The dummy firmware interface functions return 0, which means success,
> causing subsequent code to make use of the never initialized output
> parameter.
> 
> Fix this by making the dummy functions return an error code (-ENOSYS)
> instead.
> 
> Note that this assumes the firmware always fills in the requested data
> in the CONFIG_RASPBERRYPI_FIRMWARE=y case.
> 
> Fixes: d45f1a563b92dac7 ("staging: vc04_services: fix up rpi firmware functions")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thanks Geert!
-- 
Florian
