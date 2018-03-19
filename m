Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484141-2-10876066534604839863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484140; b=N6cxAQyvJ0Drny9hQCKy7bCE5Yw+pbmGWqSy9X9aphYBxHQ
    lyj/U9U+P8xdsAcbT90NZScQkVvjYhcIIoatYj5W7o+8jhQceITaCDGACfWMP4bb
    5Bx4bvKhcO8MfkM0a7+kQwicA9eEeoczw+A2+hGIKDwm15JMrriccC8dm2q+BuuT
    JZ7YCcDs8EmusNKFit7mlxHXqTE1wvYUBNcPzdo5rYp3GvU9GAmO6pxXQXYxhuqW
    1IG06Fyfbb2/yhcG1DhN41jKu0GRu47NVBHvH4+6f7txprACOPpVFDPFAiuNQBo5
    6IMp/jrSNaHZqZE9OUDP4ES3rpzN6cZ33dAefhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484140; bh=Wkcmc8BUgfxZ+f3jfRD/PX2VlK
    8UQPhY6JGNLjf2qQo=; b=SkBDrk2eL/mHIcfuphmy4S5mgxB+RG8pU3q5PN5F9i
    VSTx2SzdhSuN21BDZyS10cB+Xmgv6r9PMZnx4mueD3nsj76q0tq2Xvqkgjbayzz+
    5KbPO/GfORtH8bRxHlPbuTDSCY/+XM0LkX0r5a5uSN84TV2S2bKmHehUCcXXU16P
    5e3YdwBPlO5/eORyv5n/EkhBqbovdSPOnvZ4YBb50gGs6gYB5GNsjFRAKviI/B32
    dcAaoa68pFzt7KDG/b0m3E2W42TbwvuZnOa1myk63llkh481ERHMq9e42xnTz4Kp
    +8bdNFHwbxtp8KsXPBmaIz0FseGHlSi12pckvUCUngpw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepihhnthgvlhdrtghomhdpvhhmfigrrhgvrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefgeejtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepihhnthgvlhdrtghomhdpvhhmfigrrhgvrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefgeejtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969968AbeCSS25 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:28:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031748AbeCSS2y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:28:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Sergeyev <sergeev917@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Kyle Huey <me@kylehuey.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 219/241] x86/speculation: Remove Skylake C2 from Speculation Control microcode blacklist
Date: Mon, 19 Mar 2018 19:08:04 +0100
Message-Id: <20180319180800.241523303@linuxfoundation.org>
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

From: Alexander Sergeyev <sergeev917@gmail.com>

commit e3b3121fa8da94cb20f9e0c64ab7981ae47fd085 upstream.

In accordance with Intel's microcode revision guidance from March 6 MCU
rev 0xc2 is cleared on both Skylake H/S and Skylake Xeon E3 processors
that share CPUID 506E3.

Signed-off-by: Alexander Sergeyev <sergeev917@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jia Zhang <qianyue.zj@alibaba-inc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kyle Huey <me@kylehuey.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180313193856.GA8580@localhost.localdomain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/intel.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -64,7 +64,7 @@ void check_mpx_erratum(struct cpuinfo_x8
 /*
  * Early microcode releases for the Spectre v2 mitigation were broken.
  * Information taken from;
- * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/microcode-update-guidance.pdf
+ * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/03/microcode-update-guidance.pdf
  * - https://kb.vmware.com/s/article/52345
  * - Microcode revisions observed in the wild
  * - Release note from 20180108 microcode release
@@ -82,7 +82,6 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
