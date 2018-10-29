Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B745C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B57920827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B57920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeJ2TDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:03:50 -0400
Received: from foss.arm.com ([217.140.101.70]:38152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbeJ2TDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:03:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9657C341;
        Mon, 29 Oct 2018 03:15:49 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7EADE3F6A8;
        Mon, 29 Oct 2018 03:15:48 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        joe@perches.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 0/2] efi/fdt: get_fdt cleanups
Date:   Mon, 29 Oct 2018 10:15:40 +0000
Message-Id: <1540808142-33208-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are just some minor cleanups of get_fdt function.

Changes since v1:
- Add a set of brace for the for loop
- Reorganize code as suggested by Joe

[1] https://lkml.org/lkml/2018/10/1/465

Thanks,

Julien

-->

Julien Thierry (2):
  efi/fdt: Indentation fix
  efi/fdt: Simplify get_fdt flow

 drivers/firmware/efi/libstub/fdt.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--
1.9.1
