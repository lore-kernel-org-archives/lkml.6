Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0696C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901D0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfAJLFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:05:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60330 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfAJLFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:05:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78361A78;
        Thu, 10 Jan 2019 03:05:54 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62F1F3F694;
        Thu, 10 Jan 2019 03:05:52 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     corbet@lwn.net, peterz@infradead.org, rjw@rjwysocki.net
Cc:     mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quentin.perret@arm.com
Subject: [PATCH 0/2] Documentation: Explain EAS and EM
Date:   Thu, 10 Jan 2019 11:05:44 +0000
Message-Id: <20190110110546.8101-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently introduced Energy Aware Scheduling (EAS) feature relies on
a large set of concepts, assumptions, and design choices that are
probably not obvious for an outsider. Moreover, enabling EAS on a
particular platform isn't straightforward because of all its
dependencies. This series tries to address this by introducing proper
documentation files for the scheduler's part of EAS and for the newly
introduced Energy Model (EM) framework. These are meant to explain not
only the design choices of EAS but also to list its dependencies in a
human-readable location.

The two new doc files are simple .txt to be consistent with the existing
documentation of the relevant subsystems, but I'm happy to translate to
.rst if deemed necessary.

All feedback is welcome.

Thanks !
Quentin

Quentin Perret (2):
  PM / EM: Document the Energy Model framework
  sched: Document Energy Aware Scheduling

 Documentation/power/energy-model.txt     | 144 ++++++++
 Documentation/scheduler/sched-energy.txt | 425 +++++++++++++++++++++++
 2 files changed, 569 insertions(+)
 create mode 100644 Documentation/power/energy-model.txt
 create mode 100644 Documentation/scheduler/sched-energy.txt

-- 
2.20.1

