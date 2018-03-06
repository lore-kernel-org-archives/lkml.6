Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4059601-1520327929-2-7330399440379317384
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520327928; b=gGzhNdFT65WgTmoLsr8obETkyZI6jOdhVi/6rXM52iMAqcW
    Nt3cLs4oJC4pY3aXbqc4lnN5Isa0BgOspxi/VAsP9gCkuJ7NcY3axupSL6Gu/8zT
    iOVj+l6nShjUbjbFH4fKarmUR0Ik6UCcVW9hkFapQHYNL2LTSOT9wmNJxmldbVlC
    PRLUquN/8sBQ330Llcboga6vRd/VMJTLdAd9URXzc+xOEso4Lvuv5TEqzSGT2UdS
    imhiknA41ESyGKsqNQdlkwFtdxomDC01EYrfABbf76rlHfq5PPtqycFYl+WcFqCP
    S3JFY2SEKhfJfKR2FAGnAhBukG4hM3wre9TQEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520327928; bh=T
    wuvVorD6ne82tXrYMreBoUpnrhDOwuBv7FgJmEhADo=; b=NErKZicvmf9XrtV/7
    ae4+2Xb/4w0IEIBDiOj+xOi1IZM0Bh9+/VtgnxbEOE4C8rbl4xxJTwYcJpUuxZb3
    iUKtEiQr9iW4vdvXRILQjT3hpGRuIBJj9JIkWy8aPOQM3S6+kdkNo9+VBaXn1LKt
    hyPvRE39ev7Fh0DkfzjOsh5vFbk9ghNgelYPK56pMBPU8d1p2fqENzIORvGehRt4
    nmTrngrhyeyTXK7NqjMkMvRyxPM04Hf6SwDC8jurbZjUGpTEFZ8pPNb9rP1P9ZNI
    qR6DFZDbAnGNT9Sx6owC4cePIOIaJA8VMXK9zC/VoZasmIKBGvpK0t2LftT6iVyZ
    +4R8w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH v2 1/2] staging: most: Add a blank line.
Date: Tue,  6 Mar 2018 01:18:02 -0800
Message-Id: <20180306091803.16689-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302101221.f26ehzc6kvbowq5r@mwanda>
References: <20180302101221.f26ehzc6kvbowq5r@mwanda>
X-Provags-ID: V03:K0:6e0PPCW0e0L2zS9curBbp9iQtFERY6+VcMQ/yRHLO1V54cV8Nh/
 yH38MVOwCDa4PIwN6lZE1JxqJZSCJYNk+LEzSi1v152oaXrLR94GLuXtTzpxc7iOVjQ4i+c
 aRIgeHH4AHDZ9qdTl0kWWqIGXr4b4UhsD72UAX6Ys7DWtNjOwyTfeD5eLm8zq03sDLXXJA2
 l6kjzSLtiRVW7yO609I2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/EMwGYZlOIc=:ZgMVreGwH+zEqjxbD/iJKZ
 yI6VwYXaDI2yqdBGKrdsLOUeYMEfQfwHYVU18H7xjGvAiYkg/SzhL/WCl0nzTsItUCF4saFc3
 BXjWW4FkeIBK/0ZjkB9ILvKtXKvIdhYLvYbb7HS2c7qovYT+DMF8I2U2jsZD0/tQ/YxH0t8ZH
 W6vAkNRGrC73Jgxl+x9LL6wtJY41fqQ6g3wNfLr+DA/Iq2xVzKe1I66Q3ldAIhORMDzDydqlk
 oElncKIe1KqwajsjcZQ4dTAzf9w9ijhQDQNVYFU3KTAYDMsEFP6Oj/unIdPPafTzOfoZtjU2m
 nK5sgCIX8eEBShqNDGJE7vDrjbZ57wWktsJw13eB7k1/6REgCq+nssjDqTLt9XkS8PXV94UAA
 sjrUdsf2Qzeej7SEW++QGAgzwFUtFyik43w75YbgI/XQBfojOJ36AAFMqzAyC3HfKpkiugUgN
 rff3Y5udokGa4WSyeXycMlO6+kiLSFSgPGirBY/RekiugMXIpxoXeHLyXgBerW0TdgTCLDoqi
 Rc9SUH1Cdie6gZwJwXkjbeWA5QM2cl0elHfaumuBwSfCs/NgLX3nUKfLxuDgRrM2gRYyfTfL4
 bUJlrrz8pHtkticcLchyRiAi0EDqTgn1UNMCpwGUcXwZkF6aLeZf2PkZ0td06tkLY2IIY47J2
 Vp84aZQolTbfwn29sYUwk5MAdA9G8igUFkHTi77BuPggJVhdgBu5xfL2G9wUeZB0cA+U+AHM9
 k3PVCIDN/arIFiDiYCoczyN+pCbn5gXNTAWzyg==
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
