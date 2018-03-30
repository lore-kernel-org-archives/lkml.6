Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+WM5/oUQXNUzMFgaKoUMzBF7i6LtW8MwKybv9rDY5U+5gn+e1iWYZRA0jYHPv/wCH5nNPv
ARC-Seal: i=1; a=rsa-sha256; t=1522393800; cv=none;
        d=google.com; s=arc-20160816;
        b=regASHn/1yQEiZj0s/SJqbDOEMrR7UpbL9AaMnPQN7EgJnqnmFlvsrbG7Xf6vmQd2L
         CY8us9GoMlRWWMDoVgQjDt/j5h3xCrnAI7u1pPlQw6K26R83x58314j6ptkV7IsYHjwi
         p94V/H2DIynbvADDLTKiBFGQLPz6/x60QaJKnQxL9olau8DLKv9hw3XPbcx5L2hzpz39
         qvsazC0Fck02pEEefQp0LAE7yc6MexbHCu4f9CqpahZPKMGqUrCwPieHUV6xJCLWuLFB
         2GIyi+/eBpEBXMZSugDG5DP8uzvzbWnMCi061biZjBfXi2lwriMnvfeFzJDsbt7tz6JK
         AYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PQvkBxqDh5yki8yCbZgzHHVD4ZH36ZfXBCKJdqTcrvc=;
        b=Xk3Itmdsx8f/bzgP/ct3AW+oHmVIGG3MwNY31WNAJJPbrg+S6BAw+Cds4Jb8mJo8sZ
         4wmhAjA1eBBT6UaLpT8Z9bwLzhEsG4+ysWOE5AXmXOi2eSTiXNh2owRjNEd2QHHBzi5N
         TBMvjz/k89oJLS6NXsjM7xECLksZ3YOC25eVBuOLg7elIEoLGgQc9/GKx0/5K+Ls4oHl
         ERIe1asqbOOMge2hJzgcgXXicgoGpJfuDRWkZq1YrWbiu0lr6vJBjhXG8XUF5KC1gMiw
         DvoqdNhCG1tRICYYE/N19ZOxGHe/ceAL7ODoDozakWroruTC1RuFmMGFisK1iiKnKHgV
         oBdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 71/76] staging: ks7010: Rename ks_wlan_set_multicast_list()
Date: Fri, 30 Mar 2018 00:08:36 -0700
Message-Id: <20180330070842.25224-73-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:n7bHACMC/hHovuAsGnNuwjEdBQmafE/qbmGz5HVWjIEGxKFzcWP
 XymzciCAWw9877X8KQkDDRtfbBuTW+4HFvingzw/ptOZruuHyJm7g320JO2n9eGB4Nav6pf
 aAgXPBC49GwBrdp5qjkByzeiNCgd5zQjzINqyltCSVV0nJ+ASNVStE7RmqkhsX2nHfCnNQA
 tfr5XxGdhCd/fWwe7otBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fO+yrrXsD1Y=:NMPilb9/3/MjSUb3Sij7Zf
 7JgiNWIbvck5fCIKCgLKd7HIv8taNLLJR5rjASmIZCpUjIot5B0ZTH5gYA81bD9nEVclKj/ML
 cHkfrFYs07zTzmb1MvhVXCQyN3jwiDKBxnOEuQOQLipkWnmYSIggsPvjhpZYDGdvEXr428+nK
 f8gGlhyPhvoGsENSt4xvUQmPyzt34v9yo+mauUUJBAebw9QYMYH7/VapUk0qrBnJ67CPdHxwR
 IGKWMADDBzQG+MWP3zRabFpgtwLkU1jmikoqLZZCu6FJWwdeTz5SslDT5vNP8lys2HaVXZZLD
 R1iDN0dtfaXziMU3hjD2+ip+mkmlg+rb9V14tfuAZTws1ej/3K7F3DpU6oPsOdQd4sWpmV44V
 sMPn+/TBKe2Byl9PtFC0lyfYY7pC5OV1jWfledOSmCSc81yTIx4awQcEAyFtJ8Glt/plHQmbV
 IGSlqUaVAwl76BO1cVBXLPW3alw6LcSHy4pb1IsLKQBZzc2b1bh8EVYi90tCw5s4bojrK8v19
 dNQOH6oqe9+X6r1SbJgF2ORd6SbyW5bq9+DBKFuOdyZCzUV2gsRPbjGtpnfUbVXKZo5vRBn8p
 +KmAJGk4RuqthBjMCTyAPtzUY/pEPHQPeCepPz45NZ/yCGbtzyI0WBZpM0WBxz+ggYlC0XNKp
 9rcbeESVGQd0Atgql4kWDhImncNBE/IJztUBRZVtXPm+OCkmKPhDn9WHlRkr6uAN4CEXtnVeM
 afRN8nUwYWTCvdzP96q+lBVbmrRcwAxvSdt1Hw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345599842678462?=
X-GMAIL-MSGID: =?utf-8?q?1596345602036743422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All of the net_device_ops callbacks are named after their counterparts
in the kernel's 'struct net_device_ops', except
ks_wlan_set_multicast_list().  Rename it to ks_wlan_set_rx_mode() for
greater consistency.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 35c615433687..5c5569000fce 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -73,7 +73,7 @@ static int ks_wlan_open(struct net_device *dev);
 static void ks_wlan_tx_timeout(struct net_device *dev);
 static int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int ks_wlan_close(struct net_device *dev);
-static void ks_wlan_set_multicast_list(struct net_device *dev);
+static void ks_wlan_set_rx_mode(struct net_device *dev);
 static struct net_device_stats *ks_wlan_get_stats(struct net_device *dev);
 static int ks_wlan_set_mac_address(struct net_device *dev, void *addr);
 static int ks_wlan_netdev_ioctl(struct net_device *dev, struct ifreq *rq,
@@ -2816,7 +2816,7 @@ void send_packet_complete(struct ks_wlan_private *priv, struct sk_buff *skb)
  * This routine is not state sensitive and need not be SMP locked.
  */
 static
-void ks_wlan_set_multicast_list(struct net_device *dev)
+void ks_wlan_set_rx_mode(struct net_device *dev)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
@@ -2864,7 +2864,7 @@ static const struct net_device_ops ks_wlan_netdev_ops = {
 	.ndo_set_mac_address = ks_wlan_set_mac_address,
 	.ndo_get_stats = ks_wlan_get_stats,
 	.ndo_tx_timeout = ks_wlan_tx_timeout,
-	.ndo_set_rx_mode = ks_wlan_set_multicast_list,
+	.ndo_set_rx_mode = ks_wlan_set_rx_mode,
 };
 
 int ks_wlan_net_start(struct net_device *dev)
-- 
2.16.3
