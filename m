Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1346284-1521811944-2-9312080784933892826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521811944; b=e/U5HOreLqsLZ/llgID1/ZPUyv0QNXpUl7hDO1YeEk+tNDL
    5iXuhx0Qy73JQT+fVwa/6CskiEAsZZv/0+wr/ZImpRQiyKf8E4MvjO0HKp5wjqn1
    KUDNrU8ZllzVu/nXDyUN6d723u76saBcxlezM65ctZ4Q0zX4X/qd2QXlMEdPAO7+
    S2r8eV7Vw5CAz0NawuYjtYSGAhv3iGGInzw1rgPBG8HNOtqnQLqarrDsp3rROpdJ
    jj8/gTBeZVGl3QSxDhg+tlw1j0Cke259eBpDBLK0rfL/GOenNIJr0xZMhMD8YHj5
    2V5CjNJ8KvkF+u1GhpPUzGlcUvrFZHdm0SFXOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521811944; bh=w
    KmvtU+BdHWm3S9U1xQGWElU34IERVkYHS/J4GF+ad0=; b=iorRklemqx5/VBDJQ
    wFDn/k08WEIjAZs0FglW/Ke0jq+Y+GoJ5ndVmF7DLC/66k/Mcb6WsHSTqFB6+0PM
    guxQKZKJhDC1CclU27Tsg1xNIbFaDPGqQPK7nq1ynuU820JuGKvaoEmirH/Y8KSg
    ptGOoROGxESJEk96B+JfZz6sMS7qllZmSDIk3LgyxddDfGz0MMUAfImx91n8Suyq
    cbWhJm7YTw6qusYL5Jo9dymakWxtoNwecblXvmihZ5qEqfhbf6McFze9sxsu1zl+
    t+IwbdS30VJCy4RC8PXQ2Bhw4qDGfIl8Xe9Rhf6O8bXa4W5bCUhsCTNYQAJlbYz3
    kU4vw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 13:32:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 1/4] Staging: iio: accel: adis16201: Remove unused headers
Message-ID: <20180323143204.000026f7@huawei.com>
In-Reply-To: <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
 <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018 00:42:42 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Remove few unused headers files since the adis core handles the buffer and
> sysfs support.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Please avoid sending a series in reply to a previous series.
It is far to easy for people to miss that this is new material.

This patch is fine, I'll pick it up when on the right computer.

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 97e25a3..b04dbb3 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -6,7 +6,6 @@
>   * Licensed under the GPL-2 or later.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -16,8 +15,6 @@
>  #include <linux/sysfs.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
>  #define ADIS16201_STARTUP_DELAY_MS			220

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
