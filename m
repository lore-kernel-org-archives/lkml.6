Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1692876-1524230956-2-2771220627225594233
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='be', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524230955; b=XaGPnH8NgjtbMB3FcAr62o1vsw5nF4o6KiIztHToDIq+qb67KA
    0gZN+ozB3gxJpnhS3YKwHC/+naFhrOTMqAU3GiFwrEz+TkQYriR63psEc8H3PCr7
    iuXgVAC/VUsRCi1x6035onzSvqr4CzaKyM5XfUxt2UfRO1Kyq5qbeUgNrJ2cqCqh
    FcO/BiQkFpWOFv4wYFn1zuzFNzYZdEYAaSqYeAq7LkDs3gATbWzcU/lXdySCA1jV
    cs7HrmUuFe6QAcxRWnn4qk3PbooWkMjDh0Wz85IvrzenmPZ6GlJv7VmDK+8lzKfN
    ol3mkcrNRHw727+9/sXyVB+qm8oRbdcVZgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524230955; bh=pElOe
    ma0qxKXqfSGwNI4GRxkM99AhdKqN6Ykb+/0WFo=; b=C9T0I0TW912JWHfb6IRWB
    2jBfIVaU6lkwSncxezqna2QATfPcKX8Y45bxheQ7uh2g6/n/dznuw282SPFMkmyY
    cNHLb6PmWVFjkAR5SCGcLgNAlPm8yvdk8HR55ghdCo67B8o55WvyN3EO96jEjvX8
    tGBQnv/Pv2jgy/qHlkbNVt+Al/eAQj+1NrNkXcyHV0Zf1znXQJ4abY+6e48eK15M
    eF38hxnmVxtZJhfJLYUFYefIM7Vmw3facwvVKJdASaWC/R7w2c/JZ6pn6TYN8XNo
    JBOh89DexLGWdaNMLA2UQHUlHN9sPSCg833bH8oREvq4mJ7vcuun3JzRVYk3gEId
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=glider.be header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=glider.be header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJd9GFgqBTJ7Ukpo/Kth3SqXcEq7r6WbpaGHkhCUOIhJd77ia3axqhSDhInlx+VcY/ffNMVuUYwdyKqozuTjimxBiPL6zfNVqXEJ4UU2D17pYcCp5LIt
    2mPJqMfvvOJoytwABVVqu97H/4ymElZzCzPEQI23+T+m5IusynuWWwPqIpgzKveZcDI5pifJYlpWVegHqifNYQEmCvJFMy5ZVbQHKaCBRRlORuPjntCzI7ii
    g2JQgPozi9m2yHdP0ty6ew==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=1oJP67jkp3AA:10 a=Kd1tUaAdevIA:10 a=d53lkjku8EkA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=hRP4I365x7KFcmTrv1YA:9
    a=aC6qQp9hIPXAdDXf:21 a=XxqT4pE1RTvrVy9o:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 "David S . Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 2/8] dmaengine: shdmac: Change platform check to
 CONFIG_ARCH_RENESAS
Date: Fri, 20 Apr 2018 15:28:28 +0200
Message-Id: <1524230914-10175-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
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
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
is CONFIG_ARCH_RENESAS a more appropriate platform check than the legacy
CONFIG_ARCH_SHMOBILE, hence use the former.

Renesas SuperH SH-Mobile SoCs are still covered by the CONFIG_CPU_SH4
check, just like before support for Renesas ARM SoCs was added.

Instead of blindly changing all the #ifdefs, switch the main code block
in sh_dmae_probe() to IS_ENABLED(), as this allows to remove all the
remaining #ifdefs.

This will allow to drop ARCH_SHMOBILE on ARM in the near future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/shdmac.c | 50 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 516f5487cc44cf96..8fcaae482ce0949a 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -440,7 +440,6 @@ static bool sh_dmae_reset(struct sh_dmae_device *shdev)
 	return ret;
 }
 
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
 static irqreturn_t sh_dmae_err(int irq, void *data)
 {
 	struct sh_dmae_device *shdev = data;
@@ -451,7 +450,6 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
 	sh_dmae_reset(shdev);
 	return IRQ_HANDLED;
 }
-#endif
 
 static bool sh_dmae_desc_completed(struct shdma_chan *schan,
 				   struct shdma_desc *sdesc)
@@ -683,11 +681,8 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	const struct sh_dmae_pdata *pdata;
 	unsigned long chan_flag[SH_DMAE_MAX_CHANNELS] = {};
 	int chan_irq[SH_DMAE_MAX_CHANNELS];
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
 	unsigned long irqflags = 0;
-	int errirq;
-#endif
-	int err, i, irq_cnt = 0, irqres = 0, irq_cap = 0;
+	int err, errirq, i, irq_cnt = 0, irqres = 0, irq_cap = 0;
 	struct sh_dmae_device *shdev;
 	struct dma_device *dma_dev;
 	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
@@ -789,33 +784,32 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	if (err)
 		goto rst_err;
 
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
-	chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
+	if (IS_ENABLED(CONFIG_CPU_SH4) || IS_ENABLED(CONFIG_ARCH_RENESAS)) {
+		chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
 
-	if (!chanirq_res)
-		chanirq_res = errirq_res;
-	else
-		irqres++;
+		if (!chanirq_res)
+			chanirq_res = errirq_res;
+		else
+			irqres++;
 
-	if (chanirq_res == errirq_res ||
-	    (errirq_res->flags & IORESOURCE_BITS) == IORESOURCE_IRQ_SHAREABLE)
-		irqflags = IRQF_SHARED;
+		if (chanirq_res == errirq_res ||
+		    (errirq_res->flags & IORESOURCE_BITS) == IORESOURCE_IRQ_SHAREABLE)
+			irqflags = IRQF_SHARED;
 
-	errirq = errirq_res->start;
+		errirq = errirq_res->start;
 
-	err = devm_request_irq(&pdev->dev, errirq, sh_dmae_err, irqflags,
-			       "DMAC Address Error", shdev);
-	if (err) {
-		dev_err(&pdev->dev,
-			"DMA failed requesting irq #%d, error %d\n",
-			errirq, err);
-		goto eirq_err;
+		err = devm_request_irq(&pdev->dev, errirq, sh_dmae_err,
+				       irqflags, "DMAC Address Error", shdev);
+		if (err) {
+			dev_err(&pdev->dev,
+				"DMA failed requesting irq #%d, error %d\n",
+				errirq, err);
+			goto eirq_err;
+		}
+	} else {
+		chanirq_res = errirq_res;
 	}
 
-#else
-	chanirq_res = errirq_res;
-#endif /* CONFIG_CPU_SH4 || CONFIG_ARCH_SHMOBILE */
-
 	if (chanirq_res->start == chanirq_res->end &&
 	    !platform_get_resource(pdev, IORESOURCE_IRQ, 1)) {
 		/* Special case - all multiplexed */
@@ -881,9 +875,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 chan_probe_err:
 	sh_dmae_chan_remove(shdev);
 
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
 eirq_err:
-#endif
 rst_err:
 	spin_lock_irq(&sh_dmae_lock);
 	list_del_rcu(&shdev->node);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
