Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbeDPTff (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:35:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36509 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752934AbeDPTfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:35:30 -0400
X-Google-Smtp-Source: AIpwx4//dGO/53xthjL8fYkrMmTY/Q3ukbKgkVVGkNGAAg5FtALaxHil1BPUs7sweYemTlV/hAyyYA==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Gainey@arm.com
Subject: [PATCH 0/3] coresight: Refresh documenation 
Date: Mon, 16 Apr 2018 13:35:24 -0600
Message-Id: <1523907327-20979-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the perf tools CoreSight support is upstream this set adds
documentation to go with it and move things around so that topics 
are located together. 

Mathieu Poirier (3):
  coresight: Remove obsolete reference to "owner" in CoreSight
    descriptor
  coresight: Add section for integration with the perf tools
  coresight: Grouping all perf tools oriented section together

 Documentation/trace/coresight.txt | 101 ++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 27 deletions(-)

-- 
2.7.4
