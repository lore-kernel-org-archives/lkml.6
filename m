Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484464-2-12174721065746416464
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
    t=1521484463; b=fm8LjNm2jLA8p2BzmPqTIAdnB9tRxwOuxtOwVBBgs8hkzJj
    LIKrnjbhLzoBvPlJEULXlManQd5pxpQzFL2QzHD5/jnhA6mJDy8peBF77roNfcNk
    WE9gOh4+uKcrMSNjyx6bThkZmoNBwFg+KeREa4FQfpeCrvkyM+3mwaS4Gj2786g3
    tA+Y9mFIJJ+hyXEnGfxMMJeLudMWf1L1C62GVqtLjbPuy2ySyIx6a1h4WE+6Ma1R
    XY8EzKBBEF771dZ+4BrOMkeCOuhFr6SThd0sqIIAVo007QymRSrrh58/GK1vIMXs
    5kABuHDqqsqPrBn/IlPrOCfxRaZwuTQ+6MOUlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484463; bh=UZ5tNPX/atpUOcDdRITGmxqc7Q
    enm75CK9KNhTh4DOc=; b=diL9i/Sk3ewaKp9Z1HmRhLpn7s+ngZiDDdgitHGavW
    UoBfm9UYLw5baGqnijhE1/9IH5TRA1fXaFowPjFteJ2EWW4mDp6UEbfY784IfUN8
    /WzZY6ypCEmYmpiMuMWELitzUaGwRdGd4KYdX9Qgi74uSHBi6AoZR7rucbeN6uYb
    YSRUnNaER5HftdTNtveHyJU8QUGKB1cWsR7Y52t6yRW+PXbl2zd/UV1WYaOrqBx7
    CB0cJrzy5cHSQtLYJAqvTAxqxaehmd1DyKjEJ4BOfxVxPmx2J5dBDzKdCAlcfL+Q
    iHIIRbO8tGhAYO7kAuIR1aCnfq8yA7O2MMztNGS7mkrw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepshhpihhnihgtshdrnhgvthenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtdejleenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepshhpihhnihgtshdrnhgvthenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtdejleenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967418AbeCSSeH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:34:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54736 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032214AbeCSSd0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:33:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Hans van Kranenburg <hans.van.kranenburg@mendix.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 34/52] btrfs: alloc_chunk: fix DUP stripe size handling
Date: Mon, 19 Mar 2018 19:08:32 +0100
Message-Id: <20180319180736.927690482@linuxfoundation.org>
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

From: Hans van Kranenburg <hans.van.kranenburg@mendix.com>

commit 92e222df7b8f05c565009c7383321b593eca488b upstream.

In case of using DUP, we search for enough unallocated disk space on a
device to hold two stripes.

The devices_info[ndevs-1].max_avail that holds the amount of unallocated
space found is directly assigned to stripe_size, while it's actually
twice the stripe size.

Later on in the code, an unconditional division of stripe_size by
dev_stripes corrects the value, but in the meantime there's a check to
see if the stripe_size does not exceed max_chunk_size. Since during this
check stripe_size is twice the amount as intended, the check will reduce
the stripe_size to max_chunk_size if the actual correct to be used
stripe_size is more than half the amount of max_chunk_size.

The unconditional division later tries to correct stripe_size, but will
actually make sure we can't allocate more than half the max_chunk_size.

Fix this by moving the division by dev_stripes before the max chunk size
check, so it always contains the right value, instead of putting a duct
tape division in further on to get it fixed again.

Since in all other cases than DUP, dev_stripes is 1, this change only
affects DUP.

Other attempts in the past were made to fix this:
* 37db63a400 "Btrfs: fix max chunk size check in chunk allocator" tried
to fix the same problem, but still resulted in part of the code acting
on a wrongly doubled stripe_size value.
* 86db25785a "Btrfs: fix max chunk size on raid5/6" unintentionally
broke this fix again.

The real problem was already introduced with the rest of the code in
73c5de0051.

The user visible result however will be that the max chunk size for DUP
will suddenly double, while it's actually acting according to the limits
in the code again like it was 5 years ago.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Link: https://www.spinics.net/lists/linux-btrfs/msg69752.html
Fixes: 73c5de0051 ("btrfs: quasi-round-robin for chunk allocation")
Fixes: 86db25785a ("Btrfs: fix max chunk size on raid5/6")
Signed-off-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update comment ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4737,10 +4737,13 @@ static int __btrfs_alloc_chunk(struct bt
 	ndevs = min(ndevs, devs_max);
 
 	/*
-	 * the primary goal is to maximize the number of stripes, so use as many
-	 * devices as possible, even if the stripes are not maximum sized.
+	 * The primary goal is to maximize the number of stripes, so use as
+	 * many devices as possible, even if the stripes are not maximum sized.
+	 *
+	 * The DUP profile stores more than one stripe per device, the
+	 * max_avail is the total size so we have to adjust.
 	 */
-	stripe_size = devices_info[ndevs-1].max_avail;
+	stripe_size = div_u64(devices_info[ndevs - 1].max_avail, dev_stripes);
 	num_stripes = ndevs * dev_stripes;
 
 	/*
@@ -4775,8 +4778,6 @@ static int __btrfs_alloc_chunk(struct bt
 			stripe_size = devices_info[ndevs-1].max_avail;
 	}
 
-	stripe_size = div_u64(stripe_size, dev_stripes);
-
 	/* align to BTRFS_STRIPE_LEN */
 	stripe_size = round_down(stripe_size, BTRFS_STRIPE_LEN);
 
