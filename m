Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484382-2-3423253423938546887
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
    t=1521484382; b=vdEcGUX2lxsESk9ZNYcTxHxm3jrh86AEt0nE6bffDdN0Kjl
    O6z4LzkurMRQE/PgzRpsNwA/U4KP8P8a8GdqoIvOfwyCkDthmwaxWphEPgFS3csr
    ToodCCxBlOUDN3cskebQlPfQNtKbAEkhf4llELqMDUR8wEYn9Po4fKw5f7Z173I8
    rc7ZD2VFBHzVJ2ohUUcPKLcuRdzUTm044StsfXB4ZpON+xHgkncQ2ACcEC6zYd7f
    2DV1aVLSEZCVqXvDQoUvBFJwbiSavRWWqAZiiH09pWrVE9M0RXjNZuktuFa1VAZ6
    6m40FhjCeyDZ3Q4a2L9/OTXvfU4s1KXqDHwGkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484382; bh=dwDFlkmLG6gqLWZ7lPpRJUaA3K
    xNxOw4qfDt8xrQnjY=; b=BgSvt5+mLwGCyg9Z9gAO1m41S7XtUFC9stTwYFKNQo
    XU7ihTdsMUDfSIcuXtRmxQox0aNcI8A6B7LIpmWvzyBBOpJfiZygM9TFmrL8wxD0
    2drVk0IEOJ3ZJlAfXUvppAVat4qDm9nYh2evm0YMOWTeM0ed9QPAvE354s/WnK29
    RprbYNvsxlgzEqQ/P1Ch1ZidpvNfZxSJMPFpVXSH/nysvqNXQmmr887FoNSC9vqC
    LPMOAMDnv0tbl9SN6QgfI1tI3+7iaSMH2yxwvMCU5iEGvZYmFm2mzZ77aUGoYDWK
    MoCz6SbMaN5/KTmISbhSlTuk3sLjn7ZTTXF+14ab83MA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvieduieenucevlhhushhtvghrufhiiigvpeegtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvieduieenucevlhhushhtvghrufhiiigvpeegtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032133AbeCSSc6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:32:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032132AbeCSSc4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.15 48/52] usb: gadget: udc: renesas_usb3: fix oops in renesas_usb3_remove()
Date: Mon, 19 Mar 2018 19:08:46 +0100
Message-Id: <20180319180737.612921151@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit e3190868e5f52fb26544f16463593d54ce46ce61 upstream.

This patch fixes an issue that the renesas_usb3_remove() causes
NULL pointer dereference because the usb3_to_dev() macro will use
the gadget instance and it will be deleted before.

Fixes: cf06df3fae28 ("usb: gadget: udc: renesas_usb3: move pm_runtime_{en,dis}able()")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2410,7 +2410,7 @@ static int renesas_usb3_remove(struct pl
 	__renesas_usb3_ep_free_request(usb3->ep0_req);
 	if (usb3->phy)
 		phy_put(usb3->phy);
-	pm_runtime_disable(usb3_to_dev(usb3));
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
