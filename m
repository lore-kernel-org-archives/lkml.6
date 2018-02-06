Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeBFP3k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:29:40 -0500
Received: from mail.arcx.com ([184.94.50.18]:52860 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752358AbeBFP3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:29:14 -0500
From: Sven Van Asbroeck <svendev@arcx.com>
To: <svendev@arcx.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <helmut.buchsbaum@gmail.com>, <Maarten.Blomme@flir.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v1 0/1] spi_ks8995: use regmap to access chip registers.
Date: Tue, 6 Feb 2018 10:13:55 -0500
Message-ID: <1517930036-17618-1-git-send-email-svendev@arcx.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.155]
X-ClientProxiedBy: webmail.arcx.com (192.168.2.64) To WEBMAIL.arcx.com
 (192.168.2.64)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1:
	starting point.
	is there a way to test-run this on supported devices that I don't
		have physical access to - (ks8995, ksz8864) ?

Sven Van Asbroeck (1):
  spi_ks8995: use regmap to access chip registers.

 drivers/net/phy/spi_ks8995.c | 163 +++++++++++++------------------------------
 1 file changed, 50 insertions(+), 113 deletions(-)

-- 
1.9.1
