Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936770AbeE2Bbh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:31:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:38820 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935112AbeE2Bbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:31:36 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Subject: [PATCH 00/15] fsi: Overall improvements and new SBE fifo driver
Date: Tue, 29 May 2018 11:30:29 +1000
Message-Id: <20180529013044.23815-1-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings in a number of improvements to our FSI stack
(one of the service interfaces for communicating between a BMC chip and
our POWER processors).

The GPIO based "Soft FSI" performance is significantly improved, and
it's reliability as well.

The SBE fifo driver provides the interface to the processor "Self Boot
Engine"

Some of these patches have been simmering for a while in the OpenBMC
tree.
