Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3527515-1521361784-3-9251232057355832372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521361783; b=e9SMcBkgYLoYZeDh09IkI/Cdlel7oRvZ3Y4YIriST8Nygfe
    3LKWftujlnctlTzPabyjHcFw4rs2DREB9RBVMTAQF90kexAlKp02xYi4lrN3QVnA
    PHkoZLTwuzlB0atcp1+KYeBSrXy9xsk3pqo6nM4K1VskOWYUHFTRPyrmZRe2velQ
    V97xtyKqwQzbDVuGxcGjVpglUm82WzzWKWLq0Tl2mXthkjp3AtD1GI3Rqy/PkzC+
    IXQ0eiF4JHlHoclW4QsLBgF4sRGrmzBSJsIuaQU7seINjfJpplbKRfO0vJUYmC3/
    vi7OL+WSQzzgOTGxrz8yeagh2TTsVPDNttBA+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521361783; bh=x
    8i12HJHojAyLL3s1VveGed3/auU7M0YOkDgUzdBOG0=; b=p+mWPVqzubAN+hBf4
    PzcfyRFNRr86VBv7ZKGcm4cVk3TmjqN5ZgfFtoTAt9kXX5FeMU3A7D29V+c81TE/
    HSDxkVMdaOCcExNmo/F4PLHxSdvNblkopNzQmrxv1LXBD6j/99ElXNJwmFGu/PYK
    KSUSYNobt8KgI5GnPjQ8O9gANc9CkFZd9lOxbQuk2uCQG7LROElA4RnVNAa1PMir
    dV4xnnUkrNdWCQ5/qIJTTp8YwzoVTmXF7l2hooQ64iGfH60+zZMfKqJo71sIuTja
    pOWpz+qeK6azhQRVpY4o6YTSEgDCYJl2VXtV5tJAkFTxVoNKoFMVLG0FioIyVrDZ
    gRcxQ==
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E25321720
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 08:29:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH v2 4/9] Staging: iio: accel: adis16201: Group register
 definitions
Message-ID: <20180318082932.4b79b0c6@archlinux>
In-Reply-To: <1521230786-18155-5-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
 <1521230786-18155-5-git-send-email-himanshujha199640@gmail.com>
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

On Sat, 17 Mar 2018 01:36:21 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Group register definitions with its register field bits to improve
> readability and easy identification. A small comment is also added to
> denote the purpose/functionality of the grouped register definitions.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
There was one small issue in here that I fixed up.

Applied, thanks.

Jonathan

