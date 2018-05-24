Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161317-2-6906885752579790797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161317; b=j8EaA9cOen7HvUiT/N7JcYGm6HbE/4XzJObZTKaS42NeatSzaQ
    4pX7X7HHAL+r4s83fRkg1ISzFGRGoA9qB1KVPHjUfMH/6TIft3O38r9gaWbEq6Yo
    MNTjjPJhsxsKav8cD2v9T7VnY08HdOkLjLLwjjdKEazpLvzdLG4B2B6yea2vjcaY
    PG3GRuVoazCxfxVeI74+ov0aovbr552x6NNijmImOK/wvAINeRO6U5EQgzno1DAJ
    WKj7VVIEgKpHnMH11SZQUbIEj/amuYcMhB9aEcP0nm2U66hc+Kni6Dwh/shcyTAZ
    c0R1mO2gj0J08f6CRtgEBqrHq2qwvFtrloXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161317; bh=mfn15vjQEjiPE2SmYHBwwYexrSV0sW
    Qf3jOsRnf/W+4=; b=IhjZqbqwnsXbZ4c5lbmhv+aZO3R+IqFKJEHl5FwuaFRZX9
    pFKU63gcbx3blSv5TMZvs14NUkUT8Tejfiz86MBCylSoxzEiBk8Kv5eQCxwXYRSu
    DZNRaQ4Fwlz+5Xeg5C7+wg2wCT8xoj65EerghUfMZmQhkh2jqHk7HYM76U/Y1mwu
    br+5Fth4cC2MyUIra5ghqDkVSDPFuJ+uQsn7YSlQQ/5CZCrqc8WHUv6UFsWBtNiR
    oOIWSVCyfAwe/yFemv2Z/9wfNZV6UkxeVtRJ3NKgchMddBfLGtA1n0XtP55UonSG
    R1FHe/E7WMs5D7e34q3Ezt9FWh36k/URAP7G7+IA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=XmFpLPdc x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=XmFpLPdc x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFcmaz5J/KbbauF2fJH+8tOj/1eKi98PKur0Vx0wxyl0U9wtXIb74lkENOJ21E0Wy6Dbl3vQyjCJmCRVtcYQqKDHDf3PSgRtE4VcynngTReu/8d3eYJc
    UTeZ2TlqAi7iCPxXqbEiaC6SKGavn8LDxlhbookzjCHyfVNcB+18ONvDhO1jmLeqXTwkOaQW6gsFZjn8U22Ys03nUC5Rpnk1Hv0qs8kYZF+TfUABhCeVICj+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=WIANZK8Gtf-dEdyjr7cA:9 a=QEXdDO2ut3YA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967691AbeEXJvY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967687AbeEXJvV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 66/96] scsi: lpfc: Fix frequency of Release WQE CQEs
Date: Thu, 24 May 2018 11:38:49 +0200
Message-Id: <20180524093609.230100675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 04673e38f56b30cd39b1fa0f386137d818b17781 ]

The driver controls when the hardware sends completions that communicate
consumption of elements from the WQ. This is done by setting a WQEC bit
on a WQE.

The current driver sets it on every Nth WQE posting. However, the driver
isn't clearing the bit if the WQE is reused. Thus, if the queue depth
isn't evenly divisible by N, with enough time, it can be set on every
element, creating a lot of overhead and risking CQ full conditions.

Correct by clearing the bit when not setting it on an Nth element.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_sli.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -116,6 +116,8 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, u
 	/* set consumption flag every once in a while */
 	if (!((q->host_index + 1) % q->entry_repost))
 		bf_set(wqe_wqec, &wqe->generic.wqe_com, 1);
+	else
+		bf_set(wqe_wqec, &wqe->generic.wqe_com, 0);
 	if (q->phba->sli3_options & LPFC_SLI4_PHWQ_ENABLED)
 		bf_set(wqe_wqid, &wqe->generic.wqe_com, q->queue_id);
 	lpfc_sli_pcimem_bcopy(wqe, temp_wqe, q->entry_size);
