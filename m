Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4156463-1520455344-2-7103370777109360099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520455344; b=o0vxoEWFWaWbsBrS774V+yt/dhYhN3nZxoe27EaYyEz69Ad
    TOjr0HimR2kpfV8g4x26rqW3PyMqgtya6yrhOrdwQXzNX7MWBQQOkOPI6obbNrfE
    vwoE5yhPFLRxeo/XuktU9kH0XEOxLKurjWb/SrGpl0QWU7hJj+awZTbh3s8S84pt
    SZB7fkokUhDV5eqb83GFkqS1fBldy97yfGfdP82vYVbIYVZhFNaTLcdwPQmwvnT4
    bEIxX99T0lSxrDufI4HAqAnB6RZ12WcyeKTJI2j/wsgChbxloeZW2lJKfD9rVq+d
    2G8QHiXXcIyjFCbXmjt5cjQqvOZNtUH/Npb/RSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520455344; bh=y
    eleAJNKcBQBeUe0z31VdegK3UXuD8xeLpaK0pvKMJs=; b=eYq7pApd94Y8I6a15
    Zdtxw+o2lOaOybSnAiewDlANnrwfCwGm2Td2TO+pIzCEAhQyH5U3zyFVfr/LBI3g
    FPs2zQ0IfQEBVKUKfk1AYCcRhZqM91tmmZMKZcuCxQwWhpWp8X6kMHf4XLEoqjyJ
    lwC453GLQOWkygsjwmll4IrLLziCEiZSeoqtXtZnMaDxvEO8TF9dwG+uOPeVi71c
    ySXn5FJdpyBvbGauUwDtKofJ65jW//oSoalC3f7FttvU3gaHRfiyqRzo3gCX2+gf
    2zifs9e2lnskmX11NFUSkdWBVRpFgmWClfnMlnEAn/ULYRRmui0MTF0QnB7RMVIK
    TFgzw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED422133D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:42:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 04/11] Staging: iio: accel: Rename few macro definitions
Message-ID: <20180307204210.748056eb@archlinux>
In-Reply-To: <1520236170-14668-5-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-5-git-send-email-himanshujha199640@gmail.com>
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

On Mon,  5 Mar 2018 13:19:23 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Rename few macros with appropriate names specifying their usage/function.
Most of these are obviously good, but for one I didn't understand your
reasoning.

Given there are only a few of them, I'd put some more description here
to explain why you changed each one.

Thanks,

Jonathan
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16201.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 59c1166..445cb56 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -20,9 +20,8 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16201_STARTUP_DELAY		220
> -
> -#define ADIS16201_FLASH_CNT      0x00
> +#define ADIS16201_STARTUP_DELAY_MS	220
> +#define ADIS16201_FLASH_CNT		0x00
>  
>  /* Data Output Register Information */
>  #define ADIS16201_SUPPLY_OUT     0x02
> @@ -69,7 +68,7 @@
>  
>  #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
>  
> -#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> +#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
>  
>  #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
>  
> @@ -80,14 +79,14 @@
>  
>  #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
>  
> -#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
> +#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
>  
>  #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
>  
>  #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
>  
>  #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
> +#define ADIS16201_GLOB_CMD_FACTORY	BIT(1)
What was the logic behind this particular change?

>  
>  #define ADIS16201_ERROR_ACTIVE          BIT(14)
>  
> @@ -231,7 +230,7 @@ static const struct iio_info adis16201_info = {
>  
>  static const char * const adis16201_status_error_msgs[] = {
>  	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> +	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
>  	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
>  	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
>  };
> @@ -244,11 +243,11 @@ static const struct adis_data adis16201_data = {
>  
>  	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16201_STARTUP_DELAY,
> +	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
>  
>  	.status_error_msgs = adis16201_status_error_msgs,
>  	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
>  		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
>  		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
>  };

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
