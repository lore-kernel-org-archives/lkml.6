Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-229752-1519956792-2-18126546036564576615
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519956792; b=PXhfUqHGhtExmlCZdT0NkAu2TH1M9j6A0Rxlscp+u8pHIRY
    6arB5tKdfkIJ8csEuuxFH2HxM5XRyZtMCXKgt9PBWg6Txw6BvidtmTNXkLvVtZdv
    scMBepRKEs2kN7LyE1PnLac0Nb4H2NO/QGN61/t35zG2jxjA2dvzAbRz5ZIDVg8o
    DBlzQW5kz5W8ksyUvMoE+wl021EPiFmYCrZXSnG6485gTScWy8n4nONoHPIpjRq9
    wpdzWICgiMZaLFl3Z+RVYCHAiIe7qUdKet8Wj6KV95ujMOiNW5o6ng24MimA5Z9S
    sslU96pl9kQNZozM2DeuKOvHEAWStW0BXrk1PCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519956792; bh=1
    /rzXDaiFub+Tj/tQ/zrDhxZPITJJFQClh/MXIn5A7M=; b=wi4tGDQ7pwR+w3XpB
    62s0Wc7f3IXoYz+b3ad5GMYj4hnXWElD1+tz1eOsyOxSJidFJXsjlvp03zeqJc34
    z7NRWc02NjvX/mcu3OYrYRjCQaHtN5sawT3kPG9t9yFlIuzP/9Zs5cALIE7v/2OO
    o7vi6a5zkDFIaUg9OX1xtI68yB4kaEKFy783n3dsIrz0DkmsPK4vvybhMAJm2ub3
    RYrFtuTM+iuPK4D6DFkuKJ9J16aYI0kda+Zk3aVwE63nY5yYfW+ZBf+L3qpzvtNG
    BYw1o6AJqQaF/fGDV+58KOu1ivzMTnSgTvofOBovGnP5xCiht1fXWtz5sfPHvaaK
    vudMw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 2/2] staging: most: Fix a coding style problem
Date: Thu,  1 Mar 2018 18:11:44 -0800
Message-Id: <20180302021144.10795-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302021144.10795-1-quytelda@tamalin.org>
References: <20180301162034.GA15087@kroah.com>
 <20180302021144.10795-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:dty7cdaOUTMhIW0Si/5Nh/7fl6w6o9uk2AQJcj1jQHc7h2MnIJn
 yrqDbds7SYCYmFyFamx2SbvEJIobtPw+MdcN9CIyCGc8sd1b5kqnSlGrLFEE4efLVwOLQQ1
 jPWd4ZK0IFwTNFZWp3jBcoEUDMRyBhsqSVkzdm/9EpJFEjV/YHQv8bQIZ8nivaXqVVUJHbw
 8p5WSWajpuNyj9OONKqCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:imCFzA4o9G8=:IkC6+85PPuDOYyjSpz1hIM
 tAHalsXn7XBYWlRwvlgMRZxFuRXFXvmilETtbVAdIWc7x1B1ELfj49rH9Qn3Y++wfXUAPQeSJ
 A6T5mRxJJ6dGgjQzCPUusfrw4bRuybivSkrMD+vX6CfwGeLTRExhdecPUupOTxb6yqBsDe4yF
 gI1JK7w1+ha8dCKxZ0tFRY9cgKGzpsIfDqEA1fGN0S+STKIPvtc5ptTohpbYWV59timEcMBSt
 kvHHRzHO1tyL1hHZKg6LX2VfF793qoVqKs0kcCgaWzAWzA0NUjMAlzRW31sjjl59LvQ+X3fSh
 DhAZRtVGnsH0WtpyaXb4JzBSdH8nsUqmrIp3oqBGbtk5TruPyqONo3R3pS0opB+Qk+iWRyoRx
 OAmcWfV/PIaF9d/s1anLp8JyHFTs36Y+Tkm9VKBM8RgFqu4CMG9iKB0Uts9SMhqdI8ozg4dnn
 u9nI3pUwOw6xBydxA9LDKb1KWB6rzgbEVNmuRWCwjdeTkvr7W4OVghZiOQ9ZPbHLowgDHaD6C
 rWXghJRkoKc+LZkZL3kf9Brc/nezRAa9YQqXoYbGzmGYvI8QwRMBv1Kqa74Mo3cxx0vEuQUM1
 19wVqlsngtKSOQhqynFcQiSE1jeNknovWf4F+gnG5AaZQIc4BwsmfC1noV2VngfXPe+ampbRv
 PqkWnLmcPknzfYrjE1xQRovX4kjb9YN3Y2+B7QZAZDB8bccFv+uaddAvpBoNimJk7X6poTRfp
 x/ZOyvWbjnk0qm/PNxhqu3/OS6YZ5zZ2ohDn3g==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, chris@engineersdelight.de,
 linux-kernel@vger.kernel.org, Michael.Fabry@microchip.com,
 christian.gromm@microchip.com, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Indent the parameters for a function call that extends past 80 characters.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/most/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 67e2d7f29967..8d311970225e 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -1473,7 +1473,8 @@ void most_deregister_interface(struct most_interface *iface)
 	int i;
 	struct most_channel *c;
 
-	pr_info("deregistering device %s (%s)\n", dev_name(&iface->dev), iface->description);
+	pr_info("deregistering device %s (%s)\n", dev_name(&iface->dev),
+		iface->description);
 	for (i = 0; i < iface->num_channels; i++) {
 		c = iface->p->channel[i];
 		if (c->pipe0.comp)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
