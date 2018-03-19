Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbeCSLc7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:32:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53903 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933042AbeCSLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:32:44 -0400
X-Google-Smtp-Source: AG47ELtLixVMppEqlwICOvPFMZQlaYnYOUpB3ea0RDdARGpwZ32II8UR6ousm2r6cbagpRf7Y6rBNA==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: space required
Date: Mon, 19 Mar 2018 11:32:22 +0000
Message-Id: <20180319113222.6725-4-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319113222.6725-1-paulmcquad@gmail.com>
References: <20180319113222.6725-1-paulmcquad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

space required before the open parenthesis '('

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index e0e6461b9200..ec4b6b2bbf9a 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -94,7 +94,7 @@ static void hci_uart_write_work(struct work_struct *work)
 			hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
 			kfree_skb(skb);
 		}
-	} while(test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
+	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
 
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 }
-- 
2.16.2
