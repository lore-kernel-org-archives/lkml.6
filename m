Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966519AbeEXRad (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:30:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52412 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965481AbeEXRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:30:29 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 0/2] serial: imx: more shutdown cleanups
Date: Thu, 24 May 2018 19:30:22 +0200
Message-Id: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are two more cleanup patches for imx-serial. Both
issues were found by code reading, no real-world issues
are known.

-- Sebastian

Sebastian Reichel (2):
  serial: imx: drop CTS/RTS handling from shutdown
  serial: imx: disable UCR4_OREN on shutdown

 drivers/tty/serial/imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.17.0
