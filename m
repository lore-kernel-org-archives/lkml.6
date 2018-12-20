Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D406C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FFF21852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbeLTOez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:34:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbeLTOez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:34:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E91832CD803;
        Thu, 20 Dec 2018 14:34:54 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-196.ams2.redhat.com [10.36.116.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 643085EDEE;
        Thu, 20 Dec 2018 14:34:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] ACPI / scan: Create platform device for BSG2150 ACPI nodes
Date:   Thu, 20 Dec 2018 15:34:50 +0100
Message-Id: <20181220143451.25962-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 20 Dec 2018 14:34:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch adds support for another ACPI HID which describes multiple
i2c-clients in a single node. As such this applies on top of the recent
patch from Andy making a similar change for INT3515 nodes:

Commit a3dd034a1707 ("ACPI / scan: Create platform device for INT3515
ACPI nodes"), which is in the platform-drivers-x86-v4.21-1 tag.

As such I believe it would be best to merge this tree through the
linux-platform-drivers-x86 tree, as was done for the INT3515 patch.

Rafael, may we have your ack for merging the single line drivers/acpi
change through the linux-platform-drivers-x86 tree?

Regards,

Hans

