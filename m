Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523851844-2-17409020270927761057
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851844; b=TIwz53gR7uTiGGPvs+400l5d0pWWFwna8+Yp07fK47/UIqEw5Y
    sUr3+ByzlxuR8THgPFVvjRgA1AiFZRi5WiirEPf3PcTFe+GTxXgfs5p1hA38ZohF
    ZWq3nLgIrnw0jRawsMhJY3BN2qDLNh5WmIynmJhxXFuVeu2QsIS0NER8PNt0/luT
    Md+JcswVeyjyrbdieLADIixB4IiSNYvVAZE1tHuYcZb5mv5ETyhqIxEK1lR/nWDf
    NtQOJ8X5cPSUPrq+Nga/O0r3SQ/kNbf5u4PwJm2tgkC4wruZFKaYYkC7jHq3xjqX
    OjjhHSB8QvcenzjX7l0b0h6ko+J0UKg2VTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851844; bh=hxHUQ
    e7zBJ9yeoLZgU18o/k6k5L1BRTpjey+6L+ZVeo=; b=MhRESDDUQIRt5Z9GnyiMb
    ACQMa1mesWLyiRb0oN4y34/XPor9KnsuLCqgluTC/eJ9WDugn8t+mjS3Z3Y/llYO
    bK4fKHhCm1TRXkgqjEuzNabWFKYfooJ/lO+NdQR2a6IU41u3H3ma1sAun/rFH3Q+
    /BSHRB+ERRuIkeL7dqOzJedd52ZcvaDfKN+usS3iJR6CrI41MuAoudGuQg2FI4jh
    fUQdd01sT92Cg9Dd1DDWooPYyvE28slCOsR2nbuM6yCC5uJ2R8WhwQ9Eb8MqN0MR
    9vZVmcLyiFFUjtShpcwFjzgWpwuQQsibw4sEl9aaUaosAjISBrjYVDyBixzyZLGt
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBNBOlOjvULYz6u+W7AoULBwC+4ppPXC4nAWaadEj0VrR7ZLmu9JXqf3O1d4MNTADDJpF1R8APjuVY6/LrMthcCtKzEFysN5tN7tpAaH6AtjmFfePIJ6
    62+s34M6pNJNfSe8qNrXNqFVRHCQEBNHoNy/eNOX3/k6nE14V5YhlPn3a3RjcstMBsBjrbtA43eV9NRBBqniwfgdAyDNkYPGATCGxFJAgD6jdHxnvqiLDMT1
    diAJqtO3aVdCFeX5cyejfA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=L1wxkR1V5OfEDU6ryuMA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 18/25] staging: lustre: libcfs: clear up failure patch in
 cfs_cpt_*_print
Date: Mon, 16 Apr 2018 00:10:00 -0400
Message-Id: <1523851807-16573-19-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
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
Cc: Dmitry Eremin <dmitry.eremin@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Eremin <dmitry.eremin@intel.com>

Currently both cfs_cpt_table_print() and cfs_cpt_distance_print()
handle the error path in a confusing way. Simplify it so it just
returns E2BIG on failure instead of testing rc value before
exiting.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23222
Reviewed-by: Amir Shehata <amir.shehata@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 435ee8e..c4f53ab 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -155,7 +155,7 @@ struct cfs_cpt_table *cfs_cpt_table_alloc(int ncpt)
 int cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
 {
 	char *tmp = buf;
-	int rc = -EFBIG;
+	int rc;
 	int i;
 	int j;
 
@@ -183,19 +183,17 @@ int cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
 		len--;
 	}
 
-	rc = 0;
-err:
-	if (rc < 0)
-		return rc;
-
 	return tmp - buf;
+
+err:
+	return -E2BIG;
 }
 EXPORT_SYMBOL(cfs_cpt_table_print);
 
 int cfs_cpt_distance_print(struct cfs_cpt_table *cptab, char *buf, int len)
 {
 	char *tmp = buf;
-	int rc = -EFBIG;
+	int rc;
 	int i;
 	int j;
 
@@ -223,12 +221,11 @@ int cfs_cpt_distance_print(struct cfs_cpt_table *cptab, char *buf, int len)
 		tmp++;
 		len--;
 	}
-	rc = 0;
-err:
-	if (rc < 0)
-		return rc;
 
 	return tmp - buf;
+
+err:
+	return -E2BIG;
 }
 EXPORT_SYMBOL(cfs_cpt_distance_print);
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
