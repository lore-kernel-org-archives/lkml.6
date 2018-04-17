Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-442875-1523926943-2-16678660566056653248
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
    1523926943; b=NtI4CtEtjC0kP0w+bFW/ISb3UMECTfAewDpbOp+rMN17WLyM1q
    40U3HSyXdyr+aYxoY7pHG4YDh2ROLN0Rz3MdN7x7u7a6d3pzP95b+tcT3IK8yzWa
    eAWbFZ4TTENEPIftv9oZ7P1OIVz4jjaGYEu2OsG38LZrt2k5+Up3yR9EEk3qWTeq
    29/GF9rAmm3aB3zuxWQzuFtbhiqcRjYvA3lts+djXV/lmHpnMUT0qcishZMNX9so
    DcxU8kyo5disYeENIe+gBXeVDrjTbcZYx8IcTiGVonfb6Uz4d+fW3PPOdsu42AnI
    VUkGBuEPjpeH6PLVnI59/wtQumUlVBNGMZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :reply-to:sender:list-id; s=fm2; t=1523926943; bh=/NjPMtGP4dJ9nC
    c+8my6wvjfrGpSw394exVTFZ/e7H4=; b=potQc3K2hnyLRf70dlx+3+VGRO6CSU
    bix8TIjEltDuGWcNdyCyqH0Q+JZ7vpZg7MC5+M0P9B4G663CoAqw2DwznWbwu4n3
    WiNFASQOyXwAAZkBupb4WpzJGluNWI8jQVoy2kfbjsFcIWtF6RMxaM2DJcyEnt6b
    ee3/4nHKAokPh7q5Hu5rUVCpo0fBaVHKg2pUuFNRuMfck9zgkF2nc1nnLtAORiLo
    3VmbZ9VvUayvFJbdmw9f/pIirGRuJFmwL0zh+YeMZ7C80PBr8mc7vp7qLXCKrYxa
    nUAsbZtgu83zEn7uFFo4sLpVFHAwWrA+FtUOR87EGc4sivH3kdmem1yw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfOGvJ/5Fps81LHTP4iFRNSWWQeNydguipJBLWhDLD0bq7C1lf2RtrWLPwuxLcMe2zTpoxWJ7arM2eWt0gryJ4hgzseigYApdTnsfcgI1UCTZchDquNO1
    nt+gp54rKDx65RJMiVFlvG5NpZ8SxNblGbAFw7/Qcbj9sxnRi1TDuhTN63rfzO6AZBgtEEDLqkE4FUPR9JqzeEbXnFxOIDyzklv0IrxY/dPMC16XAvRuT+kb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=dihGPPrMb8lbbuB8swMA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeDQBCU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 21:02:20 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:60352
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751060AbeDQBCT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 21:02:19 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 1/6] cifs: smbd: Check for iov length on sending the last iov
Date: Mon, 16 Apr 2018 17:49:13 -0700
Message-Id: <20180417004918.29213-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfP4N6ubxwmwRb4BfbpL3lDGzZhZP+lZl8mCXslQW9GIIEBzsU8hKslmNVl1nR+88F3qUpncPxNXVZPXBtwdnOnpTRTitnvT8pd09wZ4ubT49tR853y9+
 GvDYBLKDp7uWx9V9eB010Ss+DETrTSf+0LUHB8z1s909WBihzPKKUku0yq4UII8aeLjfW0tDXSjdLKUDz8D7wk0ZAMZJGZ45bBdZ1d4Dm4g49n67Quvu5DeI
 RGAs9PmliuI8GuzWco8jBB5yijR+GBY4xP+26oiDrgL9Mc9zdcFPTGGt6hWhMuWG2PvJwkqUyhNyJgjxrfNfMsBZvNCdCnmd3Q9RTmByxSKidT4B1fNhpr2X
 AAUcpaWBF+i6pbaRwszZhaWf8cQd1lMr3Vef6Pps8QQ5FuXND1nWMMUrKN5eipBaEmtsNlAkpPovkTAScsyqHSiYKBHFAaVk7PRWSAXwloYiDRvLGRg=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

When sending the last iov that breaks into smaller buffers to fit the
transfer size, it's necessary to check if this is the last iov.

If this is the latest iov, stop and proceed to send pages.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 90e673c..b5c6c0d 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2197,6 +2197,8 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 						goto done;
 				}
 				i++;
+				if (i == rqst->rq_nvec)
+					break;
 			}
 			start = i;
 			buflen = 0;
-- 
2.7.4
