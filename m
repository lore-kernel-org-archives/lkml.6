Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161934-2-12579514404999604646
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161934; b=iQZn6iPMmRuawYfgSlMiS9QQsWxLZBUGXPhoyyO/LuP4V4RO7x
    4TqjhqP7p0dCEaAd3WX6GzRqTdPL/pDGW+9NqFFIR/aA9hXsJlRMgVvtgNmjSStE
    VfSe4bqpw6zNEudtn7aIaHiGBBuWdS0faafhAA+gDvVjR5vzA+C1MBmpYUFMDzop
    8hdMzY6YMnCI8dS4ImYPIltKTU3DAiC2/o7Da83534XZ6fS3sPYxoWqMWfAxJlz+
    QJascHzhE/tsFOY44JxTvCSoaORgAwqTx9JdZXPkoE5G8NslFO0Qb+Ys21NA578T
    RqexTb9Jrwv/jLpJ7YFE5KtkCPR0Caqz020w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161934; bh=N2z6xizFl7G+xxwW9THVISaud650Ek
    Z7YALlLZnm9JE=; b=iZnlfOAocsUle2RzPRpEzgQFMqjkqC309CqtrH3UdHef/3
    IOycoaqiY4xFyRX/djIA0dffIN2ZFDzr1Vw3iFA+KBkBp3OiFIYiLNu7GYsZ3gTm
    7R37IQ7d+5OeAG0XVn29lYmPfmWz+NGNLDPjq9eCmcvW58vPWA6C/ii6XkJUkln4
    n2EVNmAuX38o6zI8f/SN6e+g0f+3pWr0KTXM/cAGjhIvJqIzZZcRAFCIl5XWAuoU
    sO2aGSXzS14wFQwMqb4hTmfIx7cs1+SpChELaGRdSF1nhv9k2aXQ5N5fzRawqq/V
    47mPBx9Fw9ongZKhVjT/h4CMNx0bfIXsKD3uStww==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=hGuDug23 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=hGuDug23 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfN2bi3fSmZpwfzPJ3Bj/g31VgCR06+7FB8LJd/i3wptpWVDv9ad6/uNcP9AEHZWO0c5OQZiiywGuYbpacKkgyIu+TIJLGjwBMGTAD0eEfksTmz3FeXoL
    Ne+oO7xghnh0STwvof1a/45DDmdBGwUrFdN27UK07ca0FPFwQobEYVqvlgCAHyisaFi6/oMSjKUO2CQuRz1WxMkiK/ExWixz0bQ29+0o8zL9BsYSUK2hC/7+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=x3GXP8Dy4zAY1LmwQykA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967353AbeEXJtR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967345AbeEXJtO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 54/96] scsi: sym53c8xx_2: iterator underflow in sym_getsync()
Date: Thu, 24 May 2018 11:38:37 +0200
Message-Id: <20180524093608.611763912@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e6f791d95313c85f3dd4a26141e28e50ae9aa0ae ]

We wanted to exit the loop with "div" set to zero, but instead, if we
don't hit the break then "div" is -1 when we finish the loop.  It leads
to an array underflow a few lines later.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Acked-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sym53c8xx_2/sym_hipd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -536,7 +536,7 @@ sym_getsync(struct sym_hcb *np, u_char d
 	 *  Look for the greatest clock divisor that allows an 
 	 *  input speed faster than the period.
 	 */
-	while (div-- > 0)
+	while (--div > 0)
 		if (kpc >= (div_10M[div] << 2)) break;
 
 	/*
