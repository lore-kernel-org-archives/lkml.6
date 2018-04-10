Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3248292-1523344454-2-4562200194044340249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523344454; b=C9zCCNI9n+o5kit3MSFgo6ff3l0y/Im3BnzhE/FEv4V55hTh38
    kvAFGPBbx9XNHMJM8+FEp5V4NHVi+Ko0YFj3HNK2EIgZke7n7AhpiJGgf28TuFZl
    cejTtqSHuo1mz/GDN802cJ9umwjROemPBuyfte/SSEv0fCpSZw+SSq8NnUJYWoW6
    tDMVT/TP8OIlFrVEmIdxbMUBU+yY9mEXZLFxFqeybxQvt6TNNJobKTKUtPO3+fgu
    GaAPutfRh+p4EZyNTf5u9vA3oSbP36zAKTlTiogLEorml8vNjeJ8/gt1Ihu/j+Xs
    LqMhilNL9swU/Dbl31LBbElFMVNn+fj0ZZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523344454; bh=N+9tlDKqhRe2cfxcePRpNQd1o/qPxD
    lNn5UyA49AXVE=; b=wg/mam1Jop/V+oFveOOkKPMtE1HZzVzE3/QmL8ziQQtBYr
    kSdjdGmxW0ioN2Il1rhyd5eGFXZSjyV4Snn4vIHjZVAtHbW3Yt/IRfw/7bakseTJ
    32GE4w3dehOS3vLGkQ3Nm1yBp41xX5d8B1hUx66dMje0ACozXuJi/elIT4xAnIlo
    HFWuahV0VKFrYyKR23CdmN5XVxn3XQtNzhSiYwTYcQhLtpLixcJpYffofxGdtNc7
    ikkPw8Pt4pVfXiMx/2HTeMKP8M2Pj7wl8cWf6r4jM57t8FN4e9ljNz8qtVUuwhuG
    vC9d1MaL1zsZSzwgHuvOoKcyKuhTCD0jwgSDS0yg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNyLBXH42d24cOn/Em9ll9YfjVSTVyB8QjMbWWDsvbpj3fZq+lHfYB61G0lJRmp9hNniUuDlS+oefWVi+x9eGSZw+LOARnkc5TA4fuGuyreojGUCdTZA
    yuj1QQMY3lZ1nKaVK3D00P3emjz1lIwogsyRHU3KJ9JXBeBQB4N3LZ09btEVG7UHZmYrR1pjQkAyCEFmLlbIxVR8ek9AQiJblJA98nuz9OxqqWzlvztByb6w
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=qZZeiA7pcbm-lTdGaAkA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeDJHOA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 03:14:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeDJHN6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 03:13:58 -0400
Date: Tue, 10 Apr 2018 09:13:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 3.18.104
Message-ID: <20180410071351.GB31194@kroah.com>
References: <20180410071346.GA31194@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410071346.GA31194@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

diff --git a/Makefile b/Makefile
index 2df4a1163714..2eae8b1039aa 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 3
 PATCHLEVEL = 18
-SUBLEVEL = 103
+SUBLEVEL = 104
 EXTRAVERSION =
 NAME = Diseased Newt
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f17b427d91bd..02262b8e57ee 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -58,6 +58,7 @@
 #include <linux/if_vlan.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/prefetch.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/cacheflush.h>
 
