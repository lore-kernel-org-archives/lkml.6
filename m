Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3444719-1521361500-2-1761954628448708188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521361499; b=w9LvtYERC9uakXcxN8mc8Udcimr23Zw+epml3u/TYJbWs70
    /jutDl28IFnv4o8RURA2Ra8DEXVSNs6jrMvF6N1yM+O3B6gj9ZABKJzq4TIdZhq1
    gohVbPxsrSBxytb5iuDWigsoty5/cLFdBLkTooymWlv2E4yc47nZGGhU1e573I5y
    4fobt7Doi7zctiUaLlDdnDKz/0A2TWw8mkS8lJ2ehE7fZ39wHl/TX2ieBEwkC6Ti
    u79qheaEnWVrCXygeGPS5ftYXmik7uPNCST22TkQyLRjcv4YPa+RDLZhRxJjuRU5
    xjOZjWShYHd6IudqyPr4hc7eBgxQ6ZGCFG9HdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521361499; bh=K
    qw53CqNdUYMLVAKGy0uRtabsU6wV8ljOg0uEJlTO/M=; b=birbo54+JhXcVyj1/
    ZPbaFXsveZW7Qx/tIMZupqjmtJPXdR0gmNB+j5tnYNagM0BW7/+SuQo3UjRfYDTC
    sg/DoIQGoHEKDtaJEpk9QvpbNK8n4+uyTevKsMWeMB7aPcHzeL4U1XTbjncT/UEQ
    19tGgHvXfS/Wa3yGxz3IC85PQsUH8pRaixYgf3Fx0S9sg+hwZ9A1WY7QO4aW8hpb
    JXNgFJ3GjZ2jRo4c3Z+g/wkEz1WQX08dut2B+uaPKln/zK/joq3N/6IEcFNUq81U
    0H+4N8J4Wpx/NpZQXkfMNc/JUty0MZeUknzro1S1c7Td5S70E2n4+IVXYUjF/srZ
    GY7HQ==
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBE720838
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 08:24:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH v2 3/9] Staging: iio: accel: adis16201: Add _REG suffix
 to reisters
Message-ID: <20180318082447.5cc8d661@archlinux>
In-Reply-To: <1521230786-18155-4-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
 <1521230786-18155-4-git-send-email-himanshujha199640@gmail.com>
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

On Sat, 17 Mar 2018 01:36:20 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Add a _REG suffix to distinguish between registers and the register bit
> fileds.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Other than the typo in the patch title, this looks good (I fixed that up when
applying).  Applied.

