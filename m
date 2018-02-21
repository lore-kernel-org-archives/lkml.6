Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeBUCsH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 21:48:07 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41183 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeBUCsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 21:48:05 -0500
X-Google-Smtp-Source: AH8x227RmnmowACkh0duSuMOczswJk1qsrl2lSuhUd3HGHKpBLq684nmUwVGPts3oOxOVZwMhM2W2g==
From: Tycho Andersen <tycho@tycho.ws>
To: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc: Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 0/3] some fixups for PTRACE_SECCOMP_GET_METADATA
Date: Tue, 20 Feb 2018 19:47:44 -0700
Message-Id: <20180221024747.9659-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

Here are a couple of tweaks/fixes people suggested to the get_metadata
functionality, plus a test to ensure that things work the way they're supposed
to and stay that way.

Cheers,

Tycho

Tycho Andersen (3):
  seccomp, ptrace: switch get_metadata types to arch independent
  ptrace, seccomp: tweak get_metadata behavior slightly
  seccomp: add a selftest for get_metadata

 include/uapi/linux/ptrace.h                   |  4 +-
 kernel/seccomp.c                              |  6 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 61 +++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 4 deletions(-)

-- 
2.14.1
