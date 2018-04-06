Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeDFUjF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:39:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:20577 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbeDFUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:38:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="39963011"
From: Andi Kleen <andi@firstfloor.org>
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Some minor fixes for perf user tools
Date: Fri,  6 Apr 2018 13:38:08 -0700
Message-Id: <20180406203812.3087-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchkit fixes some random minor issues in the perf user tools

-Andi
