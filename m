Return-Path: <k.kozlowski.k@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524497222; cv=none;
        d=google.com; s=arc-20160816;
        b=cYR82KI8emPRyzFzHSobhVP/icsbOK2Rnwy6QcGA4GTbb/LVf/VNA+kb7ZGhC8vVK3
         XOzP9U5MDW4xbRs+BWI7OtImkjui8h5CPfguDzmj0IoyPdayri9O1EiSxyo9IAYQQY4E
         PZfPksb23Ht5m0oA1fJKWUFkn8NKBTu8LKgXhw9uZaBg9TPPXJBwfuJEq1P/16N/Gqdf
         7TFdXdPdu2O+T4b7+nhPkaLsSLNrZZGv5TSed0kk/K9heKGpWNnh9DZ5FUtcfohidrv0
         hqYRSpL0NGj5c4n0jUPtI0liWohkBnzGQyW7vV3MnWWcmru+ORa8OsQPouD5xve7UU0/
         4qkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=RR4M59OJFQyyCJPESLGHr7NSmhq4P35X1Ik0dedN3ws=;
        b=c8ICP4dOpzvqbNaiEvk0m6ghYCLvfHH+sDUVVCdFcm+A3OqafUsXIcEY/NTUX0rmoa
         8V7SIoYTSHEDsOMTZeRU9WKnJ3M9XqIoSLYdmjy8z9qkW6w0i2O4qON1rWHgryUU+ol5
         T+HadSkWxNGOVqPMYHLsfbC1FA/3JCgGRe0NmpBk0wkgyZxkrt4K7kPuwYunrwR6RouO
         5CDhmh2QKUG18NquqgS5HLfDrz19juVHhcPKMn10z622jV7QKqWPiIvnvA4Rx8nofjqt
         UIam1qQ0BKnC96dx9dyz/3RWEYXSVcix0o1vTLrMxF0Nt+MDPk9BCqAMPBdvXHlwJhlo
         OE5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of k.kozlowski.k@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.kozlowski.k@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of k.kozlowski.k@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.kozlowski.k@gmail.com
X-Google-Smtp-Source: AIpwx4/Yo79I5Tu5iA3YaMSTQBxglVZ+/9sAFmQYZjUmVEPhSiwXXuDA9ZPZlFCwBBklLB3TdOEQcQ==
Date: Mon, 23 Apr 2018 17:26:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Arnaud Patard <arnaud.patard@rtp-net.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [patch 3/9] ARM: S3C24XX: Fix invalid SPDX identifier
Message-ID: <20180423152659.xrvk73z3mj3j66mq@kozik-lap>
References: <20180422220208.772527041@linutronix.de>
 <20180422220832.982315239@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180422220832.982315239@linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486099682318202?=
X-GMAIL-MSGID: =?utf-8?q?1598551199517377518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 12:02:11AM +0200, Thomas Gleixner wrote:
> GPL-1.0 is not part of the valid identifier list and as its meaning is GPL
> version 1.0 only this would be incompatible with the kernel license.
> 
> As this code was included into the kernel, assume its GPL-1.0+
> 
> Fixes: 84b2170109e4 ("ARM: S3C24XX: Add SPDX license identifiers")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-s3c24xx/h1940-bluetooth.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

+Cc samsung-soc

Thanks, applied.

Best regards,
Krzysztof
