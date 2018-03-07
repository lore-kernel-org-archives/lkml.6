Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520453390-2-15658140980370398466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520453389; b=XcRrVn1tel0s3gF3dd6NXL7TA9fPRpVNIMZOYzhMZsaZcr3
    eEyv64GZVeBAA5/UaYM1d3vAG/bMGZh6DJaeHz9U+h/IuF5JGBnWhLL3RCJWsf7v
    v0TGDVz0N4J3B8i9RYVw3+icLK1qEt8/GhMxifGexna70AWZA8ZEjL6Ohd2QaF0T
    fuJHPc8bnKfqLXY9L9UaissLf6tE78n0k/4m0kmJ5EAX1Mjtee1T2dcg+De/+WS3
    QniYczrxGS7Z/St36SgIXKQG/4fR2IIQAztYceczBmNl6C1IBD5zQ9+qDQ6YZuZ3
    CDTlnhPowGat4OFh4LOG8XpKcJh0Wh50SgeTncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520453389; bh=8
    9PTLvBy+ClSPhuTF52hcFEKKPyNvapFQPyCMVOTQ6M=; b=SbXjCl8FREMO7o8W5
    b/xOW+6q7dW7zu6W+6E4Lemjg7yPSZOTrVGw7RH6HbwawJB4YrifTIsttXlF0W8e
    PkpwdyaeAXUM3VAfDlqpti+ZaS3SepbzyTSST9HT4PzCLEr5x0vhecVjW5v4M2jt
    a5+OlfMqdtfzqoTyrL50ngv2DJAL/qzp4wAf+K+5XflTOuUIRlrWzqXC1Og/IGcT
    G/+DQugVKr5eqbgRZxhHFoUzj7l4HflVlntqxQYnVopCPBjQlJwOsdb0uqeTaDl4
    9tR9tSetU7CceVLoYaazwHxD6C6VcQ/sYKHBz8BthB/2MQ2B105xvLuNXkCmB2KJ
    nEwCQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7993420685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:09:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 2/3] staging:iio:meter: Remove unused macro
 IIO_DEV_ATTR_CH_OFF
Message-ID: <20180307200932.040bf33b@archlinux>
In-Reply-To: <d22093b4c22f6df9c6efc2e7f711417726719fee.1520382753.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <d22093b4c22f6df9c6efc2e7f711417726719fee.1520382753.git.rodrigosiqueiramelo@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 6 Mar 2018 21:44:07 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch removes the macro IIO_DEV_ATTR_CH_OFF. The macro
> IIO_DEV_ATTR_CH_OFF is not required, due to the replace of it by the
> direct use of IIO_DEVICE_ATTR in files staging/iio/meter/ade7759.c and
> staging/iio/meter/ade7753.c.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Doh! I should have read to the next patch.

Personally I wouldn't have split this in to, but it is a small thing
so doesn't matter.

Applied to the togreg branch of iio.git (having reverted my tweak
to the previous patch) and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/meter/meter.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/meter.h b/drivers/staging/iio/meter/meter.h
> index edf26302fa57..5ed59bf30a25 100644
> --- a/drivers/staging/iio/meter/meter.h
> +++ b/drivers/staging/iio/meter/meter.h
> @@ -348,9 +348,6 @@
>  #define IIO_DEV_ATTR_VPERIOD(_mode, _show, _store, _addr)		\
>  	IIO_DEVICE_ATTR(vperiod, _mode, _show, _store, _addr)
>  
> -#define IIO_DEV_ATTR_CH_OFF(_num, _mode, _show, _store, _addr)		\
> -	IIO_DEVICE_ATTR(choff_##_num, _mode, _show, _store, _addr)
> -
>  /* active energy register, AENERGY, is more than half full */
>  #define IIO_EVENT_ATTR_AENERGY_HALF_FULL(_evlist, _show, _store, _mask) \
>  	IIO_EVENT_ATTR_SH(aenergy_half_full, _evlist, _show, _store, _mask)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
