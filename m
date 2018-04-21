Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-401687-1524328398-2-17345416917334920219
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endafr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524328397; b=KbSu+vq9DsEikMippldWHCtH5Suhvo0pZHV23WbhNR5rIgkJa8
    pN0yEEbnkHVaR2HrIG9KczvbjJsIr7/T3R+VRjEwOjtgnGzYvQ9aQWBBGe02uzHp
    X36xXMhhhKDGmeC9wmJb39nfhpOVFdH6myl81qRP1Fa3lsQbdAu3/vMfYaRHnc8w
    06s8R+1+IA59iaxB2UAsT8FbPYV4AKMIdQF/ojGwr9j1ZbhRcc+ZHJR1SiOqHJba
    O2/pImah/+9skD9nV2CxkvEYmgRopmloKIHxMEdKp9dK+vJbDJiNXDlJLjQ9vyUG
    RXE3msaTVQFYYcQlZ9GCwZT6yFqD0S814MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524328397; bh=GdpnD
    ezUQJj4iNuNogp0ZQ3rwN4bkNqsOMVKJP35R6s=; b=putPE51Nlr5BY5cMClMfL
    bv2xJ7g7S71wz/euT8O8wH+Sl8L8yKAvs9/s48FoGmMONHN47EDx1qr1Snf5a8cc
    r/PUi05ahbNWzdd1l1SZjN92+FfkrLI+KTn+oANKzQF23U1ciOIEyMIenqdG2gxb
    tw5vYCopKZSd0q67ReFeSUQfjbHMpxRODm+aOI4gbeuhig35F3JVdfAcvNBqW/VW
    NrJAPuJ6XSEskoRXXfVILr0PPbby5C6IIc+Smo5F97tZT/Vb7FiRKkYkf7KGuwP8
    YYshHtqYIAfi1E2Ij1heAD3TUTXM/VujZZQAkSqzQgSgIVqXiYbxFGnZ3d2bo1Vr
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGe9lIDqY2AMk4+5nbAH7C/l5rYKHnQz+nwYNdgdqw9lOCFjlrj4pwI5GcxGMPcqGJg9lz8KU+jkwda0X+N5r8ZCmV3jLHPWvPWs5CoGXoiGutz9gHdg
    cCWvMrkqEhXGK3lvhJI0qn3EOS7/z2i5Kuk9YNbStLoFEl5vpKZTusV62QyRUlzx/sxj4IB6jCOKaa94QEwbPCTMe6RV2GhsdfU8XXINokB7i6cUIMvClusG
    eNkEg5WNzPI70tZZbCu5qQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=Qm6KNX1dnUffDAKJ8wUA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B7621104
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:33:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 09/13] staging: iio: tsl2x7x: move power and diode
 settings into header file
Message-ID: <20180421173305.3ae125a2@archlinux>
In-Reply-To: <20180421004153.19073-10-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-10-masneyb@onstation.org>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018 20:41:49 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The power and diode defines are needed for the platform data so this
> patch moves the defines out of the .c file and into the header file. A
> comment for the diode is also cleaned up while this code is touched.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Makes sense.

Applied,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 12 ------------
>  drivers/staging/iio/light/tsl2x7x.h | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 15bc0af1bb6c..87b99deef7a8 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -103,18 +103,6 @@
>  #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
>  #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
>  
> -/*Prox diode to use */
> -#define TSL2X7X_DIODE0			0x01
> -#define TSL2X7X_DIODE1			0x02
> -#define TSL2X7X_DIODE_BOTH		0x03
> -
> -/* LED Power */
> -#define TSL2X7X_100_mA			0x00
> -#define TSL2X7X_50_mA			0x01
> -#define TSL2X7X_25_mA			0x02
> -#define TSL2X7X_13_mA			0x03
> -#define TSL2X7X_MAX_TIMER_CNT		0xFF
> -
>  #define TSL2X7X_MIN_ITIME		3
>  
>  /* TAOS txx2x7x Device family members */
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 992ee2465609..2c96f0b39b1e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -23,6 +23,18 @@ struct tsl2x7x_lux {
>  #define TSL2X7X_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) * \
>  				     TSL2X7X_DEF_LUX_TABLE_SZ)
>  
> +/* Proximity diode to use */
> +#define TSL2X7X_DIODE0                  0x01
> +#define TSL2X7X_DIODE1                  0x02
> +#define TSL2X7X_DIODE_BOTH              0x03
> +
> +/* LED Power */
> +#define TSL2X7X_100_mA                  0x00
> +#define TSL2X7X_50_mA                   0x01
> +#define TSL2X7X_25_mA                   0x02
> +#define TSL2X7X_13_mA                   0x03
> +#define TSL2X7X_MAX_TIMER_CNT           0xFF
> +
>  /**
>   * struct tsl2x7x_default_settings - power on defaults unless
>   *                                   overridden by platform data.

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
