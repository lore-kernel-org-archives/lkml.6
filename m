Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1557870-1526338531-2-7820444445611072627
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526338531; b=mj0xZYQtDGGUnWYKhv1CdVwKH+auXylw5fK6imWOb4ASdE/ohb
    cRs6h8gw85IinIP7p1Xc95EmdKZXRih0Kc3Aq/EbnX1AzDD6HIaxZGseBTzWiaa7
    ZDMBTWzrU5rfv1LMv8Q6PQOfQcAhpj0rgdi0xp9+I2Hl2aNxvrMrfKBNrAzFCc4q
    llrCGLqQmsPFjRIywVmOfeBADH+Am2ZkdD2ISxxsrT3pu+C2A2ZVxXgGjcCZfPLU
    2gV/dpXE8R8M3l29pvPB9/T2JnEc3evwEgmiPIboNs/1jk6Qk3Yn3oGpfyGYiEV+
    chLsrBgSecnqqB89g+ZrxVX62YumWiK3TyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:mime-version:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1526338531; bh=Bwq0qjz+lCQ2
    F0JY8sYHhIYZ+hntfub23VVZpHxaEjc=; b=BfY2lMzhiotrNIZ2dhI4fYFrN9be
    G5T47SEDt/3Rm+edtZKGfNm6QjQj55fAneKkLuZYumE801qKG1QJvjQkmbATQz1v
    CtfpL+TC4ZBfZVzMHIihbZA0kG9/cmKMF4TjvmMIB+Vmrycw6YH7v3tSq3Zn219y
    u/UW+ACvG+e2GGvzMnNoC7oaycJV1TUFj9GrjS9bQKfYAo5CdVmFoMMO6KPx52zI
    ZGB3URL7sVTcBxMzq7MoZIBDHq/nvhv/02ThrfyDQ3ha3IoIraSDAWMMBbvOj7st
    mff1oObzLr62vJDGiP6HH2H2UvNa9lnZk3t9bh7PgAEn/YVnZdLMJn197w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOQbJ5EBeXS8yDjtceWY/TKLXBgwU2NipMZtWpwonW1xswN9CnMEPFLaYRkRkoGCsC/KOsrAsj/5wYFGft2/olvgVMY6GGO9pL5cIR9w5NnIM2NLCBSN
    zG56gxe5yEHeGVnsjiBN1wksSPpnxS1lP6kpbYC6XHT+FOQq9HhVzipywJA48YKAa+sURczhUb0+wVluaAWL0WrAT6w7WQlNS6jM57xuBeAMSSxv3eokOERx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=fTKT6qC9wrIcX1quwt8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeENWyL (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 18:54:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752233AbeENWyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 18:54:10 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 4/8] kokr/Documentation/memory-barriers.txt: Cross-reference "tools/memory-model/"
Date: Mon, 14 May 2018 15:55:29 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514225457.GA5142@linux.vnet.ibm.com>
References: <20180514225457.GA5142@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051422-0052-0000-0000-000002EE708A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032370; UDB=6.00527776; IPR=6.00811502;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 22:54:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051422-0053-0000-0000-00005CAF2E25
Message-Id: <1526338533-6044-4-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140226
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: SeongJae Park <sj38.park@gmail.com>

This commit applies an upstream change, commit 621df431b0ac
("Documentation/memory-barriers.txt: Cross-reference
"tools/memory-model/"") to the Korean version document.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 44e47c2d33cf..2c0ab128cd04 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -36,6 +36,9 @@ Documentation/memory-barriers.txt
 부분도 있고, 의도하진 않았지만 사람에 의해 쓰였다보니 불완전한 부분도 있습니다.
 이 문서는 리눅스에서 제공하는 다양한 메모리 배리어들을 사용하기 위한
 안내서입니다만, 뭔가 이상하다 싶으면 (그런게 많을 겁니다) 질문을 부탁드립니다.
+일부 이상한 점들은 공식적인 메모리 일관성 모델과 tools/memory-model/ 에 있는
+관련 문서를 참고해서 해결될 수 있을 겁니다.  그러나, 이 메모리 모델조차도 그
+관리자들의 의견의 집합으로 봐야지, 절대 옳은 예언자로 신봉해선 안될 겁니다.
 
 다시 말하지만, 이 문서는 리눅스가 하드웨어에 기대하는 사항에 대한 명세서가
 아닙니다.
-- 
2.5.2
