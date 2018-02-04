Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbeBDDUq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 22:20:46 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:42693 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBDDUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 22:20:42 -0500
X-Google-Smtp-Source: AH8x22748rpzSuBSwtLuNHf5r3Z8J4jvPZzOI5tNAJs19gBeCZ4fti9y32fLskxRYF4a9hHmD2C2Lg==
From: sztsian@gmail.com
To: rostedt@goodmis.org
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com, sztsian@gmail.com
Subject: [PATCH 0/2] trace-cmd: Improves python plugin support
Date: Sun,  4 Feb 2018 11:20:12 +0800
Message-Id: <20180204032014.6962-1-sztsian@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zamir SUN (Red Hat) <sztsian@gmail.com>

This is a set of patch to improve trace-cmd python plugin support.

Patch 1 fixes the detection for swig. With this patch, python-plugin can
be built successfully.

Patch 2 improves the detection for python ldflags. With this patch,
ldflags can be detected with python3 in the future.

Zamir SUN (2):
  trace-cmd: Fix the detection for swig
  trace-cmd: Change the way of getting python ldflags.

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.14.3
