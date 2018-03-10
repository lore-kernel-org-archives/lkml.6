Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3563217-1520700111-2-6072583806938742407
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enfr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520700110; b=pE2eJCDGX0rdXxVxxU+STZmu8ihI7zl34cTGxxYjQOgcfn5
    nZpQl915ZCggCKD2yWc8r0ZZ3NbUsn0Q+RImYxgstNPo8Ft/O794tXFzEcSJc+X5
    8LEyUwOnaVzCEe5fxuOvyeIR/y7duwzrkf8qCG9zD+/QDNIp2IxiZSXCgiMyQMUi
    hPoV1If/s87O4K9cdIsn8PHqMlArVb28bN0FNCG2jse53VXpnb9+pB856u9ekI28
    B2i0enXXERNBwl3b/o/eVp21ecRk0UWuP0R4ACKzDgXLILbBqpfVBqmuHI2ZJpYw
    Cy1vyzXGAJS9uDELxqJi6kD2qlR2483lEaC+pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520700110; bh=8
    UhhkLqYXyNm9QjI7X95kyIk7cqRpH93zR4jlhB2wR0=; b=JK42Z8HZeRVi/GOWv
    Lz3mKCg3kcN8ASVzcEO5zBdveHAHa3/dX+GWzvwYnLNHjXKAhzkQkswzh0TnLw8C
    DUkxy+B9891hPXAyfaGIzrRNeUF4bi2w8m/iKhLRC/jHm37L+6ZWw8WWkdrLRSrc
    zwMPJurCJlmVY8IdCW10GdM9pJabBs4ebPNTKO/zJUk3inT9RqdW3pYu5ALoHcpl
    VRcge+LkNZvzbE9lpYEjtljYkng/13EBcWAEzjPVKF9hJA4J++vh6G2nAdFUavOG
    lzHvE2RcczOncovhfJc6Wl1DuDZkGmttswz+VitsyY5KVMQBpN9RPYnsQZD8rbDQ
    WMpZA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA9221771
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 16:41:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 1/4] staging:iio:ad2s1210: Remove end of line with '['
Message-ID: <20180310164137.6ca243aa@archlinux>
In-Reply-To: <b87fdd8b09ebee3fd29a8b65257e37eff7d8532b.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
 <b87fdd8b09ebee3fd29a8b65257e37eff7d8532b.1520638889.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 9 Mar 2018 20:45:50 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch fixes the checkpatch.pl check:
> 
> iio/resolver/ad2s1210.c:202: CHECK: Lines should not end with a '['
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index f8baab061eba..0cdcd71e285b 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -165,9 +165,10 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
>  
>  static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
>  {
> -	return ad2s1210_resolution_value[
> -		(gpio_get_value(st->pdata->res[0]) << 1) |
> -		gpio_get_value(st->pdata->res[1])];
> +	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
> +			  gpio_get_value(st->pdata->res[1]);
> +
> +	return ad2s1210_resolution_value[resolution];
>  }
>  
>  static const int ad2s1210_res_pins[4][2] = {

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
