Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF81C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E190520875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E190520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeJFDlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:41:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbeJFDlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:41:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F32FC3097031;
        Fri,  5 Oct 2018 20:40:59 +0000 (UTC)
Received: from localhost (ovpn-117-52.phx2.redhat.com [10.3.117.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B04362937;
        Fri,  5 Oct 2018 20:40:59 +0000 (UTC)
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tools/perf: Python 3 + clang build fixes
Date:   Fri,  5 Oct 2018 17:40:56 -0300
Message-Id: <20181005204058.7966-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 05 Oct 2018 20:41:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a couple fixes to make it possible to build
perf with Python 3 and clang.

Eduardo Habkost (2):
  perf: Make clang_has_option() work on Python 3
  perf: More portable way to make CFLAGS work with clang

 tools/perf/util/setup.py | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140

