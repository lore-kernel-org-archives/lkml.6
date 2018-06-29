Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE57C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CD727E35
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="18IguZwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CD727E35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937358AbeF2U1g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936587AbeF2U1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:27:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4324C27E32;
        Fri, 29 Jun 2018 20:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530304054;
        bh=H2CkQZ5FHjrudUj3JQXom4warwp5My6HYvIJRXfqmCo=;
        h=Subject:From:To:Cc:Date:From;
        b=18IguZwJkjbWqApKVPlbylPrfd99Iw/FUfPdn1iYN6ZzhkRy9dNSeZ6jG2AplsdA6
         xtArzR34/e5S2VLGrvli8XlQJXePBkSEAiiXoIniIm+sxvnkrynRmQ4vy/KRN532bO
         KN2lo4S72/cJwWgjOB1YbWlt4iWc/8mXZKVotlr8=
Subject: [PATCH v1 0/2] PCI: Add patch submission and ACPI FW/OS info
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Jun 2018 15:27:33 -0500
Message-ID: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hints about my patch idiosyncrasies and and ACPI firmware/OS interface
usage.  I posted the latter 18 months ago or so, but never followed up on
it.

---

Bjorn Helgaas (2):
      PCI: Document patch submission hints
      PCI: Document ACPI description of PCI host bridges


 Documentation/PCI/00-INDEX               |    4 +
 Documentation/PCI/acpi-info.txt          |  183 ++++++++++++++++++++++++++++++
 Documentation/PCI/submitting-patches.txt |  153 +++++++++++++++++++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 Documentation/PCI/acpi-info.txt
 create mode 100644 Documentation/PCI/submitting-patches.txt
