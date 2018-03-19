Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484875-2-6876070623469560976
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
    t=1521484875; b=U8lqdzFqQoLtgeqfOEPNVAj6zBEl7U+1hd1GQWDPII7ynoT
    6hY58z4VKvQZ2KvBxP/O3Sr/dEy5t+Slyk1U0yvYjnikETbjDU40J6IvhQV0A4af
    jMk2zxK3H1RdkPqI1pWxxHG3uZXXniJE+pZ64q+ZWxrg/fctS3W//Z/86pneCw2h
    ceAjk0xd1RGZ3zKvLD1Q2Y0HEtCRTpXX8AZaB7XwYWoG3Ka9SXEs8tJvwrKgGeFE
    rCjduehV5dt2JQtPV1votlD5ojsjK36DJKLfhqb+CAbFBVohAhCLH+VPcUmcPCi8
    ihTD2yb9yFA1BqOdvwHxzsH8aqlnf7rSftjZU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484875; bh=YOT8FudQMJJi2VQkW3sean7qXb
    sMMLITRTldBXKc6MU=; b=U5I1I7b8qS6udKFye/D1omu68troB4j8QKARBfm6mG
    icWauxM/KWy8N9K2k9mzszAbFh92i/kwvgKexYzQ5qecmJexEHPEtHcxjYCz3yS6
    ojin4ySpdnP20FExwZu79Uv4JJhMm8oNa91a/AK5XPAJ49dQ6P1hWpRqvFF5L0FY
    wlGamp/px/vF4dqX0lcK4kOkaMOOrKuikcJRyWYQjTI2w4SGCeBo9oxNgNytvCzR
    JvJFEIz5n7LYGZlL1f9X45qQ/3JUJTPA4R8SZEtP9EeLcTIRI2CSXv2gpvBGnmc/
    RiR6ujfsKg31ygM10tBdjhYNFMyfxq3qTM9aB8voDlaw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeffeeljeenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeffeeljeenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935727AbeCSShS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:37:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032127AbeCSScy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.15 47/52] usb: dwc3: of-simple: fix oops by unbalanced clk disable call
Date: Mon, 19 Mar 2018 19:08:45 +0100
Message-Id: <20180319180737.572313960@linuxfoundation.org>
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

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

commit bff52352e0ccc2481f2b6b0d612ff8ff56c50f3a upstream.

dwc3_of_simple_dev_pm_ops has never been used since commit a0d8c4cfdf31
("usb: dwc3: of-simple: set dev_pm_ops"), but this commit has brought
and oops when unbind the device due this sequence:

  dwc3_of_simple_remove
   -> clk_disable ...
      -> pm_runtime_put_sync
         -> dwc3_of_simple_runtime_suspend
            -> clk_disable (again)

This double call to clk_core_disable causes a kernel oops like this:

 WARNING: CPU: 1 PID: 4022 at drivers/clk/clk.c:656 clk_core_disable+0x78/0x80
 CPU: 1 PID: 4022 Comm: bash Not tainted 4.15.0-rc4+ #44
 Hardware name: Google Kevin (DT)
 pstate: 80000085 (Nzcv daIf -PAN -UAO)
 pc : clk_core_disable+0x78/0x80
 lr : clk_core_disable_lock+0x20/0x38
 sp : ffff00000bbf3a90
 ...
 Call trace:
  clk_core_disable+0x78/0x80
  clk_disable+0x1c/0x30
  dwc3_of_simple_runtime_suspend+0x30/0x50
  pm_generic_runtime_suspend+0x28/0x40

This patch fixes the unbalanced clk disable call by setting the num_clocks
variable to zero once the clocks were disabled.

Fixes: a0d8c4cfdf31 ("usb: dwc3: of-simple: set dev_pm_ops")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/dwc3-of-simple.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -143,6 +143,7 @@ static int dwc3_of_simple_remove(struct
 		clk_disable_unprepare(simple->clks[i]);
 		clk_put(simple->clks[i]);
 	}
+	simple->num_clocks = 0;
 
 	reset_control_assert(simple->resets);
 	reset_control_put(simple->resets);
