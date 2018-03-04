Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2505222-1520164915-2-11608044800125990008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520164914; b=a4SFDPgAxD6YarIKfxRbyq9bw0nRvS9assM+j97C1ayo171
    zeaQIGczvZ8FnjHVAhCA54aHDJ3e89EPpSnXaAkIEHUoD6lUZ4tMCLM2QMcqwLl+
    6MjNeG6lCw8Tl25sLJ+MCEi1g0QGvQ0flbjNmQY9x1P/dNEBLTcwPSvu3mqxm13O
    WB5wrpf+nVFPrE3NjNhBBkmmBj1W2ij4uf/A81X07tZ10wj+B2eW1E2Hmg/K+kIv
    9HZ/ZqaV2qqfvzfsGf2HUcSHi2fG+5ijDEsNzYIBJdebO131KZ/7QLzkV3VUqRnW
    ckXONiE53IZaYpNtcfYvp/Kkd783SUDCJdgSY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520164914; bh=f
    Yk3OVo9g+mow7XJJX+BFA9kPPeaArKy2l2OqHL1qFg=; b=jXcbUY2QSrfJ9GdAL
    K2H9K4HDL4QWAD7kL5vWqWrzc4VN3M7CDVpa9VKisBbrWhHLUKY7Y9kwnuThCcV2
    XDs04AbCLhjM5cTRpVssV9A0LVZuODmqIhiOPZkQspLqzxyxsO3ZKmztjzD/KIIC
    XPPM4TT6+wwWuhRo18dbo1emb8AjnxelJGh7vGAz2qfmxYe7f/EA7S2d93G4+0+4
    WbgMQ6qgrkCH5IHj8xzeYvto9hIzNutBMfjAogRinSe8BdyAIROC8NJvRaq0S+wj
    80uTHwJ9Ksqxwz3vdorjvBtdLT5MFm4XLj+wA1td9URWMLRmscT/WxhdBIYjCZGz
    vRFOg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,422,1515452400"; d="scan'208";a="256897733"
Date: Sun, 4 Mar 2018 13:01:42 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: comedi: "dont" is changed
 to "don't"
In-Reply-To: <20180304105732.GA24762@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803041301210.2223@hadrien>
References: <20180304105732.GA24762@seema-Inspiron-15-3567>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
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
Cc: devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 abbotti@mev.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Sun, 4 Mar 2018, Arushi Singhal wrote:

> "dont" is changed to "don't" in messages, "dont" is not correct
> english.

The change is fine, but please rewrite the commit log in the imperative.

julia

>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/comedi/drivers/cb_pcidas64.c | 2 +-
>  drivers/staging/comedi/drivers/das16.c       | 2 +-
>  drivers/staging/comedi/drivers/das16m1.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
> index c007500..ceef905 100644
> --- a/drivers/staging/comedi/drivers/cb_pcidas64.c
> +++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
> @@ -1700,7 +1700,7 @@ static void i2c_write(struct comedi_device *dev, unsigned int address,
>  	 * eeprom and i2c bus
>  	 */
>
> -	/* make sure we dont send anything to eeprom */
> +	/* make sure we don't send anything to eeprom */
>  	devpriv->plx_control_bits &= ~PLX_CNTRL_EECS;
>
>  	i2c_stop(dev);
> diff --git a/drivers/staging/comedi/drivers/das16.c b/drivers/staging/comedi/drivers/das16.c
> index 74ff204..81eb51b 100644
> --- a/drivers/staging/comedi/drivers/das16.c
> +++ b/drivers/staging/comedi/drivers/das16.c
> @@ -619,7 +619,7 @@ static int das16_cmd_test(struct comedi_device *dev, struct comedi_subdevice *s,
>
>  	/* Step 2b : and mutually compatible */
>
> -	/*  make sure scan_begin_src and convert_src dont conflict */
> +	/*  make sure scan_begin_src and convert_src don't conflict */
>  	if (cmd->scan_begin_src == TRIG_FOLLOW && cmd->convert_src == TRIG_NOW)
>  		err |= -EINVAL;
>  	if (cmd->scan_begin_src != TRIG_FOLLOW && cmd->convert_src != TRIG_NOW)
> diff --git a/drivers/staging/comedi/drivers/das16m1.c b/drivers/staging/comedi/drivers/das16m1.c
> index 72f8ed2..4e36377 100644
> --- a/drivers/staging/comedi/drivers/das16m1.c
> +++ b/drivers/staging/comedi/drivers/das16m1.c
> @@ -407,7 +407,7 @@ static void das16m1_handler(struct comedi_device *dev, unsigned int status)
>  		if (num_samples > cmd->stop_arg * cmd->chanlist_len)
>  			num_samples = cmd->stop_arg * cmd->chanlist_len;
>  	}
> -	/*  make sure we dont try to get too many points if fifo has overrun */
> +	/*  make sure we don't try to get too many points if fifo has overrun */
>  	if (num_samples > DAS16M1_AI_FIFO_SZ)
>  		num_samples = DAS16M1_AI_FIFO_SZ;
>  	insw(dev->iobase, devpriv->ai_buffer, num_samples);
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180304105732.GA24762%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
