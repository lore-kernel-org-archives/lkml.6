Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1453640-1523423286-2-2608623870488984204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523423286; b=DppvWdDx3RC0OXajX+PecituBVC90dscrqVPnd+XbY1D8KhOd0
    9eefy/60dYYJiS61LTDn1WIuzoZ+aHfXOCthPqPgkD5JP6aABefnyIacEVrJ36Tm
    AhbDxvGZMtnVR6CWdx41YcnF+2d0FjFbJD4QfXeC8fj3LwTdeD2Jh1taRUj4Pala
    x3YKv0WQtvLUKH9J4kDuhXCk2soy2u+3m4rmlatpm/93rsw89w40zWch9is5rlfE
    bMmt03oEXJev8o+VuqV1y70+p5yKoIOL8aSqVn8tI2sG1rOmwsIZHIOu0pKkdzNE
    eFzljoTtJ+xHEnJRCARaWatz7YMr47zoM2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523423286; bh=80trq
    jiWY85MYCwM2ctUnxk5pXAoRD5Ww/HqUBIfHsQ=; b=j/eiZnc5cxjM5aJEI9T2c
    SBAx7NIw+MTuyMAfBdj5E9n73BVltLjUdQ9BUmx69Ljm0ozQYHJrkTR68lMRONbt
    w/kvU48RxuoXjs5J1ImPUWfOE3AkjkqBWb18CBxIihBZ+lamGkxkXj+Y5/md+V+k
    RgIaYEMp8IRqVGCG4UYn+qxl/1O3KzkmALS8QdTm3cluEwx/34HP9GuxuDjdv9LM
    5ZVqKdbibcxEC5yOSTRWulqUreXPPwmCikljehNSONgD/NPm3e1k/n+JNtP/p5gs
    bvoLIUCYkbncNCmGdV81rCWqS/+mVY7DJdF6vGBKGNDQAsFnwov9/Iq6LUwieXH1
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGR0fBSO2VUYc6OeM+mowTNS+6OM9ocBwGfjkT6W7gJXTSlsST/Z0ksUmtCzDi9Qzhc6fYQa8bNNz2LVCvK7mv0/Sd2z5Z0JLblejKfSfZDxgz+SCQFV
    Xo0VXZdLz8vbjk8sLE2n2DqAI4+QKlVRgTiLDuC6k9l5HIeed/Hae1FEJ4OxtiIZUmz3H9zkI6AiiOhP7PNImqBmecsfELqKgZlysXbTTRav3vyd4PXjGWeO
    3BtP55kROuVjsrx8yyrQpQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=DaYrNbTBmTKoTfM4XlIA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.48,434,1517871600"; d="scan'208";a="322238738"
Date: Wed, 11 Apr 2018 07:07:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
Subject: Re: [PATCH] staging: comedi: cb_pcidas64: fix alignment of function
 parameters
In-Reply-To: <20180410225007.GA5050@gfm-note>
Message-ID: <alpine.DEB.2.20.1804110707130.2316@hadrien>
References: <20180410225007.GA5050@gfm-note>
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
 lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Tue, 10 Apr 2018, Gabriel Francisco Mandaji wrote:

> Fix most checkpatch.pl issues of type:
>
> CHECK: Alignment should match open parenthesis
>
> Signed-off-by: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
> ---
>  drivers/staging/comedi/drivers/cb_pcidas64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
> index fdd81c3..631a703 100644
> --- a/drivers/staging/comedi/drivers/cb_pcidas64.c
> +++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
> @@ -2268,14 +2268,14 @@ static inline unsigned int dma_transfer_size(struct comedi_device *dev)
>  }
>
>  static u32 ai_convert_counter_6xxx(const struct comedi_device *dev,
> -					const struct comedi_cmd *cmd)
> +				   const struct comedi_cmd *cmd)

Someone has made the effort to put const on these parameters, but not on
the other similar functions.  Perhaps this can be improved as well.

julia

>  {
>  	/* supposed to load counter with desired divisor minus 3 */
>  	return cmd->convert_arg / TIMER_BASE - 3;
>  }
>
>  static u32 ai_scan_counter_6xxx(struct comedi_device *dev,
> -				     struct comedi_cmd *cmd)
> +				struct comedi_cmd *cmd)
>  {
>  	u32 count;
>
> @@ -2296,7 +2296,7 @@ static u32 ai_scan_counter_6xxx(struct comedi_device *dev,
>  }
>
>  static u32 ai_convert_counter_4020(struct comedi_device *dev,
> -					struct comedi_cmd *cmd)
> +				   struct comedi_cmd *cmd)
>  {
>  	struct pcidas64_private *devpriv = dev->private;
>  	unsigned int divisor;
> --
> 1.9.1
>
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
