Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-442876-1523926945-2-13155454364773388614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523926945; b=LhWekUDs1tYghhK3fCEgtdR3RPXzx2UU82K3is2PAmu2SKrP12
    Rr65lnbV3V8cVuZrStEBcFvUeX0+BzWeM6V8rA6Mc3xrWg9cfaoYRaxG1wW9y39x
    LYaOJp5GOi7q1OLelykCsbcooZ3J9wMuE9qWs0HZt3vaCyPqfiO8YHFjSLbwV6h1
    8tpBOgwLV/UtzN34+0IK28ryJ4ndpTudrEmkxFSu26U5NohhMY232dUcfaGW9iSs
    IPMPkWL95u6L5HiURo9VAIV4JENu6q/1oyLBSRl3k+tMRerH74Qz42LYmq0muep3
    66/cPyAEhL3AJYCMjgTYRKE05tNHaXlmmKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523926945; bh=ZCHwJRUUDhRY3+9OcnkqlxnEYG0HFlH7Rml0TuVu9so=; b=O
    V6F41qPOiHKJKFM/4fDX37SrNkiWw2iRwTIy0bp/tgzrRIW9u3+jq1BHcRrwDMBs
    xOySQ0/Ne6VD9oTFQpfVEjBCiJT/6XIJHd71uHr66t0QTLgLmmI10pdtu0M4xpcI
    mcdbnRGxkrYCPPObqMceHjyx/u83XA6VjVVuflOIFP7hSx4zU6Xb2dYCijqTAznw
    UhFTF/efllmC5uZ9yoePuKGBQX/A+kzQvY0B8f5iaLddxefAdbcpXx90PW8JN1Tb
    fNGKKoz/K2wZxUAxVvvVEvzhksAv2QZsb5Q1Kf+zn4I1FH3FAF7/IdOh7d4CpCno
    HOFGcmWof6VUsPmxYd9RQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJHVviAYitnQvfP95IIFusJjnSm6gjsLe/ghQ5ulCJhj59JBpXSDl1shIM99sHe+eqmaCECcW9JRUU02WBH289g2iZEM4R6dkmXXMqq2IWJeZDtczte2
    TnTLevgf4z/R4zUcMA8XdVbjnwV82ymcZeDiZ1yxKBiNyIkW499HvXxlnkDPUWIlK8oykbnLCNOUpGYhR/pbekmRxFArSx8+DwWSgqERJ2S3lD6JY73hH3+a
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=nXmEi__yKZsk49VwxFsA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeDQBCW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 21:02:22 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:36278
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751206AbeDQBCU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 21:02:20 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 5/6] cifs: smbd: Enable signing with smbdirect
Date: Mon, 16 Apr 2018 17:49:17 -0700
Message-Id: <20180417004918.29213-5-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180417004918.29213-1-longli@linuxonhyperv.com>
References: <20180417004918.29213-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfIIfCoW4GdMewIaUyEJ1B5h+PnBpDoaG7Q0+bvKNRPDp5MYPMgvpaQtNbhMVQsXYe6zoVkaa6iKa1pOQsuwTvbxfkZDL9y8LBDuK8Aq8utMfuaR8PDgF
 W8UsJ/6bxH7+VlrevEIhXk6E0GXPIiaUpH9vS/PFPtUNt0gJXb9Pq01xvRVu0tD02EypdbJKMju9RKj96aeJiTd8ufKZiGvyuWRgsjYo2qj4pjVk+L0cEy95
 GvuL376UwqEOUbSE6CWC5GLdkd2XLEt+QPuIn8UNJowooXtgdJWQNcWoEMBwSf/0Hf5aQrWEuphFBdTZhli8xtMbTonoUxKJN13n427NLMB9BCtwoiLYbCVG
 Av0p85NEN3p+/N/68LujwPZtpuD8/FQzVGqC2jGx3D3SWNylzXeHK9xDNUddRol9N05kOE5VwzORUX26LX8ABYZixsLNUbzDHxXL+WkojhOIpaq2sJs=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

Now signing is supported with RDMA transport.

Remove the code that disabled it.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/connect.c | 8 --------
 fs/cifs/smb2pdu.c | 4 ----
 2 files changed, 12 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index e8830f0..deef270 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1977,14 +1977,6 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 		goto cifs_parse_mount_err;
 	}
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (vol->rdma && vol->sign) {
-		cifs_dbg(VFS, "Currently SMB direct doesn't support signing."
-			" This is being fixed\n");
-		goto cifs_parse_mount_err;
-	}
-#endif
-
 #ifndef CONFIG_KEYS
 	/* Muliuser mounts require CONFIG_KEYS support */
 	if (vol->multiuser) {
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 6759035..d71ce51 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -737,10 +737,6 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 
 	cifs_dbg(FYI, "validate negotiate\n");
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (tcon->ses->server->rdma)
-		return 0;
-#endif
 	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_KERNEL);
 	if (!pneg_inbuf)
 		return -ENOMEM;
-- 
2.7.4
