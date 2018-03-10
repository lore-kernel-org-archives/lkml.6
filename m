Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3594975-1520700348-2-12240775675071652040
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520700348; b=IcledeIRzkLrvBRKVA5kzCzDwOtzhjXhcByPQiaKM09qQZW
    yZg5flGFIVwxYLK+sTIPMpynu2/zEeFp7AwWvks/jF+eabzk9iUXCzcyVpJKityE
    x8O8jgJDX9iuQunYXz2SSsxIjOAkamdoVl7i7+HV5Cp4puXaJqiUdOao7px85/J0
    A9g7Lb9phn5ipuXnhbS4O0XbRdkxFEm+devMEd1Pb3cvRKgohCp13ePAHTzbcf8/
    7fvJ6JE5szU8URdjBlOdSjHi8D5b2MMm0mbFe3t6TgZKjMr++EzWaOeNQkzmQv08
    T+AxSBOOdtJLFEWB+c2IsSX2I3McQ1z0ax2V7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520700348; bh=2
    OXbIEndleId0W3u+AvAJ8HvLYpTJ/D8IQ/bOPlcoQI=; b=dUrbP/FknuXJ0cKNj
    6DJ6JrgEvtQD1XoM01lRvzmOZPMykJL8qGtMcPsTbFJvch2C9pkAlai/ap6msrFC
    y3P9AuNWEm94SA39yTYfjashDjF6BEC+USZXvr6R50WWHbbDoTj7NUfGVAdCPQfI
    aI1bjqMoz6u0bdxiYi8cWfVqTeoWoIS2cKbyshArFuxgy0d3+R3UfasPvLNxzUWz
    BkKrbUn+ur7DG0Q4MHurpnH0MkRE/DIoGE2ZRp9W9RtYtAzEKRXGHnVyJF9ynv6l
    56eG8akdgWD5Q1/9c54DZ2NlBnzpnYBpo2Pf6p3mZFhDN9BtWNBvlxiqhvYpsml/
    rNbhg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4C021771
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 16:45:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 2/4] staging:iio:ad2s1210: Remove unused #define directive
Message-ID: <20180310164535.14b610d9@archlinux>
In-Reply-To: <3e7250cc1e99d3cb284e0337fcf4b1188940cd69.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
 <3e7250cc1e99d3cb284e0337fcf4b1188940cd69.1520638889.git.rodrigosiqueiramelo@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Graff Yang <graff.yang@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 9 Mar 2018 20:46:05 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch removes some #define directives not used in the code.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied.

One comment inline.
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 0cdcd71e285b..79cb56670fc2 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -35,8 +35,6 @@
>  #define AD2S1210_SET_RES1		0x02
>  #define AD2S1210_SET_RES0		0x01
>  
> -#define AD2S1210_SET_ENRESOLUTION	(AD2S1210_SET_ENRES1 |	\
> -					 AD2S1210_SET_ENRES0)
>  #define AD2S1210_SET_RESOLUTION		(AD2S1210_SET_RES1 | AD2S1210_SET_RES0)
>  
>  #define AD2S1210_REG_POSITION		0x80
> @@ -53,10 +51,6 @@
>  #define AD2S1210_REG_SOFT_RESET		0xF0
>  #define AD2S1210_REG_FAULT		0xFF
>  
> -/* pin SAMPLE, A0, A1, RES0, RES1, is controlled by driver */
> -#define AD2S1210_SAA		3
> -#define AD2S1210_PN		(AD2S1210_SAA + AD2S1210_RES)
> -
>  #define AD2S1210_MIN_CLKIN	6144000
>  #define AD2S1210_MAX_CLKIN	10240000
>  #define AD2S1210_MIN_EXCIT	2000
> @@ -64,10 +58,6 @@
>  #define AD2S1210_MIN_FCW	0x4
>  #define AD2S1210_MAX_FCW	0x50
>  
> -/* default input clock on serial interface */
I'm not sure what this has to do with the serial interface.
It's the clk input from an external clock source.

> -#define AD2S1210_DEF_CLKIN	8192000
> -/* clock period in nano second */
> -#define AD2S1210_DEF_TCK	(1000000000 / AD2S1210_DEF_CLKIN)
>  #define AD2S1210_DEF_EXCIT	10000
>  
>  enum ad2s1210_mode {

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
