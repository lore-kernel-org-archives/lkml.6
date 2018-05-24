Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156030-2-11035494734150860013
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156029; b=bbGT1nzXXIJmzvAD9hcg0MO3Cncy8ZVQy9kvMAWES/2N1F7yDI
    hSl/0h9xhOC7YuIxD4qfxMnyxbc49n+8aJlZSS8Hxfj/V9r5Hpc/gsyC7rshjyZQ
    q5WVjGlJk2OWp7JFAaSDG6B2cRmUZGcVeV21uHCqYe56+NSoYWoCwbdl3dEfF2oH
    D/LpfjvxNNchccuGUWw3D7ZbCvV5wZwyy3ci/+50pq1NaIZzXWP5Dqka71PXSw5Q
    USHRdlyHo8C1RFNmZncuhLoFqcnSDyzk+4LZe4VHbrZ8fzW73Yy/Rjp2jVO+oQX9
    ovVfpsNSvaQT6EoAkPH7fyZQAKARuJKwjyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156029; bh=RtE5XOM6k0DBpjfXcz6s/Xt2wNYpUe
    eHuOllToRdgdk=; b=Ncvfke8dqFM0rXK7GV6HmP98hKBC33Yc7DctQsObXCYEZW
    TtuzE9TgvElhDhCxKo7z25ZFE9ue6eug9Gz6QUvEvNVIZz6biKMZrZ52gjK7RBwY
    UJ6DtI/up0qN8jDbULbXvg8Jp15+rdBopr+uLPMswGGjzYGu8eFGMAVJ/Q97pRIU
    NGCvgWjPffa2jd5OmcZLf6bNUEJurF5KJFNxMUKBvvvfP4kmVb8KvlAzYXJVGsKF
    IQ09XCfXkHnh4+O8I/NkDAWqKc7rlk8019eYzj+SqWCnOOSe8msKmhXuUrPjzTcT
    ox0gV7YLl9BXKiXaa3pAG8ZYt3poOIrV/HYkQ2AA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1WUG0Q4c x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1WUG0Q4c x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfK6wnqoUl9eSwuP1oxKRy2TXzKDZbk9+dd3Y2GN6dTqKY0Uv8o6sozn1cwQx84fkd+FofyFwD3Hfp1moSWygIc2J0S0i2/m6l/wCK7PyomRkG9776ZoG
    bOSMJWi5rMAl8S9GkIVOQtF4JBJOqTtZMTDrb5eiCwXclz+Cgetq82H3hqqegyZnHLgxspx1runygAbsqFuDdJWKqm8p8wBfJaUaZj59KSmmiDsKNZuIoqQD
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=_KYyZdXvlfYLBtlrgXgA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968311AbeEXKAZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030849AbeEXKAO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:00:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 033/161] sparc: vio: use put_device() instead of kfree()
Date: Thu, 24 May 2018 11:37:38 +0200
Message-Id: <20180524093022.332924297@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

[ Upstream commit 00ad691ab140b54ab9f5de5e74cb994f552e8124 ]

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/kernel/vio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -403,7 +403,7 @@ static struct vio_dev *vio_create_one(st
 	if (err) {
 		printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
 		       dev_name(&vdev->dev), err);
-		kfree(vdev);
+		put_device(&vdev->dev);
 		return NULL;
 	}
 	if (vdev->dp)
