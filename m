Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeC0MFP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:05:15 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:32805 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751066AbeC0MFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:05:13 -0400
From: michaelsh@mellanox.com
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v1 - resent 0/5] Add capabilities to i2c-mlxcpld
Date: Tue, 27 Mar 2018 14:01:21 +0000
Message-Id: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

This series is resent (original series has been sent at 5/3/2018).

PATCH1
  It adds support for extended length of read and write transactions.

PATCH2
  It adds support for smbus block read transaction.

PATCH3
  Fix report about supported functionality.

PATCH4
  It allows mlxcpld driver to be connected to pre-defined adapter number.

PATCH5
  It adds capability register description to documentation.

Michael Shych (5):
  i2c: busses: Add support for extended transaction length for
    i2c-mlxcpld
  i2c: busses: Add support for smbus block read transaction
  i2c: busses: Fix adapter functionality support callback
  i2c: busses: Allow configurable adapter id for mlxcpld
  i2c: busses: Add capability register description to documentation

 Documentation/i2c/busses/i2c-mlxcpld |  4 +++
 drivers/i2c/busses/i2c-mlxcpld.c     | 68 +++++++++++++++++++++++++++++++-----
 2 files changed, 63 insertions(+), 9 deletions(-)

-- 
2.1.4
