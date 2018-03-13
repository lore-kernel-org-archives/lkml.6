Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeCMR4N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:56:13 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:34775 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752519AbeCMR4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:56:12 -0400
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To: jakob.unterwurzacher@theobroma-systems.com
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] can: ucan: add driver for Theobroma Systems UCAN devices
Date: Tue, 13 Mar 2018 18:35:19 +0100
Message-Id: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second iteration of the Theobroma Systems CAN/USB
adapter driver.

Thanks to feedback from the list and additonal internal stress-testing,
the driver, the wire protocol and the device firmware have been improved.

Among other changes, error states are now handled, and an explicit
tx completion message has been added.

A few questions and review comments are still open. I will post an
email gathering all answers in a reply to this cover letter.

Jakob Unterwurzacher (1):
  can: ucan: add driver for Theobroma Systems UCAN devices

 Documentation/networking/can_ucan_protocol.rst |  315 +++++
 Documentation/networking/index.rst             |    1 +
 drivers/net/can/usb/Kconfig                    |   10 +
 drivers/net/can/usb/Makefile                   |    1 +
 drivers/net/can/usb/ucan.c                     | 1587 ++++++++++++++++++++++++
 5 files changed, 1914 insertions(+)
 create mode 100644 Documentation/networking/can_ucan_protocol.rst
 create mode 100644 drivers/net/can/usb/ucan.c

-- 
2.11.0

Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
