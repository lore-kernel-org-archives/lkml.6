Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523852151-2-9284025498073983677
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852150; b=LPD7b6G6LcJod6s0CA//zdSL3XYAKDNJksvKL1lOhfR7U2L5YT
    +jQDLSBk/u64HwmngnGucXMvjt2NvR0aB240evf5x4CbTg7F5+87EpxRJ1Oaj3jO
    2uM756HoyC8Qz2kE8j3beGv508QkC3b5pwsNl0HhE2MwJWOhvWspIbAH/4B+DJvl
    42KGUWJX2u7qAfC80w5LISFoX1Y71AvP4RwmVm4oU6/0dn/Mnc7C5GCBufQx8xdT
    o31s1WFwBuZftKJ5dxPZdKQ3qjx4/Cuv9TrSKgNXFP9YnP3QQ9vNBAs0lfTVSn8P
    G4XB5Ex0fVIYGDY1jpjrncPgHF/cr0n5Rsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852150; bh=SNZPo
    7C/GMY4L4IacXUpuJeiRngfjCdulJvCXuwkk0w=; b=rf8CzBCeFcBJ6YV/AnNsT
    0qCAX/iA6Pldf99brQQQq4X9ol4Erb1DlvlvsLQcDokNqWyuTzrgTiP6SnMKZkBz
    QAlyhXm544hvW1EtgA/skMrLv/nuOyibxkcFxyygFjcul6O1U//hDVb8WQSwfZVr
    HQylvHowtoUCQvSZZP95QwCWgkpuRcK7cKijPnNeelUQq3rwhgjIE5TXMhntPisk
    Gu32eWbdJ0p8rtEKXw8DThaa0aP6ricj0mwMMCO16NTYiskPHJP3658XDp4rVL1M
    uM7zeiZAkT2DfMVjysvl52omDCNDFK2betDkgqE2XQ8SbYmdQ88HmZsAAJMcTl06
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFllN7ofQDde2cyMbZI9tVxZSfO8GFjrj6M4J8rSeYvXDzC0AHlt4yxcQfQuh1E0cBaoOKKpedHutmgUCNvjSwacwIE2q6VZzARMI2//ZOmXmH+5efgI
    len4wYemTmYJ1BbNAoR/DLtTNyuqU13XkkkIHlObTH79WMTDNOCjxu7D+WY4EgwfAr2lacPomIb/t1525uWjvpBKj02s4dMHconStHoN/kI3B3DXPVxtUDYC
    tfrCk6QgzgDNo9pkuicqzg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=CjxXgO3LAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=lB0dNpNiAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=U2SPwd_TcMqo9KUxNAQA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=c-ZiYqmG3AbHTdtsH08C:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 17/22] staging: lustre: llite: cleanup xattr code comments
Date: Mon, 16 Apr 2018 00:15:06 -0400
Message-Id: <1523852111-17321-18-git-send-email-jsimmons@infradead.org>
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

Add proper punctuation to the comments. Change buf_size to size
for comment in ll_listxattr() since buf_size doesn't exit which
will confuse someone reading the code.

Signed-off-by: James Simmons <uja.ornl@yahoo.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
Reviewed-on: https://review.whamcloud.com/27240
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Bob Glossman <bob.glossman@intel.com>
Reviewed-by: Sebastien Buisson <sbuisson@ddn.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index d6cee3b..835d00f 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -564,7 +564,7 @@ ssize_t ll_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return rc;
 	/*
 	 * If we're being called to get the size of the xattr list
-	 * (buf_size == 0) then just assume that a lustre.lov xattr
+	 * (size == 0) then just assume that a lustre.lov xattr
 	 * exists.
 	 */
 	if (!size)
@@ -577,14 +577,14 @@ ssize_t ll_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		len = strnlen(xattr_name, rem - 1) + 1;
 		rem -= len;
 		if (!xattr_type_filter(sbi, get_xattr_type(xattr_name))) {
-			/* Skip OK xattr type leave it in buffer */
+			/* Skip OK xattr type, leave it in buffer. */
 			xattr_name += len;
 			continue;
 		}
 
 		/*
 		 * Move up remaining xattrs in buffer
-		 * removing the xattr that is not OK
+		 * removing the xattr that is not OK.
 		 */
 		memmove(xattr_name, xattr_name + len, rem);
 		rc -= len;
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
