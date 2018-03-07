Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-32406-1520456788-2-14171598372430218737
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520456787; b=N73BJhnQ82PjKSnd9seAFxf3XyKYvyNa7Gr/QgNmYeAm+8f
    cL/ykzZQHjvxboD4YpIxJ3OiZYP/bbPgekC6/YsgNe4pFUsfx5qAsGFyWv0fuf8H
    CqWoEtcj6NZGFoZH1Yx+OU0ROrjt7NWpJZ2esCtsoIPvpPopylebznXo1nVjDFFz
    JZ4ZNuZDsNKtheS8qgl/KDqHDDbal+zJ8UiDt+qwodpsnKn9iMtE+KgCeeTnHWlE
    UGQEvvm3Bb2eo8V6iKkLv76zqgKUeVtnjCunhOA/hE5oyIwUgBWPrzXO6k5TSfD1
    oIeL26viqHdsKyjZCmt3jpPIkYdShei0/wLOAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520456787; bh=a
    Uj4W5npbCaxj5dYyExXeTdFBOMu5v/6a7wTiLpYCqk=; b=b0exi9DJaxeS/UHVK
    EX9ZkeePCD1rGeSjyOuCEqYweb/AjHDxW5wSOU8tBQYnQxMKbzY+kc2/csfCt2wo
    HGZ5cJxwy61/6ZPugNZqWU6Z4B0NwDBOeT2odrIwjhcGuJBjeFgMdgf0ajh8eBGG
    k1BOWDsn3AhrHSpXe4FTjLIH7tVHcsCJ/d2LRla1CI1tYxzjp8v3rF4LJcFdvENm
    2q9KPVVFlV02V20gVBUjOuijbwG8dZKw473U4Zt63lPgCySSzBC3q4mk0ekOapuB
    rSMPRqNuFhOOvuistU3sy0LnDJmrpgw2T3pysf72x9R60qWIuB3RVEG3yuQWu/i5
    +eaww==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006F72172D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 21:06:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH v3 2/4] Staging: iio: adis16209: Change some macro names
Message-ID: <20180307210615.63768b5b@archlinux>
In-Reply-To: <3880510489f196d93ccb3ef7551e0216009d4a10.1520164945.git.shreeya.patel23498@gmail.com>
References: <cover.1520164945.git.shreeya.patel23498@gmail.com>
 <3880510489f196d93ccb3ef7551e0216009d4a10.1520164945.git.shreeya.patel23498@gmail.com>
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

On Sun,  4 Mar 2018 18:11:17 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Make some of the macro names according to the names
> given in the datasheet of the adis16209 driver.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
A small comment inline which we should clear up in a follow up patch.
> ---
> 
> Changes in v3
>   -Introduce this new patch for v3 of the series.
> 
>  drivers/staging/iio/accel/adis16209.c | 48 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index d8aef9c..eb5c878 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -68,21 +68,21 @@
>  #define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
>  #define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
>  
> -#define ADIS16209_DIAG_STAT_REG			0x3C
> -#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
> -#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
> -#define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> -#define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> -#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
> +#define ADIS16209_STAT_REG			0x3C
> +#define  ADIS16209_STAT_ALARM2			BIT(9)
> +#define  ADIS16209_STAT_ALARM1			BIT(8)
> +#define ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> +#define ADIS16209_STAT_SPI_FAIL_BIT		3
> +#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
Given these are also fields of the STAT_REG, be it defined in a different
fashion I think they should also have the small additional indent.


>  /* Power supply above 3.625 V */
> -#define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
> +#define ADIS16209_STAT_POWER_HIGH_BIT		1
>  /* Power supply below 3.15 V */
> -#define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
> +#define ADIS16209_STAT_POWER_LOW_BIT		0
>  
> -#define ADIS16209_GLOB_CMD_REG			0x3E
> -#define  ADIS16209_GLOB_CMD_SW_RESET		BIT(7)
> -#define  ADIS16209_GLOB_CMD_CLEAR_STAT		BIT(4)
> -#define  ADIS16209_GLOB_CMD_FACTORY_CAL		BIT(1)
> +#define ADIS16209_CMD_REG			0x3E
> +#define  ADIS16209_CMD_SW_RESET			BIT(7)
> +#define  ADIS16209_CMD_CLEAR_STAT		BIT(4)
> +#define  ADIS16209_CMD_FACTORY_CAL		BIT(1)
>  
>  #define ADIS16209_ERROR_ACTIVE			BIT(14)
>  
> @@ -238,29 +238,29 @@ static const struct iio_info adis16209_info = {
>  };
>  
>  static const char * const adis16209_status_error_msgs[] = {
> -	[ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> -	[ADIS16209_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16209_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> -	[ADIS16209_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16209_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +	[ADIS16209_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> +	[ADIS16209_STAT_SPI_FAIL_BIT] = "SPI failure",
> +	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
> +	[ADIS16209_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> +	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
>  };
>  
>  static const struct adis_data adis16209_data = {
>  	.read_delay = 30,
>  	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
> -	.glob_cmd_reg = ADIS16209_GLOB_CMD_REG,
> -	.diag_stat_reg = ADIS16209_DIAG_STAT_REG,
> +	.glob_cmd_reg = ADIS16209_CMD_REG,
> +	.diag_stat_reg = ADIS16209_STAT_REG,
>  
>  	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,
>  	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
>  
>  	.status_error_msgs = adis16209_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_FLASH_UPT_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_POWER_HIGH_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_POWER_LOW_BIT),
> +	.status_error_mask = BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
> +		BIT(ADIS16209_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16209_STAT_FLASH_UPT_FAIL_BIT) |
> +		BIT(ADIS16209_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16209_STAT_POWER_LOW_BIT),
>  };
>  
>  static int adis16209_probe(struct spi_device *spi)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
