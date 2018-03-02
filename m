Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-229752-1519956738-2-4930908471105660408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519956737; b=hTVxev55x899o9fo+lGLPjwGj15lWVXxB0/6j1GPNtd6tPt
    M1p9vOybZwkH3uojABxluL9kDsF0NxBwTzgPlPfl89rFYFT+4yl+4AS7mGzFus1m
    KXmt1XPvgWTGEfSxdsHsxAOyqcMZ/Wqas0DIRDZ4Pybqo0TJsHaliUQbDnIJuoT6
    9qGovBLCjAYFXduh1X2oFseugR/8wcZ2W6zXO5ESgy4mOMVTzOjARGrgss3KgK2b
    oE+Tnr5s3NYQlN7C7AYEjnqBG1cnxXy68wlO3TGQLB2ZVU8rK6FrQ9eiy7gAeNtf
    30ib/rxyjKgYg4f+Km4FYLRURdlzXklySa9bY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519956737; bh=T
    wuvVorD6ne82tXrYMreBoUpnrhDOwuBv7FgJmEhADo=; b=Z82ObDbagtz9EozMp
    PJtBv22E9JTh+7b6FRvS1AKFhuMqZKXEK2IV2C7baMK7RRpNshWD5qmewfM5kyga
    3OeDzoA9jIKi00FmsNBqHkY1w9nC1QGaT62GK6gecRVa6w0CgUBBroqf/5o1B1As
    T9McqbbdWuNdrcQiDCHPSUG7unab1DUlH9pntFZX5JXCHucjhdsyjQzoAzd2vztQ
    ViemKxzfiLDxTudUPg9Z9Om8ihe2ulw8Ocq3cOZWO/SI6O4xHzDiOye/9QxTCGm3
    dgs8/6/yaMgSYOfTIbQESu8jwL6iVydg+4ouEWrUbaXTzffzdMTdPjBsf85n6DHS
    OslIQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
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
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 1/2] staging: most: Fix a coding style problem.
Date: Thu,  1 Mar 2018 18:11:43 -0800
Message-Id: <20180302021144.10795-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301162034.GA15087@kroah.com>
References: <20180301162034.GA15087@kroah.com>
X-Provags-ID: V03:K0:e/BQx/jANVLbwPjzMUyoAPruyO4xa6DdQPgfYTCIS1OQieH2aBe
 C+0RSoi4MVYhdBswB5lY71v5gepoUs2Qcqe61jDtwZdacEVh0VMssSxaovta2oPKRdr05mp
 LHY8TjEBB6pUGZOsT205TMtNVikIKtGypISIMD8D5UdE6+VMreP/kfbx9cb7Ac9FBkr3NV0
 iM1Iqvh/mI8Uq/NWYp7ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n7RnU5d5gDg=:Oeme/wAmoksiYijIYBkA8k
 mUmV9TneMn+nQdOXYH9pHcXoV7+8vcxA8BWwflNI1J24aPxLnMG8n6Umb+RkkIedZfVY5U/4G
 bSQ4rXa3F86udg57SNKgeeSDQ7wtmbmE7piIB/Mt3y9Msrxyqq8VIJhGjiviSLGTLWvb8Z/y5
 KslDGdh3waDe2+Bji1Gn9MmQJx2k6T7Sufzj7qU9t2/RRXM5je0pQiDNZIE3y/ux4KivvBP6s
 bepjIWTRniYTPvyabK/Ddejr/Ued+2S/8UxjB6GYFmL22BGtdN5UvW6OEMuWQ50aDL20BaMVb
 me9IrKq91sGvtcyEhW6j71J1yby3wXtdw123Wr2r/a2H0dHZePGf9DcOBpOqHwftp+dVVI3D5
 3XIms+XFxFED4lkwhQ7ZBkmC9Jp+iDAcwhuJgS2Am++ymVTBbIgNtPobR3Imjbe2ezI6m0+Q1
 +7ZN2DNSPuCn/z2+IwkuuIU/xNRlIZkHqj99EW1q3B5XUmon5FmIMemKvRyw4COvI+GG6cmZq
 9nIi4PsTiSg+Ze8ghybzJldnxhUvQlqZVMS1wCYhIP1M3xyA5K1Kiu08dGL0tbN1IONEIfjxz
 XmZJ2t+bu2JUNbxgU79bpElMqe1QgBE3L01mPsVBAiw1OrmVwsnslQlzw6iIgubBW7tQwYh1u
 Py8ZW3gl+rhDZzmgdWjK7TajSsQuafTdDTj7sPdsQe2ExIqrmXieNB06Z5wXNLYAXxw3QnY8F
 xifxUBHrKswOnP/SnB7M3PRtdKWigjOMiT/wdw==
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

Use a blank line after components_show() function declaration.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/most/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 0ab2de5ecf18..67e2d7f29967 100644
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
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
