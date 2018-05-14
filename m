Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AB8JxZqOPsauYw0abfZPas6lEX8HOoGFviZ7zwO8hLmALNE4CIX6M2bY3NwlHsoT4FNHoJKokSGM
ARC-Seal: i=1; a=rsa-sha256; t=1526334913; cv=none;
        d=google.com; s=arc-20160816;
        b=imZwu7oBjVRhGHt4+0KKyzcBrSD6cWvwdUaVVgPFaT++jPwWmdJCVV8vgO9l3jo2d8
         LV2AgEHKt23ArRO9C91ForVLyz96QTYlwJrOwOQY3L57bZ8RBwCY789upgsNGpZxklsS
         apmV0+jzICJwrWWRhdf9Jm7bP24/dQkV+IfoSgM4obBHIx+3ZidO9BFb/p8BHw8+t/P8
         3a6cL0WNXdfOJdRxEiZwSI+uONd7yRxZ3PURxrpCXSnLLvMJvRjnW5Axd1kkkCuZ6XkD
         yBqfjS+9Ae283i60ZFv+Ox24mXB9He33nEOQYu/XpslAuPVLS1A7E2H+r4VflaOXa3BJ
         S4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4Ugpn4mrtJm7ENiNBt+Bnq8KamOJl5RnkThZJENqjVQ=;
        b=l9hk/KauD6HxibUXd86v/Vlc8tShz7OiTtg7RBI6522bPS+eeDuzkYVuCFDabaUV/i
         LjAMZEtcyGvEWpfKi/+qWxFv88hMw1lHQ7EUTbbzK6ijsyg+7NFZYQLOD90H8jRaqOmR
         UejfqUM8iC+ZEUkl5AxhAqpmALRdrTtPIeloPiBAg7cDD6vU9fnX3DsvvvX0aD3cDMdo
         PmbABKFLS+pIXOovHDRZkA8YopsXGvlxmAp00WITPU8znjlS+oeakXdj2UOI5Fsi8qTN
         cgWjfsNBmunpGDJ9zD/xmDs5MMv/P8SRf/J3qvwK9cFBuKCe0PxruKQQ4U8oTjl/k7UA
         uSYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=SMqpmDeO;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.41 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=SMqpmDeO;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.41 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: LvrKWPcVM1nMavrPr491I2YjjgLKRkwqKDV82oSapzkBYzJJiA.eYUxIfTm61se
 GjvDbDtCUkIyItlBsDrpVbKNTNdPn6P_U6P39NYL9qYFkEwDgE1CW2nV.3N7nRYrRkITnHl6bVx8
 I4MMngNT3WkmUD8YnG.gfn2wUpZwI1QPafmEe_1E4DMAp0gYeD0xPTk0CyryTI8aa30pTCI20rxw
 3A6sP2x9I04G_GgcWyLuqLH300AuJF1eZ.opHz6wcwHw.kPPaSJsIUCpFEDft3GyFkGmy1RCg1m5
 .UVq8g4y16QA6iXvY5jTgMA5zudJzB_0W6KXPSaH1WmQ6jU9Mc8zyBwYaT46FPXL2N.l8L_bKk5.
 ZlqqJktbK6LsTyqzM5Cg.GsMLYHvzqmVf5llD1O2CeqI0jnMFQEFKysLQpRd8swGJNIT96O0TPNF
 amQDMRmrPB6HuP5He6uvoppBM0j6227bzANdf2ScnaSZlvroiLxChke6VkKadM_tShp5tpTn3VdA
 KhZoTN3vSu7NtL8Z_ChlGIKqZNz_H9rwfqocYlOyxo5R24OUG8AyjD1iHqI1HpWdl2JRpBZJNVN2
 dpZDYXS5MrS.Z1PfjJFiwiQ2xZf6MAeagHGYeLD3YYoNuyYz.BqQuzstpPk5q9668uSObvUPvjwQ
 GK84R_o6Wcj.iwTbrSXYsC1H3_kBSOcvl
From: Jeffrin Jose T <ahiliation@yahoo.co.in>
To: shuah@kernel.org,
	kstewart@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrin Jose T <ahiliation@yahoo.co.in>,
	Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH 49/49] selftest: intel_pstate: More accurate error message and also a debug support message from aperf.c
Date: Tue, 15 May 2018 03:24:54 +0530
Message-Id: <20180514215454.9337-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600478158436689024?=
X-GMAIL-MSGID: =?utf-8?q?1600478158436689024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix for  aperf.c to produce the path of the file which is in mention
during error report.CONFIG_X86_MSR=m support requirement is also mentioned.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 tools/testing/selftests/intel_pstate/aperf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
index d21edea9c560..da98c1673f08 100644
--- a/tools/testing/selftests/intel_pstate/aperf.c
+++ b/tools/testing/selftests/intel_pstate/aperf.c
@@ -41,7 +41,9 @@ int main(int argc, char **argv) {
 	fd = open(msr_file_name, O_RDONLY);
 
 	if (fd == -1) {
-		perror("Failed to open");
+		printf("Failed to open /dev/cpu/%d/msr:", cpu);
+		printf(" No such file or directory:");
+		printf(" Make sure CONFIG_X86_MSR=m support is Enabled\n");
 		return 1;
 	}
 
-- 
2.17.0
