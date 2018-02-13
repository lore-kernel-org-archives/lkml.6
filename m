Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x226cpsOVHGEtRl8RWSeHAQrb8mY88Ymcqwl8knAepvRu/wkRz+0+x413OjL3K4Xl6neLDNpF
ARC-Seal: i=1; a=rsa-sha256; t=1518554435; cv=none;
        d=google.com; s=arc-20160816;
        b=V2gLSWbeEJaZcaa5mwjPFXHZoVYxRxD6YajY90nyjh6Capi2kY5Iywi4Hx6GIlJY3s
         TIw4g1deLG9O/lH9pl0rLjF6x2F6bmqQBvDo7aG5I2h0ENhm6WQywARExUUqnCcTVqQk
         waaMUyFuVUCumojkeX9lqY/WoHPMtxYco9xurpdk3GPL7gMzEG9ka8N4xXbXNpQ3bKUK
         l+0BVpYL/UWJEECBovUMUDm4WDfbTVUWoeS2IkYv/ib9J4eejWVO5GS2z8dBxhbwPTTa
         zJVdvbPy5UFsHjgzkyG4Xwo+QSNkUUgp+l1b8FVr1+cf8OAPcIEKJVryWa04KKIPpJLY
         tAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=UKFwL3yswIFuzL6qgVjBqhp5HyH6SccUonYSozO47VU=;
        b=cBbxJL2ifmivqoZavPeVBItSqvNtPq+ST6qb1R8yXmtQg6rqUhg/LKqIP4Iqi+D12b
         Q2FvFUYgCn3cCg+DORrv2ygFThG4rMEn2Embi8qo/1GsqNgrrzPbmgxmhjPBJ55xgrM9
         FzSDoNP75BWOmsgGfkejbIOjE0GRZdiS5k2D7BfnL0LQNGCO9rXdOVi/0NyAVgPE4qp2
         7xEn6t0aDHmhsgwNJvOO5ufxXh0FNRLESTsacJtv+NF7xNwkq44xnabCOietfFOpRiv+
         wLgvkekhO4FONzMIXkjjJgP6DuqcL0wMw6MOZ54LfZliCytTihFSJBwQO+t8PCtX0MlJ
         jPYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.66 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.66 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2899:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3873:4321:5007:9040:9167:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12294:12296:12438:12555:12740:12760:12895:13069:13095:13255:13311:13357:13439:14659:14721:21080:21212:21433:21611:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: brake09_3f134fbf6b006
X-Filterd-Recvd-Size: 2653
Message-ID: <1518554431.22190.56.camel@perches.com>
Subject: Re: [PATCH 1/2] dma/ppc4xx: Delete an error message for a failed
 memory allocation in two functions
From: Joe Perches <joe@perches.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>,
 Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Tue, 13 Feb 2018 12:40:31 -0800
In-Reply-To: <ce6646e3-dfb5-2496-2a3a-d41de4802de6@users.sourceforge.net>
References: <4d9b3ca7-e1bd-42f9-5933-550146812f1e@users.sourceforge.net>
	 <ce6646e3-dfb5-2496-2a3a-d41de4802de6@users.sourceforge.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318774436342324?=
X-GMAIL-MSGID: =?utf-8?q?1592319735922532526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-13 at 21:25 +0100, SF Markus Elfring wrote:
> Omit an extra message for a memory allocation failure in these functions.
[]
> diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
[]
> @@ -4183,7 +4183,6 @@ static int ppc440spe_adma_probe(struct platform_device *ofdev)
>  		INIT_LIST_HEAD(&ref->node);
>  		list_add_tail(&ref->node, &ppc440spe_adma_chan_list);
>  	} else {
> -		dev_err(&ofdev->dev, "failed to allocate channel reference!\n");
>  		ret = -ENOMEM;
>  		goto err_ref_alloc;
>  	}

Stop being mindless and think about the change
you are making.

Reverse the test and unindent the block above.
---
 drivers/dma/ppc4xx/adma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 4cf0d4d0cecf..1fc1a2f03aa4 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4178,16 +4178,15 @@ static int ppc440spe_adma_probe(struct platform_device *ofdev)
 	}
 
 	ref = kmalloc(sizeof(*ref), GFP_KERNEL);
-	if (ref) {
-		ref->chan = &chan->common;
-		INIT_LIST_HEAD(&ref->node);
-		list_add_tail(&ref->node, &ppc440spe_adma_chan_list);
-	} else {
-		dev_err(&ofdev->dev, "failed to allocate channel reference!\n");
+	if (!ref) {
 		ret = -ENOMEM;
 		goto err_ref_alloc;
 	}
 
+	ref->chan = &chan->common;
+	INIT_LIST_HEAD(&ref->node);
+	list_add_tail(&ref->node, &ppc440spe_adma_chan_list);
+
 	ret = ppc440spe_adma_setup_irqs(adev, chan, &initcode);
 	if (ret)
 		goto err_irq;
