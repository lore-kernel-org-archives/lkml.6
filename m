Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3274038-1524147307-2-2524232520788709788
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524147306; b=sdU57cmqrFpM72I2Gqi+wj03ABxDLudbRvCbKUxX5/lPim0r/p
    GlKp1WRfNwre1/eNO0xhCJg/mkbEllzHyXtnSI4MhVvLM7on/eDPqYsySXJE+l1N
    MzK+lv0GxXulHflrI4LcErtpoAkTIrEnR35QBuoW4EqzYS3yJkKbFGA1eSHO3OVb
    bhvZOuvTP2PpAkwLR5yMkoQ2kO+belBZY93hMPwvsWPQA1WoKZNtLtJJMzU+Gt57
    Uoum2GwsBkAYhfX0lwaL5QBHWoxXXsogXSKvO5ymRjLH4EqeONy30RW/qnXS4VwL
    Gw1J57jHxHdaSjuxHkgPTDvEcYUzH7uR3Mfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524147306; bh=+S9XW
    +Wiar+f4Nw3aGQD+WnhUIdMOoqZhnpVmIMdluk=; b=q7E2SE+dYPB5Zj0KgTxQT
    yw5lpH4O2Cp21aVItvKM4CGXMpSHEzR61LHcWwll0vprPbuGmnAAAV8DBzwrVR7g
    i1+q2a4kZsQO4sHDnVZTSNyvmhtjE5s1WO+mRLpoP7sVJ4oz/vc+3nJZKMZ7oJHx
    nYDL6qSpVYTTHPHdRDNaDrVoO2V71asxulM4UzvXix/qc7nNZFLjtIr5VXu7+Cht
    ThwRDm8cfFD1qaM4kvdEggHRpmI76JeeTwc80g5VBHRSTGBpezMIUVu5mL8BWETD
    ReVtk3rVdL/ldrh8RRT4iwctDawXA7LNzDq0u60Yw7j2jozbKmXjMr+x+QOZcpGi
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEAEylBxndBL1QhEpsLhDcpxXN6X2qPIPqOG1xVPjoAY6Zt5NCzd8NC77cvi4oqoE01ApNB7tCL8WxnDfUOk/NW7l9zG/ifBh+gr0BWf3i2eLHmpFjTH
    alGlIJKgLd0NkEP+oyIgkscdix4max8CsrmVjOCwvPOQGeePqoh73xD+8tHxVz7ysRDvApWSnujz9p920AzBXgsj6ZDVrEugg7gtMs0XhwmA/VhvWjksbYSg
    inMyz4mgxg8Bod5Y/wlPVw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=LDBv8-xUAAAA:8 a=DDOyTI_5AAAA:8
    a=TfsKkDOJGvE6wVcqPHgA:9 a=-MYuCsTrHuTGeAzS:21 a=wAw8_B8zwaMphcr5:21
    a=CjuIK1q_8ugA:10 a=DZeXCJrVpAJBw65Qk4Ds:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 48/61] staging: iio: adc: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:18 +0200
Message-Id: <20180419140641.27926-49-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel-janitors@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/staging/iio/adc/ad7606_par.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 3eb6f8f312dd..a34c2a1d5373 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -18,8 +18,7 @@
 static int ad7606_par16_read_block(struct device *dev,
 				   int count, void *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	insw((unsigned long)st->base_address, buf, count);
@@ -34,8 +33,7 @@ static const struct ad7606_bus_ops ad7606_par16_bops = {
 static int ad7606_par8_read_block(struct device *dev,
 				  int count, void *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	insb((unsigned long)st->base_address, buf, count * 2);
-- 
2.11.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
