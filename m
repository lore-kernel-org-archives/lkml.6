Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4059601-1520328870-2-14431158479773296670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520328870; b=fQNDI5P39zcy/4izIfAWkYBTKPn8mBAdz46WWjqpLPT2JfW
    gMgOqZwmxVtXyi8jFxAHFbz6Va3+dXeKTNQZBH/2WN2t0XPK19ncOGtJHGP9aQx3
    f8NvQd1CgiD0ThHhA+hmMnL/DUYF5Bu/eCZ2nHDozcUmnP8wwTs4mvygmRPJCX4T
    7KTI9gi4QnN0jjcEJkT/d+pktKX6mZw9FzINIRGImNdE8/p5H087p/1pj2pWe+gQ
    g5PDk4X13Od69yRG8cVYILo/+UffGHJo5ZaP6X59InsuIQ5g1cHYF8Mp3naxgikn
    +5zJ4nbSq9GlDkgjIgkPKcpdthiWw+iU6pVbYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520328870; bh=1
    /rzXDaiFub+Tj/tQ/zrDhxZPITJJFQClh/MXIn5A7M=; b=oe++TeR2L1xyptBp/
    l0Vo/TcZxUvrSRj3QOT1D1tlafMSVPo/bqpIUF++mTan5InowilNa1rIUL2oWUDU
    5ytQ4P4BqWfynH4BXWR8rIt1izeRz5+M4bZejtD4G9hcW57BAK3GfbGVl48QmVl5
    wxez1SR1Oeg9sRYG8JM9tYeV6hY1QYlsIjOmrUdGGWpRlf2Uja7aX2Ve3caFR/Sk
    5jTeMb8K+j9B0bHovlG1TDG4MZfDLIWaVbAG6C6+pPt5WTtevNuM4wxLIW+OyfBN
    RdIusEcd6WN/7ZMU1pAZaB7dGhF0/Od2Ms2qJuGT3qykvlncqUc2lhMtnrpqKL/3
    OgQxA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH v2 2/2] staging: most: Indent function parameter.
Date: Tue,  6 Mar 2018 01:34:08 -0800
Message-Id: <20180306093408.17626-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302101221.f26ehzc6kvbowq5r@mwanda>
References: <20180302101221.f26ehzc6kvbowq5r@mwanda>
X-Provags-ID: V03:K0:mRjcc2Qmf5cNA1N4eNgtlgnLKUafg5eui2f3tybRG68fVLEOeKQ
 ZErr6fZ50CoFupo5u7LsNCGe+GszwEwGqxcq1qyiK6JjKMyqFeA6zUJAX8ZjiRA5jsyyMvB
 8yKvOJ/Mhy/uopJyNwrBM1wISWhk0xv7RxH7L/vPRiUYHIdcRPgVkVUhKxug0YXSgpmXjob
 nolqtiSEuyu9wB2aB5bJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1mST8wFSAU4=:wbPbmqhWVZ+0RjFhA06ior
 ZACQn0WMy5zBQULlR2MtzEFhgZnjrix5zfBAGCFGOgtURvS6K2ff1GWG93GP6DijQ3KYUmXQy
 fzdBK6BiT1o72ywA2othTnQoQMNBUQ9+yVUH96QEsTwsz8xyqxGAvVZiSPSkarWdNzdNpNs5E
 P44hJf3hPE626OdjUO3yk3oacWTZLtcgfZUxnypmFX2WRzOoiXmbDu6AuITKB8lXhxNfZJMX6
 vINP4XN/Tend+M9Kl0gTSdbLSRyx4SWkojahfNfkfductg6QDdxWLLmu5Ala1x/NjmIsihZFN
 SRTV2PBrT3e7tYx3xWBV0paZ+iBy6nMiu22aVEHnd6NHGmkEKU2szqjAxOEkC19dZ4b5j/IY6
 NqcHXXhrGiBPXz3iIyDlDONOMMurgR5JolCbC966H3/2+yw0/PhNB/+m9PWGRxw5tjLNcxnYG
 B67V7FRqHGkYaK7u8fhNe2RMh4iq5rr0uT6ddLYtvXi/lEqn2ABVr62WiWUkrhX1+TlHwbq7U
 u6Af93Ae9bss68yaNDPlzvsCJcpmSCf5nlXUo4fr9iaLa04vX5X9s9OywPdAyD+E1sCDiz2Aq
 7EEFtsCWNovyTfCK+LhNGKWILBn3JoRHl8mT1WIKzxsuo7HXlgzkdMlV0v5MzZS6CKcdGtFN+
 8qcVYaTBJDd20yylfwLAewj87vCWm2oDFhlOSKDH5sLRR3En9rAAc2WZZyIZIN2qIgvuG2k2U
 j0nDg0ormTXPf/6tWv7IXD4TmFtd+EXFLl0osw==
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
