Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-10225-1522302759-2-6775298132317770532
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522302758; b=t8yH7ZhkZUaIJOfmm3Fo0ZGtg6AxdmYN0n6TwzlsPUs96Xn
    dpn282TkAxVca3mh4HV+TD+FG1wLfP6u/Dq2fnHjjjl8z60fdGZcYUFmX8DQEt7P
    /KIfiyZ1kDGL5MPMQxBiNqeMtX6fs5HACWVzRs2+UNgysiNAXExZiw/avd0X/c8p
    4v1XD+/liQ5Xlu0oq6lrCpmPSOGgOTHM2px+UWUhLTbKe+GpfZIo1SZYRAqNPCFy
    gQWwBuogaQxgNwSVJGpezIdC/drtWD4vQp8j06aqe4UqRwC4F5VJHU0EAry0nSKJ
    /UtYs1SQDp+gX5iwsGQjunenVZ/6OGwaDrSZknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522302758; bh=3
    nIHhXW5T9/A1bn23aKheuqCqQvnSKiJOmvjozg80D8=; b=nZgy87sU9hYn+QrFZ
    wuyy2ziLbX1gDwc2V4wQt2wH4YKZ7eOV5Q2UPbj25+lVBcT71x3kiv9WSPv3ymZf
    zO71sB+rnI3FkrI4JqTIsy3N1Mjk9Yv7YQSRUUlfMk3aAgwe1cmtJTwHjG0WVD6K
    Sr65sJp9JDLwiZMx7/wAbg7hgcrhDRfX2qNosV+wbZNeHJJn3H9Z1LL72DGIvDpG
    JZyJlZcBTGBkTTRPerh0DOXQ/Gvnh8DmQC4KQ6eYk6C+At3RW0rNZFqtTZUnKzmU
    a+kWIYlY5+AbOYe45x0Ou3DkudREtRYrIPAiO0SEEYm2Yu9OU2/40hbaGJROgZUa
    Xcd2w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKy1Dd9zy7ACocnKmQqyqRHxHVNxdevIau+vC9DKLsKEqQlsjkVMshhIo8oqCdCOKKkGbVN+Ij1ziexOwqirDtt2w5xFhOqyCArH/1RoMcL4BOqPsJdg
    qfjCGKE03hkR8CXxeXbz/Lw1iAOpQ3SrPggF/LoqDu3ISd+m5zG400S7TH8Et3Tyi0/WKRDM7D22S2N+DMtATU9pl6wMdAlnjoeLcl3VhHMW3xdp54bQJH53
    +nUBwub4rbmSU4KDtaZuQQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=xg3qtUn-kyI1REKnmQwA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 9/9] staging: ks7010: Remove extra blank line between
 functions.
Date: Wed, 28 Mar 2018 22:51:52 -0700
Message-Id: <20180329055152.13059-9-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329055152.13059-1-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Aiah5f8io+fIsUjeoeDC88qkr4tEB2DHJB7aH205oBSM7gVKcKv
 4PdroO+W4F00hu43Dv2iK+m6V3yxC5uQ+dSfaPGjXwqV7rfsOPmS2OMn13GEMPxxICcOuGn
 ShCh4GJypm3gvELjLJLuldKu/KYQKjzjcKvPM6rF3nPq6cYNMHRErUXcI3R96WJx/Vb0fHJ
 Kk5wlFGWmaKMEM/h9ZV6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tmxI5NlRXZw=:RMRcgfQ37Ci5OkZl860FBT
 ZhWRqNQCjvlxixgYKJxFibPsNEtGH0Hed9Usdn3sZ7aUVRyWD6U8+VRZ43Ha2AuPqtXH3Wkkx
 NYsK75O3ad9SYPdIlDHh8Uy6nVL/2qcft6mPrTpoz08GEhmI360AxMgFxwEqf79ZV5Epf646V
 J5ItNtPdcvFNGck3LcABYkOolZpSsw5KFJpyAovV8ycC5IYf0VGLgRDN04CR3lO1nyrYtqqIC
 agJ0XRpWtvYj251IkIHQJ37nlyvWF1ijbEuFX4VyGO5T/4UaPJIjgKlWjucOxYOQCk0ZQqIBe
 Oq1ftyGkMQWB/borWWioH8RrYr9gAqT3ZZgOdSIhIL6wX65ardMAtm3Xg+pAIg67ZUPs8FFxP
 WSWHY5rUU2wgZSwGxg9Uhdu/5ZZML7rENFbN0gWhCVOeMw51p/U3VxEn/J1tfTsf+oEBYIVN6
 RP/VzX2AqYRcCiOry66dJjTtbOVT3QTOJX8t80ER46N+MaMq9bJL4re2I3Z82LNMZlgVVB4zP
 Zikz6KDZBMTq0SDbPVuUOqtUk9v/VWlXKmtRERjQ6rRFMZyefoVtgnYx0k+HvYHR6QdxC88CL
 lVnEcOhNlpwPxQpPiDD23uDQSYg/pSkbr1fk+NRibWiXZKhXF8/sYdyZT0fBFZ50bTeT7CsvX
 NP8mBonBhfZvPkOr2KF4XSd/28rs4JyNibXO+ZSkPxWgCrClMx621o5slSRSBnIoh4arfkiA8
 U6lK3y1372DsOlBCQaYfZFiGVbDIDHJiwtKVlA==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove an extra blank line indicated by checkpatch.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks7010_sdio.c | 3 ++-
 drivers/staging/ks7010/ks_hostif.c   | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index d083bf8d238e..930d1f7d7dbf 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -305,7 +305,8 @@ static void tx_device_task(struct ks_wlan_private *priv)
 	if (priv->dev_state >= DEVICE_STATE_BOOT) {
 		ret = write_to_device(priv, sp->sendp, sp->size);
 		if (ret) {
-			netdev_err(priv->net_dev, "write_to_device error !!(%d)\n", ret);
+			netdev_err(priv->net_dev,
+				   "write_to_device() error (%d)!\n", ret);
 			queue_delayed_work(priv->wq, &priv->rw_dwork, 1);
 			return;
 		}
diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 7bb0a6dffe61..de68dbdf7e2d 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -221,7 +221,6 @@ static u8 read_ie(unsigned char *bp, u8 max, u8 *body)
 	return size;
 }
 
-
 static
 int get_ap_information(struct ks_wlan_private *priv, struct ap_info *ap_info,
 		       struct local_ap *ap)
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
