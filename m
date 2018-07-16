Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DEFECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BDB20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BDB20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeGPLuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:50:24 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:60133 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbeGPLuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:50:23 -0400
Received: from faui49t (faui49t.informatik.uni-erlangen.de [131.188.42.17])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 2959258C4F2;
        Mon, 16 Jul 2018 13:23:21 +0200 (CEST)
Received: by faui49t (sSMTP sendmail emulation); Mon, 16 Jul 2018 13:23:21 +0200
From:   Andreas Ziegler <andreas.ziegler@fau.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Ziegler <andreas.ziegler@fau.de>
Subject: [PATCH 0/2] Documentation: trace: improve probe documentation
Date:   Mon, 16 Jul 2018 13:05:56 +0200
Message-Id: <1531739158-31133-1-git-send-email-andreas.ziegler@fau.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves the documentation for uprobes and
kprobes.

The filename for enabling/disabling single events is 'enable',
not 'enabled'. kprobetrace.rst lists the files present in the
per-event directories but missed 'trigger' so far.

Andreas Ziegler (2):
  Documentation: {u,k}probes: fix filename for event enabling
  Documentation: kprobetrace: document 'trigger' file

 Documentation/trace/kprobetrace.rst  | 9 ++++++---
 Documentation/trace/uprobetracer.rst | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

--
2.7.4

