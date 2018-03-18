Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3444719-1521361335-3-4504470596497349794
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521361335; b=nb5FQgd0LorIhCPwesaYeRxOXVnhhb8w9iIGyo7zNXmdP/t
    tyNS5ehcgWoMzDicFIxOme8wTSEY2Old/MB1TCTKPNaJK69/9OuumKtDvGXEFAJz
    OWZq+JyeuIHXqIFjQbt564QFUzJVVt8MIHAaMcG/pbLo3bfwC8LzI1HhhEaa55ht
    rFcfepFDnGwR345ASc14bzzE9EFhJxrgS4he7cB2sAaS0BnQHhnam42+g3s+cw1l
    lDZMnEm4BM+niS7L2yV97roNEd5LeYuRB2rqzAhvEKOscNlJrqB3+rNF2R6PNkhE
    8/z3TCICkmJGZbJ7SA/xY2fdpv4XUlEVR3Poi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521361335; bh=p
    dRvdiPkOAaKG4os5Z1hQ66xoi0QTAqTmrho/+XHhUQ=; b=e5r+hOCpwicxDFGZO
    G3uDj9IOK5KCmptAbghlbqGB5g9t3QVhJzntmfMDLNh6jDDz5eVG1YFSpv4sSE8F
    NrNQYxzBS0c4J3pLJ0u6a34PgLZtLeLhmlZg17RRmuDeU2aQj8ZrpX94YFK6hNg+
    fSDDxd7FrIVa4ANtPuuFJLM3A0qkvBON3Cnv0015oKqh+NZJQPxYB+SzrS8OEj8J
    amjhy2z//2ZJaM5yJ1XIn/y656VZeO1FoN1hcZlzVrVT+Gzg7SnKFsDodXggrbnS
    mhwC97NtaNySl/+5k15eI2zpQ5g+eKPmFwtWdKVJwyb+PSDt6mr7BGiSu9Pyl+Cv
    MGafg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B60820838
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 08:22:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH v2 2/9] Staging: iio: accel: adis16201: Remove
 unnecessary comments
Message-ID: <20180318082201.56db5299@archlinux>
In-Reply-To: <1521230786-18155-3-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
 <1521230786-18155-3-git-send-email-himanshujha199640@gmail.com>
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

On Sat, 17 Mar 2018 01:36:19 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Remove few unnecessary comments since the macro definitions clearly
> justify their purpose.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Seems like a good balance between enough information and too much noise
so applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> v2:
>    -reodered patch series.
> 
>  drivers/staging/iio/accel/adis16201.c | 36 -----------------------------------
>  1 file changed, 36 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 767ebf0..6c06c0d 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -22,96 +22,66 @@
>  
>  #define ADIS16201_STARTUP_DELAY_MS	220
>  
> -/* Flash memory write count */
>  #define ADIS16201_FLASH_CNT      0x00
>  
> -/* Output, power supply */
>  #define ADIS16201_SUPPLY_OUT     0x02
>  
> -/* Output, x-axis accelerometer */
>  #define ADIS16201_XACCL_OUT      0x04
>  
> -/* Output, y-axis accelerometer */
>  #define ADIS16201_YACCL_OUT      0x06
>  
> -/* Output, auxiliary ADC input */
>  #define ADIS16201_AUX_ADC        0x08
>  
> -/* Output, temperature */
>  #define ADIS16201_TEMP_OUT       0x0A
>  
> -/* Output, x-axis inclination */
>  #define ADIS16201_XINCL_OUT      0x0C
>  
> -/* Output, y-axis inclination */
>  #define ADIS16201_YINCL_OUT      0x0E
>  
> -/* Calibration, x-axis acceleration offset */
>  #define ADIS16201_XACCL_OFFS     0x10
>  
> -/* Calibration, y-axis acceleration offset */
>  #define ADIS16201_YACCL_OFFS     0x12
>  
> -/* x-axis acceleration scale factor */
>  #define ADIS16201_XACCL_SCALE    0x14
>  
> -/* y-axis acceleration scale factor */
>  #define ADIS16201_YACCL_SCALE    0x16
>  
> -/* Calibration, x-axis inclination offset */
>  #define ADIS16201_XINCL_OFFS     0x18
>  
> -/* Calibration, y-axis inclination offset */
>  #define ADIS16201_YINCL_OFFS     0x1A
>  
> -/* x-axis inclination scale factor */
>  #define ADIS16201_XINCL_SCALE    0x1C
>  
> -/* y-axis inclination scale factor */
>  #define ADIS16201_YINCL_SCALE    0x1E
>  
> -/* Alarm 1 amplitude threshold */
>  #define ADIS16201_ALM_MAG1       0x20
>  
> -/* Alarm 2 amplitude threshold */
>  #define ADIS16201_ALM_MAG2       0x22
>  
> -/* Alarm 1, sample period */
>  #define ADIS16201_ALM_SMPL1      0x24
>  
> -/* Alarm 2, sample period */
>  #define ADIS16201_ALM_SMPL2      0x26
>  
> -/* Alarm control */
>  #define ADIS16201_ALM_CTRL       0x28
>  
> -/* Auxiliary DAC data */
>  #define ADIS16201_AUX_DAC        0x30
>  
> -/* General-purpose digital input/output control */
>  #define ADIS16201_GPIO_CTRL      0x32
>  
> -/* Miscellaneous control */
>  #define ADIS16201_MSC_CTRL       0x34
>  
> -/* Internal sample period (rate) control */
>  #define ADIS16201_SMPL_PRD       0x36
>  
>  /* Operation, filter configuration */
>  #define ADIS16201_AVG_CNT        0x38
>  
> -/* Operation, sleep mode control */
>  #define ADIS16201_SLP_CNT        0x3A
>  
> -/* Diagnostics, system status register */
>  #define ADIS16201_DIAG_STAT      0x3C
>  
> -/* Operation, system command register */
>  #define ADIS16201_GLOB_CMD       0x3E
>  
> -/* MSC_CTRL */
>  
> -/* Self-test enable */
>  #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
>  
>  /* Data-ready enable: 1 = enabled, 0 = disabled */
> @@ -123,18 +93,13 @@
>  /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
>  #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
>  
> -/* DIAG_STAT */
>  
> -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
>  #define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
>  
> -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
>  #define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
>  
> -/* SPI communications failure */
>  #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
>  
> -/* Flash update failure */
>  #define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
>  
>  /* Power supply above 3.625 V */
> @@ -143,7 +108,6 @@
>  /* Power supply below 3.15 V */
>  #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
>  
> -/* GLOB_CMD */
>  
>  #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
>  #define ADIS16201_GLOB_CMD_FACTORY_RESET	BIT(1)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
