Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-9267-1520585681-2-6532545777958540175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520585680; b=Cj38mBoR4kw2o/iYoHzzvs4VAZB6WjKmxvzPQFBZmcSH2P6
    QgthGIqyf5MDbwX8zDXER+V3moujFI/28xJ50yjiiGA4ep8jNCx+5eNcjgO2QUXc
    YrHH73yubVZBkhfcvm1xpizlfYqSdDpMGWGVu9xb5VJs2QIEMpPp4HKw1IZJDRG2
    7dScbwjAfNwqkfNuvy9W2vTXy6ckuweIu5Ogyxeo98rPP2SWO7HwPaObwGsIyuWz
    +co6GbdVvUGy4Ej5eWo2mSciZ5Sb9aJRRKfG1uAyRRanCfNAEbXAc3HEGc6jYHBn
    npWsi6taB+R/tu9//Od3mh14MC63kyB5c5ZuLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1520585680; bh=7MypysnNbBqwxzjOnPDAEjnqct0
    IYF+7vJCe73e3PRM=; b=edzobkxGL873+p+NUy3EQwe4rhdIu1+LdFKC+ciNVub
    ttHFf4IpbZFZMI6EhaLyUVgYftf1e5qWOtp66Con0tKobLC47UjrCqQ9rx9lczE6
    zGKJyzJ5+tG/g2+lInswapKLHtZP5QA6w/HvEl/amiad6gXk2dyeCJRUoNW0PJ+a
    nUhHl29B311NRf/dcg6ZV4Ystmjmu6QUy9EigIaXaGWJ0nV4mhdyK+qUtARoG9bC
    8FgkMgkUbTbCtD0b2WN7+a5+aLS5ZXmtXX1jYl1JMVDpzony+h1+4jq6H69MMXXx
    aKu0nvqJQ5z264823onLn3zJ5Ga/ZMAWGwlzZMC/T1g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800"; d="scan'208";a="33653452"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [lustre-devel] [PATCH v2] staging: lustre: Remove VLA usage
Thread-Topic: [lustre-devel] [PATCH v2] staging: lustre: Remove VLA usage
Thread-Index: AQHTtlaLfWBjl7/Rn0q8LtJYujUiQaPIIeSA
Date: Fri, 9 Mar 2018 08:54:29 +0000
Message-ID: <D86B331F-466E-4395-9620-A84349F2DD2E@intel.com>
References: <20180307205444.GA11349@beast>
In-Reply-To: <20180307205444.GA11349@beast>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-ID: <256AED917176C643BB96F1916F39FFBC@intel.com>
MIME-Version: 1.0
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Tycho Andersen <tycho@tycho.ws>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Gargi Sharma <gs051095@gmail.com>, "Drokin, Oleg" <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 7, 2018, at 13:54, Kees Cook <keescook@chromium.org> wrote:
> 
> The kernel would like to have all stack VLA usage removed[1]. This switches
> to a simple kasprintf() instead, and in the process fixes an off-by-one
> between the allocation and the sprintf (allocation did not include NULL
> byte in calculation).
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

This seems better than the VLA_SAFE() macro, at the cost of an extra kmalloc.
I don't think these code paths are super performance critical.

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/llite/xattr.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
> index 532384c91447..ff6fe81a4ddb 100644
> --- a/drivers/staging/lustre/lustre/llite/xattr.c
> +++ b/drivers/staging/lustre/lustre/llite/xattr.c
> @@ -87,10 +87,10 @@ ll_xattr_set_common(const struct xattr_handler *handler,
> 		    const char *name, const void *value, size_t size,
> 		    int flags)
> {
> -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
> 	struct ll_sb_info *sbi = ll_i2sbi(inode);
> 	struct ptlrpc_request *req = NULL;
> 	const char *pv = value;
> +	char *fullname;
> 	__u64 valid;
> 	int rc;
> 
> @@ -141,10 +141,13 @@ ll_xattr_set_common(const struct xattr_handler *handler,
> 			return -EPERM;
> 	}
> 
> -	sprintf(fullname, "%s%s\n", handler->prefix, name);
> +	fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
> +	if (!fullname)
> +		return -ENOMEM;
> 	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
> 			 valid, fullname, pv, size, 0, flags,
> 			 ll_i2suppgid(inode), &req);
> +	kfree(fullname);
> 	if (rc) {
> 		if (rc == -EOPNOTSUPP && handler->flags == XATTR_USER_T) {
> 			LCONSOLE_INFO("Disabling user_xattr feature because it is not supported on the server\n");
> @@ -364,11 +367,11 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
> 			       struct dentry *dentry, struct inode *inode,
> 			       const char *name, void *buffer, size_t size)
> {
> -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
> 	struct ll_sb_info *sbi = ll_i2sbi(inode);
> #ifdef CONFIG_FS_POSIX_ACL
> 	struct ll_inode_info *lli = ll_i2info(inode);
> #endif
> +	char *fullname;
> 	int rc;
> 
> 	CDEBUG(D_VFSTRACE, "VFS Op:inode=" DFID "(%p)\n",
> @@ -411,9 +414,13 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
> 	if (handler->flags == XATTR_ACL_DEFAULT_T && !S_ISDIR(inode->i_mode))
> 		return -ENODATA;
> #endif
> -	sprintf(fullname, "%s%s\n", handler->prefix, name);
> -	return ll_xattr_list(inode, fullname, handler->flags, buffer, size,
> -			     OBD_MD_FLXATTR);
> +	fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
> +	if (!fullname)
> +		return -ENOMEM;
> +	rc = ll_xattr_list(inode, fullname, handler->flags, buffer, size,
> +			   OBD_MD_FLXATTR);
> +	kfree(fullname);
> +	return rc;
> }
> 
> static ssize_t ll_getxattr_lov(struct inode *inode, void *buf, size_t buf_size)
> -- 
> 2.7.4
> 
> 
> -- 
> Kees Cook
> Pixel Security
> _______________________________________________
> lustre-devel mailing list
> lustre-devel@lists.lustre.org
> http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation







_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
