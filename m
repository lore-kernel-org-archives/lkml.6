Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523852147-2-11066487348520971234
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852146; b=FmINk1aK8f5Gw4VVT5gzjSHTnpMSiiM/QVMHhBV3zJsqwsnQbu
    aihjn33QL0j7aScYHOr+mFb55CjINHn1qzERS0E4gaUj0X9xnXOlKmOcc1YJNRW8
    nW2IxzP2UPUpfqdcTIi8CPWi6LCVSBNeiOcnMG7G53Y0KINzD4UkorbYB8sWBQpS
    DA6CC7+arqF9krQ+DYrbS3N/vIM4ghgKiXvrHhtbZdmYcyvnLaYKQlPbL0gWH4yy
    9dJ6qd+2pHMnUc2UK6LbDKPj2w4JQDBdoFoNxuCKo0cl1o/UdXzzYphicZbdP3QN
    JSENtjyMtQRh5piTfQIz9Oj402D7FowNL/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852146; bh=ogbQO
    w060B47npsUYWnCMVew2erdoR79vKSzqjgqTQA=; b=CHoSsnSryHXJ38XDhU8oY
    bANA1jbcXKttoaoaNg7VUE5iEs2WlXXvi+GYXenSzyF2Rc6mVR6ariqkRFp6tPa1
    MOTg+f8EHhv1F4R+bRp9S6ZCl5gUopN+Pl3ZcCEFFQFSCsZ+Nb1mouFk+nYE++qz
    AHjorZM+Kwg9B6CS9TnYApIldbNv9hc/bloRrFMIWBgc9KKWvVe6ZBYeKi9AReHZ
    L1vylVyH00f+DxxB2eKc4ubTK3TvnUy08NhqvojjoT6QX1Ui/fLVGbrIgA+qyRER
    3pLXrb7WGefTgvkbbecDij1yLsHmDjnaML7rOTzCd69XNyQ1KzlYkMu9XhcQvfLp
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCK+3UjBDgV95FcT7z0fguH0OHdUK8ly8AgVk1z285++CSXyhB7OdHeaNaabGMxVN/DxAWGC/YTgv2hNi/qrepXSkOmgJMs0sPVaYNUuKGc5yv7jdVbX
    /t7BpMIIQDqDdBGQKKJy+0FTXxeqR6HMB4UpZSiwtzHyxg0DvRq2xOkOviy/jlP15LytqOMVEacGKLy6X9LQD7kmE19DJ5535UGFgZetx5UNWYhYaOstEgxy
    JSdjWlpop9XanPjYf+vvcg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=CjxXgO3LAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=lB0dNpNiAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=wIu7T7ocvrzLoG2bzUUA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=c-ZiYqmG3AbHTdtsH08C:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 16/22] staging: lustre: llite: use proper types in the xattr
 code
Date: Mon, 16 Apr 2018 00:15:05 -0400
Message-Id: <1523852111-17321-17-git-send-email-jsimmons@infradead.org>
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
Cc: James Simmons <uja.ornl@yahoo.com>,
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

Convert __uXX types to uXX types since this is kernel code.
The function ll_lov_user_md_size() returns ssize_t so change
lum_size from int to ssize_t.

Signed-off-by: James Simmons <uja.ornl@yahoo.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
Reviewed-on: https://review.whamcloud.com/27240
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Bob Glossman <bob.glossman@intel.com>
Reviewed-by: Sebastien Buisson <sbuisson@ddn.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 147ffcc..d6cee3b 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -91,7 +91,7 @@ static int xattr_type_filter(struct ll_sb_info *sbi,
 	struct ptlrpc_request *req = NULL;
 	const char *pv = value;
 	char *fullname;
-	__u64 valid;
+	u64 valid;
 	int rc;
 
 	if (flags == XATTR_REPLACE) {
@@ -246,8 +246,8 @@ static int ll_setstripe_ea(struct dentry *dentry, struct lov_user_md *lump,
 		return rc;
 
 	if (lump && S_ISREG(inode->i_mode)) {
-		__u64 it_flags = FMODE_WRITE;
-		int lum_size;
+		u64 it_flags = FMODE_WRITE;
+		ssize_t lum_size;
 
 		lum_size = ll_lov_user_md_size(lump);
 		if (lum_size < 0 || size < lum_size)
@@ -309,7 +309,7 @@ static int ll_xattr_set(const struct xattr_handler *handler,
 
 int
 ll_xattr_list(struct inode *inode, const char *name, int type, void *buffer,
-	      size_t size, __u64 valid)
+	      size_t size, u64 valid)
 {
 	struct ll_inode_info *lli = ll_i2info(inode);
 	struct ll_sb_info *sbi = ll_i2sbi(inode);
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
