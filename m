Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3527515-1521362095-2-4275132087889169207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521362094; b=DAGMhVTBeVx2bmtB4OXcDozLNi7WncZieQTZJHO1gu2LxBx
    XwEKMNdkWZlZNukt/sCHD//OvoJWbTv4R1a5dTGWJv/9lV9C1Qkvq0Q/oxtkQGe4
    gidmsOvS9I6Ph95CZzn1mGfxg7e3mirtbf0C7l7buZEf87fo5TtPPpXuKVuuKtNk
    NORHTjPbKcq1dlvh3cz61wCMKMFf8NJdB/ZjSglIZvwmXsI+7hcmBR7C4d7rgVwu
    +Ihvmw+PyA1ut3kdWRwMfx7gEeKmE1DWyhcMzpOSaC/VwYWOOMW7Oi2kn2d+3RoR
    ojMh3ywNVFy22O2zHQq9ke1M0fcV3LXqaZo4oGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521362094; bh=j
    oOMvkNGpoOkcxpFsmTdeV+9jBas9bnRS8ARAfb7ySE=; b=K3cE+h9+5/F+35MBz
    dvtq6sHNF7zNWlmKDPZAhiqSRIPrqldGJro9j+dQ6XRUgApmDMAj98smFGeFilLA
    FO0eh2pKsZ7MyQxTiVm2x6TovCFXJPcMEfH7R/Fx9gcwztI5t+yWemyzB0vLUtkO
    LEnn3vUlqcg8jYcSIs6WKHPzXpvRaz87RaI7o2DuRSbHfbWMqy7mLL+jySQeWWkz
    ANaA2WI3smTLtbEF1mRuoI/V8pQv3m+BqPZjwgpAmqYLD6d0uqJy8Mox9zKaIzcc
    XnIomdDk/cnBRHPeE0Km0Cf5afMDw1ubs62sEsPeUNAiF8oA9+Xd/b2SlX734diW
    Dk4+Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA3D21720
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 08:34:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH v2 7/9] Staging: iio: accel: adis16201: Prefer reverse
 christmas tree ordering
Message-ID: <20180318083442.15544cc9@archlinux>
In-Reply-To: <1521230786-18155-8-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
 <1521230786-18155-8-git-send-email-himanshujha199640@gmail.com>
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
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, 21cnbao@gmail.com, linux-kernel@vger.kernel.org,
 pmeerw@pmeerw.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Mar 2018 01:36:24 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Prefer reverse christmas tree ordering of declarations to improve
> readability.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
As ever, this sort of change is only worth doing if you are working on the
relevant code anyway.  You are, so good to tidy up! (I put that here to
avoid getting lots of people feeling they 'have' to make this sort of
change).

Applied

Thanks,

Jonathan
> ---
> v2:
>    -no change in this patch.
> 
>  drivers/staging/iio/accel/adis16201.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 298bf90..00e944e 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -259,9 +259,9 @@ static const struct adis_data adis16201_data = {
>  
>  static int adis16201_probe(struct spi_device *spi)
>  {
> -	int ret;
> -	struct adis *st;
>  	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
