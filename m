Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELuRfKluhGWd3Q1c6ND5ho3QIaYIAUufbp1bmXv+N7JyrSKC+O22PtBidZvfVMqeYOHhqHzk
ARC-Seal: i=1; a=rsa-sha256; t=1520696592; cv=none;
        d=google.com; s=arc-20160816;
        b=JVPUk3wEOLXrmzwq+r7lAIqpCN7VPeV2NG9QmJyG/Y4u9V6/fO2KjCJ2k8xCOzPJ9I
         dnMdCpIQG0FiPmm5sloKLatZlveco8uHjHt+Ysngfkkb46n3hUAMp0ilFZ9ed6yb44vU
         OaHyjM4k44MzgVeQsCKFPKLf3tbRQEvrJEuM6SQOynxQ+nmh9GR2qDiqyP3VeWVW4fAG
         dfCENV7ActN7zabIiLNhJFgHAZo4y30TtFNkoTin0fgQEiN8GzPNokAnuaUa1CRd/YdR
         ryTCRYaCWMhB0N/8emr/q//9pl9Kz0Ci+WRDKkHCWUFgHmsOdU5S7e8o76BMLMMggR7x
         xV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=3oQh73AANkgpGWJzpzn/iD0TFXQ+FCPlAGjigoP9Yhc=;
        b=hKl4dCF6Ri4ErcFIL79o2WyxrvWWo9G9lWmi1n3bsJnIW7Bk/jn4ngNhiNd8u02NsH
         FI3FeSYl3xIbiu5KUexwWpiXtxmubzeKtd+ZR2JuQETFnlEHjLRWAi4ooRtuCgALPYym
         fKyNSZ6QNcYNi8h6mCHhRNvSC8X1snbeBVE4Wm7ISOC0jMkPuv/zhJPcldFWG/4gJyA2
         w7icl9QHs0NjpCzBZ/+pTox6WvlMZWZHVJ6QOxPNTBFHg9uaqhiWpbKnrsrfzyTIrMSD
         p7vG5Sw0mAa30jpGXpw20zlPrqD6kxocbtKjI46MeoEriWkerG7N151P6eUOKhh232g8
         /jGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8322620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 15:43:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 daniel.baluta@gmail.com
Subject: Re: [PATCH v5] Staging: iio: adis16209: Change some macro names
Message-ID: <20180310154306.0dd311a5@archlinux>
In-Reply-To: <1520676614-9556-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1520676614-9556-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594545037143650868?=
X-GMAIL-MSGID: =?utf-8?q?1594565949690040122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 10 Mar 2018 15:40:14 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Make some of the macro names according to the names
> given in the datasheet of the adis16209 driver and
> have slight indentation in field definitions to make
> them clearly different from the register addresses.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
I applied an earlier version so this should have been an
incremental patch not a new version of that one.

I have since pushed a tree out with that patch and it's a non
rebasing tree (as others may be basing their patches on it).

Hence please send a new patch to just make the indentation changes.

Thanks,

Jonathan

> ---
> 
> Changes in v5
>   -Re-send the corrected patch.

Please keep previous change lot here as well.

> 
>  drivers/staging/iio/accel/adis16209.c | 48 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index d8aef9c..ed2e89f 100644
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
> +#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> +#define  ADIS16209_STAT_SPI_FAIL_BIT		3
> +#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
>  /* Power supply above 3.625 V */
> -#define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
> +#define  ADIS16209_STAT_POWER_HIGH_BIT		1
>  /* Power supply below 3.15 V */
> -#define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
> +#define  ADIS16209_STAT_POWER_LOW_BIT		0
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
