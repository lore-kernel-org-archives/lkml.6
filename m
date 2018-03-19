Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483241-2-2666317176264396159
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483240; b=Gj+c3P4jLjxFtz4fhOfX5St7CtKwh2pS7yawbj4DYxan+gn
    TaxodGc/RdX+Y/HZrv+mN8h9jtUfNn8vb6S1tFm5sjmgnK++tdglBSvvOyPNSgsX
    oY+HyKI6WVQYlqKp84/+kmuWRYHhEIWie5pRQ99IC/qlBmKFCzPjGk3Qszfjl0FA
    vx4uN6M1Npk0+n4WcnNPvmnvjOtuTx08OwKEzAK9Km2IPea9S5QtySRD5UOmXW2G
    CczZ/4EP6ZG8AVBsZajbNf43iJJLH2NmWiqVAx8srYAy6iUk5+8UofPsHJmjLf6v
    kERB5BUl9bJAnpQvUFK45IPec2BVqGr8WIsjung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483240; bh=J1TLQ60fKBj6xdJj8Rn4n724zP
    Nwl8BgQVgoty61d3s=; b=TSuzCIntKFI6TjE1shORxVpPK+9E6YkmirKKnaf45Y
    YKUlUR7iKIrVi5aCRhm7wwWdp52OvcVhKVCcYoXLU78hKumKsnIH9G5CbUJpqjjV
    xOaiqOot8hZ1qkJdVkIZ6Bl/n5CPewUiEraBe1aF8Mexkm9Lndz/R8C9fk91HdTi
    pSqJegLpLik7mZo0KgbXn4GbigPGJWGmEBqDaabJU5MJwc8z1j5xu5oJVFLjLjpy
    qX8idx+3ml+GmRAmz2FW0gBvoB5l1N2HDC9G3JQcnmYHfD4X4kt1cbyUhqvWIMfi
    wGgnzNPXQx//RQjw1t3NT24vXqubym7dU4rlaBTUIoIQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvdefvdenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvdefvdenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030601AbeCSSNy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:13:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030441AbeCSSNv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:13:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 048/134] ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks
Date: Mon, 19 Mar 2018 19:05:31 +0100
Message-Id: <20180319171856.294111453@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 16fe68dcab5702a024d85229ff7e98979cb701a5 ]

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

Fixes: ee9141522dcf13f8 ("ARM: shmobile: r8a7791: add MSTP10 support on DTSI")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7791.dtsi |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1374,8 +1374,11 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
 			clocks = <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
 				<&p_clk>,
 				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
 				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
