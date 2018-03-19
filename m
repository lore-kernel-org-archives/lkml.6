Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483288-2-6091757082473111556
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
    t=1521483287; b=juWH/4Q669CjuA48MNhKFky50jJJ21bE9ktRj1hP8BjsEX6
    uQJQmATr3mE+edraYkC/wQI/Q5i+wZymEs16IDi6stUE2VzrO3XDEJ8aq9TTqB5u
    hpHLpyJO7dvO94dDe7A1BTYwYLKUuVcaftiOpEmlMNg7Ujk+MtaxCy+JB/a+aWr+
    EpI4ydv0/vLpR7X+HpCgHp0OaQnRbht+pDNm0+DX3nwv2vy2TEp05zQ64nZsRr6g
    HqiyQlWJYeanLVWdUsuKYo4RNuA7OeF/YpcGCBw8NoWzv/Unuw3hRbFZxlycD6s2
    cCxetdHuzZtz2eX4m2XQycg0/CTVCrX13C8b6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483287; bh=BuMfp/7byD0KK9x5fzze174P48
    l7CgdYjdEEQJdz50w=; b=wpIR8u9gTek08fwdaJTi035UOT3otFoiPG9/T/zkqv
    mnDaeEI0srjofJS5qeN2ejciNWQkbqQEIu8ErJgAdb7SwsKjiBAc2lRAEXaX4sDf
    mHWvU9Gco2LmOE4zi9EF97kbYMi/4pd52lz6Is1SHyQ7hu8lbSr6BaVIuOxzpeby
    /9uFzGeYBQhw2f3k9+H7HJ8zoWvIBJ6TQc7iRgFn/LUgyVweG5kMGfmKe3s2aYwz
    tSM6AZg9gv/5aGRN4mehBGxX5WRJAwIYtT3El32bA5CqAsnLx70DS78tTabmxEKw
    1IaSgsE9xq02lgSPwJCdkw5d53mLNIZa/CtTMdlrwjZw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvdduieenucevlhhushhtvghrufhiiigvpeduudeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvdduieenucevlhhushhtvghrufhiiigvpeduudeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968724AbeCSSOn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:14:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968902AbeCSSOk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:14:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 038/134] ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss
Date: Mon, 19 Mar 2018 19:05:21 +0100
Message-Id: <20180319171854.858515505@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>


[ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]

It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
is in use then there are random chances that the usb_otg_ss module
will fail to completely idle. i.e. IDLEST = 0x2 instead of 0x3.

Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
fixes this issue.

We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
issue or not so don't add this flag for those instances.

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2240,6 +2240,7 @@ static struct omap_hwmod dra7xx_usb_otg_
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.main_clk	= "dpll_core_h13x2_ck",
+	.flags		= HWMOD_CLKDM_NOAUTO,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
@@ -2261,6 +2262,7 @@ static struct omap_hwmod dra7xx_usb_otg_
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.main_clk	= "dpll_core_h13x2_ck",
+	.flags		= HWMOD_CLKDM_NOAUTO,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
