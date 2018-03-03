Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-384599-1520091640-2-12282128309164897331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520091640; b=E77Bq1vCiJJDe0zAZh+QguGAYCN891IYekS0zjHB/bOr4xu
    wKalZr/bQecy52RrCTyZ6qiPXbzffdagkwp+1LeFQYV8g5C3SL966ZcwlEhzW+jC
    s0fd4gKrKKYablpDvIhBpV6Fqt0VbrbCGDE5yz1sWOZGlK05I2exWZZ0UW6qtbP4
    ZHnpGX8O18fEHtcodDaozbutKqONTkyZiQ9ie58F/S4Y69m3Wxwdim/UudMBgGv7
    14Yrr1pprFPD7si1SdO++97kT3+5mBuduC9icUI6WG81vU8Tp/VkS+SE735qhgTP
    W9S55G0QWyDzAVFcKRcAV0c8qy2cvfRXAlUC7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520091640; bh=+
    WwbdURU8TR0Tca8QXyUC+4YFXHQMk/OYagrGFow9oE=; b=IdYZGX0Bk4Y+t+4B1
    oEI1xlnp8J4X6tuahtXcsD4DBDY+TgsKcYKy9ZMoTNK44jkyYnsvrLfCUz2i9Udb
    zHfyQWIqxZ/yVFY1juCrbFxSeIvqm8PuYMU0pu7S/6rsof4UWn3FExavc1JK5YTP
    5bHuSnCU1+Al5jwEDjgkYLcn1J+xYlcV83RuVU2WfUUnkGaFPamaIc+Mg6rMiOib
    qlRi8RTc3oDs3NwPGn1ywsLgr5fha1le1qY1DOD2FeSnFKcODgBb5dl9a5C4RX//
    Nsdpyaqhc5XELoov+SZWjfQj84DNlbx8zpACIO3y/LAw+ZXj9EKjsD9Aq+ZWR3Fz
    5LvQw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476D52178D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 15:40:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH 2/6] Staging: iio: adis16209: Change the definition name
Message-ID: <20180303154029.1d8f30ee@archlinux>
In-Reply-To: <646c1e2ac1311db1879a5cae58f5f0a0c07114a5.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
 <646c1e2ac1311db1879a5cae58f5f0a0c07114a5.1519995673.git.shreeya.patel23498@gmail.com>
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

On Fri,  2 Mar 2018 18:53:41 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> The change in the definition name makes it then obvious
> what the units are throughout the driver and there will
> be no need of the comment.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16209.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 58f604d..830c278 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -20,7 +20,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16209_STARTUP_DELAY	220 /* ms */
> +#define ADIS16209_STARTUP_DELAY_MS	220
>  
>  /* Flash memory write count */
>  #define ADIS16209_FLASH_CNT      0x00
> @@ -303,7 +303,7 @@ static const struct adis_data adis16209_data = {
>  
>  	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16209_STARTUP_DELAY,
> +	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
>  
>  	.status_error_msgs = adis16209_status_error_msgs,
>  	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
