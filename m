Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELsytb2pBAv6oOLM+9r41RoP1tUuLs8By+owNrIfqzhkApdFLdKg4HC+Y2JKeKEZiAE+lz6g
ARC-Seal: i=1; a=rsa-sha256; t=1522140095; cv=none;
        d=google.com; s=arc-20160816;
        b=vqWjZnvu2MFvzlz/fsQiSZ83YsMNF3Epbw/rO10YcEL5nPmj3yIjmMebu9qz35IM0B
         2yL15XTALqR9Y6oBG7fmChtmlWelUKawK7wmD+i6UiSthmgxM0xf0jKoe87qT7v+fsCA
         KFK554BhCYNQyTC9CY2LWr5xBCNTjClc5aKGVcXK7v1WteTQGhWmgPLnN7TRbnpjNtaU
         CwTlbIX9Pm0NE11fG3h7uD+QuchksMX+/ubHUxHRF6JDabvVqCcldG0xyLl8Ow+tkkSJ
         Zjko6F30BhOqRt7uJJ9A6GUgYTkwQheb3rCtDHACHFiiwYx50svBbcBkFfBmuSb+4EGC
         7KAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=eEm4wSnDbsFHHPJOq5CJJE29YqnY7l5piFakAQGZ33s=;
        b=G6N14FWSuQIDxKn/2re8DiGU1Sn/8i+bTIDRiDrDNwiM/La8pIX9MBXJB9sElyTE7R
         P1xe5v6a9rvTh+Tl06taGeJx+9iJR3Dgd59JgFSh4Z82mqNEZ+mqVm4m5Ol62rSiUpRz
         frET0ijMMzqYtfKUORF6hIQ66ViT1uZv49N/bfQRPrYAPsVuWz3KhPlbR6oaIhzJmR1e
         bdKzUmchO4zmfd0qqEYfbXjuilwR+KuV22tLuVqmo6RhK+P7opFo5ENyzohvl2ZFOp/Y
         siVDmuSN0CiBZWdy5sMGe/7QeidD+F0oatCPaEq39CI/HLdZgCJTVh/LB8DoTyZGb7xn
         qaIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 14/23] staging: rtl8723bs: Add missing braces in else statement.
Date: Tue, 27 Mar 2018 01:41:06 -0700
Message-Id: <20180327084115.16129-14-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Vj1lhxSfbkLQutv9JWbM/o/vfFiOlUMm1N8BEoR4lutyszD0ENR
 BfzO46//d94BWvNbhiYJwyfvh25DkwmZLcqHrpEGXgjcXPBDXEuKI60KfwQdbFJeAQBerCs
 lzKheA7rkJk5n2DuVNOH2Bydl0FKSpY4StecGLEvzcR26Ox2Oy5tpj1atwPTFbYkpi/siyW
 aa/G6fYW6LAbQP6miABgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3w5BAvB3c38=:KYI1iYZf5mkXeDsdzEeelC
 GyQ4Hku7lP11aGfyj7VNXbZa/6XrpGV4tKTSVZuNnRDJ6oPKgpU1uRcs7aAYGkwSyfeAWTvUK
 zhhi4zwlSw2EcaVfD16zKlK495CRlSmfeonKc8+e1x5q7LGolUHyYvw6rYhbzOtel5jK22b87
 1LeD3luupeGzbevLaZUubsJgtFS08l30Ca51oUDP1zjArx1jcRx8r9ZxhjnK+mmUNxbrpbfd/
 FnKiIoyis/2boTNEQfeXPxOMPULrK6+MO18MC0NNTT6eMykHqpDga3FLosBouVT4EnLN+Z7D8
 9IrPkTWnx0NrBSs2M4Qy1CdmXH7iHIDJ+KcFEWQEEYvk2t221PxRdk5t1MrH4IrQESk5FQ3U5
 badia0rKab1zzIOr+4jfQ7tr2wrVL6KgDt3cVtmaoz4vBe7clNFc+zx+aUMQXU816wt4eqVL7
 /Zak3cqmZAOUKDjDXn5FKraEpfCMLtRb/ogDt3JhS/NBSXIMO4wvhRVELhUN0IByb/hFZAZ4K
 8+qj2ii70cfoX+DqAwkbfMdhrmcLtogkFNo+HZGvadeXkEWZ+/MB4ECQ3vyBYM/az0inRv8YG
 3tyvpFR5Nos7XLDAkM6IK1anyGgeMNNfbB9Pi9coj0hlHBYBibGtp2CLH+Ncv/Ks/nxlvWSAd
 +r/3QLH44Nt+TmVnYtTaTtwiWU94+BiKqkkkWqLFgJW9XxDrlXpMkviAVcHGD/POL9GXzamuB
 avDqgshJ5HAVJVduOKLOGNOSQq17iv1T2t10kg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079572297410431?=
X-GMAIL-MSGID: =?utf-8?q?1596079572297410431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The style rule to leave out braces in single line conditional statements
doesn't apply when one branch is multiple lines.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 9c2d6dd0130f..4ba315f1daaf 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -75,8 +75,9 @@ static void update_recvframe_attrib(struct adapter *padapter,
 		pattrib->mdata = (u8)prxreport->md;
 
 		pattrib->data_rate = (u8)prxreport->rx_rate;
-	} else
+	} else {
 		pattrib->pkt_len = (u16)prxreport->pktlen;
+	}
 }
 
 /*
-- 
2.16.3