Jonathan
> ---
> v2:
>    -reordered patch series.
> 
>  drivers/staging/iio/accel/adis16201.c | 84 +++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 6c06c0d..0c63cd0 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -24,62 +24,62 @@
>  
>  #define ADIS16201_FLASH_CNT      0x00
>  
> -#define ADIS16201_SUPPLY_OUT     0x02
> +#define ADIS16201_SUPPLY_OUT_REG 0x02
>  
> -#define ADIS16201_XACCL_OUT      0x04
> +#define ADIS16201_XACCL_OUT_REG  0x04
>  
> -#define ADIS16201_YACCL_OUT      0x06
> +#define ADIS16201_YACCL_OUT_REG  0x06
>  
> -#define ADIS16201_AUX_ADC        0x08
> +#define ADIS16201_AUX_ADC_REG        0x08
>  
> -#define ADIS16201_TEMP_OUT       0x0A
> +#define ADIS16201_TEMP_OUT_REG       0x0A
>  
> -#define ADIS16201_XINCL_OUT      0x0C
> +#define ADIS16201_XINCL_OUT_REG      0x0C
>  
> -#define ADIS16201_YINCL_OUT      0x0E
> +#define ADIS16201_YINCL_OUT_REG      0x0E
>  
> -#define ADIS16201_XACCL_OFFS     0x10
> +#define ADIS16201_XACCL_OFFS_REG     0x10
>  
> -#define ADIS16201_YACCL_OFFS     0x12
> +#define ADIS16201_YACCL_OFFS_REG     0x12
>  
> -#define ADIS16201_XACCL_SCALE    0x14
> +#define ADIS16201_XACCL_SCALE_REG    0x14
>  
> -#define ADIS16201_YACCL_SCALE    0x16
> +#define ADIS16201_YACCL_SCALE_REG    0x16
>  
> -#define ADIS16201_XINCL_OFFS     0x18
> +#define ADIS16201_XINCL_OFFS_REG     0x18
>  
> -#define ADIS16201_YINCL_OFFS     0x1A
> +#define ADIS16201_YINCL_OFFS_REG     0x1A
>  
> -#define ADIS16201_XINCL_SCALE    0x1C
> +#define ADIS16201_XINCL_SCALE_REG    0x1C
>  
> -#define ADIS16201_YINCL_SCALE    0x1E
> +#define ADIS16201_YINCL_SCALE_REG    0x1E
>  
> -#define ADIS16201_ALM_MAG1       0x20
> +#define ADIS16201_ALM_MAG1_REG       0x20
>  
> -#define ADIS16201_ALM_MAG2       0x22
> +#define ADIS16201_ALM_MAG2_REG       0x22
>  
> -#define ADIS16201_ALM_SMPL1      0x24
> +#define ADIS16201_ALM_SMPL1_REG      0x24
>  
> -#define ADIS16201_ALM_SMPL2      0x26
> +#define ADIS16201_ALM_SMPL2_REG      0x26
>  
> -#define ADIS16201_ALM_CTRL       0x28
> +#define ADIS16201_ALM_CTRL_REG       0x28
>  
> -#define ADIS16201_AUX_DAC        0x30
> +#define ADIS16201_AUX_DAC_REG        0x30
>  
> -#define ADIS16201_GPIO_CTRL      0x32
> +#define ADIS16201_GPIO_CTRL_REG      0x32
>  
> -#define ADIS16201_MSC_CTRL       0x34
> +#define ADIS16201_MSC_CTRL_REG       0x34
>  
> -#define ADIS16201_SMPL_PRD       0x36
> +#define ADIS16201_SMPL_PRD_REG       0x36
>  
>  /* Operation, filter configuration */
> -#define ADIS16201_AVG_CNT        0x38
> +#define ADIS16201_AVG_CNT_REG        0x38
>  
> -#define ADIS16201_SLP_CNT        0x3A
> +#define ADIS16201_SLP_CNT_REG        0x3A
>  
> -#define ADIS16201_DIAG_STAT      0x3C
> +#define ADIS16201_DIAG_STAT_REG      0x3C
>  
> -#define ADIS16201_GLOB_CMD       0x3E
> +#define ADIS16201_GLOB_CMD_REG       0x3E
>  
>  
>  #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> @@ -125,10 +125,10 @@ enum adis16201_scan {
>  };
>  
>  static const u8 adis16201_addresses[] = {
> -	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
> -	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS,
> -	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS,
> -	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS,
> +	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
> +	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
>  };
>  
>  static int adis16201_read_raw(struct iio_dev *indio_dev,
> @@ -232,16 +232,16 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_chan_spec adis16201_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 0, 12),
> -	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0, 12),
> -	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
> +	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
> +	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
> +	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
> +	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>  	IIO_CHAN_SOFT_TIMESTAMP(7)
>  };
> @@ -261,9 +261,9 @@ static const char * const adis16201_status_error_msgs[] = {
>  
>  static const struct adis_data adis16201_data = {
>  	.read_delay = 20,
> -	.msc_ctrl_reg = ADIS16201_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16201_GLOB_CMD,
> -	.diag_stat_reg = ADIS16201_DIAG_STAT,
> +	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
> +	.glob_cmd_reg = ADIS16201_GLOB_CMD_REG,
> +	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
>  
>  	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