> ---
> v2:
>    -reordered patch series.
> 
>  drivers/staging/iio/accel/adis16201.c | 138 +++++++++++++---------------------
>  1 file changed, 54 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 0c63cd0..8de3f27 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -20,99 +20,69 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16201_STARTUP_DELAY_MS	220
> -
> -#define ADIS16201_FLASH_CNT      0x00
> -
> -#define ADIS16201_SUPPLY_OUT_REG 0x02
> -
> -#define ADIS16201_XACCL_OUT_REG  0x04
> -
> -#define ADIS16201_YACCL_OUT_REG  0x06
> -
> -#define ADIS16201_AUX_ADC_REG        0x08
> -
> -#define ADIS16201_TEMP_OUT_REG       0x0A
> -
> -#define ADIS16201_XINCL_OUT_REG      0x0C
> -
> -#define ADIS16201_YINCL_OUT_REG      0x0E
> -
> -#define ADIS16201_XACCL_OFFS_REG     0x10
> -
> -#define ADIS16201_YACCL_OFFS_REG     0x12
> -
> -#define ADIS16201_XACCL_SCALE_REG    0x14
> -
> -#define ADIS16201_YACCL_SCALE_REG    0x16
> -
> -#define ADIS16201_XINCL_OFFS_REG     0x18
> -
> -#define ADIS16201_YINCL_OFFS_REG     0x1A
> -
> -#define ADIS16201_XINCL_SCALE_REG    0x1C
> -
> -#define ADIS16201_YINCL_SCALE_REG    0x1E
> -
> -#define ADIS16201_ALM_MAG1_REG       0x20
> -
> -#define ADIS16201_ALM_MAG2_REG       0x22
> -
> -#define ADIS16201_ALM_SMPL1_REG      0x24
> -
> -#define ADIS16201_ALM_SMPL2_REG      0x26
> -
> -#define ADIS16201_ALM_CTRL_REG       0x28
> -
> -#define ADIS16201_AUX_DAC_REG        0x30
> -
> -#define ADIS16201_GPIO_CTRL_REG      0x32
> -
> -#define ADIS16201_MSC_CTRL_REG       0x34
> -
> -#define ADIS16201_SMPL_PRD_REG       0x36
> -
> +#define ADIS16201_STARTUP_DELAY_MS			220
> +#define ADIS16201_FLASH_CNT				0x00
> +
> +/* Data Output Register Information */
> +#define ADIS16201_SUPPLY_OUT_REG			0x02
> +#define ADIS16201_XACCL_OUT_REG				0x04
> +#define ADIS16201_YACCL_OUT_REG				0x06
> +#define ADIS16201_AUX_ADC_REG				0x08
> +#define ADIS16201_TEMP_OUT_REG				0x0A
> +#define ADIS16201_XINCL_OUT_REG				0x0C
> +#define ADIS16201_YINCL_OUT_REG				0x0E
> +
> +/* Calibration Register Definition */
> +#define ADIS16201_XACCL_OFFS_REG			0x10
> +#define ADIS16201_YACCL_OFFS_REG			0x12
> +#define ADIS16201_XACCL_SCALE_REG			0x14
> +#define ADIS16201_YACCL_SCALE_REG			0x16
> +#define ADIS16201_XINCL_OFFS_REG			0x18
> +#define ADIS16201_YINCL_OFFS_REG			0x1A
> +#define ADIS16201_XINCL_SCALE_REG			0x1C
> +#define ADIS16201_YINCL_SCALE_REG			0x1E
> +
> +/* Alarm Register Definition */
> +#define ADIS16201_ALM_MAG1_REG				0x20
> +#define ADIS16201_ALM_MAG2_REG				0x22
> +#define ADIS16201_ALM_SMPL1_REG				0x24
> +#define ADIS16201_ALM_SMPL2_REG				0x26
> +#define ADIS16201_ALM_CTRL_REG				0x28
> +
> +#define ADIS16201_AUX_DAC_REG				0x30
> +#define ADIS16201_GPIO_CTRL_REG				0x32
> +#define ADIS16201_SMPL_PRD_REG				0x36
>  /* Operation, filter configuration */
> -#define ADIS16201_AVG_CNT_REG        0x38
> -
> -#define ADIS16201_SLP_CNT_REG        0x3A
> -
> -#define ADIS16201_DIAG_STAT_REG      0x3C
> -
> -#define ADIS16201_GLOB_CMD_REG       0x3E
> -
> -
> -#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> +#define ADIS16201_AVG_CNT_REG				0x38
> +#define ADIS16201_SLP_CNT_REG				0x3A
>  
> +/* Miscellaneous Control Register Definition */
> +#define ADIS16201_MSC_CTRL_REG				0x34
> +#define  ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
In this one case you have spaces when it should be a tab before BIT(8).
I'll fix it.

>  /* Data-ready enable: 1 = enabled, 0 = disabled */
> -#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> -
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_EN			BIT(2)
>  /* Data-ready polarity: 1 = active high, 0 = active low */
> -#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
> -
> +#define  ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	BIT(1)
>  /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
> -#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
> -
> -
> -#define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
> -
> -#define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
> -
> -#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
> -
> -#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
> -
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1		BIT(0)
> +
> +/* Diagnostics System Status Register Definition */
> +#define ADIS16201_DIAG_STAT_REG				0x3C
> +#define  ADIS16201_DIAG_STAT_ALARM2			BIT(9)
> +#define  ADIS16201_DIAG_STAT_ALARM1			BIT(8)
> +#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT		3
> +#define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT		2
>  /* Power supply above 3.625 V */
> -#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
> -
> +#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT		1
>  /* Power supply below 3.15 V */
> -#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
> -
> +#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT		0
>  
> -#define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16201_GLOB_CMD_FACTORY_RESET	BIT(1)
> +/* System Command Register Definition */
> +#define ADIS16201_GLOB_CMD_REG				0x3E
> +#define  ADIS16201_GLOB_CMD_SW_RESET			BIT(7)
> +#define  ADIS16201_GLOB_CMD_FACTORY_RESET		BIT(1)
>  
> -#define ADIS16201_ERROR_ACTIVE          BIT(14)
> +#define ADIS16201_ERROR_ACTIVE				BIT(14)
>  
>  enum adis16201_scan {
>  	ADIS16201_SCAN_ACC_X,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
