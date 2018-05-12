Return-Path: <sabin.rapan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526122926; cv=none;
        d=google.com; s=arc-20160816;
        b=1LUXLgTDzB3NMDqcFhqpLPXRuBLJDA3kEPseGIy8voCLe3p7+e4QF3nxU74c4GPPhC
         TdYw7B8ihizMtCKTaE3Da9OXUJrwDF+f19LovRC9ssJ7iJ9H0+0+oDqb1j6tyEWdsMVf
         ywOcxl8Vgy/T7jJr19CuFjsDTB8LPs1dMSoh97k5ykNrgt10FF4nt6qaeiThMzmKIk7B
         CI73pVmkErmVbOg1Q5QQoi4ybdPzueX8igOH/IEnhUfSuMwVMYp/qPiD/fQb7JlFwId1
         fTlvJBlr3kDG2GlDyvV4BlYR8QyI4755iF+XBkK1Bv/0JJ9CVCzYjXXRl/7z3kf2Cl6o
         UFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=X3pBdSNz1QDWKVCx9+eBL6HuTUXmYJAn7SbQC18GYHU=;
        b=Z+NCIN9murNSBWYBEc9KeqJajNqO6pFXBoo8tWTLBDaasVd9O1Xb5jMQ7Wu2hwlP/g
         OKggzFXpHtGlRG1GnjI3ndvgRK5l5sPxIx7s6/PPcmU1JRyWb0UMz1Q6fBSBpSqAeALB
         7g18NBUK3L60LXqETE/bu1gx1BlQSwxFym2DJYoDIC6bKDfseb0wgomvbqsAPNFqO0y1
         quIboFKrm6Kjtdkf5MNUTGqKNJqDrX12sGx4d1fozi+TsVWi8i7C4mc1WIbq2J4HrVXO
         EQXGkIGTyRIk+jG3jyPNKoNRdKYWHX6eErZTT92u6xCJqBziq8Nt/dERZANk91FLQMxG
         bBtA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fFJZNxrs;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fFJZNxrs;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZo1CBVYW3N56DT/Ku6N04+QhY+7/WZ1rYriAuc3IpNSDSZl8XUuEdzkAfGJR2ECXYitUQjoCw==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org,
	jsimmons@infradead.org,
	andreas.dilger@intel.com,
	leg.drokin@intel.com
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 1/2] staging: lustre: Fix spelling mistakes
Date: Sat, 12 May 2018 13:01:53 +0200
Message-Id: <20180512110153.6797-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600255873512183341?=
X-GMAIL-MSGID: =?utf-8?q?1600255873512183341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Trivial fix to spelling mistakes in TODO and README.txt

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 drivers/staging/lustre/README.txt | 2 +-
 drivers/staging/lustre/TODO       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/README.txt b/drivers/staging/lustre/README.txt
index 0676243eea9e..783959240490 100644
--- a/drivers/staging/lustre/README.txt
+++ b/drivers/staging/lustre/README.txt
@@ -4,7 +4,7 @@ Lustre Parallel Filesystem Client
 The Lustre file system is an open-source, parallel file system
 that supports many requirements of leadership class HPC simulation
 environments.
-Born from from a research project at Carnegie Mellon University,
+Born from a research project at Carnegie Mellon University,
 the Lustre file system is a widely-used option in HPC.
 The Lustre file system provides a POSIX compliant file system interface,
 can scale to thousands of clients, petabytes of storage and
diff --git a/drivers/staging/lustre/TODO b/drivers/staging/lustre/TODO
index 94446487748a..5332cdb19bfa 100644
--- a/drivers/staging/lustre/TODO
+++ b/drivers/staging/lustre/TODO
@@ -12,7 +12,7 @@ addressed:
 * https://jira.hpdd.intel.com/browse/LU-9859
 *
 * Track all the cleanups and simplification of the libcfs module. Remove
-* functions the kernel provides. Possible intergrate some of the functionality
+* functions the kernel provides. Possibly integrate some of the functionality
 * into the kernel proper.
 *
 ******************************************************************************
-- 
2.17.0
