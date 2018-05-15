Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1731937-1526350638-5-9891465336812751679
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526350637; b=DHzxfFq3sTb51Cz8NiZjy6AeQe8S5oPxF0VTEFoYIeEoYOPnED
    qhfCBueDzei2YR0nRkuXdZOPRGpIj6HFpkCHqAeiv+95b1Tw5m+Jti2Nu4jioUVh
    QWSNnZ6oa4KDbF5T9JP95TfwCFJDa/FXrzONhyFv060OYja/FkcU+7asflNcoYbF
    zZGAewrjY02pzFX3QxdSbG7op9ApbGRwPo4vcS6S9mm8oaWW8881Daj2NM+6Us4w
    8AYifzVGMSi6F00GrPWZL8VWhwU+9HXxcB9u5IU75bm+XjMMkQgLtKgOh9WRyzXc
    DSpL7TEDAOVk5TZwng9SPuaevU7X10PA4NEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526350637; bh=uSWqa
    b/gRQaciIiJmalidFqc/1kVFsQu2PVN2eB4G5A=; b=jq/u+zgwyVggVbKYfjDbA
    leQ3S94crkaqODVSs2NaeDKzqj/xflToJ6wOCv9bHCPCVV68ZzPLWIvYV5N+IM+D
    cy0tYbWOtCAv8+jqyg1vopvbQRjuNjuG56vj7hPEJtneqe0oGAmUGPfuzD+IwTy8
    O+W75+DvyB3qJVx1EvOJqt2GZjVqn2Eq+qmoNY+jyGfdaFuV1TpC7STAmIJoNtkm
    S1wCI6kCPitDG+gWCgIHVq8MMLL5gqXBiqvSpKjPezxbyg6mVy5Ft7DLAHXoy1PK
    ssxhpMPX6Tzis/2tELL+vfE74vpdjEEJLfcpKE3OQ5qGniO2QnRpQQ09MvEvQTw3
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPxo7s3vvkxLCvu4csdUXly9NIu9d6awThQS+Wra57CYm9Dx8xDazvXFEn2bz8Zs3O1sbMpRGA7/hJ4VMXlXfeDrSO3eUZzIfzlvwzVaRT3YwZlBSWUG
    3GFIhaROghp1ycpuAY1nBK/H6hT6LeBZK/MWYH8xCsXLMmNXqruEqCXZWpmIK+QvrLGoqgXr2pCMgSawgt+USO9i+fdKWEY6M2O9eWvV/utIXjYHH5CBz0Mx
    VFclLif2Cl2rSEURyzh/sQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=lB0dNpNiAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=cxoYFxPdgCK7NhDY_vMA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=c-ZiYqmG3AbHTdtsH08C:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 3/5] staging: lustre: acl: increase ACL entries limitation
Date: Mon, 14 May 2018 22:17:01 -0400
Message-Id: <1526350623-4616-4-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526350623-4616-1-git-send-email-jsimmons@infradead.org>
References: <1526350623-4616-1-git-send-email-jsimmons@infradead.org>
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
Cc: Fan Yong <fan.yong@intel.com>,
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

From: Fan Yong <fan.yong@intel.com>

Originally, the limitation of ACL entries is 32, that is not
enough for some use cases. In fact, restricting ACL entries
count is mainly for preparing the RPC reply buffer to receive
the ACL data. So we cannot make the ACL entries count to be
unlimited. But we can enlarge the RPC reply buffer to hold
more ACL entries. On the other hand, MDT backend filesystem
has its own EA size limitation. For example, for ldiskfs case,
if large EA enable, then the max ACL size is 1048492 bytes;
otherwise, it is 4012 bytes. For ZFS backend, such value is
32768 bytes. With such hard limitation, we can calculate how
many ACL entries we can have at most. This patch increases
the RPC reply buffer to match such hard limitation. For old
client, to avoid buffer overflow because of large ACL data
(more than 32 ACL entries), the MDT will forbid the old client
to access the file with large ACL data. As for how to know
whether it is old client or new, a new connection flag
OBD_CONNECT_LARGE_ACL is used for that.

Signed-off-by: Fan Yong <fan.yong@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7473
Reviewed-on: https://review.whamcloud.com/19790
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Li Xi <lixi@ddn.com>
Reviewed-by: Lai Siyao <lai.siyao@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h | 2 +-
 drivers/staging/lustre/lustre/include/lustre_acl.h            | 7 ++++++-
 drivers/staging/lustre/lustre/llite/llite_lib.c               | 3 ++-
 drivers/staging/lustre/lustre/mdc/mdc_locks.c                 | 6 ++++++
 drivers/staging/lustre/lustre/mdc/mdc_reint.c                 | 2 ++
 drivers/staging/lustre/lustre/mdc/mdc_request.c               | 4 ++++
 drivers/staging/lustre/lustre/ptlrpc/layout.c                 | 4 +---
 drivers/staging/lustre/lustre/ptlrpc/wiretest.c               | 4 ++--
 8 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
