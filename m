Return-Path: <sabin.rapan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526495267; cv=none;
        d=google.com; s=arc-20160816;
        b=SWd//qxiN/IVpwIxrHoTB/XUxecCJYD3X2GCv8SCaTehAKOdTPBTKWodPAnVlbklq2
         hreSSJvLAoGCzNWxV8RSsq+OO4qhRDIQ9CDtQNnK2x4e/gpvtmAnvtA+iZmEk5VTOqml
         4EkSp1FsNvoMCO4tANeaaDHMUgWQ12AMtn6m++LH80ua6UcchDS9R7sZ/giixQAjvVyT
         EpKHZG2Y2u63tfzgsL3nxQiwEeruCEaUWp2M107m0Vljh8Fa8noK0+5ko/ykIzYDiBX4
         LblPiymIgjBTQbcQ/+C5u8ZIt2s8SXbYPS5kIdqSGn4kPgaER13Z8W4j6CQCCml8onKS
         NtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=E/lQfvbpEXWkzo92o4NlP/ucu4GmPTYiH49NEEmSCH0=;
        b=sGvFWT94nz/7HSeVWVI9kAbkV+7k8re3/d3a4ylHAoSDqrrf7ZnchKKT6Jd7frrt27
         UCq+kwus/Y4OvqdbMvSzD6SbS6vM8mMOZAR29H8TSfXDznaiIMS3FnmIai3cRnQZpwK9
         Ts7VL3Z4mG+iHNMYsSaiLaGHx/cPlPS8ecYfgZPn0Jbhp1Nrx7R1+pkTu7n9xOmzEuFo
         HmP8pvKAeYpeT2cD8V036neHTWeJbbpHwl0h2Xg3CnA4k+OTwfCT14gotQEVcazz9gAi
         7ZKkRIj3xbyNzGsPJTyauvBRxrGDupcUIRBt+Rko26Ws3rkxDw83uXIjDK2WAOG4wQWy
         8sqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TB1Z1zZE;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TB1Z1zZE;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrd68NtG2slHFxMqJ/FSVGW4rRXJ0vImYsA7SrPSy/VqZl6s81Rnu63TYFMikFiYtOCUCfQKQ==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org,
	jsimmons@infradead.org,
	andreas.dilger@intel.com,
	oleg.drokin@intel.com,
	lustre-devel@lists.lustre.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 5/5] staging: lustre: Fix "from from"->"from"
Date: Wed, 16 May 2018 20:27:43 +0200
Message-Id: <20180516182743.5387-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600646301719167980?=
X-GMAIL-MSGID: =?utf-8?q?1600646301719167980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Trivial fix to spelling mistake in README.txt

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 drivers/staging/lustre/README.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.17.0
