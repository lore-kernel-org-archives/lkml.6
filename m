Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483715-5-12278247353921482584
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
    t=1521483715; b=QdnHkSss2+5bCqcsORggxaDOtlpd7YVn2yjPdEPw4Vqs/9K
    /I1F+tkIYObH9Tz6rYeJRLnXs45qWX+ZcgDFLE2iCN4X/mej2wLjhIogZ8ZXe2sg
    eAIFDx32t41Xx0YYHZKPhRzEUVGUz44EyTQ3H3wXAnQ4ABx6Ef0zwLnPAQxrhBF3
    ZEhWolHwJACmQPORH121q1DdoisYG3NO5wyfRMz/mogNQhIM5NHGArnem7N1gjZB
    4k5YiTg8/9ySF5w2sT9ry65ZkLAyTgHtuR9OAh6+pXPt9s5E6LYpNAtZDtSxqg5O
    A/YuEPYA066oUSmy41lPfp0HInGOvn6cVu625bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483715; bh=DuihOIiSaJLsvCUk5iEGIzI8KE
    gnnBhkTuwYIJ/cA7E=; b=JGPhkMX1QVgesWhn5VOeWeSfb3s57Bd6lTAf5co/LL
    0TKwhRAiZnvicbdTgAw/S+lGvosMVqVpyhzSfF6P+T+KehOVSkyM+8Syur6K4Cdz
    CFCoKa6T018KH0caie3QwLECwypplIf5x7XRt8CmrCfer0IXf/VUOoN2JYdVRMqg
    Tc4nbSGkHpd9LZuSI4fGXudq0cTy8gtExxYRAYGoVM752O5ycNwKHeMNCFjRA6wk
    Yjr1gOb0EfgTmfkLGnb9u6iJLZ0IQ4/DzsAGqL8X1IOqDC7pA5BSOA+2chfrBHfa
    RBcMDFP/qb3B/0jTg1nba5mFD6DOxznZG9hO60l47o7A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefheeijeenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefheeijeenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968070AbeCSSVp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:21:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030442AbeCSSVo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:21:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 086/241] powerpc/mm/hugetlb: Filter out hugepage size not supported by page table layout
Date: Mon, 19 Mar 2018 19:05:51 +0100
Message-Id: <20180319180754.771365592@linuxfoundation.org>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>


[ Upstream commit a525108cf1cc14651602d678da38fa627a76a724 ]

Without this if firmware reports 1MB page size support we will crash
trying to use 1MB as hugetlb page size.

echo 300 > /sys/kernel/mm/hugepages/hugepages-1024kB/nr_hugepages

kernel BUG at ./arch/powerpc/include/asm/hugetlb.h:19!
.....
....
[c0000000e2c27b30] c00000000029dae8 .hugetlb_fault+0x638/0xda0
[c0000000e2c27c30] c00000000026fb64 .handle_mm_fault+0x844/0x1d70
[c0000000e2c27d70] c00000000004805c .do_page_fault+0x3dc/0x7c0
[c0000000e2c27e30] c00000000000ac98 handle_page_fault+0x10/0x30

With fix, we don't enable 1MB as hugepage size.

bash-4.2# cd /sys/kernel/mm/hugepages/
bash-4.2# ls
hugepages-16384kB  hugepages-16777216kB

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/hugetlbpage.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -765,6 +765,24 @@ static int __init add_huge_page_size(uns
 	if ((mmu_psize = shift_to_mmu_psize(shift)) < 0)
 		return -EINVAL;
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	/*
+	 * We need to make sure that for different page sizes reported by
+	 * firmware we only add hugetlb support for page sizes that can be
+	 * supported by linux page table layout.
+	 * For now we have
+	 * Radix: 2M
+	 * Hash: 16M and 16G
+	 */
+	if (radix_enabled()) {
+		if (mmu_psize != MMU_PAGE_2M)
+			return -EINVAL;
+	} else {
+		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
+			return -EINVAL;
+	}
+#endif
+
 	BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
 
 	/* Return if huge page size has already been setup */
