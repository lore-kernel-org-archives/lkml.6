Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBHEU5PKAKGQEU6PXNPQ@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520093724; cv=pass;
        d=google.com; s=arc-20160816;
        b=jDepgJHvDm5vouYZJbBSORjtIYB7qlAeQ8+Wai8g8NXesKAveSUrwD1QdJjH/tx1Pm
         gL6qE/buk4StVmnnPtkg8cKOPsug0wQGpuUPqqOP8JutwIUjXZUd2UKWvTrwZQh9CPCk
         JnFNDk8h+A/ZkZhb9PgFVv80kcHWF97FK2zWKNpHWtMmJULJvSuzUfvy9A8RMutGEXGH
         q2eG2u9YMh5SRJ1icw610FTzxSllnuufFUFbalDE71MvagQZf9ne6t7u5BEQ+MOBr66h
         OQYWrDl2EkQmg5kdovRx+37ykcy5Rc1Zu1SD5NPaWInMt71V0oGzy8Ci3dhbbMlBjT5+
         dyGg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=vuVT/DFpRjcFmG8LqOGyFHrbuvZXIug67F8ai6zmQG4=;
        b=NhRMXUuUW6+LGSg6Avb9b/WZwEGwQIfMhcHvtGuAiFEHDa9pkmPwOjYLrV6aOXzcae
         38OHn4B5O1NGB5sR1j9FZuBiVLxDcRY4UMq7i0Ns4i9iXdtrY/O4p3kN9n9et++iPNF5
         4yN+AlgiVRVPNB+AESKBhYS058QMTo3cqU16lMRKBguC6YmeR4z0ciuXfl86wt1va9ku
         p1vGtOWjpV0kmGMuDAEkjNOMytJi9yKq7FAj8RhwUxCFk/Kh8JIWjioXB6aQFHVKbt1c
         s+JV0OELloL1ldxHJREGrAkJjASnOtEmQlI1+3oEKvpKf5rn6dY3G6pTaiufjH1dJ0mU
         wi6Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=QQiycy8+;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=m73cvR0r;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbheu5pkakgqeu6pxnpq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBHEU5PKAKGQEU6PXNPQ@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=QQiycy8+;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=m73cvR0r;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbheu5pkakgqeu6pxnpq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBHEU5PKAKGQEU6PXNPQ@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1520093724; cv=pass;
        d=google.com; s=arc-20160816;
        b=yqeYIIJGV6fzjLFZQDkSal+z0JKjJs1knP9vI7MNx+U7upAKleAIi5EpiMVEWy7oPx
         1x0jJfHR8zZO4UX4YQ14t08P3GzZBpy2DCJXVlIv3LrYBFOuptCl7bfbAShmAqVKbTNm
         SCHhtY3IDMucZpcdlYWaOokKr8gnde0p5R6xAde3xBY0b/r40b9Y8rXV+kncUGLuGe4R
         J0OGbZ805lO2W9fBqDHIKtkBbLJbWNT7a3J6+hUZBl8EQRTeuzVtHYIMNlP8VPJj22fY
         l79gSZwtBKFrT75/BFXHP20WCw2dCTWM7lBn003kZETO/XrjtYuCvL3z4ih3aQwx3GgS
         wUSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=vuVT/DFpRjcFmG8LqOGyFHrbuvZXIug67F8ai6zmQG4=;
        b=yPH4iY+NC1UFYQglpSNVfaLIfoKbp+DeXPVVuX6YhNVQtvQxx/LyZsHJvsHGzVDI5u
         DU1duBt8GJcACta9l9ti/3VOLhYZ4zItA2+kjSoE0hMhfubhSL2n1P0FJwSHYb2D93Q7
         2O2gYAIX2Qm/uYNw3DbDfrm0pDPVgelm40NlrzMVM9fA1oKObz/XJTRtrG/SUwIxwNT8
         QFHPiPKHW30uqrzx7hgPOsiYx3bzVvz6qAPbypwBNT3VRjgWrWBkrXH12J8vxjnD7s3m
         20E3Eu+1FyexKTWWiE+yAcrOSwZPbe0squQ9Jh9oJgMvBxC+aks090zgdSdYlrfaRYyC
         YKgw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DozxbTrQ;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c00::244 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELux+Ke85JUKBy9iG+0LZ2vJyBZ23SEirLahJ9wwriIYvj83YZsrrMcAa7aYaQ6TpkxD8usyYw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520093723; cv=none;
        d=google.com; s=arc-20160816;
        b=O1VXVqLHnebZtBB414vIKWy6YohRgi5Xusnr/UQT7BqbUmgOVNb47Hgv2HZdAYp2L4
         mFKX3ElRYBvxa4tFTI/1eZSyjlr4m4258Bzidlu9Kn9IK5asLIbH9ZdNNpVcWrIeiUJ6
         iaq/Ce472oq/L5HYM84T7FPrllx5OinsWWzeKY+ZNgaNCjmPMBcMDwKOtR2ksWMw9okV
         XhDXF81234M53lLOTIe34ATzvn5SASZj2uAf6ZcnDPGCv2HJ/lN3hyih0AXPVf1AHSoW
         PGnFve8fKJFYvkBm/x2lP3n0kaKguVx7UFpKKf8XcezwUoxwUB9bvx6D8w4kKeH8ZFLu
         jeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=t0HQ6YV8ds8Vb/vE8TqiZEc8+xTnMGLxddhz3oyjnk8=;
        b=Sn/iJkBVzB4ZjHHFDzpsNTht15VbDnHxzYpvPHInCDcRStod6JSDJnZTJCbtNMfMjw
         rtrvYIJqyXMN155qeqShUB/4WVYv7NwKVwXutB2zTcpTEDxgX8RuhNa/M+tj2B13XjP8
         oYwQ9qZ1S3ZDxNzDx1x5QFDWFQ0aWrKDdE02QiQplh523npJqpZeh4LM0RyKnhkbtmhW
         l6roLVp3I0BTmJP3wHcpMXm50/y6fCePNeJvExWtkkuDY3eldRw5/3YrWknD5oQBRZZf
         VpbUJk97bU8K+VE48xsbNtbdYbZ7G85Rzdlkgbc425DEhbG4UNxYYQ0zxQS/S9ZRQvBp
         7nlQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DozxbTrQ;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c00::244 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Sat, 3 Mar 2018 21:44:56 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: jdmason@kudzu.us
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oss-drivers@netronome.com,
	outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] [PATCH v2] net: ethernet: Drop unnecessary continue
