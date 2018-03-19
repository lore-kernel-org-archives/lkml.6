Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483593-2-12447806675765634705
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
    t=1521483593; b=m9vT31Hb4UFFgPkD2CVy47zQ2VLVyuGLdgjiRYmvp1Jggct
    5XEqYz17OPZlIQrOLIPBiLyz5ql8GdYEqlZ1HfNRD8qXeVZq2xsKAPCkFuNDwYv4
    tW0OfjRsUQSCTXPZH5ZQ7cCrb/EIOKkljrKXdEMl6fg96sWh4ojEVwyymo5X7CBH
    qPU6LS3HHSxkLIltkql/SMhUwSEoJ+AgrECZgCigh4WPF2DujKX+wZeGlj4dySyh
    gw+9qwCSuVMei3Ko+AJTttY8KnAK0a6iWVEKiVpdLeumladI/zbz3zEeBN/2N0Xo
    ZXk3mB+cc+w85SR6GAMN8+Eh/8pUUrkCEuPTgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483593; bh=lLUsyRlS++Ysn9sgeA0l3jyCsh
    SsUUb3oSIwkBVUds4=; b=lvoEk3UY7AhecJJus+LD/kLkOv01Ztk5aNm8pLRJ3p
    VG1G8C3AvGtfMaOp86KpvIpcNXx2QLS5CB1P4WtYq81N9sP1dsKgg7ijHLOU64oQ
    dvbm45Y7pmWZZqKQnh3bMZbfADsYM0u9r/y+z/r7czjI1AET2Cx7/sttczeZ5Xy6
    D77yhhIaGdR26cPYjor0vH1zrSp8z9kqlhv/Du+xOvhD3a0O8T0cc+GxbnBMbvf1
    QtiL+f9nuUKzLW897Jy+fLrmhDC8elQuVfq2q484MmUaR83gANIexeRRxrtWlQwz
    BwRBw9ynslZU0QIyu5kbRBUHYpUZbI6VVzmcKrhTAmqg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvledvudenucevlhhushhtvghrufhiiigvpedvud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvledvudenucevlhhushhtvghrufhiiigvpedvud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969472AbeCSSTp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:19:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969467AbeCSSTo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:19:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lihong Yang <lihong.yang@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 025/241] i40e: fix ethtool to get EEPROM data from X722 interface
Date: Mon, 19 Mar 2018 19:04:50 +0100
Message-Id: <20180319180752.211378509@linuxfoundation.org>
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

From: Lihong Yang <lihong.yang@intel.com>


[ Upstream commit c271dd6c391b535226cf1a81aaad9f33cb5899d3 ]

Currently ethtool -e will error out with a X722 interface
as its EEPROM has a scope limit at offset 0x5B9FFF.
This patch fixes the issue by setting the EEPROM length to
the scope limit to avoid NVM read failure beyond that.

Change-ID: I0b7d4dd6c7f2a57cace438af5dffa0f44c229372
Signed-off-by: Lihong Yang <lihong.yang@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1135,6 +1135,11 @@ static int i40e_get_eeprom_len(struct ne
 	struct i40e_hw *hw = &np->vsi->back->hw;
 	u32 val;
 
+#define X722_EEPROM_SCOPE_LIMIT 0x5B9FFF
+	if (hw->mac.type == I40E_MAC_X722) {
+		val = X722_EEPROM_SCOPE_LIMIT + 1;
+		return val;
+	}
 	val = (rd32(hw, I40E_GLPCI_LBARCTRL)
 		& I40E_GLPCI_LBARCTRL_FL_SIZE_MASK)
 		>> I40E_GLPCI_LBARCTRL_FL_SIZE_SHIFT;
