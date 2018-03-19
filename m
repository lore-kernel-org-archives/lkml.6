Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521483716-2-13971050230833696319
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
    t=1521483715; b=SV0KDUM2DWBKiLkFKNdHEx1fwnwU2IGk1MJUYxjXjkW6ZHk
    50un7cEzyWQE5nloHyj8G2LiD1Ovgu8Z5IZr8NyXCo39t5l286MINVxO29PYoBYe
    r6u587BhIQIRAID4Ib3dPGOOjGSix/rAn32cI8s0ZYBWdIaNoKTCLYnVeKR0wrr8
    IuomS9kwG9GV++sJ1VVzqVJa3dlPy9pp8x6kg9+AKmBwOD0sB+h83Ow5r9fJQBVw
    4bw9roYXe3U3ABiwbFg2tK6WjPTIZvYglymKZMahoYbGwIFU5DubLX4dSqt5WtDD
    BaUSwS1868c2ufO3IJ84MquQs7LV3f5iStq8wIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483715; bh=FrzeiqxSWQJ7WlUlRKYLULpn6C
    2j/NOZYywNrXHqGPY=; b=L0odwUiiL9QYLJziWRKcSw1bF7NWExah/NG6poDBpR
    wz5HWieIC7b7fe8QxmiAVcZQqW7Lc6uRLtW/pF6lLcyMtqkDkIzsyjruMPyN5haE
    lQRa/hxbDdCb67Q+q2rEf6Wt/+TevB+76cKSZ9KJvpkjNegul99tZOTkNsVDoJFX
    aWsNnrybHQTwY3kYX2ySLbxVU3zLR7nT57VZjolToQryVNgaPcNOuShQN8X5+ECT
    quKjvNIS0HCZgfXU0ZjJDaXxQnQOir5+Pb0XByDgb5V0wAzPCZDnTrMiGneIAIJC
    iu4EUYnjUhDh6uaJ5SrS7a+6EaBBYhzxyc+0NpaJT2yw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvledvheenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvledvheenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969119AbeCSSVv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:21:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969602AbeCSSVt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:21:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 088/241] drm/vmwgfx: Fixes to vmwgfx_fb
Date: Mon, 19 Mar 2018 19:05:53 +0100
Message-Id: <20180319180754.849858133@linuxfoundation.org>
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

From: Sinclair Yeh <syeh@vmware.com>


[ Upstream commit aa74f0687cfe998e59b20d6454f45e8aa4403c45 ]

1.  When unsetting a mode, num_connector should be set to zero
2.  The pixel_format field needs to be initialized as newer DRM internal
    functions checks this field
3.  Take the drm_modeset_lock_all() because vmw_fb_kms_detach() can
    change current mode

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -433,7 +433,7 @@ static int vmw_fb_kms_detach(struct vmw_
 		set.y = 0;
 		set.mode = NULL;
 		set.fb = NULL;
-		set.num_connectors = 1;
+		set.num_connectors = 0;
 		set.connectors = &par->con;
 		ret = drm_mode_set_config_internal(&set);
 		if (ret) {
@@ -821,7 +821,9 @@ int vmw_fb_off(struct vmw_private *vmw_p
 	flush_delayed_work(&par->local_work);
 
 	mutex_lock(&par->bo_mutex);
+	drm_modeset_lock_all(vmw_priv->dev);
 	(void) vmw_fb_kms_detach(par, true, false);
+	drm_modeset_unlock_all(vmw_priv->dev);
 	mutex_unlock(&par->bo_mutex);
 
 	return 0;
