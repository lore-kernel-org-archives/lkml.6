Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523852129-2-2456070434542660613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852128; b=KLfUF/yq//7x5lvJH3tBDxhcSnyGeSkdpfPILOC0dGtJ00hhln
    ajtnzJXKbu2HEx9+XUZjebnmcjFfKpQQOzCaJCtXTKWpPmj/hLg95mfMGVxPaOcp
    HVfzx6CU+4wImmK5e6hG97plw40J4LvMLIvb3NHqJa5g61NT3wy0md7H9ZfwwCqx
    2qXX7WFZEhwT+9LplT/PWsymJIw1ghp4umJnzIiHRRG2E/TOhj2GNF0ukWLB1JDB
    6f3VGTuVXsR1IujUinOK9K7EsPmyioMi0aiqnZn+HDoECOgj6xFH8ctuPDJM+7Mb
    VNh+JQE3N1HxPbxIPkmQvxPuwIcUFkTydiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852128; bh=dkkdt
    i0Qn2mY7bYZu793MKwvPaHufX+OFsdsClxKRz4=; b=uL7P7SsJ++AiK5HcBYOLn
    XwTAhKz0KSwANXZ03T/mtBdg8iNDsHao4jh1HOD1hLvUqgXzvcLNUSQ9CQhhEKWz
    W3GClx+5PFzYvv7ID7N5aRg0XY3T5bikALXPej6p2SO/g53wJ/oC7+AO9uaI2K/V
    AS61/UwL8RywpaB8kuuOQNCeRwDeryTKJguKQrpcPGEwCxwsWWNLVXsF/Ef9VCx1
    oLDntR0HkjKqd0ghR8BRaQnKNn5eIBR/Cyg5Gvzq5Qg2QSBBaXElRjnHK3gzpaGf
    Eiz6JeNZ9zFfAusaxCf0BaqiUXtaBVmJJDwZfQtXYDwEaUlu7rSPZZzZMFbbKhyN
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKYMGvCC7vM1Lw04AuFor6pjLYKFUm0T/i//K+J4MOrYAPbjCZlvcHVQoIW/Yfd7Wj8YV7WTfGFNEajC7FNUGbl4a6RDZAVeNbxT6iJMeyBLN137y34+
    cv2cQ5zo54pkRrM1Yzb0SjdXUZZBzEQe9KXKEJLL4jdEI+3Lf6qnNTh+SXGOsWurRV0/VKmxDB9DIm+gvw4VzCdLrhZa6Lul9dpWhI3kyhkdzW2sxUKSDQNv
    d/PBeY8BKMZbF/b5i9cMVQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=eXjRu-w9MFxI4Pyyph8A:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 09/22] staging: lustre: llite: break up ll_setstripe_ea
 function
Date: Mon, 16 Apr 2018 00:14:58 -0400
Message-Id: <1523852111-17321-10-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
References: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
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
Cc: Bobi Jam <bobijam.xu@intel.com>,
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

From: Bobi Jam <bobijam.xu@intel.com>

Place all the handling of information of trusted.lov that
is not stripe related into the new function ll_adjust_lum().
Now ll_setstripe_ea() only handles striping information.

Signed-off-by: Bobi Jam <bobijam.xu@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9484
Reviewed-on: https://review.whamcloud.com/27126
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Niu Yawei <yawei.niu@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 37 +++++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index c1600b9..78ce85b 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -186,22 +186,10 @@ static int get_hsm_state(struct inode *inode, u32 *hus_states)
 	return rc;
 }
 
-static int ll_setstripe_ea(struct dentry *dentry, struct lov_user_md *lump,
-			   size_t size)
+static int ll_adjust_lum(struct inode *inode, struct lov_user_md *lump)
 {
-	struct inode *inode = d_inode(dentry);
 	int rc = 0;
 
-	if (size != 0 && size < sizeof(struct lov_user_md))
-		return -EINVAL;
-
-	/*
-	 * It is possible to set an xattr to a "" value of zero size.
-	 * For this case we are going to treat it as a removal.
-	 */
-	if (!size && lump)
-		lump = NULL;
-
 	/* Attributes that are saved via getxattr will always have
 	 * the stripe_offset as 0.  Instead, the MDS should be
 	 * allowed to pick the starting OST index.   b=17846
@@ -234,6 +222,29 @@ static int ll_setstripe_ea(struct dentry *dentry, struct lov_user_md *lump,
 		}
 	}
 
+	return rc;
+}
+
+static int ll_setstripe_ea(struct dentry *dentry, struct lov_user_md *lump,
+			   size_t size)
+{
+	struct inode *inode = d_inode(dentry);
+	int rc = 0;
+
+	if (size != 0 && size < sizeof(struct lov_user_md))
+		return -EINVAL;
+
+	/*
+	 * It is possible to set an xattr to a "" value of zero size.
+	 * For this case we are going to treat it as a removal.
+	 */
+	if (!size && lump)
+		lump = NULL;
+
+	rc = ll_adjust_lum(inode, lump);
+	if (rc)
+		return rc;
+
 	if (lump && S_ISREG(inode->i_mode)) {
 		__u64 it_flags = FMODE_WRITE;
 		int lum_size;
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
