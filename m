Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-803568-1519459157-5-7486879234609822612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519459156; b=Ym+scgEfeOgEweqD7HJ95hDPiCuhICPAruP6YlYuqYO/2mg
    h/npZvhzJ/QcqrqilPZb5fSXlXP3smcW7pOWSZRjyqxAA9oihtwKcBKqNY13C0lz
    v5RTbFXORyd848VMS/cObNMQaNn+PNtFoJJynJU4Usr7xRp/5JtdBxL4K9d0cjc1
    FClktky3aFzLsf9i5jN0pB8K2Mtag/CW+2KKN/YhB/9E7Nj0fKXoZvh40lRmzBZH
    +JByHt5FjY9D5fgc5YHyt1f8vJsWyigv/Acn2so0aLzWNA0EdBzyj/rlabpTAwlb
    eBEiULAsz97KWOete8uFIf3UQhBRmS/FRZvooEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519459156; bh=F
    Z/hlDs0FN1sEE8o/y1XwjMEYxarNJWCEj1p+fxbfR0=; b=MnmMNjCdC/Wh0YGGG
    g13AQVe8cjYUSVstwxn0HgSvfB2HtSolpGJBIaHGGYaPQ9TrJTKGijj05q3Z+wgI
    aabPbzms7hV+sneRNQkEomu+mwnL+AggOjRnxX2JIK2f3YH5P8CbJFrj2cMN4cuC
    eMtOb/0WtWbHGWHRSE+lvfOlWL/bdHYYvd++h0emqupww0H8ryuveEbhbotcyNg1
    6e04uMY6Hl1Eo1sGdb/Ttc2fiW8WqOFW/jMpzwAWxOdUIkq5jrY4vvgxGH3PerQT
    iYK9pJIdShexksKYv93PlI7dWU4wmfw/XYB3DB2CpEL2xt53o0eycerO4CnFcXM8
    cIT/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	christian.gromm@microchip.com
Subject: [PATCH 1/4] staging: most: Fix coding style problems.
Date: Fri, 23 Feb 2018 23:58:32 -0800
Message-Id: <20180224075835.11618-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:VWg8Ow0FKtbs1N1M9b07fmT6exJ2nI+teZv09+LHKP4GOwpfELO
 9+fQmyNU1kLGcmcSEz9g8spA9VAKNOv4emp8HLSnwgaSJGp7dqPdn3N0rKIyNJ3OtZ0fX74
 dHbcK6bxuWGQcnEzCVXLV+ADfcsRSjo1eP2bUQXQucGVpmKph2pU0FwrAup4PsLXUBO4znZ
 /HJluJzVeOuF71ZUrAwKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z/43aCC7Yg4=:WYCr5FCfqnAe9eT3t1nJo+
 s8PM667IjZ8gh+v3OX83jNme2hsfvoylNhgb3Lt/a5nOk+YFPhjN7VLncpR36cSZngAN4xGYi
 NhxBwFQ5wYWji2FO8KTnvpx15GVbuvXMwwfxauRWRgu7RJqT0TTR3Cn+P1GlSkV9IxkWnFqye
 PonUGhtUJwNlMlVFa9Vi1t+12++gm3j0C2VTDF0E/yMZNtPMOlkYJD/MdExwWz5MgDpLqM3OV
 16agxgxlt02wzUetW2SWhdH+LPY/ZQKCmxI3XgptftMIuGS7Orx033p8GYNxzYo4bzCh2ctot
 a55oMiQTMCAx//0p9vQ51j33bfD+BXeESfqVMXMedZN4YGSF4I0Hnb+K9JSOjiohT+uKwqvnl
 VwASSdNPL5TYUhcJwOXkNoPckeqMR/XEbwwWv5n8ZMNpDtX/dGQ7UGqJ0OxlvqwKq/u2+WhHA
 gnFJMkX6A4k1LlpSsA7pDFtt9mvDtfA68dqEarYIKpuVkN+z8XF08zdRiTJlgf2kt8Vzrp0OP
 hMws+FIbvY+e6orodGyorfHUUZXJdtwjZsR8ViHhNiZszPWLfJOuFAwhOrFX21VJ/gPwGmjaR
 BarWStKv3rIk4bj+WKfGVq4tRnTFNjA+0aP/Y52Z6i++jAB/ltpfaytowb9nDQ6vDyHn0PSJP
 0+Fcc/Tx7d0P6/nAKV+Z+l10ycEsT4f0u6qLq0cfWmFgUZlYftzPWYr73UBeI7vQhwms5NC1T
 9ekVWlpeyXr6h7b7x2MUtDees99Aq/iQOYuh+A==
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
Cc: devel@driverdev.osuosl.org, Michael.Fabry@microchip.com,
 Quytelda Kahja <quytelda@tamalin.org>, chris@engineersdelight.de,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Makes two very minor changes indicated by checkpatch:
1) Add a newline after components_show() definition.
2) Fix a line over the 80 character limit.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/most/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 3dda8d81bf0b..18157dd80324 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -583,6 +583,7 @@ static ssize_t components_show(struct device_driver *drv, char *buf)
 	}
 	return offs;
 }
+
 /**
  * split_string - parses buf and extracts ':' separated substrings.
  *
@@ -1474,7 +1475,9 @@ void most_deregister_interface(struct most_interface *iface)
 	int i;
 	struct most_channel *c;
 
-	pr_info("deregistering device %s (%s)\n", dev_name(&iface->dev), iface->description);
+	pr_info("deregistering device %s (%s)\n",
+		dev_name(&iface->dev),
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
