Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-32406-1520455897-2-1342251610838382899
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520455896; b=u47WBoRwV7t7mPbEh8zA4WGgxBrXZ2JT/7YoPU3wLDX4Bxv
    OKJJULEV49r00wX1wUk/1m22KMbdjflix/5Q9B+uwRtETy8dQBviP9s10MytQmdg
    qk9vhA7uCORAXrOIaK3g2+Jay/KdgS/wgX08q5C7jOGt1/UTWxNa399cz6dX2UTA
    r/vtPtnusZF+2zPRqwnW8WBV2BJD6OWHLXDiyw2vBIWf/qlYJQPlQHN+sLrNEvEY
    kwwt25UelnTO6HOXnOplHiWpqjTvL22m5Y4u32QZn6vHXpeecsWQ6HO+b+K2xvCw
    XTIXVcOpZ+6K+DabdHzjCuOVdU5rvTwGIKfcolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520455896; bh=m
    Dok3cGd3eeBRUXRK2nwvEicafflV1X/Yfxg6ELx1es=; b=QycFt0cahleUm3L8P
    kJLEaRstI3OiyWop/QT9wiVJ89XqM7O8WbRzLJVWy6eOgy3CArCdwtVUw2EQQgKU
    ZFkRYC759/P4vz3XaVvt8LWepLCz3fo6NNYBQgSd37YXGpZMWltWBcEvTBgg4uSR
    TrzKyQUct5abn08dbpAGIQYTHq11oZj0NzaQEFY1q/tI/yx0CAecm94i5+XI+6FG
    2moEUlaKADFAiMnbigjG/YYB1Oc5V74pTjEGu2ZiTI2ftyMk8mS707xast+gq5H2
    /dT/47wlZY/huBTNPhhinc5BuOXslk2RQLsQf+c/2HDu2Ih404fehR3lXvrOapab
    Nldog==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E318320685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:50:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 10/11] Staging: iio: accel: Add comments about units in
 data read function
Message-ID: <20180307205030.11fff428@archlinux>
In-Reply-To: <1520236170-14668-11-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-11-git-send-email-himanshujha199640@gmail.com>
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
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  5 Mar 2018 13:19:29 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Clarify the conversion and formation of resultant data in the
> adis16201_read_raw() with sufficient comments.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
This is fine but it needs to be in the original comment changing patch
rather than removing the comments first then a few patches later putting
back a different version.

So good change but in the wrong place in the series.  Learning to reorder
a series and merge down multiple patches into one is very useful when
working with git.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 8d795e2..946c7b1 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -130,6 +130,11 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
> +		       /*
> +			* IIO base unit for sensitivity of accelerometer
> +			* is milli g.
> +			* 1 LSB represents 0.244 mg.
> +			*/
>  			*val = 0;
>  			*val2 = IIO_G_TO_M_S_2(462400);
>  			return IIO_VAL_INT_PLUS_NANO;
> @@ -142,6 +147,11 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> +	       /*
> +		* The raw ADC value is 0x4FE when the temperature
> +		* is 25 degrees and the scale factor per milli
> +		* degree celcius is -470.
> +		*/
>  		*val = 25000 / -470 - 1278;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
