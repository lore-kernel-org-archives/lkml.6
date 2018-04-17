Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755396AbeDQQIS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:08:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46176 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755350AbeDQQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:08:11 -0400
X-Google-Smtp-Source: AIpwx48NYwAcxxdalovq3SA1QcIXpPkCqW+/QVYjWys//UgxBCAso9FLGNwNbA9nuefdpmC814eMlA==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, Ben.Gainey@arm.com
Subject: [PATCH v2 0/3] coresight: Refresh documenation 
Date: Tue, 17 Apr 2018 10:08:04 -0600
Message-Id: <1523981287-15370-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the perf tools CoreSight support is upstream this set adds
documentation to go with it and move things around so that topics 
are located together.

--------
Changes for V2:
* Addressed grammatical problems highlighted by Randy

Mathieu Poirier (3):
  coresight: Remove obsolete reference to "owner" in CoreSight
    descriptor
  coresight: Add section for integration with the perf tools
  coresight: Grouping all perf tools oriented section together

 Documentation/trace/coresight.txt | 103 +++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 28 deletions(-)

-- 
2.7.4
