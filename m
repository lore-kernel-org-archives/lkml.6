Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3971411-1526651246-2-11491969027095417901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526651245; b=ZGIJqHv2BzZjXG6XaqyJNLB4Oez3/Xm6kEiwe//7qKO/frmJCI
    UV6+UyLvwJwQ9p9yL0t+eNkNnzx48RNyCfTcBuLL7XjxKUZQM9n67o6upWhU0J0z
    gyT2l/LI5Z454jszOCXpC3BGHKyIkwPQtks53qbHdUvD6e2OmTthomO6d3QTzTWt
    goYSyfGWyQWLBHFpeBE6fRhFy3MNwVjchAHxWwEZalVwnvA6Cfo7EHNplEyl/Kgn
    w5egzMxHKFXHa6H0BnConngrUpf8Mu5gMB1ueTtu0/COMJ9fLUNkHFE/n6vvUw4y
    aQLACZsqhHccYdu/uzAcTutWGz9peVkQTpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526651245; bh=Fac3e5QkeZ6MANXHAA7078jH9HBrU2
    EPFNojUQZD7QQ=; b=FS5o7hO8YZAk120QmUkSdnbSRf8alQwZpgWjk2CvhjdlcK
    gP7DTeA85ccl486sCseWGtsSNXZTvYsqluY46E3k4Fe0iB/TDuaBvwo07ZQ4LRec
    8wnAs4ETCeRW96GaaMZwSEK2YUv1UxeWFSqyVissoS0LdhYqfyrjy4C6Ry5mKa8A
    qJS3k9Qzk5tQADbna7+wYq7xtwzcC9f+YmTlLuqvz5qflsrq+7FpkvkSiT/VLMdy
    KgjeNF7zmYPCXPTh6gIpBqZu26gxl5CiLeNC04fRveuOZO55/AGWlDiGFwX34wtS
    8wxScjLfxTP1HuVgLAI52iujphp9Fmv3BmVWz0ag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=h98x9CBV x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=h98x9CBV x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfJ90Rj+Uzazq+K1BR5Jn5wcULvoa+O6O6Rdw5kyzDJrFQnf3SPxpHzgeex/0/aoks33HxbicllUDofYjJ0/BIcbyiMPJxOswty+9Ux82x79Z0kuaoIay
    YH/bI9FHsUeKLamq0CSJ+ouKg6iZKYw+Mr8/xM/7Tri1I4jN7GyMw001HfO3V7zl4gH2LnfL3b4lScbQ6MBsaxvf+eiW95g092YJIrpQSTJVo8EnKA9ktkSv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=_Wotqz80AAAA:8 a=7xLxSbQvrZr6QBFMdIgA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeERNrU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 09:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeERNrT (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 18 May 2018 09:47:19 -0400
Date: Fri, 18 May 2018 15:47:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usbip: vhci_sysfs: fix potential Spectre v1
Message-ID: <20180518134701.GA15598@kroah.com>
References: <20180517201628.GA6090@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517201628.GA6090@embeddedor.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 03:16:28PM -0500, Gustavo A. R. Silva wrote:
> pdev_nr and rhport can be controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential spectre issue 'vhcis'
> drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential spectre issue 'vhcis'
> drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_ss->vdev'
> drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_hs->vdev'
> 
> Fix this by sanitizing pdev_nr and rhport before using them to index
> vhcis and vhci->vhci_hcd_ss->vdev respectively.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Place the barriers into valid_port.

Thanks for the change.  I'll wait for Shuah's ack/review before queueing
this up just as she knows that codebase much better than anyone else.

thanks,

greg k-h