Message-ID: <20180303161456.GA20194@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=DozxbTrQ;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c00::244 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593933797410411478?=
X-GMAIL-MSGID: =?utf-8?q?1593933797410411478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Continue at the bottom of a loop are removed.
Issue found using drop_continue.cocci Coccinelle script.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
Changes in v2:
- Braces is dropped from if with single statement.

 drivers/net/ethernet/amd/ni65.c                   | 4 +---
 drivers/net/ethernet/neterion/s2io.c              | 4 +---
 drivers/net/ethernet/netronome/nfp/nfp_net_main.c | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/ni65.c b/drivers/net/ethernet/amd/ni65.c
index e248d1a..8931ce6 100644
--- a/drivers/net/ethernet/amd/ni65.c
+++ b/drivers/net/ethernet/amd/ni65.c
@@ -435,10 +435,8 @@ static int __init ni65_probe1(struct net_device *dev,int ioaddr)
 		}
 		if(cards[i].vendor_id) {
 			for(j=0;j<3;j++)
-				if(inb(ioaddr+cards[i].addr_offset+j) != cards[i].vendor_id[j]) {
+				if(inb(ioaddr+cards[i].addr_offset+j) != cards[i].vendor_id[j])
 					release_region(ioaddr, cards[i].total_size);
-					continue;
-			  }
 		}
 		break;
 	}
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index b8983e7..4738bc7 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -3679,11 +3679,9 @@ static void restore_xmsi_data(struct s2io_nic *nic)
 		writeq(nic->msix_info[i].data, &bar0->xmsi_data);
 		val64 = (s2BIT(7) | s2BIT(15) | vBIT(msix_index, 26, 6));
 		writeq(val64, &bar0->xmsi_access);
-		if (wait_for_msix_trans(nic, msix_index)) {
+		if (wait_for_msix_trans(nic, msix_index))
 			DBG_PRINT(ERR_DBG, "%s: index: %d failed\n",
 				  __func__, msix_index);
-			continue;
-		}
 	}
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index 15fa47f..5cd4f3f 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -258,10 +258,8 @@ nfp_net_pf_alloc_vnics(struct nfp_pf *pf, void __iomem *ctrl_bar,
 		ctrl_bar += NFP_PF_CSR_SLICE_SIZE;
 
 		/* Kill the vNIC if app init marked it as invalid */
-		if (nn->port && nn->port->type == NFP_PORT_INVALID) {
+		if (nn->port && nn->port->type == NFP_PORT_INVALID)
 			nfp_net_pf_free_vnic(pf, nn);
-			continue;
-		}
 	}
 
 	if (list_empty(&pf->vnics))
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303161456.GA20194%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
