Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-442876-1523926380-2-16597361043038612197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523926379; b=w2HVMCbLMNz/sLa+Z2g1DPoPLx0wxONh7kJFZ5wj53sdq25aW2
    dnR1X9xwpzipy42TEOB5r0ALzncbiAiBjbRDEcDgqA8iVeKCG1jcXoSb3/UuiJt5
    82dAE8Mg9gVo+fhGbP+0ZS8XVmm9kiAFQRbr9GKUUXqWkoy+fHoPpJ/ZG8BN2Bbi
    KI05dLGZjcNWm/o3hh8R54+jyFE2nCEHomaRkg/jQRFkm5kj3xfnfrEyRtgxdVT5
    0S/BpO69m18PsViMhKBDNaInAWUIt7i53rpOG37PDTkPfA2Vv/xWJ2/TEuIjIgPw
    F7QRVmxpYeq8R58gGAv7een0gXi09v9hz2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:reply-to:sender:list-id; s=fm2; t=
    1523926379; bh=AC6bK+f6iOaTghdkN1MtxuDThQwnNLXD/VIVIdNC0EY=; b=H
    aZwNxIKfh3IPNrqyybF1BPyT3jGEr4s+Eel67va2Xcuf7fh73OPDCqBIlON3yFja
    NOpEjeQeCUT6rbMn5GbwN8+na9RKC86iBERBcgKKnhYKLCjOOn1sFRCtt6MoyEBY
    Ya4EMaugbu82wO+cvf18AWV6ydJ3uk3yC53UiQhfYZeCi32fJsIAZBlPy38JSOJT
    tKLtYJFFqKv7s6UpPYWl0OG90O3z/SngLOuM3PBkp6G4aoraXvvJ87Menr6FgY3a
    R7AgRLGyNSZcHd/bhDbxShv/95foXIPwT1BtLLcwTNykqE0Tdd3EYYGrHoXdehpB
    vsrW4BgC3PBQxjK6aBPsg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfFLhKocX+izK95LGtoJegsjbVrKspoAwYp6PHD0m28dgflDGfxpQjY0y/Xh+YqUPFNfKYL9gOKsGe+Fbbgq885ONc0HmZip+gSuHkux5JHW6J6/EsjsU
    SBzr/mOOtLUOtaq+xmZTZOa95GGxbsnsweQfAFLTTGP4hAkRGwBmZdXz05LRXKcNNqy/nwOP08xYQB6Vidx+T83q8Gv7PQMsy1RZ9sYIzrPqQvQlheilsDbc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=gCM20FAegu7IZ1vN_e0A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeDQAvC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 20:51:02 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:57016
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751060AbeDQAvA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 20:51:00 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 2/6] cifs: Allocate validate negoation request through kmalloc
Date: Mon, 16 Apr 2018 17:49:14 -0700
Message-Id: <20180417004918.29213-2-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180417004918.29213-1-longli@linuxonhyperv.com>
References: <20180417004918.29213-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfNn7nzn/YUBATsQLuXba9KIvk9dGqlGbhhw1LOtEAvThb5KctXcN+fRGkU9hCHhwQkZVRCUafvI4k8YKDolXbsX9P5cHlle0GGTsaKuD2Rd6OQ+ADmpc
 KNj/uvL+JTWYj/PplG0xT2s4/gZ2gymqqpBY2RF8HzAPHFqpFIFoaNWSz3tPTlXDupBOF4p0c1oh5EfmwYX3AC7hnY6w6dGFct2RPnSKKKeTreEcYHIb7cvF
 WqG9jMOZyW29qH/sWJzEB8uYRGjoNaKNdOKx3klnM9/7Q2MbTQeb0I6A/PBLWyEaWSmu7m8wTbAAOjBXSy36HEnMLH29tGZ06eGOtCmojG8Zq1CzVpc8Oaea
 kv+/7s9Soh7Hh2JcGlyQynlcDIXXUZOo/10yo8SV0yIWOG/GFNNnxJjWaP+4IiQen64L6/m/Ca2CPDpWeRPRfALG6JfwPntmJ59MYxbn8C+Y9KeianY=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

The data buffer allocated on the stack can't be DMA'ed, and hence can't send
through RDMA via SMB Direct.

