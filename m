Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBLN55LKAKGQEHHJ7VXA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520082605; cv=pass;
        d=google.com; s=arc-20160816;
        b=H8rclvDqP8MvOzbBrqAZJWwJJSGuA/6qqoGvcyM3aL95h5wdmLmzBuTwMyHKz7kBwm
         ZTj7KVqJlIZp0m7lvxHSis6jJOR1JufPBGd5s9OHO4Zm5FmXSAGGLHtgjjDtIpvkbkwE
         0ohfQn2QEFZr+1HQGbGTnPwY50Ia/g9fh0R/CZYHVnn3dCQ00Ph14iSSrUwA/zQA2s4Q
         /Uo3tOq32UJVycjX/aLdNACqZDydYkbmH1qoaTefc4mm+gVCB+WW4DosowFrVAT8Dh9g
         DQe+cT5Un0eYHIB/5UGfQnWmfA6hg3YFXxRm90JfxA1YAMSIwvcodmBe3FzOY/dOz2NQ
         f5Sg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=Sb26JI5iRsaG6Fu7IZtHQLzWE+3gtXxCxtPX9xPLGRM=;
        b=EQ+555AKUmyIIwpINr6yCeowZrNEQbaPDcaUpYAtRncrC2uvk6Ta0uwShgmk1ez5CL
         ge+0b46DIfIwIT3YrvBAoETnTn646ETYLbgpWsONIUudes58pYfJoQOzOpCwX3KK3H66
         XxIEZQCoLCv6+qIH1tmBocsP+oLuPqG/ITFa9o/mND2gqHMZM45h1fZHrWR1WRRvuOV8
         cLj9wL5mwV7L2KARLqNA6Njv331bMuSaJfVdyOLjVGa6ypu4RUMDsXieHBX4dIlvJH62
         5WabijdwiBsDntZ1ef4Wze1pxR36LxonHv0rKzy703PFfwjncVYrHZqffO/xs5o9GJMC
         bF0Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=IzghoTv0;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oCo0xhNl;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbln55lkakgqehhj7vxa@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBLN55LKAKGQEHHJ7VXA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=IzghoTv0;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oCo0xhNl;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbln55lkakgqehhj7vxa@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBLN55LKAKGQEHHJ7VXA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1520082605; cv=pass;
        d=google.com; s=arc-20160816;
        b=ss8jTh8zvxKY2QSrGHNN7gFGqI+Up5ECEC2VBX8KToVpARZaFVJjt7HlSUOetUTld7
         mu50aH6epBXSOiqK3rT4LDn7DzH5JMoIECO48s/dvXfOsR8ypVDsM5Ap5wlvBGeAGXh8
         hK5Gs0wfRPaxgnNt6069Eq0hBoc+Cc43FOyC5GIcatN7YPIC+CHpbtRac0eb0f1QBE93
         712NNC7piaT0LAEEVZ7sZBmvpikTTPwFIiIRJP6AnY5Zo+mnTtXjPpKulaQaHSr71xPP
         cYcH/Hrz3EgJ/qdzjqtMaSQGHB9amkVFdSLvYrf6k/M9i/9L0D04L3AOKWdJ57shykxR
         9Gmg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Sb26JI5iRsaG6Fu7IZtHQLzWE+3gtXxCxtPX9xPLGRM=;
        b=VCIlVmgHKx1nSXfgIElyeiJkO6gNowv6/s8cP3C3QnOFzZdLemj79Lr7sKzY5nq4jo
         89kcGxFh4/4/JA4t3XS3rkdN/xpGb7digPlTwPCYbq/4poWQSLfb13WEDIWSFy0p0VBt
         bCHctj7GbvnwEKzl8V9C9TCRsqZcNXRQiwwGf5q6gR4BG0P/nsT7fp/Ypz7IE+JGy8f3
         cyl+kmof/zc03eyCk8CGIqJS9b3ypFckhU6uujbzaV4Kap7wwB+moZvBBKfiKmJIKH0t
         0moABY7KkNES2yB+EZG7zuGRLWPKJBYKNGZNGIqEiCs5pji2+e+LjCj/fAUXYkQ6qrMD
         81FA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=duVsVAde;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c01::236 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELu2Z3bqWBi3RNT8RHL/aG/x+VuVaeavAJW94taVcQOWKXIhG44XJW7AH7J2pYIWMr4LkP6y/Q==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520082605; cv=none;
        d=google.com; s=arc-20160816;
        b=htOHqY61sSdJ0OqJ4xMwVAoTgAe6TCIh66EVIaryLX2sd+HOZPpmt3fY+DQ6XYXmds
         kglVGIYNVEOrEKEq7cT5SNjDdF2kNtjrejkrD19nCfVR0OdATX0XN5Qf9LJUbIec7GSI
         EEofyz08h296YB7gTfSmE39EWNDLgmQ2VU1n4/ZND8jhLLCZ0sjq8y3tog/BZew20Og4
         /+O14LjP8AGlPUUkfk72mGxUt6EVUDn7fIXfn8+sSlv+A1rwGwvJddOWAyC4uiNsNr3a
         GD52qmzwf0p8TyTLCudyOLS8jtGyu8xpgLvSzngrtatBD1qenWxbL+1QUeerxHZCM6d/
         grQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=PrX4uBkV0G6iFmA2Rt1g8J6WoqbpIjfVQOnavqHIMrU=;
        b=0cBK6ip1K55tcauI+zagAVN4+HfOO5DSDvmyIVSqAqiTgELIum33d7KLqDUU7RCLnt
         zGZNisAx/0UNummLKpRsxvqewgXFLBgnazcFVXLGhjXdrZrWlfS7HbORGkf+pseWM0u/
         Yjh4qhEvgUU/GbTsQYKRzjf/z8MOcKxyDuutyNQIYpxsRoqxDvqvR/iah8tiBe6J4AoB
         RuzCU5KOcCYRLElw7JNixy0LtltKH8XLpuziPswbfl4Xba+0IMqYjUili8IHnq1VCP6U
         NV4CuKtZ7btemp8+tzYLzhuwpE8SYOm/GBx9pv9uFQCwkmXube/szagqLdf2H0roSJMF
         DLpw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=duVsVAde;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c01::236 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Sat, 3 Mar 2018 18:39:34 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: jdmason@kudzu.us
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oss-drivers@netronome.com,
	outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] [PATCH] net: ethernet: Drop unnecessary continue
