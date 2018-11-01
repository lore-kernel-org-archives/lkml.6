Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB25AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA952064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA952064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeKAKxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:53:49 -0400
Received: from mout.perfora.net ([74.208.4.194]:35161 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbeKAKxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:53:48 -0400
Received: from localhost.localdomain.ziswiler.net ([188.155.129.42]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LqBsM-1feYbp2u36-00dm8M; Thu, 01 Nov 2018 02:52:50 +0100
Received: from localhost.localdomain.ziswiler.net ([188.155.129.42]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LqBsM-1feYbp2u36-00dm8M; Thu, 01 Nov 2018 02:52:50 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-serial@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 3/3] serial: tegra: fix some spelling mistakes
Date:   Thu,  1 Nov 2018 02:52:30 +0100
Message-Id: <20181101015230.27310-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181101015230.27310-1-marcel@ziswiler.com>
References: <20181101015230.27310-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:hKj1LNPrmR2PtZRtqfLLnesEuw2sTQ5Ibd0wz0egqOv3aUEFi9n
 6oRTQYdzVnVU1ZZpui+4woe03Q0wb6i2sPiMi50IruvBzbhEY2Rbmt3I5flXPPXy6NOmV7C
 q7jNCRniCsSz+9Hpfzl+0TSPmDrhqyF1GFdU/Q14GqUgui6bXJClT0S4w6ZheRFdHcgDsZn
 AtvJ4J7fMA9+coWPTVOcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hxY/ToO7yss=:0jjnHLy0PaqauCJZJJ1Vh/
 /Op5QocBUb2HTv3i3PP1J3Xk0JoVhDQyawuf5xwgjYsVmd60qI8De+KbMjOSTYqBhRycj9Xsg
 G3YXq5TR4Rq2SoSkqO0nLJyeb/UgzvIWf53j9/WVzIRkFWj4iSoUNRKMrhyt8YuW1N8XjqYVX
 KmFEPjjW9MPXpQh9qJHYakO+iW3l269Htcky2fOCtKa1W//uJg3g3PMj44pEHBf7sNidk9h+4
 ZWZVXTPtHkBHMTABPnWGJ71TVGwvbvHln+TfMuBP5Ce1ch6ERnwcDsWRkIY3hFxtyflITQncV
 Wx2145Aw+W48Om3yQc0PIwzma126n2NS0reWlJ61C26sTRHiiCYnCfzKH1sHfILig6IKOKMNr
 0qvWhWcIVbyZJ8qe40mHXxt2bjt7t6JzusqIcBXMVrrXZmzO0T66kyXzUd+87Y79B6FLwJSRN
 ov0FjTRFfkFF41xPyfkYPoPELGZEgGHkeFPuXj7ep57xe0buUgh6WcukQH+fuyGD0gcIriC2i
 xUGlW0lBbjaa+NiU2pu1ECaPB8COakbXuZV1qSaf3y2+Fai09QuvPtnyrsA+nbM+BgtOTVqYf
 CQHUG9hpKro3d2JluZ5fD1c+LUPT65yhyjlsYGktaDh1FlFMcj1Zc6rz3aHUEmonc9j6TTlq5
 bKK7R6v3HtfejPGEcVUFEsGd9Y4M2yQs14ZX1aUMZKVYO23HYB344rzwT6z+MnGteFdM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix a few spelling mistakes I stumbled upon while debugging a customers
UART issues.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/tty/serial/serial-tegra.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index af2a29cfbbe9..d5269aaaf9b2 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -746,7 +746,7 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 	if (!tup->rx_in_progress)
 		return;
 
-	tegra_uart_wait_sym_time(tup, 1); /* wait a character interval */
+	tegra_uart_wait_sym_time(tup, 1); /* wait one character interval */
 
 	ier = tup->ier_shadow;
 	ier &= ~(UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE |
@@ -887,7 +887,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 *
 	 * EORD is different interrupt than RX_TIMEOUT - RX_TIMEOUT occurs when
 	 * the DATA is sitting in the FIFO and couldn't be transferred to the
-	 * DMA as the DMA size alignment(4 bytes) is not met. EORD will be
+	 * DMA as the DMA size alignment (4 bytes) is not met. EORD will be
 	 * triggered when there is a pause of the incomming data stream for 4
 	 * characters long.
 	 *
@@ -1079,7 +1079,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	if (tup->rts_active)
 		set_rts(tup, false);
 
-	/* Clear all interrupts as configuration is going to be change */
+	/* Clear all interrupts as configuration is going to be changed */
 	tegra_uart_write(tup, tup->ier_shadow | UART_IER_RDI, UART_IER);
 	tegra_uart_read(tup, UART_IER);
 	tegra_uart_write(tup, 0, UART_IER);
@@ -1165,10 +1165,10 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	/* update the port timeout based on new settings */
 	uart_update_timeout(u, termios->c_cflag, baud);
 
-	/* Make sure all write has completed */
+	/* Make sure all writes have completed */
 	tegra_uart_read(tup, UART_IER);
 
-	/* Reenable interrupt */
+	/* Re-enable interrupt */
 	tegra_uart_write(tup, tup->ier_shadow, UART_IER);
 	tegra_uart_read(tup, UART_IER);
 
-- 
2.14.5