Fix this by allocating the request on the heap in smb3_validate_negotiate.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smb2pdu.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 0f044c4..abbefe2 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -730,7 +730,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 {
 	int rc = 0;
-	struct validate_negotiate_info_req vneg_inbuf;
+	struct validate_negotiate_info_req *pneg_inbuf;
 	struct validate_negotiate_info_rsp *pneg_rsp = NULL;
 	u32 rsplen;
 	u32 inbuflen; /* max of 4 dialects */
@@ -741,6 +741,9 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	if (tcon->ses->server->rdma)
 		return 0;
 #endif
+	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_KERNEL);
+	if (!pneg_inbuf)
+		return -ENOMEM;
 
 	/* In SMB3.11 preauth integrity supersedes validate negotiate */
 	if (tcon->ses->server->dialect == SMB311_PROT_ID)
@@ -764,52 +767,53 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
 		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
 
-	vneg_inbuf.Capabilities =
+	pneg_inbuf->Capabilities =
 			cpu_to_le32(tcon->ses->server->vals->req_capabilities);
-	memcpy(vneg_inbuf.Guid, tcon->ses->server->client_guid,
+	memcpy(pneg_inbuf->Guid, tcon->ses->server->client_guid,
 					SMB2_CLIENT_GUID_SIZE);
 
 	if (tcon->ses->sign)
-		vneg_inbuf.SecurityMode =
+		pneg_inbuf->SecurityMode =
 			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_REQUIRED);
 	else if (global_secflags & CIFSSEC_MAY_SIGN)
-		vneg_inbuf.SecurityMode =
+		pneg_inbuf->SecurityMode =
 			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_ENABLED);
 	else
-		vneg_inbuf.SecurityMode = 0;
+		pneg_inbuf->SecurityMode = 0;
 
 
 	if (strcmp(tcon->ses->server->vals->version_string,
 		SMB3ANY_VERSION_STRING) == 0) {
-		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
-		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
-		vneg_inbuf.DialectCount = cpu_to_le16(2);
+		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
+		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
+		pneg_inbuf->DialectCount = cpu_to_le16(2);
 		/* structure is big enough for 3 dialects, sending only 2 */
 		inbuflen = sizeof(struct validate_negotiate_info_req) - 2;
 	} else if (strcmp(tcon->ses->server->vals->version_string,
 		SMBDEFAULT_VERSION_STRING) == 0) {
-		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
-		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
-		vneg_inbuf.Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
-		vneg_inbuf.DialectCount = cpu_to_le16(3);
+		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
+		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
+		pneg_inbuf->Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
+		pneg_inbuf->DialectCount = cpu_to_le16(3);
 		/* structure is big enough for 3 dialects */
 		inbuflen = sizeof(struct validate_negotiate_info_req);
 	} else {
 		/* otherwise specific dialect was requested */
-		vneg_inbuf.Dialects[0] =
+		pneg_inbuf->Dialects[0] =
 			cpu_to_le16(tcon->ses->server->vals->protocol_id);
-		vneg_inbuf.DialectCount = cpu_to_le16(1);
+		pneg_inbuf->DialectCount = cpu_to_le16(1);
 		/* structure is big enough for 3 dialects, sending only 1 */
 		inbuflen = sizeof(struct validate_negotiate_info_req) - 4;
 	}
 
 	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
-		(char *)&vneg_inbuf, sizeof(struct validate_negotiate_info_req),
+		(char *)pneg_inbuf, sizeof(struct validate_negotiate_info_req),
 		(char **)&pneg_rsp, &rsplen);
 
 	if (rc != 0) {
 		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
+		kfree(pneg_inbuf);
 		return -EIO;
 	}
 
@@ -838,12 +842,14 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 
 	/* validate negotiate successful */
 	cifs_dbg(FYI, "validate negotiate info successful\n");
+	kfree(pneg_inbuf);
 	kfree(pneg_rsp);
 	return 0;
 
 vneg_out:
 	cifs_dbg(VFS, "protocol revalidation - security settings mismatch\n");
 err_rsp_free:
+	kfree(pneg_inbuf);
 	kfree(pneg_rsp);
 	return -EIO;
 }
-- 
2.7.4
