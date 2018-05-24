Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160636-2-16394870431560497176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160636; b=GOFWsPEF+8hMtHSuoV50c/fGKnr8mMzhHtX2MaFHaELJT8cbxP
    CHr+C6Swcqb5ndvos5BpHPgrRX+T6x6Y0gFPUd/RjJMPnajoXmS2t+8qIE8V77Zt
    8en9MPBOswcp99oUeVaAgnECmd00xYozR5jfgQ4kFZrzm1CHdKC2VwdffxSbx6AH
    7JxdS1xrlqhcaB1GvoqYLtF6aPp15COWteLSFAzGQyi6vdR3giph+QOaMcPWCiVm
    kIVfUG7KDBcWn/gNttPz3uHW3XQ24cz8MXOvg09FNmFW5rNLxqLb9Sp8NKK1qabq
    V5fnPtf0u4NlTT5EbkUxyeCUe2tB0v1BzsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160636; bh=nBCmF9qP4XR6Z5QJnKJLMEc+uckV2y
    6LAdkZBRuSWck=; b=a7jqzxhZFXQsfVG9To2Fg7jm8TO6gQ+G9q/CpCG3/3ZnKA
    lVhcY6RwyKridtO+gVKI+d+3sYGK+GNtq8JD64S3ZR7+3a8n0cDr9cGfYUpnzF4N
    zEUiIh4MnA5vWpPA9PYv8mc6OfeApOjMMPEfKmN/Ml8layT86QwgoZAleEjx2kMo
    Y2KGgMwwhKp6iUsndPcIZGdGtOBMhdWHltUoJ1R1rTMnnX+ttEFaof++eDym9qa7
    dXA97is6W2GaoAJ7kKKxoHPNsWRyBZ/BhWIhk65pQJAh1+VTdnbb6m+34juRQGby
    x6d3hnKmo0L6Ke66Nx65VDVwlp4hPX1Bm0Q1quxA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=J0+5t4IJ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=J0+5t4IJ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFyvXVmlCXYBQ4P/d33S3VDg6zPZrTovGk9ZTZr3s6y3fsdr0VXd61iGtqK9Y+H++XjKJ3Y6ELiPHkNX2dK0Ae0ysl81pBEgUQOqheiDmyE5EX6BxHR/
    HOv2+DyF/gkfXc3j/yLx2si6WEaCbJg9wqgmQyFdxX07kpI+o4uhJtIhcDCvzy45wh3VbU73oY1BdclZaqNtflBhaWX9nMeHcCjiNFLFAQqce04iAvIQV0nR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=FOH2dFAWAAAA:8 a=hSkVLCK3AAAA:8 a=ag1SF4gXAAAA:8 a=U9OhtlYdyY8-YEg-ErkA:9
    a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=cQPPKAXgyycSBL8etih5:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968029AbeEXLQr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968033AbeEXJxY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 050/165] loop: fix LOOP_GET_STATUS lock imbalance
Date: Thu, 24 May 2018 11:37:36 +0200
Message-Id: <20180524093624.053521515@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Omar Sandoval <osandov@fb.com>

commit bdac616db9bbadb90b7d6a406144571015e138f7 upstream.

Commit 2d1d4c1e591f made loop_get_status() drop lo_ctx_mutex before
returning, but the loop_get_status_old(), loop_get_status64(), and
loop_get_status_compat() wrappers don't call loop_get_status() if the
passed argument is NULL. The callers expect that the lock is dropped, so
make sure we drop it in that case, too.

Reported-by: syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com
Fixes: 2d1d4c1e591f ("loop: don't call into filesystem while holding lo_ctl_mutex")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1282,12 +1282,13 @@ static int
 loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg) {
 	struct loop_info info;
 	struct loop_info64 info64;
-	int err = 0;
+	int err;
 
-	if (!arg)
-		err = -EINVAL;
-	if (!err)
-		err = loop_get_status(lo, &info64);
+	if (!arg) {
+		mutex_unlock(&lo->lo_ctl_mutex);
+		return -EINVAL;
+	}
+	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_old(&info64, &info);
 	if (!err && copy_to_user(arg, &info, sizeof(info)))
@@ -1299,12 +1300,13 @@ loop_get_status_old(struct loop_device *
 static int
 loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
 	struct loop_info64 info64;
-	int err = 0;
+	int err;
 
-	if (!arg)
-		err = -EINVAL;
-	if (!err)
-		err = loop_get_status(lo, &info64);
+	if (!arg) {
+		mutex_unlock(&lo->lo_ctl_mutex);
+		return -EINVAL;
+	}
+	err = loop_get_status(lo, &info64);
 	if (!err && copy_to_user(arg, &info64, sizeof(info64)))
 		err = -EFAULT;
 
@@ -1525,12 +1527,13 @@ loop_get_status_compat(struct loop_devic
 		       struct compat_loop_info __user *arg)
 {
 	struct loop_info64 info64;
-	int err = 0;
+	int err;
 
-	if (!arg)
-		err = -EINVAL;
-	if (!err)
-		err = loop_get_status(lo, &info64);
+	if (!arg) {
+		mutex_unlock(&lo->lo_ctl_mutex);
+		return -EINVAL;
+	}
+	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_compat(&info64, arg);
 	return err;
