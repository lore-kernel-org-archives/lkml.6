Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64ECC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A4825727
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A4825727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965748AbeGARnZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:43:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030617AbeGAQer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:34:47 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9234F92B;
        Sun,  1 Jul 2018 16:34:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <Kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Jin, Yao" <yao.jin@linux.intel.com>
Subject: [PATCH 4.14 124/157] perf vendor events: Add Goldmont Plus V1 event file
Date:   Sun,  1 Jul 2018 18:23:16 +0200
Message-Id: <20180701160859.072103772@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <Kan.liang@intel.com>

commit 65db92e0965ab56e8031d5c804f26d5be0e47047 upstream.

Add a Intel event file for perf.

Signed-off-by: Kan Liang <Kan.liang@intel.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/1508331907-395162-1-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/pmu-events/arch/x86/goldmontplus/cache.json          | 1453 ++++++++++
 tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json       |   62 
 tools/perf/pmu-events/arch/x86/goldmontplus/memory.json         |   38 
 tools/perf/pmu-events/arch/x86/goldmontplus/other.json          |   98 
 tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json       |  544 +++
 tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json |  218 +
 tools/perf/pmu-events/arch/x86/mapfile.csv                      |    1 
 7 files changed, 2414 insertions(+)

<patch snipped as git-send-email didn't like it...>

