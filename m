Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1227156-1518437599-2-10512299339420903497
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518437599; b=VzluRolHPvHCHBJhzQ1qJFaItLBGbWim+2SudH36dwrIUdJ
    /v6kDkN0gcK2BUIZCnP2Mj51uQAdA1rYY4qtumBMxKFQ8ki2XhpHjQXFzv8RSX/5
    M0+a8GV6f41TYVjbdFHb9PjITsAfA0mEwveGi53LquLkzpnRLHGWyNyQFQnda9NL
    j86l73n16Jb0oiVzOMkmDqmBxsZjHeJokOjzC185GGD7QOFpMk9+ssIRWlDlGcwL
    W9KS5NNeImnF2apTkwlRpqs3jzXTUK9qRdHld4ZovmNeZ6Av5hwKvjy5wUeCAuHa
    /J81O13qajLuKwCY8JIBBR6n4DUA6iSEiE1ihcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518437599; bh=F
    PwPq12epdr6nrClLoVaTT34pRgZ/ASxISOkkmxXwj0=; b=e3wsiUbGZbw5cnWWD
    l0lSEOT/MhIzWyrPgL7p5aHteR0ptEaJq8Yp5C/ZzpAPXwHKtCp5p5jaZ2QBwfXM
    9AI50qF7O2Th97UgUDTlvqya7F7s/QEZI/2oEJzNYC3pewXVAXbKgctnfIT8U8Uk
    hEYVRsp6HiEthD9tZxVqJbbhltLbei/xn7tNmal4h43JEQ4sdjYQy+ln8uhdtWmZ
    qyOriJXqrm7rmc6rqfwvieiTmxVbnJfmH7AzWi3BY1kT7YdEym8CTbr+KqHLJdax
    W0wE55v46vM7ZWZMdjzpxWHfd3TgYH5USJVRRLTBKiadUFeVeYwkmaDWDbSaYdas
    dNL/Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=denx.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=denx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=denx.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=denx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Auth-Info: Bgjhh1ynBQJC9SJqMfnuPerAB0zQ1msxa/PAHBXQnb8=
From: Parthiban Nallathambi <pn@denx.de>
To: slongerbeam@gmail.com
Subject: [PATCH] staging: media: reformat line to 80 chars or less
Date: Mon, 12 Feb 2018 13:05:48 +0100
Message-Id: <20180212120548.7391-1-pn@denx.de>
X-Mailer: git-send-email 2.14.3
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
 Parthiban Nallathambi <pn@denx.de>, mchehab@kernel.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a cleanup patch to fix line length issue found
by checkpatch.pl script.

In this patch, line 144 have been wrapped.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 drivers/staging/media/imx/imx-media-capture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 576bdc7e9c42..0ccabe04b0e1 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -141,7 +141,8 @@ static int capture_enum_frameintervals(struct file *file, void *fh,
 
 	fie.code = cc->codes[0];
 
-	ret = v4l2_subdev_call(priv->src_sd, pad, enum_frame_interval, NULL, &fie);
+	ret = v4l2_subdev_call(priv->src_sd, pad, enum_frame_interval,
+			       NULL, &fie);
 	if (ret)
 		return ret;
 
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
