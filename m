Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeENSoH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbeENSoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:44:06 -0400
Date: Mon, 14 May 2018 19:44:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org
Subject: RFC: Drop the adis16060 gyro driver from staging.
Message-ID: <20180514194401.2ce52589@archlinux>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This part uses a strange double chip select which is really tricky to support
properly.  It could be done, but it's a lot of work to support one odd device.

Given the device is now 'not for new designs' I instead propose to simply
drop it from staging.

Does anyone mind / have the hardware to test if we try to add the support
nicely?

Thanks,

Jonathan
