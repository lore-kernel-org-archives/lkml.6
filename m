Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484231-2-14389288279633758177
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
    t=1521484230; b=ZR4di/65WXbvqUzHt8aR3Fl7VJZ4ufBa1wfNrG677lFCsX7
    xJ4CWUQRckAiFsGZIBmOYS/RGza3IzpBqsAbyuQM2pTlmBJIIoVQh8ut1h/Kon6c
    8tbY+NBGCbAp4tI9AmXh5/i/UO+8vP49japskahDQYXXkP51nFySCs+ot889ZeJn
    B9hAcVrQympSIA+c+6P0c96jheP47fIe/Ifl2jiZbcL4yU9MlE8sriAngNIj2V97
    qHme5ixpmMW8jV9pFd1jr78oIjM3QRQOo1tU2ugl0hujCMF85RZMTqGjQuu7X9/M
    GTqSbE5n2wSQFTL8/NUPQoVXFuAT0vy6DocgBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484230; bh=ak+VMCl54e5K/4iQ8758u8Mf3b
    1fTYVcXNJjR5Da/eY=; b=mC7kWqk1J0W6VM+Ql+BFN96xOm+jLEdVncmisI+x6r
    Nq4ftpVg+/1QIxGyYXz3hQr2K5i5d4K+SNwaLWYLszmAgC9f5QfHS8DSeykhGobN
    AEfPf6JlZsoEp110LPUHrdwphaSfdZhe7f8FqHRZn82KomXSnmqRXwdukurFop4p
    yHcEP/7qSPuLaTJ02S11FJfC8yq3g7h09LWegunNv+yiA4TqKzlGmAxlWtq8XWm9
    s9Gg0/N7Zf4lFgwIY7QIwOF8oPjc+IQosPgQIHbOoLY4N9LX5ORrvFMG235NPVJu
    ZgEzPyC7+amIOfS/JYWdvESEfXeapx9TvOGP4hvsWESQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvleejheenucevlhhushhtvghrufhiiigvpedugedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvleejheenucevlhhushhtvghrufhiiigvpedugedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935694AbeCSSaW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:30:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935680AbeCSSaT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:30:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 33/41] btrfs: Fix use-after-free when cleaning up fs_devs with a single stale device
Date: Mon, 19 Mar 2018 19:08:33 +0100
Message-Id: <20180319180734.387087853@linuxfoundation.org>
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

From: Nikolay Borisov <nborisov@suse.com>

commit fd649f10c3d21ee9d7542c609f29978bdf73ab94 upstream.

Commit 4fde46f0cc71 ("Btrfs: free the stale device") introduced
btrfs_free_stale_device which iterates the device lists for all
registered btrfs filesystems and deletes those devices which aren't
mounted. In a btrfs_devices structure has only 1 device attached to it
and it is unused then btrfs_free_stale_devices will proceed to also free
the btrfs_fs_devices struct itself. Currently this leads to a use after
free since list_for_each_entry will try to perform a check on the
already freed memory to see if it has to terminate the loop.

The fix is to use 'break' when we know we are freeing the current
fs_devs.

Fixes: 4fde46f0cc71 ("Btrfs: free the stale device")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -589,6 +589,7 @@ void btrfs_free_stale_device(struct btrf
 				btrfs_sysfs_remove_fsid(fs_devs);
 				list_del(&fs_devs->list);
 				free_fs_devices(fs_devs);
+				break;
 			} else {
 				fs_devs->num_devices--;
 				list_del(&dev->dev_list);