Message-ID: <20180303130933.GA8337@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=duVsVAde;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c01::236 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1593922138604238925?=
X-GMAIL-MSGID: =?utf-8?q?1593922138604238925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Continue at the bottom of a loop are removed.
Issue found using drop_continue.cocci Coccinelle script.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/net/ethernet/amd/ni65.c                   | 1 -
 drivers/net/ethernet/neterion/s2io.c              | 1 -
 drivers/net/ethernet/netronome/nfp/nfp_net_main.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/ni65.c b/drivers/net/ethernet/amd/ni65.c
index e248d1a..5975f29 100644
--- a/drivers/net/ethernet/amd/ni65.c
+++ b/drivers/net/ethernet/amd/ni65.c
@@ -437,7 +437,6 @@ static int __init ni65_probe1(struct net_device *dev,int ioaddr)
 			for(j=0;j<3;j++)
 				if(inb(ioaddr+cards[i].addr_offset+j) != cards[i].vendor_id[j]) {
 					release_region(ioaddr, cards[i].total_size);
-					continue;
 			  }
 		}
 		break;
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index b8983e7..5123abd 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -3682,7 +3682,6 @@ static void restore_xmsi_data(struct s2io_nic *nic)
 		if (wait_for_msix_trans(nic, msix_index)) {
 			DBG_PRINT(ERR_DBG, "%s: index: %d failed\n",
 				  __func__, msix_index);
-			continue;
 		}
 	}
 }
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index 15fa47f..77916ed 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -260,7 +260,6 @@ nfp_net_pf_alloc_vnics(struct nfp_pf *pf, void __iomem *ctrl_bar,
 		/* Kill the vNIC if app init marked it as invalid */
 		if (nn->port && nn->port->type == NFP_PORT_INVALID) {
 			nfp_net_pf_free_vnic(pf, nn);
-			continue;
 		}
 	}
 
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303130933.GA8337%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
