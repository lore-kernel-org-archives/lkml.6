Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483715-2-12530035023925227236
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
    t=1521483714; b=VfjoPr/ZVyFceT2BJwIkJHQTdHBSrL4ASYK0VoZWYJI8cx9
    uWmMpboNmSNLTJs7NJzyoB0O4vZUUl9LYjZbLbmWmIH7/Xoa66rQnfsYeG9gAGQH
    qEte4n8jrYz+WLS/oCOlP1/ou4qe5V4rG5oU4RqqEUy3qy2uiDQhV+Vp5Xsqzt19
    2N9iOnMYOUhcQl/t9blqZPUUWoUkDKQzscjZ1ydL1rHLr2FYsstnA4s2XnYqDElr
    DHJrU9NDmgHfX4Xns/SgGqcRmMg5xaoe4gANUiPiJUJu1Deh5+fl17s4//m+qnJg
    BxTG0hVgB7FNbI+Myf40s2IGeKlznHFiSmr9IYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483714; bh=7At78sGb1/OHojsglcMRTauJOJ
    9LwS6JM5/s4VvX6N8=; b=VGmGo1SMiYEn30KCW8RbWQoZ8pxn6P3hURojqYPLb9
    T8rm5PONc8rzilSP0KXt3v7JFypfINCV/xmiP9EUxV2tTDqMz1BB7Bl0R92CMykl
    N074ytac886bQkg2O21KNjyGahqPalte6Yg5aPsSPut2md6Y1Pj+5KlE+bCuhO9k
    GtphDZlsM77PkC5via0HFKyFIMYCS/H9nRfP0WhUOWG7yP6BR004P20xX6bo3JuD
    +qpITc7viXZCD9175zjxEDR0+PERk7kYn4+Neb3v1c24wGJBR4Yy20U3c+ufs4Az
    jfO6cEZ2/2AVshkp3o0xLpFM75Nxs9Rx/kv3JrqpWDhA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvieelkeenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvieelkeenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965466AbeCSSVo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:21:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031117AbeCSSVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:21:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Manish Jaggi <mjaggi@cavium.com>,
        David Daney <david.daney@cavium.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 085/241] PCI: Apply Cavium ACS quirk only to CN81xx/CN83xx/CN88xx devices
Date: Mon, 19 Mar 2018 19:05:50 +0100
Message-Id: <20180319180754.722150781@linuxfoundation.org>
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

From: Manish Jaggi <mjaggi@caviumnetworks.com>


[ Upstream commit b77d537d00d08fcf0bf641cd3491dd7df0ad1475 ]

Only apply the Cavium ACS quirk to devices with ID in the range
0xa000-0xa0ff.  These are the on-chip PCI devices for CN81xx/CN83xx/CN88xx.

Fixes: b404bcfbf035 ("PCI: Add ACS quirk for all Cavium devices")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Manish Jaggi <mjaggi@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4104,6 +4104,9 @@ static int pci_quirk_cavium_acs(struct p
 	 */
 	acs_flags &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
 
+	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
+		return -ENOTTY;
+
 	return acs_flags ? 0 : 1;
 }
 
