Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484160-2-6314293638286450684
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
    t=1521484159; b=CTb6FAzTYACOVEYaDKwHx0eRmNQuIVRt/G5jT0GtO74pCt5
    YdWe4Q5F5GSiNEJ19W/M6uWZswGw/ly4GgeoCPgQVNLcUKhhCv2JzqKHiNkSJ70E
    7DldBQPKN0I6Sn5kJPijapxdA8DvFHjXfxOxRBuCSGc2w/dhyG9J9TJMjF2eN8bZ
    mTqxRkRnJxaqmeHWP4ae57M3worgGiJ1DkimArpzpXQaMKzpjnC1vNQoijwmPN4N
    OnVXCuOEBM9whuLJFIQLN/0duurXwnTwXkixe0xSEsaIBcc+tBETR1K4WQXS2sLe
    fm1SZs0AcBGsYaUXpdd8o5yE3mOtj0sr9OA/1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484159; bh=JYLVCOap9CsQ4INHFTCbkn8tXy
    RQCPhLxJZbP4MdiMQ=; b=gMcmskhW0twmQCICmUQEa3Wu6oKuNvekUET5svwX5b
    mB1CPocIWEBzF2gRguRaN/iWL32fFj4gXub1nwd7S8tT6TLIyCbgX2XreNwEpafC
    XiIyXrb8KoAQpiWlaAmKgVPygCyxggW4183rRspw4h3W3iw+j8YoCSHKSyzro+Wm
    8Ox17I/6WOTS2mj1BDxWX2w/d8GV+LsyIfk1hLMenYfSuMdEYXN7/AjOTMVhubhp
    4juMyTVAtxQ001/ac/0qecLR+lnidUsp5ptXx1yl3Cj3yT/uwXIrM0o12LEEVpKN
    JqHFTyCjMFblMHMUz7j8Zn1WvSffwDtI3+nordmTwZeg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvheegieenucevlhhushhtvghrufhiiigvpeegge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvheegieenucevlhhushhtvghrufhiiigvpeegge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968156AbeCSS3Q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:29:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031813AbeCSS3N (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:29:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 10/41] KVM: x86: Fix device passthrough when SME is active
Date: Mon, 19 Mar 2018 19:08:10 +0100
Message-Id: <20180319180732.893636267@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit daaf216c06fba4ee4dc3f62715667da929d68774 upstream.

When using device passthrough with SME active, the MMIO range that is
mapped for the device should not be mapped encrypted.  Add a check in
set_spte() to insure that a page is not mapped encrypted if that page
is a device MMIO page as indicated by kvm_is_mmio_pfn().

Cc: <stable@vger.kernel.org> # 4.14.x-
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2758,8 +2758,10 @@ static int set_spte(struct kvm_vcpu *vcp
 	else
 		pte_access &= ~ACC_WRITE_MASK;
 
+	if (!kvm_is_mmio_pfn(pfn))
+		spte |= shadow_me_mask;
+
 	spte |= (u64)pfn << PAGE_SHIFT;
-	spte |= shadow_me_mask;
 
 	if (pte_access & ACC_WRITE_MASK) {
 
