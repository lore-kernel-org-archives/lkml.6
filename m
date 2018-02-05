Return-Path: <maurosr@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x22602NH0J0j73wsMyHWEckRT3koD9yLq7f1YBc6RjY2MR9iYjyKER1RNBTX9aPqydvGpp7pr
ARC-Seal: i=1; a=rsa-sha256; t=1517836207; cv=none;
        d=google.com; s=arc-20160816;
        b=MJeFYv/cLQV751USU5fdQSIQgBQ1SjI2MmPK7N1vcq+j3DOCKFDph7AJCjullYBMW4
         DFI7BFg6Kv5+cMMzCTaQkEaHTKRjFsf7YchTlyb927Fequo7iefrEEiubKWV8kIy0PC0
         aN41J5Xi/Lb2gHOKgdjBCDSwiRJ5olOPtWw9RuUHcnZaLLv1kHEXwz5uV4SMOj8nlHEo
         xXTsuc2qNIZJuYRadExpT0hiO0XWvuDrCoxWFENf5yjKVMsj3jtnIKggGwInGe6dh8hU
         a5SmXEjpREHcAjmg4mfSnjNNLetLw3QJHH9K4rBhoZecDQ0v1LOAEMNN6Vq3Eab02XJG
         0l6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=AEEquZFMY9w1qjPTzkvZVIXyqeAUY1k5PuH4gzH9NKA=;
        b=qzLNmh1MsajCzHJ7vH+yrHavbPAdtqU3680uenkhNGMarr8Cysj2Gze5ePdvAx6hRu
         tA4+BLVC23oIOynjEFO8m4z76Pzr0Ig8Jf6wGD0WjyD0qJrT4ihST1mZfblPRhBSuBnO
         uB2L/o3Sh6lgh4O1JdokrELt2rqewgSpHfTE9SGA7ykBxnOQ6oiYw/xTY4ktzr5AEjl7
         zNZrgk+fXmkpP5S85x+oiz90NWq+Qb50RpWOk4ZW3VOnr1CqG6GCEnBatK9yMKywxi9l
         0nMNrEsa+Az09SJj40uKk2MDnmlgrBIP1FVYKHP7ZsEbMPPKowIkjgpaDK8TS73sid2p
         rz4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of maurosr@linux.vnet.ibm.com) smtp.mailfrom=maurosr@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of maurosr@linux.vnet.ibm.com) smtp.mailfrom=maurosr@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: maurosr@linux.vnet.ibm.com, gpiccoli@canonical.com,
        haver@linux.vnet.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        brking@linux.vnet.ibm.com
Subject: [PATCH] MAINTAINERS: Change maintainer of genwqe
Date: Mon,  5 Feb 2018 11:10:01 -0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18020513-2213-0000-0000-00000267D63A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008475; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00985283; UDB=6.00499920; IPR=6.00764655;
 BA=6.00005811; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019375; XFM=3.00000015;
 UTC=2018-02-05 13:10:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020513-2214-0000-0000-000059021585
Message-Id: <1517836201-19362-1-git-send-email-maurosr@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802050169
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591566619699456002?=
X-GMAIL-MSGID: =?utf-8?q?1591566619699456002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Guilherme is no longer available to maintain the driver. I'll assume his
position for now on.

Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b59a8cd..21ab6b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5968,7 +5968,7 @@ F:	drivers/uio/uio_pci_generic.c
 
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.vnet.ibm.com>
-M:	Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
+M:	Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
 S:	Supported
 F:	drivers/misc/genwqe/
 
-- 
2.7.4
