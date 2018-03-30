Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx49sNWblIMoOvfn+g8uRy5ld5aZllxPLz6YNBbZ6AiXZOhGmFbyIDzvcsFFk2wPfbVkh28MU
ARC-Seal: i=1; a=rsa-sha256; t=1522406359; cv=none;
        d=google.com; s=arc-20160816;
        b=YCrgXSU6w6Q4vm72Uyjft99Ntwkto5eFZ55bPD8uQMW1F9Ie99B+zdgpPW9xOj+kOd
         CGKZU6NMMUz+b4qdZMvQClhvzyS4KVOFn7OLBRdCQxCN7tjTKXVftcKNRPGwc+t6WBMk
         XPFtadcNy4quKu5ydS6sc/z/wkzsrGYtBLCmJgP0i7jiETnVzWUyThJVpYBUptOzcut1
         EObbMUXExYKLdXVEsv1kaIr8n2ngAc6E56+Q9eqz00vPfTpC5bxJHPkV7An7LpUnjqIk
         dtgOfEmoysSEHhHzdBTd6z23XJEHLYOx8k8FS0sKJu/ykjFTxA4K0IZP6i5yy0A8zrS4
         kjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=DA8QCx3faFaa7WkH1PbMMXsy0NtlbnWdysowM92qhDY=;
        b=GjxbhM2nbS5eWtXbwFxi9A7YeoXVmVtQDsDTnLSzy3ULsBNe2hHHHxN3CsO57n4cQQ
         4Dj9N93hImMISYw74vgXxb6Bol2L8OJvtPhQsib1ZDhCcxiLqWJwLa3BJbnqxHncZNpc
         x7pJuZg9ZrXZhF4SxbmsLoeomWCkm0q9Q5JYEy22GxrJXJU7bX3smV4POHbnguOGP3CR
         iR59KDmM+dsFHKif2Vd+0a1zPv4sZHRZ7TYghFpj21G7jd36A6EYAh+pcNo3gjuDGR+8
         o6qe6k1YdYKTPvxKKjj7M2ObcMJhCb4kqKABUL6u5XMwOOEkmVvNPPBrUNA6T8r8pjws
         GbmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4221021723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 11:39:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v6 1/6] Staging: iio: adis16209: Indent the field
 definitions
Message-ID: <20180330113914.7d9dc309@archlinux>
In-Reply-To: <508a70d5477067c083408fc81e58023c7e91bc95.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
	<508a70d5477067c083408fc81e58023c7e91bc95.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596262688649068888?=
X-GMAIL-MSGID: =?utf-8?q?1596358770990317429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 14:42:02 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Have indentation in field definitions to make them
> clearly different from the register addresses.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Note that, given the timing wrt to the current kernel cycle
(merge window will probably open this weekend), this and
everything for the last 2 weeks is now destined to go upstream
in the next cycle.

Thanks,

Jonathan

> ---
> 
> Changes in v5
>   -Change some macro names and have indentation in the field
> definitions.
> 
> Changes in v6
>   -Have indentation in the field definitions and do not
> change the names of the macros as the patch for changing 
> the names has already been applied.
> 
>  drivers/staging/iio/accel/adis16209.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index a8453bf..0e6366a 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -71,13 +71,13 @@
>  #define ADIS16209_STAT_REG			0x3C
>  #define  ADIS16209_STAT_ALARM2			BIT(9)
>  #define  ADIS16209_STAT_ALARM1			BIT(8)
> -#define ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> -#define ADIS16209_STAT_SPI_FAIL_BIT		3
> -#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
> +#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> +#define  ADIS16209_STAT_SPI_FAIL_BIT		3
> +#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
>  /* Power supply above 3.625 V */
> -#define ADIS16209_STAT_POWER_HIGH_BIT		1
> +#define  ADIS16209_STAT_POWER_HIGH_BIT		1
>  /* Power supply below 3.15 V */
> -#define ADIS16209_STAT_POWER_LOW_BIT		0
> +#define  ADIS16209_STAT_POWER_LOW_BIT		0
>  
>  #define ADIS16209_CMD_REG			0x3E
>  #define  ADIS16209_CMD_SW_RESET			BIT(7)
