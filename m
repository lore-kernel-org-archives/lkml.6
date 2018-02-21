Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474421-1519217273-5-13769221368656012160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217273; b=tqm2bXsVn6rzRiuB2cqQCIEK2TQKU5hSVL/zhQ8ofJJQtPB
    4GS/QsIPT4QfAPBXrleHYgoj8EtSoqLjQBY1ll5P1K5RHr0+wtnYTQ7hBB8+W5ve
    Sy4EjF8rQzyM6IG2Thgi8+SKJbrVq04TWxW5eBzveyIrIlXQUDq6f3LN4IunovQe
    X82e84eoI3aPfee/PYdr1tMx+Lr1+X85Ns85q2zIVGF824nz4zfSbsOcMQhzY76e
    jtimLyJXMU6rX3TVXLKDh9W6wnRGL3eLqABcHc75el0RJBpgwH654uNhGtV7knVD
    TnARIPTSiRjeLPg35xvJ1p3v3W41pUS7jWq8QIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217273; bh=9nHG8vTnzcwMPmBbNS4JVjHOpz
    Mwj+6VQk12fAr59ME=; b=XObbUN2MVFUL7CaqK5eaWeQytF227uIuLN8oMVMvVx
    CWRXPaZm5VPyTKHJCgyJb/IS6Rv3B555IU1nJB9AhmBv1nRFMfAuJZhv08iQRJmb
    akc/bJhJFl1F4Edy3mXOFxAkruR+kqQ7Rpr4eC04VxfWMzxSEh5P+Ocsl/2V16p8
    IuuDZkafrYsWIuGwxx+jB6lAUnRlIh46zCPE2hevJ6Quuvc5L4EvbTe/RMLtYakn
    ZoIw4DkBLElpn7QOcD7vCD1ZjV3xWgQTx+umMnbYhur8dYVGcoBbDcO7OC5gbkU5
    pp/wUnPkfo2SfConWJ8Q5dJ0+oIYFr6wspv/g93HejOA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeBUMr1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:47:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933948AbeBUMqj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:46:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 31/33] ARM: pxa/tosa-bt: add MODULE_LICENSE tag
Date: Wed, 21 Feb 2018 13:45:14 +0100
Message-Id: <20180221124411.167024968@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3343647813fdf0f2409fbf5816ee3e0622168079 upstream.

Without this tag, we get a build warning:

WARNING: modpost: missing MODULE_LICENSE() in arch/arm/mach-pxa/tosa-bt.o

For completeness, I'm also adding author and description fields.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-pxa/tosa-bt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -132,3 +132,7 @@ static struct platform_driver tosa_bt_dr
 	},
 };
 module_platform_driver(tosa_bt_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dmitry Baryshkov");
+MODULE_DESCRIPTION("Bluetooth built-in chip control");
