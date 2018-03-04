Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2927792-1520178863-2-13179985396355931491
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520178862; b=DwFNmuRQUn3KnOcnDwz0qu2m88kk5v7sO3yEDbMmRB+xOtr
    rMQb5WL3XARL771tyCSwPu0VzOH7HXn1InuhPCZDZ4/fJEad5UQBcfY+xCUxUdYH
    1VacC40KGDGqKN6Xy+XSbziwuw3GOM1/7/5A/8g1U5jz+SnD/5hcMjTyhWe9v+Cf
    XzGYTaYw+ROS/2CxeaOrLXtX5hBWRV7wTgMz87SwHrWoXTIFbvqu7PzsFeXL1LQ0
    VtCqvpI0epBmyHLiNwOlWgOHb/Mo1UvAKKB+iqoBT4K2c96EKR9BYSl5I2pnu8R/
    aJime0MHfEZLZYa+eV88Xwsp1m4dsiflTDGaYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520178862; bh=H
    Xq+foviCVkQ5zE2XhvNBIPPY8Mja99nEAkYOZJM30Q=; b=p8iKGAvOQAIjghGhl
    q6FO47qqQ85leD0r/zRp9YWyzqk5fUMeAKHCw43fin6EBGDKCygmRhfqkuQBf/pr
    tnB9AOXDHToUECX5lWzG4BjjQMvBFaICEPjVFFU5STyvarNLtTMlAl2KvWDj+ZsW
    0rHkF9D2lF8MMPra8W2cu6HaOcDUjf9ou1FIZK2YwJoYQfsV27Me/oHSENm7sRD+
    cO7Z1jRRgXWZkk3JnJXxQADpIGk8n7i6zNK38GQCkQTl8X1XpgVK6Q+n2aN+/Oq7
    MfCUq+ILQKKTKQAniPb5xyKHcyPtEgvM72TU/63u9LEypzcVjCG3U/LfYMPg8DJS
    5m5UA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,423,1515452400"; d="scan'208";a="316311983"
Date: Sun, 4 Mar 2018 16:54:13 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 0/3] staging: media: cleanup
In-Reply-To: <1520178507-25141-1-git-send-email-arushisinghal19971997@gmail.com>
Message-ID: <alpine.DEB.2.20.1803041653350.2182@hadrien>
References: <1520178507-25141-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org, alan@linux.intel.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 outreachy-kernel@googlegroups.com, sakari.ailus@linux.intel.com,
 mchehab@kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Sun, 4 Mar 2018, Arushi Singhal wrote:

> Spellcheck the comments.
> Remove the repeated, consecutive words with single word.

For the series:
Acked-by: Julia Lawall <julia.lawall@lip6.fr>

But please look out for things to change in the code, not just in the
comments.

julia


>
> Arushi Singhal (3):
>   staging: media: Replace "be be" with "be"
>   staging: media: Replace "cant" with "can't"
>   staging: media: Replace "dont" with "don't"
>
>  drivers/staging/media/atomisp/pci/atomisp2/css2400/ia_css_pipe_public.h | 2 +-
>  drivers/staging/media/atomisp/pci/atomisp2/mmu/isp_mmu.c                | 2 +-
>  drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c                    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1520178507-25141-1-git-send-email-arushisinghal19971997%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
