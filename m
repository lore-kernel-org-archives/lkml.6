Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2391582-1519890244-2-7655460156975085358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519890243; b=Kh1LZBZR46RmC2IR+5JNtWcdXFKKjh6zYU2ES82h3ENpzIu
    Ot4jXQks18CaDMjz2aWs0e3ZH/Uv6YzZv1HtrnRFVSR4hXRi/qMgigH8yvyGJj8H
    4XyZxN1FJxjgIOFDxHHOdiefaBfqI4o/xg9S13xxCVkzlD3YWRgwunAjUWyfZNtn
    ULQE/gFl93isbKy+25Gz7vkzRBdssc03d4gPg/jA8LW4yOtlUVHYmGsH7kPi2sCI
    4ghhYl4ryTU64+2rtogaea3/Xfw8WvOyrj5Dl7OvQjhU/JYiTUf8lZTIF1iPdYGC
    sLBVXRHLk1ink6aaoqQtSLSbt4+KDHBJHlwko5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1519890243; bh=ReoEY
    fDZVBK/P+VerHj1jMkyp1EAbSDNLr6iwEJHsvU=; b=subW7dxv89qKdX2rczdrU
    R11/8QPpedMvrTn30XdS2bIY9NtBTkw0AMFosfvCMIpmV8cMXopuLBWdu6IMB75K
    fBpN6riS7q2G38j7QtbcKkzayyjphLfJLZDq5a7Qrt7kJ32COOh0llnbdsjmumUv
    wFCz8gHetww1w7aS1x1M+yS/VzHG2GRa4eDGPIG8kTS9hycqtbDX+FOzH3pQf4pf
    i/YMHR6i04DxSi4jQkyM8ifTvkZxqcyeBkZ6XTaoY3O5K3G1ryjxocjKFke488pL
    /mbSxw5cKtKivmBmWu2ld1JTI4nIOKo6KLToOzlyuZPTPyH9t7Wnn6Qf66mDVHvS
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=holtmann.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=holtmann.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=holtmann.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=holtmann.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935505AbeCAHoC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 02:44:02 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46717 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935139AbeCAHoB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 02:44:01 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Dell OptiPlex 3060 to
 btusb_needs_reset_resume_table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180301054252.16007-1-kai.heng.feng@canonical.com>
Date: Thu, 1 Mar 2018 08:43:59 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <80186954-EDE1-4DBA-8ED6-055BC53FD1C5@holtmann.org>
References: <20180301054252.16007-1-kai.heng.feng@canonical.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kai-Heng,

> The issue can be reproduced before commit fd865802c66b ("Bluetooth:
> btusb: fix QCA Rome suspend/resume") gets introduced, so the reset
> resume quirk is still needed for this system.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=13 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e007 Rev=00.01
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Cc: stable@vger.kernel.org
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-stable tree.

Regards

Marcel
