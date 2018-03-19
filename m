Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483518-2-9135689434190084976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483517; b=dyp2wD22p38W6S0f5GVNYQad5CHGdbKZhaYmqFYxvIVpnxV
    LAyn2WGvDuQ9AUypnDoKIYFZQFGgf7yk/FEwdHv8fvQFwh/rcggvDJA+Dls3jM1E
    YboFMhvCvtlL+fuBrBXQ2t3O6YeGL4Ojv8aLi3ptSz1p2c76nJ+hQYVAYzrupEu4
    rLGo4sm/JGRk+0cWWCJDqKfA4YIrKKsswYohlckmrjkSaCEe17KoXDuSC09gZ/cK
    MzgDMGMqqkfMtg+hoDQdloOQZXFZaqH0uPSTWjGbKMZqfn2bTxRYHWfrEVLUq0+5
    3KTDtZdvyD0HnXRHUSKFmrMlaguVxWPyIdjFfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483517; bh=l4yLsLIHYJGNN9rUL+CgZduOb3
    Ww511U2c/uPRkvX6g=; b=GdErRbAfgO+NX8lOvmCM8YBqeQBFqPZY7TeRep2ggj
    Y68Hx1pIu6UbKicZ+PFdnk1FcI0FrkG1K39a4TveLSykfKJo5H/FtGa6DqSww+Y0
    t+6+FwAcSpVIBpL8BnUkyjkWnuGFJ9krU/LA47w5i8XqKMPW3puo2S7nySU5QsyB
    y/0dUoT2TiRxFPOqRje7OZS8V1fBxD5+U2nENwr0QCuCyxTDXiV/7VZIvv+l8qnh
    /cRkotHl03LbzNBBarKliSVzAP3EtUrGb+lgjs3F7n+egEG4UIeHjVvMcgtlutUT
    S4XwsopvoNYr+av/90ojcHscby7YzZw8rZiByISaoueA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegtdegleenucevlhhushhtvghrufhiiigvpeelge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegtdegleenucevlhhushhtvghrufhiiigvpeelge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968989AbeCSSSZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:18:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969305AbeCSSSX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:18:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 013/241] drm/sun4i: Fix up error path cleanup for master bind function
Date: Mon, 19 Mar 2018 19:04:38 +0100
Message-Id: <20180319180751.722463516@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>


[ Upstream commit 9d56defb44b15427f4342c543a70fb7886fc06f5 ]

The master bind function calls numerous drm functions which initialize
underlying structures. It also tries to bind the various components
of the display pipeline, some of which may add additional drm objects.

This patch adds proper cleanup functions in the error path of the
master bind function.

This requires the patch "drm/sun4i: Move drm_mode_config_cleanup call
to main driver", which splits out drm_mode_config_cleanup from
sun4i_framebuffer_free so we can call it separately.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -145,7 +145,7 @@ static int sun4i_drv_bind(struct device
 	ret = component_bind_all(drm->dev, drm);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't bind all pipelines components\n");
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
 
 	/* Create our layers */
@@ -153,7 +153,7 @@ static int sun4i_drv_bind(struct device
 	if (IS_ERR(drv->layers)) {
 		dev_err(drm->dev, "Couldn't create the planes\n");
 		ret = PTR_ERR(drv->layers);
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
 
 	/* Create our CRTC */
@@ -161,7 +161,7 @@ static int sun4i_drv_bind(struct device
 	if (!drv->crtc) {
 		dev_err(drm->dev, "Couldn't create the CRTC\n");
 		ret = -EINVAL;
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
 	drm->irq_enabled = true;
 
@@ -173,7 +173,7 @@ static int sun4i_drv_bind(struct device
 	if (IS_ERR(drv->fbdev)) {
 		dev_err(drm->dev, "Couldn't create our framebuffer\n");
 		ret = PTR_ERR(drv->fbdev);
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
 
 	/* Enable connectors polling */
@@ -181,10 +181,16 @@ static int sun4i_drv_bind(struct device
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
-		goto free_drm;
+		goto finish_poll;
 
 	return 0;
 
+finish_poll:
+	drm_kms_helper_poll_fini(drm);
+	sun4i_framebuffer_free(drm);
+cleanup_mode_config:
+	drm_mode_config_cleanup(drm);
+	drm_vblank_cleanup(drm);
 free_drm:
 	drm_dev_unref(drm);
 	return ret;