index aac98db..8778c6f 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
@@ -615,7 +615,7 @@ struct ptlrpc_body_v2 {
 #define OBD_CONNECT_REQPORTAL		 0x40ULL /*Separate non-IO req portal */
 #define OBD_CONNECT_ACL			 0x80ULL /*access control lists */
 #define OBD_CONNECT_XATTR		0x100ULL /*client use extended attr */
-#define OBD_CONNECT_CROW		0x200ULL /*MDS+OST create obj on write*/
+#define OBD_CONNECT_LARGE_ACL		0x200ULL /* more than 32 ACL entries */
 #define OBD_CONNECT_TRUNCLOCK		0x400ULL /*locks on server for punch */
 #define OBD_CONNECT_TRANSNO		0x800ULL /*replay sends init transno */
 #define OBD_CONNECT_IBITS	       0x1000ULL /*support for inodebits locks*/
diff --git a/drivers/staging/lustre/lustre/include/lustre_acl.h b/drivers/staging/lustre/lustre/include/lustre_acl.h
index 35ff61c..e7575a1 100644
--- a/drivers/staging/lustre/lustre/include/lustre_acl.h
+++ b/drivers/staging/lustre/lustre/include/lustre_acl.h
@@ -36,11 +36,16 @@
 
 #include <linux/fs.h>
 #include <linux/dcache.h>
+#ifdef CONFIG_FS_POSIX_ACL
 #include <linux/posix_acl_xattr.h>
 
 #define LUSTRE_POSIX_ACL_MAX_ENTRIES	32
-#define LUSTRE_POSIX_ACL_MAX_SIZE						\
+#define LUSTRE_POSIX_ACL_MAX_SIZE_OLD						\
 	(sizeof(struct posix_acl_xattr_header) +				\
 	 LUSTRE_POSIX_ACL_MAX_ENTRIES * sizeof(struct posix_acl_xattr_entry))
 
+#else /* ! CONFIG_FS_POSIX_ACL */
+#define LUSTRE_POSIX_ACL_MAX_SIZE_OLD 0
+#endif /* CONFIG_FS_POSIX_ACL */
+
 #endif
diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/staging/lustre/lustre/llite/llite_lib.c
index 83eb2da..b5c287b 100644
--- a/drivers/staging/lustre/lustre/llite/llite_lib.c
+++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
@@ -198,7 +198,8 @@ static int client_common_fill_super(struct super_block *sb, char *md, char *dt)
 	if (sbi->ll_flags & LL_SBI_LRU_RESIZE)
 		data->ocd_connect_flags |= OBD_CONNECT_LRU_RESIZE;
 #ifdef CONFIG_FS_POSIX_ACL
-	data->ocd_connect_flags |= OBD_CONNECT_ACL | OBD_CONNECT_UMASK;
+	data->ocd_connect_flags |= OBD_CONNECT_ACL | OBD_CONNECT_UMASK |
+				   OBD_CONNECT_LARGE_ACL;
 #endif
 
 	if (OBD_FAIL_CHECK(OBD_FAIL_MDC_LIGHTWEIGHT))
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_locks.c b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
index 253a545..65a5341 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_locks.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_locks.c
@@ -308,6 +308,8 @@ static void mdc_realloc_openmsg(struct ptlrpc_request *req,
 
 	req_capsule_set_size(&req->rq_pill, &RMF_MDT_MD, RCL_SERVER,
 			     obddev->u.cli.cl_max_mds_easize);
+	req_capsule_set_size(&req->rq_pill, &RMF_ACL, RCL_SERVER,
+			     req->rq_import->imp_connect_data.ocd_max_easize);
 
 	ptlrpc_request_set_replen(req);
 	return req;
@@ -352,6 +354,8 @@ static void mdc_realloc_openmsg(struct ptlrpc_request *req,
 	req_capsule_set_size(&req->rq_pill, &RMF_EAVALS_LENS,
 			     RCL_SERVER, maxdata);
 
+	req_capsule_set_size(&req->rq_pill, &RMF_ACL, RCL_SERVER, maxdata);
+
 	ptlrpc_request_set_replen(req);
 
 	return req;
@@ -433,6 +437,8 @@ static struct ptlrpc_request *mdc_intent_getattr_pack(struct obd_export *exp,
 	mdc_getattr_pack(req, valid, it->it_flags, op_data, easize);
 
 	req_capsule_set_size(&req->rq_pill, &RMF_MDT_MD, RCL_SERVER, easize);
+	req_capsule_set_size(&req->rq_pill, &RMF_ACL, RCL_SERVER,
+			     req->rq_import->imp_connect_data.ocd_max_easize);
 	ptlrpc_request_set_replen(req);
 	return req;
 }
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_reint.c b/drivers/staging/lustre/lustre/mdc/mdc_reint.c
index 488b980..e1e26cb 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_reint.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_reint.c
@@ -134,6 +134,8 @@ int mdc_setattr(struct obd_export *exp, struct md_op_data *op_data,
 		       LTIME_S(op_data->op_attr.ia_ctime));
 	mdc_setattr_pack(req, op_data, ea, ealen);
 
+	req_capsule_set_size(&req->rq_pill, &RMF_ACL, RCL_SERVER,
+			     req->rq_import->imp_connect_data.ocd_max_easize);
 	ptlrpc_request_set_replen(req);
 
 	rc = mdc_reint(req, LUSTRE_IMP_FULL);
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_request.c b/drivers/staging/lustre/lustre/mdc/mdc_request.c
index a90647a..77cb699 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_request.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_request.c
@@ -181,6 +181,8 @@ static int mdc_getattr(struct obd_export *exp, struct md_op_data *op_data,
 	mdc_pack_body(req, &op_data->op_fid1, op_data->op_valid,
 		      op_data->op_mode, -1, 0);
 
+	req_capsule_set_size(&req->rq_pill, &RMF_ACL, RCL_SERVER,
+			     req->rq_import->imp_connect_data.ocd_max_easize);
 	req_capsule_set_size(&req->rq_pill, &RMF_MDT_MD, RCL_SERVER,
 			     op_data->op_mode);
 	ptlrpc_request_set_replen(req);
@@ -227,6 +229,8 @@ static int mdc_getattr_name(struct obd_export *exp, struct md_op_data *op_data,
 
 	req_capsule_set_size(&req->rq_pill, &RMF_MDT_MD, RCL_SERVER,
 			     op_data->op_mode);
+	req_capsule_set_size(&req->rq_pill, &RMF_ACL, RCL_SERVER,
+			     req->rq_import->imp_connect_data.ocd_max_easize);
 	ptlrpc_request_set_replen(req);
 
 	rc = mdc_getattr_common(exp, req);
diff --git a/drivers/staging/lustre/lustre/ptlrpc/layout.c b/drivers/staging/lustre/lustre/ptlrpc/layout.c
index 2855f38..417d4a1 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/layout.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/layout.c
@@ -992,9 +992,7 @@ struct req_msg_field RMF_EADATA = DEFINE_MSGF("eadata", 0, -1,
 struct req_msg_field RMF_EAVALS = DEFINE_MSGF("eavals", 0, -1, NULL, NULL);
 EXPORT_SYMBOL(RMF_EAVALS);
 
-struct req_msg_field RMF_ACL =
-	DEFINE_MSGF("acl", RMF_F_NO_SIZE_CHECK,
-		    LUSTRE_POSIX_ACL_MAX_SIZE, NULL, NULL);
+struct req_msg_field RMF_ACL = DEFINE_MSGF("acl", 0, -1, NULL, NULL);
 EXPORT_SYMBOL(RMF_ACL);
 
 /* FIXME: this should be made to use RMF_F_STRUCT_ARRAY */
diff --git a/drivers/staging/lustre/lustre/ptlrpc/wiretest.c b/drivers/staging/lustre/lustre/ptlrpc/wiretest.c
index 2f64eb4..f9394c3 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/wiretest.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/wiretest.c
@@ -1010,8 +1010,8 @@ void lustre_assert_wire_constants(void)
 		 OBD_CONNECT_ACL);
 	LASSERTF(OBD_CONNECT_XATTR == 0x100ULL, "found 0x%.16llxULL\n",
 		 OBD_CONNECT_XATTR);
-	LASSERTF(OBD_CONNECT_CROW == 0x200ULL, "found 0x%.16llxULL\n",
-		 OBD_CONNECT_CROW);
+	LASSERTF(OBD_CONNECT_LARGE_ACL == 0x200ULL, "found 0x%.16llxULL\n",
+		 OBD_CONNECT_LARGE_ACL);
 	LASSERTF(OBD_CONNECT_TRUNCLOCK == 0x400ULL, "found 0x%.16llxULL\n",
 		 OBD_CONNECT_TRUNCLOCK);
 	LASSERTF(OBD_CONNECT_TRANSNO == 0x800ULL, "found 0x%.16llxULL\n",
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
